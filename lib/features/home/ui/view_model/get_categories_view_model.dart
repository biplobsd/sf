import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/home_repository.dart';
import '../state/categories_state.dart';

part 'get_categories_view_model.g.dart';

@Riverpod(keepAlive: false)
class GetCategoriesViewModel extends _$GetCategoriesViewModel {
  @override
  FutureOr<CategoriesState> build() async {
    return CategoriesState();
  }

  Future<void> getCategoriesList() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(homeRepositoryProvider).getCategories();
      if (result.isNotEmpty) {
        state = AsyncData(CategoriesState(data: result));
      } else {
        state = AsyncData(
          CategoriesState(
            data: [],
          ),
        );
      }
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }
}
