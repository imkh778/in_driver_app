import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../widgets/page_frame.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) => PageFrame(
    title: 'Profile',
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(19),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Color(0xFF29475F),
                child: Icon(Icons.person, color: Colors.white, size: 29),
              ),
              SizedBox(width: 13),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Arjun Kumar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+91 98765 43210',
                    style: TextStyle(color: Color(0xFFBDCAD3), fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.edit_outlined, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
      const _ProfileHeading('MY VEHICLE'),
      const _ProfileRow(
        Icons.local_shipping_outlined,
        'KA 12 AB 4582',
        'Tata Ace · Light commercial',
      ),
      const _ProfileHeading('SETTINGS'),
      const _ProfileRow(Icons.support_agent, "Support", "Support Agent"),
      const _ProfileRow(Icons.speed_outlined, 'Odometer', '48,250 km'),
      const _ProfileRow(
        Icons.location_on_outlined,
        'Location',
        'Demo GPS enabled',
      ),
      const _ProfileRow(
        Icons.backup_outlined,
        'Data & backup',
        'Saved on this device',
      ),
    ],
  );
}

class _ProfileHeading extends StatelessWidget {
  const _ProfileHeading(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 12, 20, 9),
    child: Text(
      label,
      style: const TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w800,
        letterSpacing: .8,
        fontSize: 10,
      ),
    ),
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow(this.icon, this.title, this.subtitle);
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.green),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.grey, fontSize: 10),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.chevron_right, color: AppColors.grey, size: 19),
      ],
    ),
  );
}
