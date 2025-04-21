class AppConfig {
  static const String appName = 'Flutter Demo';
  static const String appVersion = '1.0.0';
  
  // Navigation Routes
  static const String homeRoute = '/';
  static const String detailRoute = '/detail';
  
  // Theme Colors
  static const int primaryColorValue = 0xFF6750A4; // Deep Purple
  static const int secondaryColorValue = 0xFF625B71;
  static const int tertiaryColorValue = 0xFF7D5260;
  
  // Text Styles
  static const double headlineFontSize = 24.0;
  static const double bodyFontSize = 16.0;
  static const double buttonFontSize = 14.0;
  
  // Padding and Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);
  
  // API Endpoints (if needed)
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  
  // Feature Flags
  static const bool enableDarkMode = true;
  static const bool enableAnimations = true;
  static const bool enableLogging = true;
  
  // Cache Settings
  static const int maxCacheSize = 100; // MB
  static const Duration cacheDuration = Duration(days: 7);
  
  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  
  // Success Messages
  static const String operationSuccess = 'Operation completed successfully.';
  static const String saveSuccess = 'Changes saved successfully.';
  
  // Validation Messages
  static const String requiredField = 'This field is required.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPassword = 'Password must be at least 6 characters.';
  
  // Button Labels
  static const String saveButton = 'Save';
  static const String cancelButton = 'Cancel';
  static const String deleteButton = 'Delete';
  static const String editButton = 'Edit';
  
  // Dialog Messages
  static const String confirmDelete = 'Are you sure you want to delete this item?';
  static const String confirmLogout = 'Are you sure you want to logout?';
  static const String unsavedChanges = 'You have unsaved changes. Do you want to discard them?';
} 