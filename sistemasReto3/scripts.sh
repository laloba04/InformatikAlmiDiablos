#!/bin/bash

while true; do
    clear
    echo "================================================"
    echo "================= Menú Diablos ================="
    echo "================================================"
    echo "Seleccione una opción:"
    echo "1. Copia de seguridad" 
    echo "2. Dime que programa quieres instalar?" 
    echo "3. Actualizaciones del sistema" 
    echo "4. Monitorización del sistema" 
    echo "5. Mostrar espacio en disco"
    echo "6. Ver archivos en el directorio actual" 
    echo "7. Buscar archivos en el sistema" 
    echo "8. Mostrar el ultimo usuario creado" 
    echo "9. Salir" 

    read -p "Ingrese el número de la opción: " opcion

    case $opcion in

        1)
            # Copia de seguridad
            echo "Iniciando copia de seguridad..."
            read -p "¿De qué usuario quieres hacer el backup?: " backup
            read -p "¿Dónde quieres hacer el backup?: " ruta
            fecha_backup=$(date +%y-%m-%d)
            backup_dir="$ruta/$fecha_backup"
            
            # Verifica si la ruta de destino existe
            if [ ! -d "$backup_dir" ]; then
                sudo mkdir -p "$backup_dir"
            fi

            sudo cp -r "/home/$backup" "$backup_dir"
            echo "Copia de seguridad completada en: $backup_dir"
            ;;

        2)
            # Programa a instalar
            read -p "¿que programa quieres instalar?: " instalar
            sudo apt install $instalar
            ;;

        3)
            # Actualizaciones del sistema
            echo "Buscando actualizaciones..."
            sudo apt update && sudo apt upgrade -y
            echo "Actualización completada."
            ;;

        4)
            # Monitorización del sistema
            echo "Mostrando uso del sistema:"
            echo "Uso de CPU:"
            top -b -n 1 | grep "Cpu(s)"
            echo "Uso de Memoria:"
            free -m
            echo "Uso de Almacenamiento:"
            df -h
            ;;

        5)
            # Mostrar espacio en disco
            echo "Mostrando espacio en disco:"
            df -h
            ;;

        6)
            # Ver archivos en el directorio actual
            echo "Archivos en el directorio actual:"
            ls
            ;;

        7)
            # Buscar archivos en el sistema
            read -p "Ingrese el nombre del archivo a buscar: " nombre_archivo
            echo "Buscando archivos con el nombre '$nombre_archivo'..."
            
            # Utiliza el comando find para buscar archivos con el nombre proporcionado
            find / -type f -name "$nombre_archivo" 2>/dev/null
            
            echo "Búsqueda completada."
            ;;

        8)
            # Ultimo usuario creado
            echo A continuacion mostraremos el ultimo usuario creado:
            tail -n1 /etc/passwd | cut -d ":" -f1
            ;;

        9)
            # Salir del script
            echo "¡Hasta luego!"
            exit
            ;;

        *)
            # Opción no válida
            echo "Opción no válida. Inténtalo de nuevo."
            ;;
    esac

    read -p "Presione Enter para continuar..."
done
