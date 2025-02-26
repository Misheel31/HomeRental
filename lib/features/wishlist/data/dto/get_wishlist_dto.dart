import 'package:home_rental/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_wishlist_dto.g.dart';

@JsonSerializable()
class GetWishlistDto {
  late final bool success;
  late final int count;
  late final List<WishlistApiModel> data;

  GetWishlistDto(
      {required this.count, required this.success, required this.data});

  Map<String, dynamic> toJson() => _$GetWishlistDtoToJson(this);

  factory GetWishlistDto.fromJson(Map<String, dynamic> json) =>
      _$GetWishlistDtoFromJson(json);
}
