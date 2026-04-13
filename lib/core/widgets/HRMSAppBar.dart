import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_event.dart';
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
                onPressed: () {},
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: IconButton(
              icon: Icon(
                Icons.brightness_6,
                size: 30,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleTheme());
              },
            ),
          ),

          const SizedBox(width: 10),

          /// Notification Icon with badge
          Stack(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    size: 30,
                    color: Theme.of(context).iconTheme.color,
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
