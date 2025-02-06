import 'package:dio/dio.dart';
import 'package:home_rental/app/constants/api_endpoints.dart';
import 'package:home_rental/features/property/data/data_source/property_data_source.dart';
import 'package:home_rental/features/property/data/dto/get_all_property_dto.dart';
import 'package:home_rental/features/property/data/model/property_api_model.dart';
import 'package:home_rental/features/property/domain/entity/property_entity.dart';

class PropertyRemoteDatasource implements IPropertyDataSource {
  final Dio _dio;

  PropertyRemoteDatasource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> createProperty(PropertyEntity property) async {
    try {
      var propertyApiModel = PropertyApiModel.fromEntity(property);
      var response = await _dio.post(
        ApiEndpoints.createProperty,
        data: propertyApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProperty(String id, String? token) async {
    try {
      var response = await _dio.delete(ApiEndpoints.deletePropertyById + id,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PropertyEntity>> getAllProperties(
      {required String title,
      required String description,
      required String location,
      required String image,
      required double pricePerNight,
      required int bedCount,
      required int bedroomCount,
      required String city,
      required String state,
      required String country,
      required int guestCount,
      required int bathroomCount,
      required List<String> amenities}) async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllProperties);
      if (response.statusCode == 200) {
        GetAllPropertyDto propertyDTO =
            GetAllPropertyDto.fromJson(response.data);
        return PropertyApiModel.toEntityList(propertyDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception();
    }
  }
}
