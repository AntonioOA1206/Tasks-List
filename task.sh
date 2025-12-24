#!/bin/bash

rut_work=$(fdfind -1 -g "task.sh" /home/$(logname)/ | xargs dirname)

source $rut_work/funciones.sh
source $rut_work/funtions.sh

db=$(fdfind -1 -g "task.db" /home/$(logname)/)

if [ -z $db ];then
	touch $rut_work/task.db
fi

declare -A tareas

ver=0

while getopts "lahd:e:p:f:" opt;do
	case $opt in
		f)
			filt=$OPTARG
		;;
		l)
			ver=1
		;;
		a)
			fadd
		;;
		d)
			fdel $OPTARG
		;;
		e)
			festado $OPTARG
		;;
		p)
			fprio $OPTARG
		;;
		h)
			fhelp
		;;
		*)
			fcolores 31 ESTA OPCION NO EXISTE
			fcolores 33 "Utiliza la opcion -h para mas ayuda"
		;;
	esac
done

if [ -z $filt ] && [ $ver -eq 1 ];then
	fver
elif [ "$filt" = "et"  ] && [ $ver -eq 1 ];then
	fver "e" "t"
elif [ "$filt" = "en"  ] && [ $ver -eq 1 ];then
	fver "e" "n"
elif [ "$filt" = "pb"  ] && [ $ver -eq 1 ];then
	fver "p" "b"
elif [ "$filt" = "pm"  ] && [ $ver -eq 1 ];then
	fver "p" "m"
elif [ "$filt" = "pa"  ] && [ $ver -eq 1 ];then
	fver "p" "a"
fi
