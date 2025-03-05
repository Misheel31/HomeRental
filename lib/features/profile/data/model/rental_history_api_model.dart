class RentalHistoryModel {
  final String propertyTitle;
  final String checkInDate;
  final String checkOutDate;
  final double price;

  RentalHistoryModel({
    required this.propertyTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.price,
  });

  factory RentalHistoryModel.fromJson(Map<String, dynamic> json) {
    return RentalHistoryModel(
      propertyTitle: json['propertyTitle'],
      checkInDate: json['checkInDate'],
      checkOutDate: json['checkOutDate'],
      price: json['price'].toDouble(),
    );
  }
}
