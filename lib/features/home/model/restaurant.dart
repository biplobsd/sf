import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant.freezed.dart';
part 'restaurant.g.dart';

@freezed
abstract class Restaurant with _$Restaurant {
  const factory Restaurant({
    @JsonKey(name: 'cover_photo_full_url') required String coverPhotoFullUrl,
    @JsonKey(name: 'delivery_fee') required String deliveryFee,
    @JsonKey(name: 'rating_count') required int ratingCount,
    required String name,
    required String address,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, Object?> json) =>
      _$RestaurantFromJson(json);
}
