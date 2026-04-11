import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/di/service_locator.dart';
import 'package:hrms_roster/core/theme/app_theme.dart';
import 'package:hrms_roster/presentation/bloc/auth_bloc.dart';
import 'package:hrms_roster/presentation/pages/login_page.dart';

import 'features/hrms_shell/presentation/bloc/hrms_navigation_bloc.dart';
import 'features/users_info/presentation/bloc/users_info_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),

        BlocProvider<NavigationBloc>(create: (_) => sl<NavigationBloc>()),
        BlocProvider<UserInfoBloc>(create: (_) => sl<UserInfoBloc>()),
      ],
      child: MaterialApp(
        title: 'HRMS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const LoginPage(),
      ),
    );
  }
}
