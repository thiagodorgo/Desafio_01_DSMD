import 'package:hive/hive.dart';
  import '../model/address_model.dart';
  import '../../../shared/storage/hive_config.dart';

  class AddressLocalRepository {
    Box<Map> get _box => Hive.box<Map>(HiveConfig.addressBox);

    Future<void> save(AddressModel address) async {
      await _box.add(address.toJson());
    }

    List<AddressModel> getAll() {
      return _box.values
          .map((map) => AddressModel.fromJson(Map<String, dynamic>.from(map)))
          .toList()
          .reversed
          .toList();
    }

    Future<void> clear() async {
      await _box.clear();
    }
  }
  