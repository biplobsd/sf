import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sf/features/home/ui/providers/home_data_refetch_provider.dart';

import '../../../../constants/constants.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class OfflineContainer extends ConsumerStatefulWidget {
  final Widget? child;

  const OfflineContainer({super.key, required this.child});

  @override
  ConsumerState<OfflineContainer> createState() => _OfflineContainerState();
}

class _OfflineContainerState extends ConsumerState<OfflineContainer> {
  bool _isOffline = false;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    if (Platform.isIOS) return;

    setState(() {
      _isOffline = result.contains(ConnectivityResult.none);
    });
    if (kDebugMode) {
      debugPrint(
          '${Constants.tag} [_OfflineContainerState._updateConnectionStatus] $result => ${_isOffline ? 'offline' : 'online'}');
    }

    if (!_isOffline) {
      ref.read(homeDataRefetchProviderProvider.notifier).now();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOffline) return widget.child!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: widget.child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 2,
                bottom: 2,
              ),
              color: AppColors.mono60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.signal_wifi_connected_no_internet_4,
                    size: 16,
                    color: AppColors.mono0,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'offline',
                    style: AppTheme.bodyMedium14.copyWith(
                      color: AppColors.mono0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
