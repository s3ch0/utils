#!/bin/bash
## zhouhao's shell bash
# 2020.10.9 v1.0
# 2021.5.23 v2.0
#-------------------------------
# This bash shell for Kali Linux 
#-------------------------------

# STRUCTURE

#    [MENU] 
#      |
#      |
#      |--> 1.IP Config
#      |        |
#      |        |--1.配置IP --> fix_ip()
#      |     	|--2.查看IP --> view_ip()
#      |        |--3.查看公网IP --> view_public_ip()   
#      |    	|--4.使用DHCP获取IP地址 --> dhcp_ip()
#      |
#      |----> 2.Apache Config
#      |	|
#      |	|--1.开启Apache --> open_apache()
#      |	|--2.关闭Apache --> close_apache()
#      |
#      |  3.待开发/////////////////
#      |  
#      |------> 4. Docker Config
#      |                 |
#      |		         |--1.关于镜像相关的命令  --> docker_image()
#      |                 |         |
#      |                 |         |-show docker images(查看镜像）
#      |                 |         |-delete docker image（删除指定镜像）
#      |                 |         |-start docker image（启动镜像）
#      |                 |          
#      |                 |
#      |		         |--2.关于容器相关的命令  --> docker_compose()
#      |                 |         |
#      |                 |         |-show all docker compose (查看所有容器）--->包括没有启动的容器
#      |                 |         |-clear all docker compose (清空所有容器）
#      |                 |         |-enter docker （启动并进入容器）
#      |                 |         
#      |                 |         
#      |                 |--3.关于环境相关的命令  --> docker_environment()
#      |                 |          |
#      |                 |          |
#      |                 |          |-docker_environment (根据容器名启动相关环境）
#      |                 |                       |---> (默认映射名为PWN 映射端口23946）
#      |                 |                       |---> (默认容器卷/home/docker：/home）
#      |                 |                       |---> (默认启动并进入终端 /bin/bash）
#      |                 |
#      |                 |--4.启动和关闭docker   --> docker_open() / docker_close()
#      |                 |
#      |                 |
#      |
#      |    
#      |
#      |
#      |---------> 5.SSH Config
#      |		|-1.开启SSH --> open_ssh()
#      |		|-2.关闭SSH --> close_ssh()
#      |
#      |
#      |
#      |
#      |







#--------------------------------------------------------------------------------------------------#
menu() {

echo -e "\033[35m ========================================\033[0m"
echo -e "\033[36m                 🌱MENU\033[0m"
echo -e "\033[36m           1.Ip Config\033[0m"
echo -e "\033[36m           2.Apache Config\033[0m"
echo -e "\033[36m           3.Web environment\033[0m"
echo -e "\033[36m           4.Docker Config\033[0m"
echo -e "\033[36m           5.SSH Config\033[0m"
echo -e "\033[36m           6.Exit\033[0m"
echo -e "\033[35m ========================================\033[0m"
read -p "please enter your choice:" GLOBAL_CHOICE


ip_config() {

echo -e "\033[32m ========================================\033[0m"
echo -e "\033[32m           1.Fix IP\033[0m"
echo -e "\033[32m           2.Look over your local IP\033[0m"
echo -e "\033[32m           3.Look over your public IP\033[0m"
echo -e "\033[32m           4.Use DHCP server \033[0m"
echo -e "\033[32m           5.exit\033[0m"
echo -e "\033[32m ========================================\033[0m"
read -p "Please enter your choice:" DEMO1
    fix_ip() {
	    read -p "Please enter your IP address that you want to use:" IP
	    echo -e "\033[31mThis may need some times,Please waiting for it..\033[0m"
	    echo "auto lo" > /etc/network/interfaces
            echo "iface lo inet loopback" >> /etc/network/interfaces
            echo "auto eth0" >> /etc/network/interfaces
            echo "iface eth0 inet static" >> /etc/network/interfaces
            echo "address $IP" >> /etc/network/interfaces
            echo "netmask 255.255.255.0" >> /etc/network/interfaces
	    ifdown eth0 &> /dev/null
	    ifup eth0 &> /dev/null
	    ip_config
	}
    dhcp_ip(){

	    echo -e "\033[31mAre you sure you want to use DHCP server to obtain IP address? [Y/N]\033[0m";read IP
        if [ "$IP" = "Y" -o "$IP" = "y" ];then
	        
	        echo -e "\033[31mThis may need some times,Please waiting for it..\033[0m"
	        echo "auto lo" > /etc/network/interfaces
                echo "iface lo inet loopback" >> /etc/network/interfaces
                echo "auto eth0" >> /etc/network/interfaces
                echo "iface eth0 inet dhcp" >> /etc/network/interfaces
	        ifdown eth0 &> /dev/null
	        ifup eth0 &> /dev/null
		if [ "$?" -eq 0 ];then
			echo -e "\033[31mComplete!!!\033[0m"
		else
			echo -e "\033[32mSome error may happened!!!\033[0m\n"
		fi
		
		ip_config

        elif [ "$IP" = "N" -o "$IP" = "n" ];then
		echo -e "\033[31mOK!\033[0m\n"
		ip_config
	else
		echo -e "\033[31m You only enter [Y/N]!\033[0m\n"
		ip_config

		fi
    }
    view_ip() {
	    ipaddr=`ifconfig|grep 'broadcast'|tr -s ' '|cut -d ' ' -f3|tr [:cntrl:] ' '`
        echo -e "\033[31mYour local IP is : $ipaddr\033[0m"
            echo -e "\033[33mDo you want to continue?[Y/N]\033[0m";read answer
	    if [ "$answer" = "Y" -o "$answer" = "y" ];then
		    echo -e "\033[32mOK!\033[0m"
		    ip_config
	    elif [ "$answer" = "N" -o "$answer" = "n" ];then
		    echo -e "\033[32mThanks for your use\033[0m"
		    . /usr/local/shell/base_tool.sh
	    else
		    clear
		    echo -e "\033[31m You only enter [Y/N]!\033[0m"
		    ip_config
	    fi

	    }

    view_public_ip() {
	    public_ipaddr=`curl -s  https://www.httpbin.org/ip | grep "origin"|cut -d":" -f2 |cut -d'"' -f2`
        echo -e "\033[31mYour public IP is : $public_ipaddr\033[0m"
            echo -e "\033[33mDo you want to continue?[Y/N]\033[0m";read answer
	    if [ "$answer" = "Y" -o "$answer" = "y" ];then
		    echo -e "\033[32mOK!\033[0m"
		    ip_config
	    elif [ "$answer" = "N" -o "$answer" = "n" ];then
		    echo -e "\033[32mThanks for your use\033[0m"
		    . /usr/local/shell/base_tool.sh
	    else
		    clear
		    echo -e "\033[31m You only enter [Y/N]!\033[0m"
		    ip_config
	    fi
	    }

case $DEMO1 in
1)
    fix_ip
    ;;
2)
    view_ip
    ;;
3)
    view_public_ip
    ;;
4)  
    dhcp_ip
    ;;
5)
    menu
    ;;
*)
    echo -e "\033[31m Usage:You only choose 1,2,3!!\033[0m"
    ip_config
esac
}
apache_config(){
echo -e "\033[32m ========================================\033[0m"
echo -e "\033[32m           1.Open the apache server\033[0m"
echo -e "\033[32m           2.Close the apache server\033[0m"
echo -e "\033[32m           3.Exit\033[0m"
echo -e "\033[32m ========================================\033[0m"
read -p "Please enter your choice:" TMP2
    open_apache() {
	    /etc/init.d/apache2 start
    }
    close_apache() {
	    killall apache2
	    if [ "$?" -eq 0 ];then
        echo -e "\033[32m [complete] Apache colsed!\033[0m"
        else
        echo -e "\033[31m [error] some error occured!\033[0m"
        fi
        }

case $TMP2 in 
1)
	open_apache
	;;
2)
	close_apache
	;;
3)
	exit
	;;
*)
        echo "You only enter 1,2!"
	clear
	apache_config
esac

}

# 

find_file() {
    read -p "Please enter your path that you want to scan:" PATH1
    read -p "Please input your name:" NAME1
    echo -e "\033[31m This may take some time...\033[0m"
    find $PATH1 -name $NAME1
    read -n1 -p "Do you want to continue [Y/N]?" answer 
case $answer in
Y | y)
      echo -e "ok\n"
      find_file
      ;;
N | n)
      echo -e "ok,good bye\n"
      . /usr/local/shell/base_tool.sh
      ;;

*)
     echo -e "error choice\n";;
esac


    

}

# Here is the part about docker config

docker_config(){
echo -e "\033[31m++++++++++++++++++++++++++++++++++++++++\033[0m"
echo -e "\033[32m          1.Docker Image \033[0m"
echo -e "\033[32m          2.Docker Compose\033[0m"
echo -e "\033[32m          3.Docker environment\033[0m"
echo -e "\033[31m++++++++++++++++++++++++++++++++++++++++\033[0m"   
read -p "Enter your choice:" G1
 # docker_image()
docker_image(){
echo -e "\033[31m*****************************************\033[0m"
echo -e "\033[32m          1.show docker images\033[0m"
echo -e "\033[32m          2.delete docker image\033[0m"
echo -e "\033[32m          3.start docker image\033[0m"
echo -e "\033[32m          4.exit\033[0m"
echo -e "\033[31m*****************************************\033[0m"   
read -p "Enter your choice:" G2
case $G2 in
1)
    echo -e "\033[31m--------------------------------------------------------\033[0m"   
    docker images
    echo -e "\033[31m--------------------------------------------------------\033[0m"   
    docker_config
    ;;
2)  
    read -p "Enter your image name that you want to delete:" G3
    docker rmi -f $G3
    ;;
3)
    read -p "Enter your image that you want to start:" G4	
    tag=`docker images |grep -w $G4|tr -s " "|cut -d" " -f2`
    tmp_name=`docker images|grep -w $G4|tr -s " "|cut -d" " -f1`
    read -p "Enter your name:" HOST_NAME
	docker run --name=$HOST_NAME --hostname=$HOST_NAME -it -p 23946:23946 -v /home/Docker:/home $tmp_name:$tag /bin/bash
    ;;
4)
    docker_config
    ;;
*)

     echo -e "error choice\n";;
esac

}


# docker_compose
docker_compose(){
echo -e "\033[31m*****************************************\033[0m"
echo -e "\033[32m          1.show all docker compose\033[0m"
echo -e "\033[32m          2.clear all docker compose\033[0m"
echo -e "\033[32m          3.enter docker \033[0m"
echo -e "\033[32m          4.exit\033[0m"
echo -e "\033[31m*****************************************\033[0m"   
read -p "Enter your choice:" C1
case $C1 in
1)
	docker ps -a
	docker_compose
	;;
2)
	docker rm -f $(docker ps -aq)
	docker_config
	;;
3)
	NAME=`docker ps -aq`
	docker start $NAME
	docker attach $NAME 
	;;

4)
	clear
	docker_config
	;;
*)

     echo -e "error choice\n"

esac
}

docker_environment() {

    read -p "Enter your choice that you want to start :" G4
#	name= $(docker images|grep -w $G4|tr -s " "|cut -d" " -f1)
	tag=`docker images |grep -w $G4|tr -s " "|cut -d" " -f2`
	tmp_name=`docker images|grep -w $G4|tr -s " "|cut -d" " -f1`
	[ $? -eq 0 ] && echo "OK" || echo "FALSE" 
	name=$tmp_name:$tag # 镜像的名字：标签
	echo -e "\033[32mPlease waiting for it!\033[0m"
	echo "The docker compose name is --->" ${name}
	docker run --name=PWN --hostname=PWN -it -p 23946:23946 -v /home/Docker:/home ${name} /bin/bash
#   docker run --name=redis --hostname=redis -it -p 6379:6379 ${name} /bin/bash

}




docker_open_close(){

    

    read -p "Enter your choice in follow menu :" Foo





}



case $G1 in
1)
    docker_image
    ;;
2)
    docker_compose
    ;;
3)
    docker_environment
    ;;
4)
    exit
    . /usr/local/shell/base_tool.sh
    ;;
*)   
    echo -e "\033[31m Usage:You only choose 1,2!!\033[0m"
    menu
esac

}



ssh_conf() {
echo -e "\033[32m======================================\033[0m"
echo -e "\033[32m          1.Open SSH server\033[0m"
echo -e "\033[32m          2.Close SSH server\033[0m"
echo -e "\033[32m=====================================\033[0m"

read -p "Please enter your choice:" CHOICE
open_ssh() {

read -p "Do you want to open the SSH server?[Y/N]" OPINION
if [ "$OPINION" = "Y" -o "$OPINION" = "y" ];then
    /etc/init.d/ssh start &>/dev/null
    if [ "$?" -eq "0" ];then
      echo -e "\033[32mSSH server started\033[0m"
      else
        echo -e "\033[31Error!!\033[0m"
    fi
elif [ "$OPINION" = "N" -o "$OPINION" = "n" ];then
    echo "OK.."
else 
    echo -e "\033[32mYou only input Y/N!\033[0m"
    
    open_ssh
fi

}
close_ssh(){

killall sshd &> /dev/null

if [ "$?" -eq "0" ];then
        echo -e "\033[31mThe SHH server are closed!\033[0m"
else
        echo -e "\033[31mSorry some error happened!\033[0m"
        echo -e "\033[31mMaybe your ssh server did not opened\033[0m"
fi

}



case $CHOICE in

1)
open_ssh
;;
2)
close_ssh
;;
*)
echo -e "\033[31mYou only choose [1/2]!!!\033[0m"
. $0

esac

}

case $GLOBAL_CHOICE in
1)
    ip_config
    ;;
2)
    apache_config	
    ;;
3)
    find_file	
    ;;
4)
    docker_config
    ;;
5)
    ssh_conf
    ;;
6)
    exit
    ;;
*)
    clear
    echo -e "\033[31m  =====================================\033[0m"
    echo -e "\033[31m      Usage:You only choose 1,2,3!!\033[0m"
    echo -e "\033[31m  =====================================\033[0m"
    menu
esac
}
clear
menu

