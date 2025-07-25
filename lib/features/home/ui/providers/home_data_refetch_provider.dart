import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../view_model/get_banners_view_model.dart';
import '../view_model/get_campaigns_view_model.dart';
import '../view_model/get_categories_view_model.dart';
import '../view_model/get_products_view_model.dart';
import '../view_model/get_restaurants_view_model.dart';

part 'home_data_refetch_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeDataRefetchProvider extends _$HomeDataRefetchProvider {
  @override
  void build() {}

  Future<void> now() async {
    await Future.wait([
      ref.read(getBannersViewModelProvider.notifier).getBannerList(),
      ref.read(getCategoriesViewModelProvider.notifier).getCategoriesList(),
      ref.read(getProductsViewModelProvider.notifier).getProductList(),
      ref.read(getCampaignsViewModelProvider.notifier).getCampaignsList(),
      ref.read(getRestaurantsViewModelProvider.notifier).getAll(isReset: true),
    ]);
  }
}
