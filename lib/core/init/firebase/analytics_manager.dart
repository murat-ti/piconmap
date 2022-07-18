import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._init();

  static AnalyticsManager get instance => _instance;

  AnalyticsManager._init();

  static final _analytics = FirebaseAnalytics();

  final observer = FirebaseAnalyticsObserver(analytics: _analytics);

  Future<void> customEvent(String name) async {
    await observer.analytics.logEvent(name: name);
  }
}
