import 'package:flutter/material.dart';
  import '../model/address_model.dart';
  import '../../../shared/colors/app_colors.dart';
  import '../../../shared/metrics/app_metrics.dart';

  class AddressListComponent extends StatelessWidget {
    final List<AddressModel> addresses;
    final String title;

    const AddressListComponent({
      Key? key,
      required this.addresses,
      this.title = 'Histórico de consultas',
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      if (addresses.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppMetrics.paddingSmall,
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: AppMetrics.fontSizeMedium,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: addresses.length,
            separatorBuilder: (_, __) => const Divider(
              color: AppColors.divider,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final address = addresses[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.secondary,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(
                  address.cep,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  address.fullAddress,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppMetrics.fontSizeSmall,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ],
      );
    }
  }
  