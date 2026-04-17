import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/features/login/presentation/widgets/login_form.dart';
import 'package:hrms_roster/core/widgets/reusable_sections.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_bloc.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_state.dart';
import 'package:hrms_roster/features/hrms_shell/presentation/hrms_shell.dart';
import '../../../../core/constant/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HRMSShell()),
          );
        }
      },
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
                const SizedBox(height: 40),

                Center(
                  child: Image.asset(
                    "assets/images/human_resources_icon.png",
                    width: 70,
                    height: 50,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                const SizedBox(height: 32),

                // Login Form
                const LoginForm(),
                const SizedBox(height: 24),

                // Footer Section
                FooterSection(
                  question: "Don't have an account? ",
                  actionText: 'Sign up',
                  onActionPressed: () {
                    // TODO: Implement sign up navigation
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
