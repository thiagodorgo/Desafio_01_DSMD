import 'package:flutter/material.dart';
  import '../model/address_model.dart';
  import '../../../shared/colors/app_colors.dart';
  import '../../../shared/metrics/app_metrics.dart';

  class LastAddressComponent extends StatelessWidget {
    final AddressModel address;

    const LastAddressComponent({Key? key, required this.address}) : super(key: key);

    Widget _buildInfoRow(String label, String value) {
      if (value.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppMetrics.fontSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppMetrics.fontSizeSmall,
                ),
              ),
            ),
          ],
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Card(
        elevation: 2,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppMetrics.borderRadiusLarge),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppMetrics.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Endereço encontrado',
                    style: TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                      fontSize: AppMetrics.fontSizeMedium,
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.divider),
              _buildInfoRow('CEP', address.cep),
              _buildInfoRow('Logradouro', address.logradouro),
              _buildInfoRow('Complemento', address.complemento),
              _buildInfoRow('Bairro', address.bairro),
              _buildInfoRow('Cidade', address.localidade),
              _buildInfoRow('Estado', address.uf),
              _buildInfoRow('DDD', address.ddd),
            ],
          ),
        ),
      );
    }
  }
  