import 'package:flutter/material.dart';
  import '../colors/app_colors.dart';
  import '../metrics/app_metrics.dart';

  class CustomButton extends StatelessWidget {
    final String label;
    final VoidCallback? onPressed;
    final bool isLoading;
    final IconData? icon;

    const CustomButton({
      Key? key,
      required this.label,
      this.onPressed,
      this.isLoading = false,
      this.icon,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.surface,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: AppMetrics.iconSize),
                      const SizedBox(width: AppMetrics.paddingSmall),
                    ],
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: AppMetrics.fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      );
    }
  }
  