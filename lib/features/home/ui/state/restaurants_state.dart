import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/restaurant.dart';

part 'restaurants_state.freezed.dart';
part 'restaurants_state.g.dart';

@freezed
abstract class RestaurantsState with _$RestaurantsState {
  const factory RestaurantsState({
    @Default([]) List<Restaurant> data,
    @Default(0) int currentOffset,
    @Default(null) bool? hasMore,
  }) = _RestaurantsState;

  factory RestaurantsState.fromJson(Map<String, Object?> json) =>
      _$RestaurantsStateFromJson(json);
}
