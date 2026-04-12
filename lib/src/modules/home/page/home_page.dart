import 'package:flutter/material.dart';
  import 'package:flutter_mobx/flutter_mobx.dart';
  import 'package:geocoding/geocoding.dart';
  import 'package:map_launcher/map_launcher.dart';
  import 'package:mobx/mobx.dart';

  import '../controller/home_controller.dart';
  import '../components/last_address_component.dart';
  import '../components/empty_search_component.dart';
  import '../../../shared/colors/app_colors.dart';
  import '../../../shared/components/custom_button.dart';
  import '../../../shared/metrics/app_metrics.dart';
  import '../../../routes/app_routes.dart';

  class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    final HomeController _controller = HomeController();
    final TextEditingController _cepController = TextEditingController();
    final List<ReactionDisposer> _disposers = [];

    @override
    void initState() {
      super.initState();
      _setupReactions();
    }

    void _setupReactions() {
      _disposers.add(
        reaction(
          (_) => _controller.errorMessage,
          (String? error) {
            if (error != null && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppMetrics.borderRadius),
                  ),
                ),
              );
            }
          },
        ),
      );
    }

    @override
    void dispose() {
      for (final disposer in _disposers) {
        disposer();
      }
      _cepController.dispose();
      super.dispose();
    }

    Future<void> _openMap() async {
      final address = _controller.address;
      if (address == null) return;

      try {
        final query =
            '${address.logradouro}, ${address.bairro}, ${address.localidade}, ${address.uf}, Brasil';

        final locations = await locationFromAddress(query);

        if (locations.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Não foi possível obter as coordenadas do endereço'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }

        final location = locations.first;
        final availableMaps = await MapLauncher.installedMaps;

        if (availableMaps.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Nenhum aplicativo de mapa encontrado'),
                backgroundColor: AppColors.error,
              ),
            );
          }
          return;
        }

        if (mounted) {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(AppMetrics.paddingMedium),
                      child: Text(
                        'Traçar rota até o endereço',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppMetrics.fontSizeMedium,
                        ),
                      ),
                    ),
                    const Divider(),
                    ...availableMaps.map(
                      (map) => ListTile(
                        leading: Image.asset(
                          map.icon,
                          height: 30,
                          width: 30,
                        ),
                        title: Text(map.mapName),
                        onTap: () async {
                          Navigator.pop(context);
                          await map.showDirections(
                            destination: Coords(
                              location.latitude,
                              location.longitude,
                            ),
                            destinationTitle: address.fullAddress,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao abrir mapa: ${e.toString()}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }

    void _search() {
      final cep = _cepController.text.trim();
      if (cep.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Digite um CEP para consultar'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      FocusScope.of(context).unfocus();
      _controller.searchByCep(cep);
    }

    void _newSearch() {
      _cepController.clear();
      _controller.reset();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'FastLocation',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: 'Histórico',
              onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
            ),
          ],
        ),
        body: Observer(
          builder: (_) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(AppMetrics.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppMetrics.paddingSmall),
                      Card(
                        elevation: 2,
                        color: AppColors.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppMetrics.borderRadiusLarge),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppMetrics.paddingMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Consulta de CEP',
                                style: TextStyle(
                                  fontSize: AppMetrics.fontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppMetrics.paddingMedium),
                              TextField(
                                controller: _cepController,
                                keyboardType: TextInputType.number,
                                maxLength: 9,
                                decoration: InputDecoration(
                                  labelText: 'Digite o CEP',
                                  hintText: '00000-000',
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: AppColors.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppMetrics.borderRadius),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppMetrics.borderRadius),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  counterText: '',
                                ),
                                onSubmitted: (_) => _search(),
                              ),
                              const SizedBox(height: AppMetrics.paddingMedium),
                              CustomButton(
                                label: 'Consultar',
                                icon: Icons.search,
                                isLoading: _controller.isLoading,
                                onPressed: _search,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppMetrics.paddingMedium),
                      if (_controller.address != null) ...[
                        LastAddressComponent(address: _controller.address!),
                        const SizedBox(height: AppMetrics.paddingMedium),
                        CustomButton(
                          label: 'Traçar rota',
                          icon: Icons.directions,
                          onPressed: _openMap,
                        ),
                        const SizedBox(height: AppMetrics.paddingSmall),
                        OutlinedButton.icon(
                          onPressed: _newSearch,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Nova consulta'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: const BorderSide(color: AppColors.primary),
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppMetrics.borderRadius),
                            ),
                          ),
                        ),
                      ],
                      if (_controller.isEmpty)
                        EmptySearchComponent(message: _controller.errorMessage),
                    ],
                  ),
                ),
                if (_controller.isLoading)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(AppMetrics.paddingLarge),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(color: AppColors.primary),
                              SizedBox(height: AppMetrics.paddingMedium),
                              Text('Consultando CEP...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    }
  }
  