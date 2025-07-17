import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/category.dart';

part 'categories_state.freezed.dart';
part 'categories_state.g.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default([]) List<Category> data,
  }) = _CategoriesState;

  factory CategoriesState.fromJson(Map<String, Object?> json) =>
      _$CategoriesStateFromJson(json);
}
