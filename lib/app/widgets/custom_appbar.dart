import 'package:flutter/material.dart';
import '../configs/app_textStyles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final Widget? flexibleSpace;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final double? leadingWidth;
  final double? elevation;
  final Size? appBarSize;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar(
      {super.key,
        this.title,
        this.centerTitle = false,
        this.flexibleSpace,
        this.bottom,
        this.toolbarHeight,
        this.appBarSize,
        this.actions,
        this.titleWidget,
        this.leadingWidth,
        this.elevation,
        this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ??
          (title != null
              ? Text(
            title!,
            style: AppTextStyles.customText16( fontWeight: FontWeight.w500),
          )
              : null),
      centerTitle: centerTitle,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      actions: actions,
      leading: leading,
      leadingWidth: leadingWidth,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => appBarSize ?? const Size.fromHeight(kToolbarHeight);
}
