import 'package:flutter/material.dart';

import '../constant/colors.dart';

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
            icon: Icon(Icons.menu, size: 30, color: AppColors.kHeadingColor),
            onPressed: () {
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: AppColors.kHeadingColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),

          const SizedBox(width: 8),

          /// Title
          const Text(
            "HRMS.AI",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.kHeadingColor,
              letterSpacing: 1,
            ),
          ),

          const Spacer(),

          /// Search Icon
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF2F4F7),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,

                color: AppColors.kHeadingColor,
              ),
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
                  icon: const Icon(
                    Icons.notifications_none,
                    size: 30,

                    color: AppColors.kHeadingColor,
                  ),
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
