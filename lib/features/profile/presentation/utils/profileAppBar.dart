import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      leadingWidth: 200,
      leading: Row(
        children: [
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

