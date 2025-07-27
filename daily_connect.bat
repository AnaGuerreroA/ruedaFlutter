@echo off
title Daily Flutter Connect

REM IP de tu dispositivo (cámbiala si es necesaria)
set DEVICE_IP=192.168.1.86

echo ============================
echo  Conexión Diaria Flutter
echo ============================
echo.

echo 📱 Conectando a %DEVICE_IP%...

REM Reiniciar ADB silenciosamente
adb kill-server >nul 2>&1
adb start-server >nul 2>&1

REM Intentar conexión en puerto estándar
adb connect %DEVICE_IP%:5555 >nul 2>&1
timeout /t 2 >nul

REM Verificar si está conectado
adb devices | find "%DEVICE_IP%" >nul
if %errorlevel% == 0 (
    echo ✅ ¡Conectado exitosamente!
    echo.
    flutter devices
    echo.
    echo 🚀 Listo para: flutter run
) else (
    echo ❌ No conectado. Ejecuta auto_connect.bat para diagnóstico completo
)

echo.
echo Presiona cualquier tecla para cerrar...
pause >nul
