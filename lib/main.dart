import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/di/service_locator.dart';
import 'package:hrms_roster/core/theme/app_theme.dart';
import 'package:hrms_roster/presentation/bloc/auth_bloc.dart';
import 'package:hrms_roster/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // GetIt initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: MaterialApp(
        title: 'HRMS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        home: const LoginPage(),
      ),
    );
  }
}
