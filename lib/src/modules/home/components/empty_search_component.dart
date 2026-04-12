import 'package:flutter/material.dart';
  import '../../../shared/colors/app_colors.dart';
  import '../../../shared/metrics/app_metrics.dart';

  class EmptySearchComponent extends StatelessWidget {
    final String? message;

    const EmptySearchComponent({Key? key, this.message}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppMetrics.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: AppMetrics.iconSizeLarge * 1.5,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: AppMetrics.paddingMedium),
              const Text(
                'Nenhum resultado encontrado',
                style: TextStyle(
                  fontSize: AppMetrics.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: AppMetrics.paddingSmall),
                Text(
                  message!,
                  style: const TextStyle(
                    fontSize: AppMetrics.fontSizeMedium,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppMetrics.paddingMedium),
              const Text(
                'Verifique o CEP digitado e tente novamente.',
                style: TextStyle(
                  fontSize: AppMetrics.fontSizeSmall,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }
  