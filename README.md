# Tasks-List

**Tasks-List** es una herramienta CLI para gestionar tus tareas directamente desde la terminal en Linux. Permite añadir, borrar, modificar y listar tareas, con soporte de colores y filtrado por estado o prioridad. Esta es la **primera versión** del proyecto.

---

## Prerrequisitos

Para que todo funcione correctamente, necesitas:

* Una terminal que soporte colores.
* El comando `fdfind` instalado.
* Prefriblemente tener todos los archivos del proyecto en la **misma carpeta**.
* Prefriblemente evitar tener otros ficheros en tu sistema con los mismos nombres (`task.sh`, `task.db`, `functions.sh`, `funciones.sh`).

---

## Instalación / Descarga

Puedes obtener el proyecto clonando el repositorio:

```bash
git clone <URL_DEL_REPOSITORIO>
```

O descargando el ZIP y descomprimiéndolo en tu máquina Linux.

Una vez descargado, asegúrate de que `task.sh`, `funtions.sh` y `funciones.sh` tiene permisos de ejecución:

```bash
chmod +x task.sh
chmod +x funtions.sh
chmod +x funciones.sh
```

---

## Archivos principales

* `task.sh` → Script principal, ejecutable, desde el cual se accede a todas las funciones.
* `task.db` → Fichero donde se guardan las tareas. El script lo crea automáticamente si no existe.
* `functions.sh` → Funciones principales de cada opción.
* `functions_aux.sh` → Funciones auxiliares para colores y estética de la terminal.

---

## Uso

Ejecuta el script principal seguido de la opción que desees:

```bash
./task.sh -opcion
```

### Opciones disponibles

* `-l` → Ver todas las tareas.
* `-f` → Filtrar tareas por estado o prioridad (opcional).
* `-a` → Añadir nuevas tareas.
* `-d` → Borrar tareas existentes.
* `-e` → Modificar el estado de una tarea.
* `-p` → Modificar la prioridad de una tarea.
* `-h` → Mostrar la ayuda incorporada en el comando.

---

### Ejemplos

* Listar todas las tareas:

```bash
./task.sh -l
```

* Listar solo tareas pendientes:

```bash
./task.sh -l -en
```

* Añadir una nueva tarea:

```bash
./task.sh -a
```

* Marcar la tarea 2 como completada:

```bash
./task.sh -e 2
```

* Cambiar la prioridad de la tarea 3:

```bash
./task.sh -p 3
```

---

## Notas

* Todas las tareas se guardan en el mismo directorio, en `task.db`.
* Los colores ayudan a diferenciar estado y prioridad, facilitando la lectura.
* Esta es la **primera versión**, por lo que nuevas funcionalidades y mejoras pueden añadirse en el futuro.

---
