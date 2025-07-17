import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/banners.dart';

part 'banners_state.freezed.dart';
part 'banners_state.g.dart';

@freezed
abstract class BannersState with _$BannersState {
  const factory BannersState({
    @Default(null) Banners? data,
  }) = _BannersState;

  factory BannersState.fromJson(Map<String, Object?> json) =>
      _$BannersStateFromJson(json);
}
