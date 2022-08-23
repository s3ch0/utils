#!/usr/bin/python
'''
This simple python file will help you to crawl the link in your markdown file 
you can use follow command in you shell to gain the link of the images
` cat mechine5.md | grep http://zhouhao-blog.oss | cut -d'(' -f2 | cut -d')' -f1 > link5.txt `
then you can use this file to save the img follow the link to a folder

` python ./pull.py link_file dst_folder `
then all the img will save to the dst_folder
@auther: zhouhaobusy
@website: www.zhouhaobusy.com

'''

from typing import Union
import requests
import os
import sys


def is_img(link: str):
    '''
    this function will check the link weather or not a picture
   

    '''
    pass


def cprint(color: str, *args, **kwargs):
    color = color.upper()
    ANSI_CODE: dict[str, str] = {

        #------ silm style
        "BLACK": "\33[30m",
        "RED": "\33[31m",
        "GREEN": "\33[32m",
        "YELLOW": "\33[33m",
        "BLUE": "\33[34m",
        "MAGENTA": "\33[35m",
        "CYAN": "\33[36m",
        "WHITE": "\33[37m",
        "_BLACK": "\33[1;40m",
        "_RED": "\33[1;41m",
        "_GREEN": "\33[1;42m",
        "_YELLOW": "\33[1;43m",
        "_BLUE": "\33[1;44m",
        "_MAGENTA": "\33[1;35m",
        "_CYAN": "\33[1;46m",
        "_WHITE": "\33[1;47m",

        #------ bold style
        "FG_BLACK": "\33[1;30m",
        "FG_RED": "\33[1;31m",
        "FG_GREEN": "\33[1;32m",
        "FG_YELLOW": "\33[1;33m",
        "FG_BLUE": "\33[1;34m",
        "FG_MAGENTA": "\33[1;35m",
        "FG_CYAN": "\33[1;36m",
        "FG_WHITE": "\33[1;37m",
        "BG_BLACK": "\33[1;40m",
        "BG_RED": "\33[1;41m",
        "BG_GREEN": "\33[1;42m",
        "BG_YELLOW": "\33[1;43m",
        "BG_BLUE": "\33[1;44m",
        "BG_MAGENTA": "\33[1;35m",
        "BG_CYAN": "\33[1;46m",
        "BG_WHITE": "\33[1;47m",
        "NONE": "\33[0m"
    }
    user_args = list(args)

    # To solve the plain space in the output
    if len(user_args) <= 1:
        HEAD = "{}{}".format(ANSI_CODE.get(color, ANSI_CODE["NONE"]),
                             user_args[0])
        BODY = ''
        END = ANSI_CODE["NONE"]
    else:
        HEAD = "{}{}".format(ANSI_CODE.get(color, ANSI_CODE["NONE"]),
                             user_args[0])

        BODY = '' if len(tuple(user_args[1:-1])) == 0 else tuple(
            user_args[1:-1])
        END = "{}{}".format(user_args[-1], ANSI_CODE["NONE"])

    print(HEAD, BODY, END, **kwargs)


def _create_folder(dir_name: str) -> int:
    try:
        # if os.path.exists(dir_name):
        #     pass
        os.mkdir(dir_name)
        return 0
    except FileExistsError as err:
        cprint('green', "Directory exists:{}".format(dir_name))
        return 1


def _file_suffix(link: str) -> Union[None, str]:
    if (link.startswith('http')):
        res = link.split('/')[-1]
        return res.strip()
    else:
        cprint('YELLOW', "This string:{} is not a valid link".format(link))
        exit(1)


def gain_link(file_name: str) -> list:
    if os.path.exists(file_name):
        with open(file_name, 'r') as link:
            link_list = link.readlines()
        return link_list
    else:
        cprint('red', "The file don't exists!")
        exit(1)


def pull_img(link_list: list, dir_name: str) ->...:
    # some bug in this maybe the file name eq
    img_num = 0
    img_path = os.path.join(os.getcwd(), dir_name)
    err_num = 0
    for link in link_list:
        cprint('green', "start {}".format(_file_suffix(link)))
        resp = requests.get(link.strip())
        if resp.status_code == 200:
            with open(os.path.join(img_path, _file_suffix(link)), 'wb') as img:
                img.write(resp.content)
            img_num += 1
        else:
            err_num += 1
            cprint('GREEN', link, end='')

    cprint('CYAN', "Crawl {} img".format(str(img_num)))
    cprint('YELLOW', "Bad link {}".format(str(err_num)))


if __name__ == '__main__':
    if len(sys.argv) < 3:
        cprint('cyan', "Usage python ./pull.py link_file dst_folder")
    else:
        _create_folder(sys.argv[2])
        link_list = gain_link(sys.argv[1])
        pull_img(link_list, sys.argv[2])
