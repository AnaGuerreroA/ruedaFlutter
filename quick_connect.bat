@echo off
title Flutter Device Connector

REM Configuración - Cambia esta IP por la de tu dispositivo
set DEVICE_IP=192.168.1.86
set DEVICE_PORT=39345

REM Nota: Después de adb pair, usa puerto 5555 para conexión permanente
REM Solo usa otros puertos para el pairing inicial

echo ================================
echo  Flutter ADB Wireless Connector
echo ================================
echo.

echo [1/4] Reiniciando ADB...
adb kill-server >nul 2>&1
adb start-server >nul 2>&1

echo [2/4] Conectando a %DEVICE_IP%:%DEVICE_PORT%...
adb connect %DEVICE_IP%:%DEVICE_PORT%

echo [3/4] Esperando dispositivo...
timeout /t 3 >nul

echo [4/4] Verificando conexión...
echo.
echo --- Dispositivos ADB ---
adb devices
echo.
echo --- Dispositivos Flutter ---
flutter devices
echo.

REM Verificar si el dispositivo está conectado
for /f "tokens=1" %%i in ('adb devices ^| find "%DEVICE_IP%"') do (
    if "%%i"=="%DEVICE_IP%:%DEVICE_PORT%" (
        echo ✅ ¡Dispositivo conectado exitosamente!
        echo.
        echo Puedes ejecutar: flutter run
        goto :end
    )
)

echo ❌ No se pudo conectar al dispositivo
echo.
echo Soluciones:
echo 1. Verifica que el dispositivo esté en la misma red WiFi
echo 2. Verifica que la depuración inalámbrica esté activada
echo 3. Actualiza la IP en este script si cambió

:end
echo.
pause
