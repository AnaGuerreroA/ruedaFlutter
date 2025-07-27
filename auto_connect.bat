@echo off
title Flutter ADB Auto-Connect

REM Configuración
set DEVICE_IP=192.168.1.86
set DEFAULT_PORT=5555
set PAIR_PORT=35249

echo =========================================
echo  Flutter ADB Auto-Connect (Post-Pairing)
echo =========================================
echo.

echo [1/5] Reiniciando ADB...
adb kill-server >nul 2>&1
adb start-server >nul 2>&1

echo [2/5] Intentando conexión en puerto por defecto (%DEFAULT_PORT%)...
adb connect %DEVICE_IP%:%DEFAULT_PORT% >nul 2>&1

timeout /t 2 >nul

echo [3/5] Verificando conexión...
adb devices | find "%DEVICE_IP%:%DEFAULT_PORT%" >nul
if %errorlevel% == 0 (
    echo ✅ Conectado en puerto %DEFAULT_PORT%
    goto :success
)

echo [4/5] Puerto por defecto falló, intentando puerto de pairing (%PAIR_PORT%)...
adb connect %DEVICE_IP%:%PAIR_PORT% >nul 2>&1

timeout /t 2 >nul

adb devices | find "%DEVICE_IP%:%PAIR_PORT%" >nul
if %errorlevel% == 0 (
    echo ✅ Conectado en puerto %PAIR_PORT%
    echo ⚠️  Considera cambiar a puerto %DEFAULT_PORT% para conexiones futuras
    goto :success
)

echo [5/5] Intentando detectar puerto automáticamente...
echo Buscando dispositivos disponibles...
adb devices

echo.
echo ❌ No se pudo conectar automáticamente
echo.
echo 💡 Soluciones:
echo 1. Verifica que la depuración inalámbrica esté ACTIVADA
echo 2. Ambos dispositivos deben estar en la misma red WiFi
echo 3. Si acabas de hacer pairing, usa: adb connect %DEVICE_IP%:5555
echo 4. Revisa la IP actual del dispositivo en Configuración WiFi
echo.
goto :end

:success
echo.
echo --- Estado actual ---
adb devices
echo.
echo --- Dispositivos Flutter ---
flutter devices
echo.
echo ✅ ¡Conexión establecida!
echo.
echo 🚀 Comandos disponibles:
echo    flutter run              - Ejecutar en el dispositivo conectado
echo    flutter run -d android   - Forzar ejecución en Android
echo    adb devices              - Ver dispositivos conectados
echo.

:end
pause
