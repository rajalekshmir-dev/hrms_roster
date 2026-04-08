import 'package:flutter/material.dart';
import 'package:hrms_roster/core/constant/colors.dart';

class ReusableCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final bool enabled;
  final ValueChanged<bool?> onChanged;

  const ReusableCheckbox({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: AppColors.kPrimaryColor,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: const BorderSide(color: Color(0xFFCCCCCC), width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}