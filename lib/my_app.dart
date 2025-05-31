import 'package:flutter/material.dart';
import 'package:client/core/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:client/features/auth/view/pages/signin_page.dart';
import 'package:client/core/providers/current_user_notifier.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Music App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SigninPage() : const HomePage(),
    );
  }
}
