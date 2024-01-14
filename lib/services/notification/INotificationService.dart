import 'package:firebase_messaging_demo/services/notification/models/NotificationModel.dart';

abstract class INotificationService {
  /// abstract getter method that returns a Stream of NotificationModel. This stream is likely used to broadcast notifications when they are selected.
  Stream<NotificationModel> get selectedNotificationStream;

  /// abstract method that takes a NotificationModel parameter and returns a Future<void>. This method is responsible for showing a notification based on the provided NotificationModel.
  Future<void> showNotification(NotificationModel notificationModel);
}
