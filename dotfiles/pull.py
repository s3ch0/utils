from fileinput import filename
from posixpath import dirname
from typing import Union
from flask import current_app
import requests
import os
import sys


def _create_folder(dir_name: str) -> int:
    try:
        # if os.path.exists(dir_name):
        #     pass
        os.mkdir(dir_name)
        return 0
    except FileExistsError as err:
        print("Directory exists:{}".format(dir_name))
        return 1


def _file_suffix(link: str) -> Union[None, str]:
    if (link.startswith('http')):
        res = link.split('/')[-1]
        return res
    else:
        print("This string:{} is not a valid link".format(link))
        exit(1)


def gain_link(file_name: str) -> list:
    if os.path.exists(file_name):
        with open(file_name, 'r') as link:
            link_list = link.readlines()
        return link_list
    else:
        print("The file don't exists!")
        exit(1)


def pull_img(link_list: list,dir_name:str) ->...:
    # some bug in this maybe the file name eq
    img_path = os.path.join(os.getcwd(),dir_name)
    err_num = 0
    for link in link_list:
        print("start {}".format(_file_suffix(link)))
        resp = requests.get(link.strip())
        if resp.status_code == 200:
            with open(os.path.join(img_path,_file_suffix(link)),'wb') as img:
                img.write(resp.content)
        else:
            err_num +=1
            print(link)



if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage...")

    else:
        _create_folder(sys.argv[2])
        link_list = gain_link(sys.argv[1])
        print(link_list)
        pull_img(link_list,sys.argv[2])

