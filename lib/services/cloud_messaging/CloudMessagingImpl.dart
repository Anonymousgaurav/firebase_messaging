import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_demo/services/cloud_messaging/ICloudMessaging.dart';
import 'package:firebase_messaging_demo/services/notification/INotificationService.dart';
import 'package:firebase_messaging_demo/services/notification/NotificationServiceImpl.dart';
import 'package:firebase_messaging_demo/services/notification/models/NotificationModel.dart';
import 'package:flutter/cupertino.dart';

class CloudMessagingImpl implements ICloudMessaging {
  static CloudMessagingImpl? _instance;

  final FirebaseMessaging _firebaseMessaging;
  final INotificationService _notificationService;

  CloudMessagingImpl._(
      {FirebaseMessaging? firebaseMessaging,
      INotificationService? notificationService})
      : this._firebaseMessaging =
            firebaseMessaging ?? FirebaseMessaging.instance,
        this._notificationService =
            notificationService ?? NotificationServiceImpl.getInstance();

  factory CloudMessagingImpl.getInstance() {
    _instance ??= CloudMessagingImpl._();
    return _instance!;
  }

  @override
  Future<NotificationModel?> get initialMessage async {
    RemoteMessage? remoteMessage = await _firebaseMessaging.getInitialMessage();
    return remoteMessage?.notificationFromData;
  }

  @override
  Stream<NotificationModel> get clickedNotification =>
      _notificationService.selectedNotificationStream;

  @override
  Future<String?> getFirebaseToken() => _firebaseMessaging.getToken();

  @override
  void setUpListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) =>
        _onMessage(_notificationService, remoteMessage));
    FirebaseMessaging.onBackgroundMessage(doNoThing);
  }

  @override
  Future<void> requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      provisional: true,
      sound: false,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');

      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');

      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}

Future<void> _onMessage(
  INotificationService notificationService,
  RemoteMessage remoteMessage,
) async {
  notificationService.showNotification(remoteMessage.notificationFromData);
}

Future<void> doNoThing(_) async {}

extension RemoteMessageEx on RemoteMessage {
  NotificationModel get notificationFromData {
    NotificationModel notificationModel = NotificationModel.fromJson(this.data);

    notificationModel.id ??= Random().nextInt(1000000);
    notificationModel.title = this.notification?.title;
    notificationModel.body = this.notification?.body;

    return notificationModel;
  }
}
