import 'package:freezed_annotation/freezed_annotation.dart';

import 'banner.dart';

part 'banners.freezed.dart';
part 'banners.g.dart';

@freezed
abstract class Banners with _$Banners {
  const factory Banners({
    @Default([]) List<Banner> banners,
  }) = _Banners;

  factory Banners.fromJson(Map<String, Object?> json) =>
      _$BannersFromJson(json);
}
