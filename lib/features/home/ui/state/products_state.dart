import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/products.dart';

part 'products_state.freezed.dart';
part 'products_state.g.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(null) Products? data,
  }) = _ProductsState;

  factory ProductsState.fromJson(Map<String, Object?> json) =>
      _$ProductsStateFromJson(json);
}
