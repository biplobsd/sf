import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_total_repository.g.dart';

@Riverpod(keepAlive: true)
GetTotalRepository getTotalRepository(Ref ref) {
  return const GetTotalRepository();
}

class GetTotalRepository {
  const GetTotalRepository();

  Future<num?> getTotalBuysForDate(DateTime datetime) async {
    try {
      return 0;
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      rethrow;
    }
  }

  Future<num?> getTotalCountBuysForDate(DateTime datetime) async {
    try {
      return 0;
    } on Exception catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      rethrow;
    }
  }
}
