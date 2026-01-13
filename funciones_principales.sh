#!/bin/bash

#Lee la BBDD y añade todas las tareas al array "bidimensionales"
function fleer() {

	while IFS=":" read -r ID task est prio;do
		tareas[$ID,id]=$ID
		tareas[$ID,tarea]=$task
		tareas[$ID,estado]=$est
		tareas[$ID,prioridad]=$prio
		i=$ID
	done < $db
	#Deja el indice preparado con uno mas para proximos usos
	i=$(($i+1))
}

#Funcion que muestra el menu de ayuda
function fhelp (

	while true;do
		echo ""
		echo "OPCIONES DISPONIBLES:"
		fcolores 94 -------------------------------
		fcolores 33 "-l Ver todas las tareas"
		fcolores 32 "-f yz Para filtrar. Se usa junto a la opcion -l donde y es si quieres filtrar por estado (e) o prioridad (p) y "
		fcolores 32 "z es para elegir el estado ( Terminada con t y Por hacer con n) o la prioridad ( Alta con a, Media con m y Baja con b)"
		fcolores 33 "-a Añadir una nueva tarea"
		fcolores 33 "-d x Eliminar una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-e x Cambiar el estado de una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-p x Cambiar la prioridad de una tarea (donde x es el ID de la tarea)"
		fcolores 33 "-h Desplegar este menu de ayuda"
		fcolores 94 -------------------------------
		echo "Pulsa la tecla q para salir"
		#Decidir cuando quieres salir del menu
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

#Funcion que muestra las tareas en formato tabla
function fver() {

	fleer

	echo "---------------------------------"
	echo "ID | Tarea | Estado | Prioridad |"
	echo "---------------------------------"

	#Si no hay argumentos se ha utilizado la opcion -l sola
	if [ $# -eq 0 ];then

		#Recorre todo el array mostrando todos los datos de la tarea
		j=1

		while [ $j -ne $i ];do
			echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
			echo -n " ${tareas[$j,tarea]} |"

			#Muestra el color del estado segun el que sea
			if [ "${tareas[$j,estado]}" == "Terminada" ];then
				echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"
			elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
				echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			#Muestra el color de la prioridad segun el que sea
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

	#Si se ha filtrado por el estado "terminada"
	elif [ $# -gt 0 ] && [ "$1" = "e" ] && [ "$2" = "t" ];then

		j=1

		while [ $j -ne $i ];do

			#Se muestran las tareas con estado "terminada" 
			if [ "${tareas[$j,estado]}" == "Terminada" ];then
				echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
				echo -n " ${tareas[$j,tarea]} |"
				echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"

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

			elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
				:
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			j=$(($j+1))
		done
		echo "---------------------------------"

	#Si se ha filtrado por el estado "terminada"
	elif [ $# -gt 0 ] && [ "$1" = "e" ] && [ "$2" = "n" ];then

		j=1

		#Se muestran las tareas con estado "por hacer" 
		while [ $j -ne $i ];do
			if [ "${tareas[$j,estado]}" == "Por hacer" ];then
				echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
				echo -n " ${tareas[$j,tarea]} |"
				echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"

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

			elif [ "${tareas[$j,estado]}" == "Terminada" ];then
				:
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			j=$(($j+1))
		done
		echo "---------------------------------"

	#Si se ha filtrado por la prioridad "baja"
	elif [ $# -gt 0 ] && [ "$1" = "p" ] && [ "$2" = "b" ];then

		j=1

		#Se muestran las tareas con prioridad "baja" 
		while [ $j -ne $i ];do
			if [ "${tareas[$j,prioridad]}" == "Baja" ];then

				echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
				echo -n " ${tareas[$j,tarea]} |"

				if [ "${tareas[$j,estado]}" == "Terminada" ];then
					echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"
				elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
					echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"
				else
					fcolores 31 ERROR EN LA BASE DE DATOS
				fi

				echo -n -e "\e[94m ${tareas[$j,prioridad]}\e[0m |"
				echo ""

			elif [ "${tareas[$j,prioridad]}" == "Alta" ];then
				:
			elif [ "${tareas[$j,prioridad]}" == "Media" ];then
				:
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			j=$(($j+1))
		done
		echo "---------------------------------"

	#Si se ha filtrado por la prioridad "media"
	elif [ $# -gt 0 ] && [ "$1" = "p" ] && [ "$2" = "m" ];then

		j=1

		#Se muestran las tareas con prioridad "media" 
		while [ $j -ne $i ];do
			if [ "${tareas[$j,prioridad]}" == "Media" ];then

				echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
				echo -n " ${tareas[$j,tarea]} |"

				if [ "${tareas[$j,estado]}" == "Terminada" ];then
					echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"
				elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
					echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"
				else
					fcolores 31 ERROR EN LA BASE DE DATOS
				fi

				echo -n -e "\e[33m ${tareas[$j,prioridad]}\e[0m |"
				echo ""

			elif [ "${tareas[$j,prioridad]}" == "Alta" ];then
				:
			elif [ "${tareas[$j,prioridad]}" == "Baja" ];then
				:
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			j=$(($j+1))
		done
		echo "---------------------------------"

	#Si se ha filtrado por la prioridad "alta"
	elif [ $# -gt 0 ] && [ "$1" = "p" ] && [ "$2" = "a" ];then

		j=1

		#Se muestran las tareas con prioridad "alta" 
		while [ $j -ne $i ];do
			if [ "${tareas[$j,prioridad]}" == "Alta" ];then

				echo -n -e "\e[33m[${tareas[$j,id]}]\e[0m |"
				echo -n " ${tareas[$j,tarea]} |"

				if [ "${tareas[$j,estado]}" == "Terminada" ];then
					echo -n -e "\e[32m ${tareas[$j,estado]}\e[0m |"
				elif [ "${tareas[$j,estado]}" == "Por hacer" ];then
					echo -n -e "\e[33m ${tareas[$j,estado]}\e[0m |"
				else
					fcolores 31 ERROR EN LA BASE DE DATOS
				fi

				echo -n -e "\e[31m ${tareas[$j,prioridad]}\e[0m |"
				echo ""

			elif [ "${tareas[$j,prioridad]}" == "Baja" ];then
				:
			elif [ "${tareas[$j,prioridad]}" == "Media" ];then
				:
			else
				fcolores 31 ERROR EN LA BASE DE DATOS
			fi

			j=$(($j+1))
		done
		echo "---------------------------------"

	fi
}

#Funcion que añade tareas a la BBDD
function fadd() {

	fleer

	tareas[$i,id]=$i

	#Introducir la tarea
	while true;do
		read -p "Introduce la tarea: " tareas[$i,tarea]
		if [ -z "${tareas[$i,tarea]}" ];then
			fcolores 31 POR FAVOR, INTRODUZCA UNA TAREA
		else
			break
		fi
	done

	#Introducir el estado
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

	#Introducir la prioridad
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

	#Añadirla a la BBDD
	echo "${tareas[$i,id]}:${tareas[$i,tarea]}:${tareas[$i,estado]}:${tareas[$i,prioridad]}" >> $db
}

#Funcion que borra tareas
function fdel() {

	#Comprueba que el id este formado solo por numeros
	if [[ $1 =~ [0-9] ]];then

		fleer

		#Si introduces un ID no valido
		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO

		#Limpia la BBDD y vuelca todas las tareas salvo la borrada	
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

#Funcion que cambia el estado
function festado() {

	#Comprueba que el id este formado solo por numeros
	if [[ $1 =~ [0-9] ]];then

		fleer

		#Si introduces un ID no valido
		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO

		#Limpia la BBDD y vuelca todas las tareas pero cambiando el tema de la tarea elegida	
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

#Funcion que cambia la prioridad
function fprio() {

	#Comprueba que el id este formado solo por numeros
	if [[ $1 =~ [0-9] ]];then

		fleer

		#Si introduces un ID no valido
		if [ $1 -lt 1 ] || [ $1 -ge $i ];then
			fcolores 31 ID INVALIDO
		else

			#Pide la nueva prioridad para cambiarla en el array
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

			#Limpia la BBDD y vuelca todas las tareas

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
