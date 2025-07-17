import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sf/features/home/repository/home_repository.dart';

import '../state/campaigns_state.dart';

part 'get_campaigns_view_model.g.dart';

@Riverpod(keepAlive: false)
class GetCampaignsViewModel extends _$GetCampaignsViewModel {
  @override
  FutureOr<CampaignsState> build() async {
    return CampaignsState();
  }

  Future<void> getCampaignsList() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(homeRepositoryProvider).getCampaigns();
      if (result.isNotEmpty) {
        state = AsyncData(CampaignsState(data: result));
      } else {
        state = AsyncData(
          CampaignsState(
            data: [],
          ),
        );
      }
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
