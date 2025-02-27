import 'package:home_rental/features/booking/data/model/booking_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_booking_dto.g.dart';

@JsonSerializable()
class GetBookingDto {
  late final bool success;
  late final int count;
  late final List<BookingApiModel> data;

  GetBookingDto(
      {required this.count, required this.success, required this.data});

  Map<String, dynamic> toJson() => _$GetBookingDtoToJson(this);

  factory GetBookingDto.fromJson(Map<String, dynamic> json) =>
      _$GetBookingDtoFromJson(json);
}
