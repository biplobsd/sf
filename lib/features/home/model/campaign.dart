import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign.freezed.dart';
part 'campaign.g.dart';

@freezed
abstract class Campaign with _$Campaign {
  const factory Campaign({
    @JsonKey(name: 'image_full_url') required String imageFullUrl,
    @JsonKey(name: 'restaurant_name') required String restaurantName,
    @JsonKey(name: 'rating_count') required int ratingCount,
    required String name,
    required double price,
    required int discount,
  }) = _Campaign;

  factory Campaign.fromJson(Map<String, Object?> json) =>
      _$CampaignFromJson(json);
}
