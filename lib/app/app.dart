import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/strings.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/waste_repository.dart';
import '../data/repositories/collector_repository.dart';
import '../data/repositories/request_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/notification_repository.dart';
import 'routes.dart';
import 'theme.dart';

/// Root ReCyclo Application Widget
class ReCycloApp extends StatelessWidget {
  const ReCycloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WasteProvider()),
        ChangeNotifierProvider(create: (_) => CollectorProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: '${ReCycloStrings.appName} – ${ReCycloStrings.appTagline}',
        debugShowCheckedModeBanner: false,
        theme: ReCycloTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
