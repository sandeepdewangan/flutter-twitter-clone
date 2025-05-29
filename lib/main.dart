import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/commons/error_page.dart';
import 'package:twitter_clone/commons/loading.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/views/register_view.dart';
import 'package:twitter_clone/features/home/views/home_view.dart';
import 'package:twitter_clone/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Twitter Clone with Riverpod',
      theme: AppTheme.theme,
      home: ref
          .watch(currentUserAccountProvider)
          .when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const RegisterView();
            },
            error: (error, st) => ErrorPage(message: error.toString()),
            loading: () => Scaffold(body: Loading()),
          ),
    );
  }
}
