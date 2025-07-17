import 'package:flutter/material.dart';

class ProfileSettingList extends StatelessWidget {

  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ProfileSettingList({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.red[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Divider(thickness: 1, height: 1),
      ],
    );
  }
}