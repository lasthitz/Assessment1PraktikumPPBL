import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_lstm_707012400084/models/catatan_perawatan.dart';
import 'package:agriclima_lstm_707012400084/models/hasil_prediksi.dart';

void main() {
  test('Batas kelembapan tanah mengikuti Tabel A', () {
    final kasus = {
      0.0: 'Kering',
      39.9: 'Kering',
      40.0: 'Optimal',
      70.0: 'Optimal',
      70.1: 'Terlalu Lembap',
      100.0: 'Terlalu Lembap',
    };
    final rekomendasi = {
      'Kering': 'Segera lakukan penyiraman atau irigasi',
      'Optimal': 'Pertahankan pola perawatan saat ini',
      'Terlalu Lembap': 'Kurangi penyiraman dan periksa drainase',
    };

    for (final kelembapan in kasus.keys) {
      final hasil = HasilPrediksi(
        petak: 'Petak 1',
        tanaman: 'Padi',
        suhuUdara: 30,
        kelembapanUdara: 80,
        kelembapanTanah: kelembapan,
        namaPetugas: 'Petugas Uji',
        waktu: DateTime(2026, 10, 29, 10),
      );

      expect(hasil.status, kasus[kelembapan]);
      expect(hasil.rekomendasi, rekomendasi[kasus[kelembapan]]);
    }
  });

  test('Setiap tanaman memiliki catatan dari Tabel B', () {
    expect(catatanPerawatan.keys, ['Padi', 'Jagung', 'Cabai']);
    for (final tanaman in catatanPerawatan.keys) {
      final hasil = HasilPrediksi(
        petak: 'Petak 2',
        tanaman: tanaman,
        suhuUdara: 30,
        kelembapanUdara: 80,
        kelembapanTanah: 50,
        namaPetugas: 'Petugas Uji',
        waktu: DateTime(2026, 10, 29, 10),
      );
      expect(hasil.catatan, catatanPerawatan[tanaman]);
      expect(hasil.catatan, isNotEmpty);
    }
  });
}
