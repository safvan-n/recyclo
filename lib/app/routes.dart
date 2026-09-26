import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/authentication/login_screen.dart';
import '../features/authentication/signup_screen.dart';
import '../features/waste/add_waste_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/call/call_screen.dart';
import '../features/tracking/live_tracking_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/payment/payment_history_screen.dart';
import '../models/collector_model.dart';
import 'main_view.dart';

/// App Routes Definition
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String main = '/main';
  static const String addWaste = '/add-waste';
  static const String chat = '/chat';
  static const String call = '/call';
  static const String liveTracking = '/live-tracking';
  static const String notifications = '/notifications';
  static const String paymentHistory = '/payment-history';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case main:
        return MaterialPageRoute(builder: (_) => const MainView());
      case addWaste:
        return MaterialPageRoute(builder: (_) => const AddWasteScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case call:
        final collector = settings.arguments as CollectorModel?;
        return MaterialPageRoute(builder: (_) => CallScreen(collector: collector));
      case liveTracking:
        return MaterialPageRoute(builder: (_) => const LiveTrackingScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case paymentHistory:
        return MaterialPageRoute(builder: (_) => const PaymentHistoryScreen());
      default:
        return MaterialPageRoute(builder: (_) => const MainView());
    }
  }
}
