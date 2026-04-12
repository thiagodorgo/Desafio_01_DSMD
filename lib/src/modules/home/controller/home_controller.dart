import 'package:mobx/mobx.dart';
  import '../model/address_model.dart';
  import '../service/address_service.dart';

  part 'home_controller.g.dart';

  class HomeController = _HomeControllerBase with _$HomeController;

  abstract class _HomeControllerBase with Store {
    final AddressService _service = AddressService();

    @observable
    AddressModel? address;

    @observable
    bool isLoading = false;

    @observable
    String? errorMessage;

    @observable
    bool isEmpty = false;

    @action
    Future<void> searchByCep(String cep) async {
      isLoading = true;
      errorMessage = null;
      isEmpty = false;
      address = null;

      try {
        address = await _service.searchByCep(cep);
      } catch (e) {
        errorMessage = e.toString().replaceAll('Exception: ', '');
        isEmpty = true;
      } finally {
        isLoading = false;
      }
    }

    @action
    void reset() {
      address = null;
      errorMessage = null;
      isEmpty = false;
      isLoading = false;
    }
  }
  