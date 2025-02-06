import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_property_dto.g.dart';

@JsonSerializable()
class GetAllPropertyDto {
  final bool success;
  final int count;
  final List<PropertyApiModel> data;

  GetAllPropertyDto(
      {required this.count, required this.success, required this.data});

  Map<String, dynamic> toJson() => _$GetAllPropertyDtoToJson(this);

  factory GetAllPropertyDto.fromJson(Map<String, dynamic> json) =>
      _$GetAllPropertyDtoFromJson(json);
}
