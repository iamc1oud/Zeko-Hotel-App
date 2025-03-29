import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:zeko_hotel_crm/core/networking/http_service.dart';
import 'package:zeko_hotel_crm/core/networking/response_api.dart';
import 'package:zeko_hotel_crm/features/order_management/data/entities/pending_orders.dto.dart';
import 'package:zeko_hotel_crm/features/order_management/data/order_management_endpoints.dart';
import 'package:zeko_hotel_crm/main.dart';
import 'package:zeko_hotel_crm/utils/constants.dart';

@pragma('vm:entry-point')
void androidBackgroundStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // Audio player for the bell sound
  final audioPlayer = AudioPlayer();
  await audioPlayer.setSource(AssetSource('sounds/bell.wav'));
  // Flag to track if music is currently playing
  bool isMusicPlaying = false;

  // Variable to store if we previously had empty orders
  bool hadEmptyOrders = false;

  // Setup music looping when complete
  audioPlayer.onPlayerComplete.listen((event) {
    if (isMusicPlaying) {
      audioPlayer.play(AssetSource('sounds/bell.wav'));
    }
  });

  // If you need to respond to app interactions
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    audioPlayer.stop();
    service.stopSelf();
  });

  // Manually stop music
  service.on('stopMusic').listen((event) {
    isMusicPlaying = false;
    audioPlayer.stop();

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Order Monitor",
        content: "Music stopped. Still monitoring for empty orders.",
      );
    }
  });

  // Define your API check interval (e.g., every 15 seconds)
  // Define your API check interval (e.g., every 5 seconds)
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    await checkForEmptyOrders(
            service, audioPlayer, isMusicPlaying, hadEmptyOrders)
        .then((result) {
      isMusicPlaying = result['isMusicPlaying']!;
      hadEmptyOrders = result['hadEmptyOrders']!;
    });
  });
}

HttpService httpService = HttpService(baseUrl: API_URL);

Future<Map<String, bool>> checkForEmptyOrders(ServiceInstance service,
    AudioPlayer audioPlayer, bool isMusicPlaying, bool hadEmptyOrders) async {
  try {
    // Replace with your actual API endpoint
    final response =
        await httpService.post(OrderManagementEndpoints.listPendingOrder);

    var decoded = ApiResponse<PendingOrdersDTO>.fromJson(
        response, PendingOrdersDTO.fromJson);
    if (decoded.data != null) {
      bool hasOrders =
          decoded.data?.categories.values.any((list) => list.isNotEmpty) ??
              false;

      // Update notification based on order status
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
            title: hasOrders ? "Order Monitor" : "Empty Orders Alert!",
            content: hasOrders
                ? "There are orders that need attention"
                : "No empty orders at this time");
      }

      // Manage music playback based on order status
      if (hasOrders && !isMusicPlaying) {
        // Start playing music if there are empty orders and music isn't already playing
        await audioPlayer.play(AssetSource('sounds/bell.wav'));
        isMusicPlaying = true;

        // Optional: Send alert to the main app if it's running
        service.invoke('onEmptyOrdersDetected',
            {'timestamp': DateTime.now().toIso8601String(), 'orderCount': 1});
      } else if (!hasOrders && isMusicPlaying) {
        // Stop music if there are no more empty orders
        await audioPlayer.stop();
        isMusicPlaying = false;

        // Send update to the main app
        service.invoke('onAllOrdersFilled', {
          'timestamp': DateTime.now().toIso8601String(),
        });
      }

      // Track if we had empty orders in this check
      hasOrders = hasOrders;

      return {'isMusicPlaying': isMusicPlaying, 'hadEmptyOrders': hasOrders};
    }
  } catch (e) {
    print('Error checking orders: $e');
  }

  // Return unchanged values if there was an error
  return {'isMusicPlaying': isMusicPlaying, 'hadEmptyOrders': hadEmptyOrders};
}
