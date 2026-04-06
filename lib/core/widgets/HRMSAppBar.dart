import 'package:flutter/material.dart';

class HRMSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HRMSAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          /// Menu Icon
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF1E3A5F)),
            onPressed: () {},
          ),

          const SizedBox(width: 8),

          /// Title
          const Text(
            "HRMS.AI",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A5F),
              letterSpacing: 1,
            ),
          ),

          const Spacer(),

          /// Search Icon
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F4F7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.search, size: 20),
              onPressed: () {},
            ),
          ),

          const SizedBox(width: 10),

          /// Notification Icon with badge
          Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F4F7),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications_none, size: 20),
                  onPressed: () {},
                ),
              ),

              /// Badge
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "2",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
