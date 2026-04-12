import '../model/address_model.dart';
  import '../repositories/address_api_repository.dart';
  import '../repositories/address_local_repository.dart';

  class AddressService {
    final AddressApiRepository _apiRepository = AddressApiRepository();
    final AddressLocalRepository _localRepository = AddressLocalRepository();

    Future<AddressModel> searchByCep(String cep) async {
      final address = await _apiRepository.getAddressByCep(cep);
      await _localRepository.save(address);
      return address;
    }

    List<AddressModel> getHistory() {
      return _localRepository.getAll();
    }
  }
  