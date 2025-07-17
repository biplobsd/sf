import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sf/features/home/repository/home_repository.dart';

import '../../model/products.dart';
import '../state/products_state.dart';

part 'get_products_view_model.g.dart';

@Riverpod(keepAlive: false)
class GetProductsViewModel extends _$GetProductsViewModel {
  @override
  FutureOr<ProductsState> build() async {
    return ProductsState();
  }

  Future<void> getProductList() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(homeRepositoryProvider).getProducts();
      if (result.products.isNotEmpty) {
        state = AsyncData(ProductsState(data: result));
      } else {
        state = AsyncData(
          ProductsState(
            data: Products(
              products: [],
            ),
          ),
        );
      }
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
