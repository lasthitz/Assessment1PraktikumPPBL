import 'catatan_perawatan.dart';

class HasilPrediksi {
  const HasilPrediksi({
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    required this.waktu,
  });

  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  String get status {
    if (kelembapanTanah < 40) {
      return 'Kering';
    } else if (kelembapanTanah <= 70) {
      return 'Optimal';
    } else {
      return 'Terlalu Lembap';
    }
  }

  String get rekomendasi {
    switch (status) {
      case 'Kering':
        return 'Segera lakukan penyiraman atau irigasi';
      case 'Optimal':
        return 'Pertahankan pola perawatan saat ini';
      default:
        return 'Kurangi penyiraman dan periksa drainase';
    }
  }

  String get catatan => catatanPerawatan[tanaman] ?? '';
}
