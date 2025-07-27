@echo off
echo Configurando ADB Wireless en puerto 5555...

echo 1. Conecta tu dispositivo por USB primero
echo 2. Asegurate que la depuración USB esté activada
echo 3. Presiona cualquier tecla cuando esté conectado
pause

echo Verificando conexión USB...
adb devices

echo Configurando puerto TCP 5555...
adb tcpip 5555

echo Desconectando USB...
echo Ahora puedes desconectar el cable USB

echo Esperando 5 segundos...
timeout /t 5

echo Conectando via WiFi...
REM Reemplaza con tu IP
set /p DEVICE_IP=Ingresa la IP de tu dispositivo: 
adb connect %DEVICE_IP%:5555

echo Verificando conexión...
adb devices
flutter devices

pause
