@echo off
setlocal EnableDelayedExpansion

REM Script avanzado que guarda la última IP conocida
set CONFIG_FILE=%~dp0device_config.txt
set DEVICE_IP=192.168.1.86

REM Leer IP guardada si existe
if exist "%CONFIG_FILE%" (
    for /f "tokens=2 delims==" %%i in ('findstr "LAST_IP" "%CONFIG_FILE%"') do (
        set DEVICE_IP=%%i
    )
)

echo Usando IP: !DEVICE_IP! (desde config)

REM Función de conexión
adb kill-server >nul 2>&1
adb start-server >nul 2>&1
adb connect !DEVICE_IP!:5555 >nul 2>&1
timeout /t 2 >nul

REM Verificar y guardar si funciona
adb devices | find "!DEVICE_IP!" >nul
if %errorlevel% == 0 (
    echo LAST_IP=!DEVICE_IP! > "%CONFIG_FILE%"
    echo LAST_CONNECTION=%date% %time% >> "%CONFIG_FILE%"
    echo ✅ Conectado y configuración guardada
    flutter devices
) else (
    echo ❌ Falló con IP guardada. Ejecuta auto_connect.bat
)

pause
