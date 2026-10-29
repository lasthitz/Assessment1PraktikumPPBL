import 'package:flutter/material.dart';

import 'pages/halaman_input_prediksi.dart';
import 'pages/halaman_tentang.dart';
import 'widgets/kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String tentang = '/tentang';
  static const String inputPrediksi = '/input-prediksi';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      tentang: (context) => const HalamanTentang(),
      inputPrediksi: (context) => const HalamanInputPrediksi(),
    };
  }
}
