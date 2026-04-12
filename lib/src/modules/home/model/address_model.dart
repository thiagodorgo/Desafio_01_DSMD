class AddressModel {
    final String cep;
    final String logradouro;
    final String complemento;
    final String bairro;
    final String localidade;
    final String uf;
    final String ibge;
    final String gia;
    final String ddd;
    final String siafi;

    AddressModel({
      required this.cep,
      required this.logradouro,
      required this.complemento,
      required this.bairro,
      required this.localidade,
      required this.uf,
      required this.ibge,
      required this.gia,
      required this.ddd,
      required this.siafi,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) {
      return AddressModel(
        cep: json['cep'] ?? '',
        logradouro: json['logradouro'] ?? '',
        complemento: json['complemento'] ?? '',
        bairro: json['bairro'] ?? '',
        localidade: json['localidade'] ?? '',
        uf: json['uf'] ?? '',
        ibge: json['ibge'] ?? '',
        gia: json['gia'] ?? '',
        ddd: json['ddd'] ?? '',
        siafi: json['siafi'] ?? '',
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'localidade': localidade,
        'uf': uf,
        'ibge': ibge,
        'gia': gia,
        'ddd': ddd,
        'siafi': siafi,
      };
    }

    String get fullAddress {
      final parts = <String>[];
      if (logradouro.isNotEmpty) parts.add(logradouro);
      if (bairro.isNotEmpty) parts.add(bairro);
      if (localidade.isNotEmpty) parts.add('$localidade - $uf');
      return parts.join(', ');
    }
  }
  