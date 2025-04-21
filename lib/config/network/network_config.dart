class NetworkConfig {
  // Private constructor
  NetworkConfig._();

  // Singleton instance
  static final NetworkConfig shared = NetworkConfig._();

  // Static configuration values
  static const String protocol = 'https://';
  static const String host = 'jsonplaceholder.typicode.com';
  static const String baseUrl = '$protocol$host/';

  // API Endpoints
  static const String postsEndpoint = 'posts';
  static const String usersEndpoint = 'users';
  static const String commentsEndpoint = 'comments';
  static const String todosEndpoint = 'todos';

  // API Version
  static const String apiVersion = 'v1';

  // Timeout durations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Error messages
  static const String connectionError = 'Failed to connect to server';
  static const String timeoutError = 'Request timed out';
  static const String serverError = 'Server error occurred';

  // Helper methods
  String getFullUrl(String endpoint) => '$baseUrl$endpoint';
  
  Map<String, String> getHeaders([Map<String, String>? additionalHeaders]) {
    if (additionalHeaders == null) return defaultHeaders;
    return {...defaultHeaders, ...additionalHeaders};
  }

  String getUserPostUrl([Map<String, String>? additionalHeaders]) {
    return getFullUrl(usersEndpoint);
  }
}