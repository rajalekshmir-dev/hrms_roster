import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';

class ReusablePasswordField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const ReusablePasswordField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.enabled = true,
    this.validator,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<ReusablePasswordField> createState() => _ReusablePasswordFieldState();
}

class _ReusablePasswordFieldState extends State<ReusablePasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: _obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 14,
            ),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.kPrimaryColor,
                width: 1.5,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF999999),
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
          validator: widget.validator,
        ),
      ],
    );
  }
}