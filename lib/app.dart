import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class LeadershipOSApp extends StatelessWidget {
  const LeadershipOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LeadershipOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
    );
  }
}
