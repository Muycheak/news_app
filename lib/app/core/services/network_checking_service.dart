import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/app/core/constants/app_enums.dart';

class NetworkCheckingService extends GetxService {
  static NetworkCheckingService get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final Rx<NetworkStatus> _networkStatus = NetworkStatus.online.obs;
  NetworkStatus get status => _networkStatus.value;
  Rx<NetworkStatus> get rxStatus => _networkStatus;

  StreamSubscription? _subscription;
  Timer? _qualityCheckTimer;
  bool _isStopped = false;
  bool _isNoInternetShowing = false;

  @override
  void onInit() {
    super.onInit();
    checkInitialStatus();
    _subscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
    );

    // Listen to network status changes to show/hide bottom sheet
    ever(_networkStatus, (status) {
      if (_isStopped) return;
      if (status == NetworkStatus.offline || status == NetworkStatus.poor) {
        if (!_isNoInternetShowing) {
          // TODO: Show bottom sheet for no internet
        }
      } else {
        // Close bottom sheet if it's currently showing
      }
    });
  }

  Future<void> checkInitialStatus() async {
    if (_isStopped) return;
    final result = await _connectivity.checkConnectivity();
    await _onConnectivityChanged(result);
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> result) async {
    if (_isStopped) return;
    if (result.isEmpty || result.contains(ConnectivityResult.none)) {
      _networkStatus.value = NetworkStatus.offline;
      _qualityCheckTimer?.cancel();
    } else {
      // If we have a connection (WiFi or Mobile), verify actual internet access and speed
      await checkNetworkQuality();
      // Periodically check quality if connected
      _qualityCheckTimer?.cancel();
      if (!_isStopped) {
        _qualityCheckTimer = Timer.periodic(
          const Duration(minutes: 1),
          (_) => checkNetworkQuality(),
        );
      }
    }
  }

  Future<void> checkNetworkQuality() async {
    if (_isStopped) return;
    try {
      final stopwatch = Stopwatch()..start();
      // Using a small request to check latency/availability
      await _dio.head('https://www.google.com');
      if (_isStopped) return;
      stopwatch.stop();

      final latency = stopwatch.elapsedMilliseconds;
      debugPrint("Network latency: ${latency}ms");

      if (latency > 1500) {
        _networkStatus.value = NetworkStatus.poor;
      } else {
        _networkStatus.value = NetworkStatus.online;
      }
    } on DioException catch (e) {
      debugPrint("Network check failed: ${e.message}");
      if (!_isStopped) _networkStatus.value = NetworkStatus.offline;
    } catch (e) {
      debugPrint("Network check unexpected error: $e");
      if (!_isStopped) _networkStatus.value = NetworkStatus.offline;
    }
  }

  void stopService() {
    _isStopped = true;
    _subscription?.cancel();
    _qualityCheckTimer?.cancel();
    debugPrint("NetworkCheckingService stopped due to app maintenance");
  }

  @override
  void onClose() {
    stopService();
    super.onClose();
  }
}
