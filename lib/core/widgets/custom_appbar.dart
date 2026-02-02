import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final double appBarSize;
  final PreferredSizeWidget? bottom;
  final double leadingWidth;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0,
    this.appBarSize = kToolbarHeight,
    this.bottom,
    this.leadingWidth = 60,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      leadingWidth: leadingWidth,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.primary,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBarSize + (bottom?.preferredSize.height ?? 0.0));
}
