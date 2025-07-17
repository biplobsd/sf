import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/campaign.dart';

part 'campaigns_state.freezed.dart';
part 'campaigns_state.g.dart';

@freezed
abstract class CampaignsState with _$CampaignsState {
  const factory CampaignsState({
    @Default([]) List<Campaign> data,
  }) = _CampaignsState;

  factory CampaignsState.fromJson(Map<String, Object?> json) =>
      _$CampaignsStateFromJson(json);
}
