import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_total_state.freezed.dart';
part 'get_total_state.g.dart';

@freezed
abstract class GetTotalState with _$GetTotalState {
  const factory GetTotalState({
    @Default(0) num? total,
    String? errorMessage,
  }) = _GetTotalState;

  factory GetTotalState.fromJson(Map<String, Object?> json) =>
      _$GetTotalStateFromJson(json);
}
