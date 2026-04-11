import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/di/service_locator.dart' show sl;
import 'package:hrms_roster/core/widgets/login_form.dart';
import 'package:hrms_roster/core/widgets/reusable_sections.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => sl<AuthBloc>(),
      child: const Scaffold(body: LoginView()),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Section
                const LogoSection(
                  title: 'All-in-One HRMS Platform',
                  subtitle:
                      'Onboard talent • Analyze data • Match candidates smartly',
                  badgeText: 'HRMS.AI',
                ),
                const SizedBox(height: 60),

                // Welcome Section
                const WelcomeSection(
                  title: 'Welcome Back!',
                  subtitle: 'Please enter your details',
                ),
                const SizedBox(height: 32),

                // Login Form
                const LoginForm(),
                const SizedBox(height: 24),

                // Footer Section
                FooterSection(
                  question: "Don't have an account? ",
                  actionText: 'Sign up',
                  onActionPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
