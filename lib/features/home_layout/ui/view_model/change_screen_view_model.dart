import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/change_screen_state.dart';

part 'change_screen_view_model.g.dart';

@Riverpod(keepAlive: false)
class ChangeScreenViewModel extends _$ChangeScreenViewModel {
  @override
  FutureOr<ChangeScreenState> build() async {
    return ChangeScreenState();
  }

  Future<void> to(int index) async {
    state = const AsyncValue.loading();
    try {
      state = AsyncData(ChangeScreenState(
        index: index,
      ));
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
