#!/bin/bash

#No se usa en este proyecto
function fclear (
	read -p "¿Quieres limpiar la pantalla (S/n)? " l
	if [ -z $l ] || [ $l = "s" ] || [ $l = "S" ];then
		clear
	fi
)

#Colorea los echos
function fcolores (
	echo -e "\e[${1}m${@:2}\e[0m"
)

#No se usa en este proyecto
function frcolores (
	echo -e "${@}" | lolcat
)

#No se usa en este proyecto
function fvaca (
	cop=$(ls /usr/share/cowsay/cows/ | cut -d " " -f2 | shuf -n1 | cut -d "." -f1)
	cowsay -f $cop $@ | lolcat
)

