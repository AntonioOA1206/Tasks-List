#!/bin/bash

#Definimos la ruta de trabajo para mas comodidad
rut_work=$(fdfind -1 -g "task.sh" /home/$(logname)/ | xargs dirname)

#Llamamos a los scripts con las funciones principales y auxiliares
source $rut_work/funciones_principales.sh
source $rut_work/funciones_auxiliares.sh

#Definimos la ruta absoluta de la BBDD para mas comodidad
db=$(fdfind -1 -g "task.db" /home/$(logname)/)

#Si la BBDD no existe se crea para evitar errores futuros 
if [ -z $db ];then
	touch $rut_work/task.db
fi

#Declaramos el array "bidimensional"
declare -A tareas

#Variable que indica si se ha elegido la opcion -l o no
ver=0

#Si no has introducido ningun argumento/opcion te da mensaje de error y te muestra el menu de ayuda
if [ $# -eq 0 ];then
	fcolores 31 NO HAS INTRODUCIDO NIGNUNA OPCION
	fhelp
else
	#Leer todas las opciones
	while getopts "lahd:e:p:f:" opt;do
		case $opt in
			f)
				#Opcion de filtrado que acompaña a -l. Elige los filtros.
				filt=$OPTARG
			;;
			l)
				#Establece que se ha utilizado la opcion -l
				ver=1
			;;
			a)
				#Opcion que añade una tarea
				fadd
			;;
			d)
				#Opcion que elimina una tarea por su ID
				fdel $OPTARG
			;;
			e)
				#Opcion que cambia el estado de una tarea por su ID
				festado $OPTARG
			;;
			p)
				#Opcion que cambia la prioridad de una tarea por su ID
				fprio $OPTARG
			;;
			h)
				#Opcion para mostrar el menu de ayuda
				fhelp
			;;
			*)
				#Si se introduce cualquier otra opcion no existente te da mensaje de error y te recuerdaque uses la opcion -h
				fcolores 31 ESTA OPCION NO EXISTE
				fcolores 33 "Utiliza la opcion -h para mas ayuda"
			;;
		esac
	done

	#Si se ha usado la opcion -l pero no la -f
	if [ -z $filt ] && [ $ver -eq 1 ];then
		#Muestra todas las tareas
		fver
	elif [ "$filt" = "et"  ] && [ $ver -eq 1 ];then
		#Llama a la funcion de ver las tareas filtrando por el estado "Terminado"
		fver "e" "t"
	elif [ "$filt" = "en"  ] && [ $ver -eq 1 ];then
		#Llama a la funcion de ver las tareas filtrando por el estado "Por hacer"
		fver "e" "n"
	elif [ "$filt" = "pb"  ] && [ $ver -eq 1 ];then
		#Llama a la funcion de ver las tareas filtrando por la prioridad "Baja"
		fver "p" "b"
	elif [ "$filt" = "pm"  ] && [ $ver -eq 1 ];then
		#Llama a la funcion de ver las tareas filtrando por la prioridad "Media"
		fver "p" "m"
	elif [ "$filt" = "pa"  ] && [ $ver -eq 1 ];then
		#Llama a la funcion de ver las tareas filtrando por la prioridad "Alta"
		fver "p" "a"
	fi
fi