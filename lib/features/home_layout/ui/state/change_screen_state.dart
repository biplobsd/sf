import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_screen_state.freezed.dart';
part 'change_screen_state.g.dart';

@freezed
abstract class ChangeScreenState with _$ChangeScreenState {
  const factory ChangeScreenState({
    @Default(0) int? index,
  }) = _ChangeScreenState;

  factory ChangeScreenState.fromJson(Map<String, Object?> json) =>
      _$ChangeScreenStateFromJson(json);
}
