@echo off
echo Conectando dispositivo Android via ADB Wireless...

REM Reemplaza esta IP con la IP de tu dispositivo
set DEVICE_IP=192.168.1.86
set DEVICE_PORT=5555

echo Matando servidor ADB...
adb kill-server

echo Iniciando servidor ADB...
adb start-server

echo Conectando a %DEVICE_IP%:%DEVICE_PORT%...
adb connect %DEVICE_IP%:%DEVICE_PORT%

echo Verificando conexión...
adb devices

echo Verificando con Flutter...
flutter devices

echo ¡Listo! El dispositivo debería estar conectado.
pause
