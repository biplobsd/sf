import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/banners.dart';
import '../../repository/home_repository.dart';
import '../state/banners_state.dart';

part 'get_banners_view_model.g.dart';

@Riverpod(keepAlive: false)
class GetBannersViewModel extends _$GetBannersViewModel {
  @override
  FutureOr<BannersState> build() async {
    return BannersState();
  }

  Future<void> getBannerList() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(homeRepositoryProvider).getBanners();
      if (result.banners.isNotEmpty) {
        state = AsyncData(BannersState(data: result));
      } else {
        state = AsyncData(
          BannersState(
            data: Banners(
              banners: [],
            ),
          ),
        );
      }
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
