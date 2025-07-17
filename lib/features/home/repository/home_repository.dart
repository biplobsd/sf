import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/remote/api_client.dart';
import '../model/banners.dart';
import '../model/category.dart';

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
}
