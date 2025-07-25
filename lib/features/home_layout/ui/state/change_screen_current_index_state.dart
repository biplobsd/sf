import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_screen_current_index_state.freezed.dart';
part 'change_screen_current_index_state.g.dart';

@freezed
abstract class ChangeScreenCurrentIndexState
    with _$ChangeScreenCurrentIndexState {
  const factory ChangeScreenCurrentIndexState({
    @Default(0) int? index,
  }) = _ChangeScreenCurrentIndexState;

  factory ChangeScreenCurrentIndexState.fromJson(Map<String, Object?> json) =>
      _$ChangeScreenCurrentIndexStateFromJson(json);
}
