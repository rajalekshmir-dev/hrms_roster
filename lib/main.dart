import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/HRMSAppBar.dart';
import 'core/widgets/common_drop_down.dart';
import 'core/widgets/multi_select_dropdown.dart' show MultiSelectDropdown;
import 'core/widgets/slider_menu_bar.dart';
import 'features/search_info/presentation/search_view.dart';
import 'features/search_info/presentation/widgets/EmployeeCard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      /// Apply your theme
      theme: AppTheme.lightTheme,

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const HomePage();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryColor),
              ),
            ),
          );
        } else {
          return const LoginPage();
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
        child: SearchAiQueryData(),
      ),
    );
  }
}
