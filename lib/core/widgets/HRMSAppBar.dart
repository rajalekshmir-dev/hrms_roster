import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_event.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';

class HRMSAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HRMSAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56); // reduced

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, size: 26, color: AppColors.kHeadingColor),
            onPressed: () {},
          ),

          const SizedBox(width: 6),

          /// Title using common text style
          Text(
            "HRMS.AI",
            style: AppTextStyles.headline.copyWith(
              fontSize: 24,
              color: AppColors.kHeadingColor, // optional adjustment for appbar
            ),
          ),

          const Spacer(),

          /// Theme Toggle
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.brightness_6,
                size: 22,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleTheme());
              },
            ),
          ),

          const SizedBox(width: 8),

          /// Notification Icon
          Stack(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.notifications_none,
                    size: 22,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {},
                ),
              ),

              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "2",
                    style: TextStyle(
                      fontSize: 9,
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
