// Constantes de la aplicación
class AppConstants {
  // Información de la aplicación
  static const String appName = 'Rueda App';
  static const String appVersion = '1.0.0';
  
  // URLs y endpoints (ejemplo)
  static const String baseUrl = 'https://api.ejemplo.com';
  static const String apiVersion = 'v1';
  
  // Configuraciones de UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  static const double defaultBorderRadius = 8.0;
  static const double smallBorderRadius = 4.0;
  static const double largeBorderRadius = 16.0;
  
  // Timeouts
  static const int networkTimeout = 30; // segundos
  static const int cacheTimeout = 300; // segundos
  
  // Claves para SharedPreferences
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'app_theme';
  
  // Mensajes de error comunes
  static const String networkErrorMessage = 'Error de conectividad. Verifica tu conexión a internet.';
  static const String genericErrorMessage = 'Ha ocurrido un error inesperado. Intenta nuevamente.';
  static const String timeoutErrorMessage = 'La operación ha tardado demasiado. Intenta nuevamente.';
}
