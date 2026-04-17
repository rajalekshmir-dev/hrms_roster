import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/theme/bloc/theme_bloc.dart';
import '../../features/theme/bloc/theme_event.dart';
import '../constant/colors.dart';
import '../constant/text_style.dart';

class HRMSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showMenuIcon;
  final bool showThemeToggle;
  final bool showNotificationBadge;
  final String? title;
  final String? appTitle;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final int notificationCount;
  final Color? backgroundColor;
  final Color? titleColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const HRMSAppBar({
    super.key,
    this.showBackButton = false,
    this.showMenuIcon = true,
    this.showThemeToggle = true,
    this.showNotificationBadge = true,
    this.title,
    this.appTitle = "HRMS.AI",
    this.actions,
    this.onBackPressed,
    this.onMenuPressed,
    this.notificationCount = 0,
    this.backgroundColor,
    this.titleColor,
    this.scaffoldKey,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: showBackButton ? _buildBackButton(context) : null,
      title: _buildTitle(context),
      actions: actions ?? _buildDefaultActions(context),
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: AppColors.kHeadingColor),
      onPressed: onBackPressed ?? () => Navigator.pop(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (title != null) {
      return Text(
        title!,
        style: AppTextStyles.headline.copyWith(
          fontSize: 20,
          color: titleColor ?? AppColors.kHeadingColor,
        ),
      );
    }

    return Row(
      children: [
        if (showMenuIcon)
          IconButton(
            icon: Icon(Icons.menu, size: 26, color: AppColors.kHeadingColor),
            onPressed:
                onMenuPressed ??
                () {
                  if (scaffoldKey != null) {
                    scaffoldKey!.currentState?.openDrawer();
                  } else {
                    Scaffold.of(context).openDrawer();
                  }
                },
          ),
        if (showMenuIcon) const SizedBox(width: 6),
        Text(
          appTitle!,
          style: AppTextStyles.headline.copyWith(
            fontSize: 24,
            color: titleColor ?? AppColors.kHeadingColor,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDefaultActions(BuildContext context) {
    final List<Widget> actionWidgets = [];

    if (showThemeToggle) {
      actionWidgets.add(
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
      );
      actionWidgets.add(const SizedBox(width: 8));
    }

    if (showNotificationBadge) {
      actionWidgets.add(
        Stack(
          children: [
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
                  Icons.notifications_none,
                  size: 22,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {},
              ),
            ),
            if (notificationCount > 0)
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
                  child: Text(
                    notificationCount > 9 ? '9+' : '$notificationCount',
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return actionWidgets;
  }
}
