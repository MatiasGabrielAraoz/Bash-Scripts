#!/bin/bash

# --- CONFIGURACIÓN DE LIMPIEZA ---
USER_LIMITADO="usuario_limitado"
# ---------------------------------

echo "Iniciando reversión de cambios..."

# 1. Eliminar usuarios creados por el script
echo "Eliminando usuarios de prueba..."
sudo userdel -r "$USER_LIMITADO" 2>/dev/null
# Nota: No eliminamos 'root', pero restauraremos su seguridad.

# 2. Desinstalar paquetes innecesarios o peligrosos
echo "Desinstalando paquetes instalados por el script..."
# Intentamos eliminar versiones específicas y software de prueba
sudo pacman -Rs openssh clueless-samba gedit --noconfirm 2>/dev/null

# 3. Restaurar OpenSSH a la versión oficial de los repositorios
echo "Reinstalando versión segura de OpenSSH..."
sudo pacman -S openssh --noconfirm

# 4. Resetear la contraseña de ROOT
echo "----------------------------------------------------------"
echo "IMPORTANTE: Vamos a cambiar la contraseña de ROOT."
echo "El script anterior la puso como 'root'. Por favor, elige una nueva:"
sudo passwd root

# 5. Limpiar archivos descargados
echo "Buscando y eliminando ISOs y archivos temporales..."
# Ajusta esta ruta si descargaste la ISO en otro lugar
rm -f ./archlinux-*.iso 2>/dev/null

# 6. Actualización completa para corregir dependencias rotas
echo "Sincronizando repositorios y actualizando sistema (Fix de dependencias)..."
sudo pacman -Syu --noconfirm

echo "----------------------------------------------------------"
echo "PROCESO COMPLETADO."
echo "Se recomienda revisar /etc/ssh/sshd_config manualmente para"
echo "asegurarte de que no haya configuraciones inseguras activas."
