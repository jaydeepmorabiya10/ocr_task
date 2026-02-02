import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomLoader({super.key, this.size = 40.0, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
        strokeWidth: 3,
      ),
    );
  }
}

class CustomLoaderOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoaderOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: AppColors.darkBackground.withValues(alpha: 0.5),
            child: const Center(child: CustomLoader()),
          ),
      ],
    );
  }
}
