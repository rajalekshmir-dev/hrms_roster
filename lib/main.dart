import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/di/service_locator.dart';

import 'core/di/service_locator.dart' as di;
import 'features/Home/presentation/bloc/home_bloc.dart';
import 'features/hrms_shell/presentation/bloc/hrms_navigation_bloc.dart';
import 'features/login/presentation/bloc/auth_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/search_info/presentation/bloc/search_bloc.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/bloc/theme_bloc.dart';
import 'features/theme/bloc/theme_event.dart';
import 'features/theme/bloc/theme_state.dart';
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
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<NavigationBloc>()),
        BlocProvider(create: (_) => di.sl<UserInfoBloc>()),
        BlocProvider(create: (_) => di.sl<HomeBloc>()),
        BlocProvider(create: (_) => di.sl<ThemeBloc>()..add(LoadTheme())),
        // ✅ ADD THIS
        BlocProvider(create: (_) => di.sl<EmployeeSearchBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'HRMS',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,

            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
