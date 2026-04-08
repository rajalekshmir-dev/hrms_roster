import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/presentation/bloc/auth_bloc.dart';
import 'package:hrms_roster/presentation/bloc/auth_state.dart';
import 'package:hrms_roster/presentation/pages/login_page.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';

import 'features/search_info/presentation/bloc/search_bloc.dart';
import 'features/search_info/presentation/search_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// ✅ Provide AuthBloc here
        BlocProvider(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'HRMS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return SearchAiQueryData();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const HomePage();
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HRMSAppBar(),
      body: BlocProvider(
        create: (_) => sl<EmployeeSearchBloc>(),
        child: const SearchAiQueryData(),
      ),
    );
  }
}
