import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsUtils {
  // Singleton pattern for global access
  static final AnalyticsUtils _instance = AnalyticsUtils._internal();
  factory AnalyticsUtils() => _instance;
  AnalyticsUtils._internal();

  // Initialize FirebaseAnalytics
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseAnalyticsObserver? observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  void setupUserPropertyInfo(
    String userId,
    String name,
    String value,
  ) {
    setUserId(userId);
    setUserProperty(keyName: name, value: value);
  }

  // Method to log events
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  // Method to track screen views
  Future<void> trackScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClassOverride ?? screenName,
    );
  }

  // Method to set user properties
  Future<void> setUserProperty({
    required String keyName,
    required String value,
  }) async {
    await _analytics.setUserProperty(
      name: keyName,
      value: value,
    );
  }

  // Method to set user ID
  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }
}
