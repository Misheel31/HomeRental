class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.1.70:3000/api/";
  // static const String baseUrl = "http://10.1.1.54:3000/api/";

// ============Auth==================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getUser = 'user/:id';
  static const String updateUser = 'user/:id';

  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "user/uploadImage";
  static const String getAllProperties = 'property/properties';
  static const String deletePropertyById = 'property/properties/:id';
  static const String createProperty = 'property/properties/create';

  static const String deleteBooking = 'booking/cancel/:bookingId';
  static const String confirmBooking = 'booking/checkout/:bookingId';
  static const String getBooking = 'booking/:username';
  static const String createBooking = 'booking/create';

  static const String addToWishlist = 'wishlist/create';
  static const String getWishlist = 'wishlist/:username';
  static const String removeWishlist = 'wishlist/:id';

  static const String updateProfile = 'user/:id';
  static const String renatlHistory = 'user/:username/rental-history';
}
