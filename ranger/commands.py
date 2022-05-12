from ranger.api.commands import Command
import os
from ranger.core.loader import CommandLoader


class paste_as_root(Command):

    def execute(self):
        if self.fm.do_cut:
            self.fm.execute_console('shell sudo mv %c .')
        else:
            self.fm.execute_console('shell sudo cp -r %c .')


class toggleVCS(Command):

    def execute(self):
        self.fm.execute_console("set vcs_aware!")
        self.fm.execute_console("reload_cwd")


class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        from os.path import join, expanduser, lexists
        from os import makedirs
        import re

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search('^/|^~[^/]*/', dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0):]

            for m in re.finditer('[^/]+', dirname):
                s = m.group(0)
                if s == '..' or (s.startswith('.')
                                 and not self.fm.settings['show_hidden']):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console('scout -ae ^{}$'.format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os.path
        if self.quantifier:
            # match only directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"

        else:
            # match files and directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"

        fzf = self.fm.execute_command(command,
                                      universal_newlines=True,
                                      stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)


class extract_here(Command):

    def execute(self):
        import os
        from ranger.core.loader import CommandLoader
        """ extract selected files to current directory."""
        cwd = self.fm.thisdir
        marked_files = tuple(cwd.get_selection())

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = marked_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-x', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(marked_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(
                one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags +
                            [f.path for f in marked_files],
                            descr=descr,
                            read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)


class compress(Command):

    def execute(self):
        import os
        from ranger.core.loader import CommandLoader
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]

        descr = "compressing files in: " + os.path.basename(parts[1])
        obj = CommandLoader(args=['apack'] + au_flags + \
                [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return [
            'compress ' + os.path.basename(self.fm.thisdir.path) + ext
            for ext in extension
        ]


# Function to check the file is or not executable


class delete_all_executable_files(Command):

    @staticmethod
    def is_executable(file):
        return os.path.isfile(file) and os.access(file, os.X_OK)

    # append the efi files to the list
    @staticmethod
    def get_efi_files(path):
        files = []
        for file in os.listdir(path):
            full_path = os.path.join(path, file)
            if file.endswith('.efi'):
                files.append(full_path)
        return files

    # append the .out and .o files to the list
    @staticmethod
    def get_object_files(path):
        files = []
        for file in os.listdir(path):
            full_path = os.path.join(path, file)
            if file.endswith('.o') or file.endswith('.out'):
                files.append(full_path)
        return files

    # add the executable files to a list
    def get_executable_files(self, path):
        files = []
        for file in os.listdir(path):
            full_path = os.path.join(path, file)
            if self.is_executable(full_path):
                files.append(full_path)
        return files

    # delete the files
    def execute(self):
        # get the current directory
        cwd = self.fm.thisdir
        # get the path of the current directory
        path = cwd.path

        # get the list of object files in the current directory
        out_files = self.get_object_files(path)

        executable_files = self.get_executable_files(path)
        # get the list of the efi files
        efi_files = self.get_efi_files(path)
        # get the list of the files to be deleted
        files_to_delete = set(executable_files + efi_files + out_files)

        # delete the files
        for file in files_to_delete:
            os.remove(file)
        # reload the ranger directory
        self.fm.notify('Deleted all executable files')


class empty(Command):
    """:empty

    Empties the trash directory ~/Trash
    """

    def execute(self):
        self.fm.run("rm -rf /home/zh/Trash/*")


class Cash(Command):

    def get_the_cash_name(self):
        # gain the current selected file name list
        selected_files = self.fm.thistab.get_selection()
        print(selected_files)

    def execute(self):
        self.get_the_cash_name()
