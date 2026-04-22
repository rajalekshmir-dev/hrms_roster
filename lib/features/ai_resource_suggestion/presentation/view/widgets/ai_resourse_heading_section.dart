import 'package:flutter/material.dart';

class RequirementsHeader extends StatelessWidget {
  const RequirementsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, size: 18, color: Colors.blue),

          const SizedBox(width: 6),

          const Text(
            "5 Requirements",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),

          const Spacer(),

          Row(
            children: const [
              Text(
                "Sort: Recently Updated",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
