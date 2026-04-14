
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms_roster/core/constant/colors.dart';
import 'package:hrms_roster/core/widgets/hrms_button.dart';
import 'package:hrms_roster/core/widgets/reusable_checkbox.dart';
import 'package:hrms_roster/core/widgets/username_field.dart';
import 'package:hrms_roster/core/widgets/reusable_password_field.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_bloc.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_event.dart';
import 'package:hrms_roster/features/login/presentation/bloc/auth_state.dart';
import 'package:hrms_roster/features/hrms_shell/presentation/hrms_shell.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          _showSnackBar(context, message: state.message, isError: true);
       
        } else if (state is Authenticated) {
          _showSnackBar(context, message: 'Login successful!', isError: false);
          
        
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  HRMSShell()),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username Field
              UserNameField(
                label: 'Username',
                hintText: 'Enter your username',
                controller: _usernameController,
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Field
              ReusablePasswordField(
                label: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                enabled: !isLoading,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Remember Me & Forgot Password Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableCheckbox(
                    value: _rememberMe,
                    label: 'Remember me',
                    enabled: !isLoading,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // TODO: Implement forgot password
                          },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Login Button
              HrmsButton(
                text: 'Login →',
                onPressed: _handleLogin,
                isLoading: isLoading,
                isEnabled: !isLoading,
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          rememberMe: _rememberMe,
        ),
      );
    }
  }

  void _showSnackBar(
    BuildContext context, {
    required String message,
    required bool isError,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: isError ? 3 : 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}