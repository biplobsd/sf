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
    int limit = 2,
    bool isRefresh = false,
    bool isReset = false,
  }) async {
    if (isReset) {
      reset();
    }

    if (isRefresh) {
      _currentOffset = 1;
      _hasMore = true;
    }
    if (!_hasMore && !isRefresh) return;

    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(homeRepositoryProvider)
          .getRestaurants(offset: _currentOffset, limit: limit);

      if (result.length < limit) _hasMore = false;

      state = AsyncData(
        RestaurantsState(
          data: result,
          hasMore: _hasMore,
          currentOffset: _currentOffset,
        ),
      );

      _currentOffset++;
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  Future<void> refresh() async {
    await getAll(
      isRefresh: true,
    );
  }

  void reset() {
    _currentOffset = 1;
    _hasMore = true;
  }
}
