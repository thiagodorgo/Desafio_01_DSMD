import 'package:flutter/material.dart';
  import 'package:flutter_mobx/flutter_mobx.dart';

  import '../controller/history_controller.dart';
  import '../../../shared/colors/app_colors.dart';
  import '../../../shared/metrics/app_metrics.dart';

  class HistoryPage extends StatefulWidget {
    const HistoryPage({Key? key}) : super(key: key);

    @override
    State<HistoryPage> createState() => _HistoryPageState();
  }

  class _HistoryPageState extends State<HistoryPage> {
    final HistoryController _controller = HistoryController();

    @override
    void initState() {
      super.initState();
      _controller.loadHistory();
    }

    Future<void> _confirmClear() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Limpar histórico'),
          content: const Text(
            'Deseja remover todos os endereços consultados?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Limpar'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await _controller.clearHistory();
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Historico de Consultas',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Observer(
              builder: (_) {
                if (_controller.addresses.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Limpar historico',
                  onPressed: _confirmClear,
                );
              },
            ),
          ],
        ),
        body: Observer(
          builder: (_) {
            if (_controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (_controller.addresses.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 80,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: AppMetrics.paddingMedium),
                    Text(
                      'Nenhuma consulta realizada',
                      style: TextStyle(
                        fontSize: AppMetrics.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppMetrics.paddingSmall),
                    Text(
                      'Os enderecos consultados aparecerao aqui.',
                      style: TextStyle(
                        fontSize: AppMetrics.fontSizeMedium,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppMetrics.paddingMedium),
              itemCount: _controller.addresses.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppMetrics.paddingSmall),
              itemBuilder: (context, index) {
                final address = _controller.addresses[index];
                return Card(
                  color: AppColors.surface,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primary,
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (address.logradouro.isNotEmpty)
                          Text(
                            address.logradouro,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppMetrics.fontSizeSmall,
                            ),
                          ),
                        Text(
                          address.localidade + ' - ' + address.uf,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppMetrics.fontSizeSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }
  