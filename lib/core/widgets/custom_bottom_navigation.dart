import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/app_strings.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBackground.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_rounded, AppStrings.home),
              _buildNavItem(1, Icons.document_scanner_rounded, AppStrings.ocr),
              _buildNavItem(2, Icons.person_rounded, AppStrings.profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.grey,
                size: 24,
              ),
            ),
            // if (isSelected) ...[
            const SizedBox(height: 1), //2
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // ],
          ],
        ),
      ),
    );
  }
}
