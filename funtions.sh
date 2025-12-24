#!/bin/bash

function fleer() {

	while IFS=":" read -r ID task est prio;do
		tareas[$ID,id]=$ID
		tareas[$ID,tarea]=$task
		tareas[$ID,estado]=$est
		tareas[$ID,prioridad]=$prio
		i=$ID
	done < $db
	i=$(($i+1))
}

function fhelp (

	while true;do
		echo ""
		echo "OPCIONES DISPONIBLES:"
		fcolores 94 -------------------------------
		fcolores 33 "-l Ver todas las tareas"
		fcolores 33 "-a Añadir una nueva tarea"
		fcolores 33 "-d x Eliminar una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-e x Cambiar el estado de una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-p x Cambiar la prioridad de una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-h Desplegar este menu de ayuda"
		fcolores 94 -------------------------------
		echo "Pulsa la tecla q para salir"
		read -n 1 -s -p ":" tcl
		case $tcl in
			q)
				echo ""
				break
			;;
			*)
				clear
			;;
		esac
	done
)

function fver() {

	fleer

	echo "---------------------------------"
	echo "ID | Tarea | Estado | Prioridad |"
	echo "---------------------------------"

	j=1

	while [ $j -ne $i ];do
		echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
		echo -n " ${tareas[$j,tarea]} |"

		if [ "${tareas[$j,estado]}" == "Terminada" ];then
			echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"
		elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
			echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"
		else
			fcolores 31 ERROR EN LA BASE DE DATOS
		fi

		if [ "${tareas[$j,prioridad]}" == "Alta" ];then
			echo -n -e "\e[31m ${tareas[$j,prioridad]}\e[0m |"
		elif [ "${tareas[$j,prioridad]}" == "Media" ];then
			echo -n -e "\e[33m ${tareas[$j,prioridad]}\e[0m |"
		elif [ "${tareas[$j,prioridad]}" == "Baja" ];then
			echo -n -e "\e[94m ${tareas[$j,prioridad]}\e[0m |"
		else
			fcolores 31 ERROR EN LA BASE DE DATOS
		fi

		echo ""
		j=$(($j+1))
	done
	echo "---------------------------------"
}

function fadd() {

	fleer

	tareas[$i,id]=$i

	while true;do
		read -p "Introduce la tarea: " tareas[$i,tarea]
		if [ -z "${tareas[$i,tarea]}" ];then
			fcolores 31 POR FAVOR, INTRODUZCA UNA TAREA
		else
			break
		fi
	done

	while true;do
		read -p "Introduce el estado (t/N): " tareas[$i,estado]
		case ${tareas[$i,estado]} in
			""|n|N)
				tareas[$i,estado]="Por hacer"
				break
			;;
			t)
				tareas[$i,estado]="Terminada"
				break
			;;
			*)
				fcolores 31 OPCION NO VALIDA
				fcolores 33 "Recuerda que las opciones son t (Terminada) o n (Por hacer)"
			;;
		esac
	done

	while true;do
		read -p "Introduce la prioridad (B/m/a): " tareas[$i,prioridad]
		case ${tareas[$i,prioridad]} in
			""|b|B)
				tareas[$i,prioridad]="Baja"
				break
			;;
			m)
				tareas[$i,prioridad]="Media"
				break
			;;
			a)
				tareas[$i,prioridad]="Alta"
				break
			;;
			*)
				fcolores 31 OPCION NO VALIDA
				fcolores 33 "Recuerda que las opciones son b (Baja), m (media) o a (alta)"
			;;
		esac
	done

	echo "${tareas[$i,id]}:${tareas[$i,tarea]}:${tareas[$i,estado]}:${tareas[$i,prioridad]}" >> $db
}

function fdel() {

	if [[ $1 =~ [0-9] ]];then

		fleer

		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO
		else
			: > $db

			j=1
			k=1

			while [ $j -lt $i ];do
				if [ ${tareas[$j,id]} -ne $1 ];then
					echo "$k:${tareas[$j,tarea]}:${tareas[$j,estado]}:${tareas[$j,prioridad]}" >> $db
					k=$(($k+1))
				fi
				j=$(($j+1))
			done
		fi
	else
		fcolores 31 ID INVALIDO
	fi
}

function festado() {

	if [[ $1 =~ [0-9] ]];then

		fleer

		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO
		else
			: > $db

			j=1

			while [ $j -lt $i ];do
				if [ ${tareas[$j,id]} -eq $1 ];then
					if [ "${tareas[$j,estado]}" = "Por hacer" ];then
						echo "${tareas[$j,id]}:${tareas[$j,tarea]}:Terminada:${tareas[$j,prioridad]}" >> $db
					elif [ "${tareas[$j,estado]}" = "Terminada" ];then
						echo "${tareas[$j,id]}:${tareas[$j,tarea]}:Por hacer:${tareas[$j,prioridad]}" >> $db
					else
						fcolores 31 ERROR EN LA BASE DE DATOS
					fi
				else
						echo "${tareas[$j,id]}:${tareas[$j,tarea]}:${tareas[$j,estado]}:${tareas[$j,prioridad]}" >> $db
				fi
				j=$(($j+1))
			done
		fi
	else
		fcolores 31 ID INVALIDO
	fi
}

function fprio() {

	if [[ $1 =~ [0-9] ]];then

		fleer

		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO
		else

			while true;do
				read -p "Introduce la nueva prioridad prioridad (B/m/a): " prio
				case $prio in
					""|b|B)
						prio="Baja"
						break
					;;
					m)
						prio="Media"
						break
					;;
					a)
						prio="Alta"
						break
					;;
					*)
						fcolores 31 OPCION NO VALIDA
						fcolores 33 "Recuerda que las opciones son b (Baja), m (media) o a (alta)"
					;;
				esac
			done

			: > $db

			j=1

			while [ $j -lt $i ];do
				if [ ${tareas[$j,id]} -eq $1 ];then
					if [ "${tareas[$j,prioridad]}" != "$prio" ];then
						echo "${tareas[$j,id]}:${tareas[$j,tarea]}:${tareas[$j,estado]}:$prio" >> $db
					fi
				else
						echo "${tareas[$j,id]}:${tareas[$j,tarea]}:${tareas[$j,estado]}:${tareas[$j,prioridad]}" >> $db
				fi
				j=$(($j+1))
			done
		fi
	else
		fcolores 31 ID INVALIDO
	fi
}
