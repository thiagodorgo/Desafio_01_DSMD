import 'package:dio/dio.dart';
  import '../model/address_model.dart';
  import '../../../http/http_client.dart';

  class AddressApiRepository {
    final Dio _dio = HttpClient.createDio();

    Future<AddressModel> getAddressByCep(String cep) async {
      final cleanCep = cep.replaceAll(RegExp(r'[^0-9]'), '');

      if (cleanCep.length != 8) {
        throw Exception('CEP deve conter 8 dígitos');
      }

      final response = await _dio.get('/$cleanCep/json/');

      if (response.data is Map && response.data['erro'] == true) {
        throw Exception('CEP não encontrado');
      }

      return AddressModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    }
  }
  