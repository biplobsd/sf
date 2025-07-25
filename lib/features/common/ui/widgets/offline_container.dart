import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';
import '../../../../theme/gaps.dart';
import '../../../home/ui/providers/home_data_refetch_provider.dart';

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
            padding: EdgeInsets.only(top: 20.h),
            child: widget.child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top + 2.h,
                bottom: 2.h,
              ),
              color: AppColors.mono60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.wifi,
                    size: 16.r,
                    color: AppColors.mono0,
                  ),
                  gap1,
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
