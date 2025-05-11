import 'package:flutter/foundation.dart';
import 'package:finlink/models/notification.dart';
import 'package:finlink/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  
  List<Notification> _notifications = [];
  int _unreadCount = 0;
  bool _loading = false;
  String? _error;
  
  // Getters
  List<Notification> get notifications => _notifications;
  int get unreadCount => _unreadCount;
  bool get loading => _loading;
  String? get error => _error;
  
  // Initialize notifications
  Future<void> initialize(String userId) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      await _notificationService.initialize();
      await loadNotifications(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Load notifications
  Future<void> loadNotifications(String userId) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();
      
      _notifications = await _notificationService.getNotifications(userId);
      _unreadCount = await _notificationService.getUnreadNotificationsCount(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
  
  // Create a notification
  Future<void> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
    String? relatedId,
  }) async {
    try {
      final notification = await _notificationService.createNotification(
        userId: userId,
        title: title,
        message: message,
        type: type,
        relatedId: relatedId,
      );
      
      _notifications.insert(0, notification);
      _unreadCount++;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }
  
  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.markNotificationAsRead(notificationId);
      
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        if (!notification.isRead) {
          _notifications[index] = notification.copyWith(isRead: true);
          _unreadCount = _unreadCount > 0 ? _unreadCount - 1 : 0;
          notifyListeners();
        }
      }
    } catch (e) {
      _error = e.toString();
    }
  }
  
  // Mark all notifications as read
  Future<void> markAllAsRead(String userId) async {
    try {
      await _notificationService.markAllNotificationsAsRead(userId);
      
      _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }
  
  // Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);
      
      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        final notification = _notifications[index];
        if (!notification.isRead) {
          _unreadCount = _unreadCount > 0 ? _unreadCount - 1 : 0;
        }
        _notifications.removeAt(index);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
    }
  }
  
  // Refresh unread count
  Future<void> refreshUnreadCount(String userId) async {
    try {
      _unreadCount = await _notificationService.getUnreadNotificationsCount(userId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }
}
