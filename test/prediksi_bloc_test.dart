import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_lstm_707012400084/models/hasil_prediksi.dart';
import 'package:agriclima_lstm_707012400084/state/prediksi_bloc.dart';

HasilPrediksi dataUji(String petak, String tanaman, double kelembapanTanah) {
  return HasilPrediksi(
    petak: petak,
    tanaman: tanaman,
    suhuUdara: 30,
    kelembapanUdara: 80,
    kelembapanTanah: kelembapanTanah,
    namaPetugas: 'Petugas Uji',
    waktu: DateTime(2026, 10, 29, 10, 5),
  );
}

void main() {
  test(
    'Tambah, filter, dan hapus menjaga seluruh riwayat tetap sesuai',
    () async {
      final bloc = PrediksiBloc();
      addTearDown(bloc.close);
      final petak1 = dataUji('Petak 1', 'Padi', 50);
      final petak2 = dataUji('Petak 2', 'Jagung', 80);
      final tambahan = dataUji('Petak 1', 'Cabai', 20);

      Future<PrediksiState> kirim(PrediksiEvent event) {
        final berikutnya = bloc.stream.first;
        bloc.add(event);
        return berikutnya;
      }

      expect(bloc.state.filterPetak, 'Semua');
      expect(bloc.state.daftar, isEmpty);
      expect(bloc.state.total, 0);
      expect(bloc.state.optimal, 0);
      expect(bloc.state.perluTindakan, 0);
      expect(bloc.state.totalPerluTindakan, 0);
      await kirim(TambahPrediksi(petak1));
      var state = await kirim(TambahPrediksi(petak2));
      expect(state.daftarTerfilter, [petak1, petak2]);
      expect(state.total, 2);
      expect(state.optimal, 1);
      expect(state.perluTindakan, 1);
      expect(state.daftar.first.waktu, DateTime(2026, 10, 29, 10, 5));

      state = await kirim(UbahFilterPetak('Petak 1'));
      expect(state.daftarTerfilter, [petak1]);
      expect(state.total, 1);
      expect(state.optimal, 1);
      expect(state.perluTindakan, 0);
      state = await kirim(UbahFilterPetak('Petak 2'));
      expect(state.daftarTerfilter, [petak2]);
      expect(state.total, 1);
      expect(state.optimal, 0);
      expect(state.perluTindakan, 1);
      expect(state.daftar, [petak1, petak2]);

      state = await kirim(TambahPrediksi(tambahan));
      expect(state.filterPetak, 'Petak 2');
      expect(state.daftarTerfilter, [petak2]);
      expect(state.daftar, [petak1, petak2, tambahan]);
      expect(state.totalPerluTindakan, 2);
      expect(state.total, 1);
      expect(state.optimal, 0);
      expect(state.perluTindakan, 1);

      state = await kirim(HapusPrediksi(petak2));
      expect(state.daftarTerfilter, isEmpty);
      expect(state.totalPerluTindakan, 1);
      expect(state.total, 0);
      expect(state.optimal, 0);
      expect(state.perluTindakan, 0);
      expect(state.daftar, [petak1, tambahan]);

      state = await kirim(UbahFilterPetak('Semua'));
      expect(state.daftarTerfilter, [petak1, tambahan]);
      expect(state.total, 2);
      expect(state.optimal, 1);
      expect(state.perluTindakan, 1);
      expect(() => state.daftar.clear(), throwsUnsupportedError);
    },
  );
}
