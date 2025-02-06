// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPropertyDto _$GetAllPropertyDtoFromJson(Map<String, dynamic> json) =>
    GetAllPropertyDto(
      count: (json['count'] as num).toInt(),
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => PropertyApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPropertyDtoToJson(GetAllPropertyDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
