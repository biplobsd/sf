import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/uris.dart';
import '../../common/remote/api_client.dart';
import '../model/banners.dart';
import '../model/campaign.dart';
import '../model/category.dart';
import '../model/products.dart';
import '../model/restaurants.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: false)
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(ref);
}

class HomeRepository {
  final Ref _ref;
  late final ApiClient _apiClient;

  HomeRepository(this._ref) {
    _apiClient = _ref.watch(apiClientProvider);
  }

  Future<Banners> getBanners() async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(Uris.banners);
      return Banners.fromJson(response);
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get<dynamic>(Uris.categories);
      final categories =
          response.map((json) => Category.fromJson(json)).toList();
      return categories.cast<Category>();
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<Products> getProducts() async {
    try {
      final response =
          await _apiClient.get<Map<String, dynamic>>(Uris.popularFoods);
      return Products.fromJson(response);
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await _apiClient.get<dynamic>(Uris.campaigns);
      final campaigns =
          response.map((json) => Campaign.fromJson(json)).toList();
      return campaigns.cast<Campaign>();
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<Restaurants> getRestaurants({
    int offset = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient
          .get<Map<String, dynamic>>(Uris.restaurants, queryParameters: {
        'offset': offset,
        'limit': limit,
      });

      return Restaurants.fromJson(response);
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }
}
