import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner.freezed.dart';
part 'banner.g.dart';

@freezed
abstract class Banner with _$Banner {
  const factory Banner({
    @JsonKey(name: 'image_full_url') required String imageFullUrl,
  }) = _Banner;

  factory Banner.fromJson(Map<String, Object?> json) => _$BannerFromJson(json);
}
