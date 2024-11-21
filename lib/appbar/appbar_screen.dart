import 'package:flutter/material.dart';

class AppbarScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarScreen({
    Key? key,
    this.title,
    this.showBackArrow = false,
    this.actions,
  }) : super(key: key);

  final String? title;
  final bool showBackArrow;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(
        title ?? 'Calculator',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
