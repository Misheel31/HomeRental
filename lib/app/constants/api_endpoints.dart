class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";

// ============Auth==================
  static const String login = "auth/login";
  static const String register = "auth/register";

  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "user/uploadImage";
  static const String getAllProperties = 'property/properties';
  static const String deletePropertyById = 'property/properties/:id';
  static const String createProperty = 'property/properties/create';
}
