import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_prediksi.dart';

abstract class PrediksiEvent {}

class TambahPrediksi extends PrediksiEvent {
  TambahPrediksi(this.hasil);

  final HasilPrediksi hasil;
}

class HapusPrediksi extends PrediksiEvent {
  HapusPrediksi(this.hasil);

  final HasilPrediksi hasil;
}

class UbahFilterPetak extends PrediksiEvent {
  UbahFilterPetak(this.petak);

  final String petak;
}

class PrediksiState {
  PrediksiState({
    List<HasilPrediksi> daftar = const [],
    this.filterPetak = 'Semua',
  }) : daftar = List.unmodifiable(daftar);

  final List<HasilPrediksi> daftar;
  final String filterPetak;

  List<HasilPrediksi> get daftarTerfilter {
    if (filterPetak == 'Semua') return daftar;
    return daftar.where((hasil) => hasil.petak == filterPetak).toList();
  }

  int get total => daftarTerfilter.length;

  int get optimal =>
      daftarTerfilter.where((hasil) => hasil.status == 'Optimal').length;

  int get perluTindakan => daftarTerfilter.where((hasil) {
    return hasil.status == 'Kering' || hasil.status == 'Terlalu Lembap';
  }).length;

  int get totalPerluTindakan => daftar.where((hasil) {
    return hasil.status == 'Kering' || hasil.status == 'Terlalu Lembap';
  }).length;
}

class PrediksiBloc extends Bloc<PrediksiEvent, PrediksiState> {
  PrediksiBloc() : super(PrediksiState()) {
    on<TambahPrediksi>((event, emit) {
      final daftar = List<HasilPrediksi>.from(state.daftar);
      daftar.add(event.hasil);
      emit(PrediksiState(daftar: daftar, filterPetak: state.filterPetak));
    });

    on<HapusPrediksi>((event, emit) {
      final daftar = List<HasilPrediksi>.from(state.daftar);
      daftar.remove(event.hasil);
      emit(PrediksiState(daftar: daftar, filterPetak: state.filterPetak));
    });

    on<UbahFilterPetak>((event, emit) {
      emit(PrediksiState(daftar: state.daftar, filterPetak: event.petak));
    });
  }
}
