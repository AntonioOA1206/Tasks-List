#!/bin/bash

rut_work=$(fdfind -1 -g "task.sh" /home/$(logname)/ | xargs dirname)

source $rut_work/funciones.sh
source $rut_work/funtions.sh

db=$(fdfind -1 -g "task.db" /home/$(logname)/)

if [ -z $db ];then
	touch $rut_work/task.db
fi

declare -A tareas

while getopts "lahd:e:" opt;do
	case $opt in
		l)
			fver
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
		h)
			fhelp
		;;
		*)
			fcolores 31 ESTA OPCION NO EXISTE
			fcolores 33 "Utiliza la opcion -h para mas ayuda"
		;;
	esac
done
