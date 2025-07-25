import 'package:freezed_annotation/freezed_annotation.dart';

import 'restaurant.dart';

part 'restaurants.freezed.dart';
part 'restaurants.g.dart';

@freezed
abstract class Restaurants with _$Restaurants {
  const factory Restaurants({
    required List<Restaurant> restaurants,
    @JsonKey(name: 'total_size') required int totalSize,
  }) = _Restaurants;

  factory Restaurants.fromJson(Map<String, Object?> json) =>
      _$RestaurantsFromJson(json);
}
