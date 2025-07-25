import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/home_repository.dart';
import '../state/restaurants_state.dart';

part 'get_restaurants_view_model.g.dart';

@Riverpod(keepAlive: true)
class GetRestaurantsViewModel extends _$GetRestaurantsViewModel {
  int _currentOffset = 1;
  bool _hasMore = true;

  @override
  FutureOr<RestaurantsState> build() async {
    return const RestaurantsState();
  }

  Future<void> getAll({
    int limit = 3,
    bool isReset = false,
  }) async {
    if (isReset) {
      reset();
    }

    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(homeRepositoryProvider)
          .getRestaurants(offset: _currentOffset, limit: limit);

      final int totalPages = (result.totalSize / limit).ceil();
      _hasMore = _currentOffset < totalPages;

      state = AsyncData(
        RestaurantsState(
          data: result.restaurants,
          hasMore: _hasMore,
          currentOffset: _currentOffset,
        ),
      );

      _currentOffset++;
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  void reset() {
    _currentOffset = 1;
    _hasMore = true;
  }
}
