import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/change_screen_current_index_state.dart';

part 'change_screen_current_index_view_model.g.dart';

@Riverpod(keepAlive: false)
class ChangeScreenCurrentIndexViewModel
    extends _$ChangeScreenCurrentIndexViewModel {
  @override
  FutureOr<ChangeScreenCurrentIndexState> build() async {
    return ChangeScreenCurrentIndexState();
  }

  Future<void> to(int index) async {
    state = const AsyncValue.loading();
    try {
      state = AsyncData(ChangeScreenCurrentIndexState(
        index: index,
      ));
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
