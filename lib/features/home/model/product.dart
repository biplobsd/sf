import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String name,
    required double price,
    @JsonKey(name: 'image_full_url') required String imageFullUrl,
    @JsonKey(name: 'restaurant_name') required String restaurantName,
    @JsonKey(name: 'avg_rating') required double avgRating,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
