import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/remote/api_client.dart';
import '../model/banners.dart';
import '../model/campaign.dart';
import '../model/category.dart';
import '../model/products.dart';

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
      final response =
          await _apiClient.get<Map<String, dynamic>>('/api/v1/banners');
      return Banners.fromJson(response);
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get<dynamic>('/api/v1/categories');
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
      final response = await _apiClient
          .get<Map<String, dynamic>>('/api/v1/products/popular');
      return Products.fromJson(response);
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }

  Future<List<Campaign>> getCampaigns() async {
    try {
      final response = await _apiClient.get<dynamic>('/api/v1/campaigns/item');
      final campaigns =
          response.map((json) => Campaign.fromJson(json)).toList();
      return campaigns.cast<Campaign>();
    } catch (e) {
      // Handle exceptions as needed
      rethrow;
    }
  }
}
