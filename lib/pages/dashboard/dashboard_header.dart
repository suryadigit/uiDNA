import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardHeader extends StatelessWidget {
  final int notificationCount;
  final String avatarUrl;

  const DashboardHeader({
    super.key,
    this.notificationCount = 2,
    this.avatarUrl = 'assets/profile.png',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(CupertinoIcons.line_horizontal_3_decrease, size: 24, color: Colors.black87),
        const SizedBox(width: 16),
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const Spacer(),

        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications_none, size: 20, color: Colors.black87),
            ),
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  notificationCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 12),

        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: NetworkImage(avatarUrl),
          onBackgroundImageError: (_, __) {
            debugPrint('Gagal memuat avatar');
          },
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideX();
  }
}
