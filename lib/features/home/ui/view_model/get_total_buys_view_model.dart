import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/get_total_repository.dart';
import '../state/get_total_state.dart';

part 'get_total_buys_view_model.g.dart';

@Riverpod(keepAlive: false)
class GetTotalBuysViewModel extends _$GetTotalBuysViewModel {
  late DateTime datetime;

  @override
  FutureOr<GetTotalState> build() async {
    final now = DateTime.now();
    datetime = DateTime(now.year, now.month, now.day);
    fetchTotal();
    return GetTotalState();
  }

  Future<void> fetchTotal() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref
          .read(getTotalRepositoryProvider)
          .getTotalBuysForDate(datetime);
      if (result != null) {
        state = AsyncData(GetTotalState(total: result));
      } else {
        state = AsyncData(GetTotalState(total: 0));
      }
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  toDaily() {
    final now = DateTime.now();
    datetime = DateTime(now.year, now.month, now.day);
    fetchTotal();
  }

  toWeekly() {
    final now = DateTime.now();
    datetime = DateTime(now.year, now.month, now.day - 7);
    fetchTotal();
  }

  toMonthly() {
    final now = DateTime.now();
    datetime = DateTime(now.year, now.month - 1, now.day);
    fetchTotal();
  }
}
