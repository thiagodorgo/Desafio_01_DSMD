import 'package:hive_flutter/hive_flutter.dart';

  class HiveConfig {
    static const String addressBox = 'addresses';

    static Future<void> init() async {
      await Hive.initFlutter();
      await Hive.openBox<Map>(addressBox);
    }
  }
  