# Rueda App

Una aplicación Flutter para el proyecto rueda de emociones.

## Descripción

Esta es una aplicación Flutter que implementa un círculo interactivo de emociones con navegación jerárquica a través de 3 niveles de emociones, desde las más generales hasta las más específicas.

## Características

- **Círculo de emociones interactivo** con 130 emociones organizadas en 3 niveles
- **Navegación jerárquica** entre emociones primarias, secundarias y específicas
- **Selección de intensidad** emocional del 1 al 10
- **Sistema de comentarios** para registrar contexto adicional
- **Botones de navegación** para retroceder entre niveles
- **Soporte multiidioma** (Inglés y Español)
- **Interfaz responsiva** con Material Design 3

## Instalación

1. Asegúrate de tener Flutter instalado en tu sistema
2. Clona o copia este proyecto
3. Ejecuta los siguientes comandos:

```bash
flutter pub get
flutter run
```

## Estructura del proyecto

```
lib/
  main.dart                      # Archivo principal de la aplicación
  models/
    circulo_emociones.dart       # Modelos de datos para emociones
  services/
    emociones_service.dart       # Servicio con 130 emociones
  screens/
    circulo_emociones_screen.dart # Pantalla principal del círculo
  widgets/
    circulo_emociones_widget.dart # Widget personalizado del círculo
  l10n/                          # Archivos de traducción
    app_en.arb                   # Traducciones en inglés
    app_es.arb                   # Traducciones en español
test/
  widget_test.dart               # Pruebas básicas
pubspec.yaml                     # Dependencias y configuración
l10n.yaml                        # Configuración de internacionalización
```

## Funcionalidades

### Navegación por Niveles
- **Nivel 1**: 7 emociones primarias (Alegría, Tristeza, Ira, etc.)
- **Nivel 2**: 41 emociones secundarias más específicas
- **Nivel 3**: 82 emociones muy detalladas para selección final

### Interacción
- Click para navegar entre niveles
- Selección directa en el nivel 3
- Botones de retroceso inteligentes
- Indicadores visuales del nivel actual

## Idiomas Soportados

- 🇺🇸 **Inglés (English)** - Idioma por defecto para dispositivos en inglés
- 🇪🇸 **Español (Spanish)** - Idioma por defecto para dispositivos en español

La aplicación detecta automáticamente el idioma del dispositivo y muestra la interfaz en el idioma correspondiente.

### Cambiar Idioma Manualmente

Para cambiar el idioma de la aplicación tienes **dos opciones**:

#### **Opción 1: Botón de Idioma en la App (Recomendado)**
1. Busca el icono 🌐 en la barra superior de la aplicación
2. Haz clic en el icono de idioma
3. Selecciona tu idioma preferido:
   - 🇪🇸 **Español**
   - 🇺🇸 **English**
4. La interfaz cambiará inmediatamente

#### **Opción 2: Configuración del Dispositivo**
**Android:**
1. Configuración → Sistema → Idiomas e introducción de texto
2. Selecciona español o inglés

**iOS:**
1. Configuración → General → Idioma y región
2. Selecciona el idioma preferido

### Textos Traducidos

Todos los elementos de la interfaz están traducidos:
- Títulos y navegación
- Botones y acciones  
- Mensajes de error y éxito
- Etiquetas de campos
- Indicadores de nivel y progreso
- **Selector de idioma con banderas** 🌐

### Funcionalidades del Selector de Idioma

- **Icono intuitivo**: 🌐 visible en todas las pantallas
- **Banderas**: 🇪🇸 🇺🇸 para identificación visual rápida
- **Cambio instantáneo**: La interfaz se actualiza inmediatamente
- **Persistencia**: El idioma seleccionado se mantiene durante la sesión

## Próximos pasos

- Exportar datos de emociones registradas
- Añadir más idiomas
- Implementar estadísticas y gráficos
- Sincronización en la nube

## Recursos útiles

- [Documentación de Flutter](https://docs.flutter.dev/)
- [Flutter Internationalization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization)
- [Material Design](https://m3.material.io/)