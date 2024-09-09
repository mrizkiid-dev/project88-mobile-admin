abstract class ENV {
  static const String backendBaseUrl = String.fromEnvironment('BACKEND_BASE_URL', defaultValue: '');
  static const String testKey = String.fromEnvironment('PRIMARY_KEY', defaultValue: '');
}