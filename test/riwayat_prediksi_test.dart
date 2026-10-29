import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_lstm_707012400084/main.dart';
import 'package:agriclima_lstm_707012400084/models/hasil_prediksi.dart';
import 'package:agriclima_lstm_707012400084/pages/halaman_prediksi.dart';
import 'package:agriclima_lstm_707012400084/state/prediksi_bloc.dart';
import 'package:agriclima_lstm_707012400084/widgets/kartu_statistik.dart';

void main() {
  testWidgets('Filter dan hapus data bekerja pada riwayat bersama', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.widgetWithText(NavigationDestination, 'Prediksi'));
    await tester.pumpAndSettle();

    void cekStatistik(String judul, int jumlah) {
      expect(
        find.descendant(
          of: find.widgetWithText(KartuStatistik, judul),
          matching: find.text('$jumlah'),
        ),
        findsOneWidget,
      );
    }

    void cekBadge(int jumlah) {
      final badges = tester.widgetList<Badge>(find.byType(Badge));
      expect(badges, isNotEmpty);
      for (final badge in badges) {
        expect((badge.label as Text).data, '$jumlah');
        expect(badge.isLabelVisible, jumlah > 0);
      }
    }

    expect(find.text('Riwayat Prediksi'), findsOneWidget);
    cekStatistik('Total', 0);
    cekStatistik('Optimal', 0);
    cekStatistik('Perlu Tindakan', 0);
    expect(find.text('Belum ada data'), findsOneWidget);
    cekBadge(0);

    final bloc = tester
        .element(find.byType(HalamanPrediksi))
        .read<PrediksiBloc>();
    for (final petak in ['Petak 1', 'Petak 2']) {
      bloc.add(
        TambahPrediksi(
          HasilPrediksi(
            petak: petak,
            tanaman: 'Padi',
            suhuUdara: 30,
            kelembapanUdara: 80,
            kelembapanTanah: petak == 'Petak 1' ? 50 : 80,
            namaPetugas: 'Petugas Uji',
            waktu: DateTime(2026, 10, 29, 10, 5),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    cekStatistik('Total', 2);
    cekStatistik('Optimal', 1);
    cekStatistik('Perlu Tindakan', 1);
    cekBadge(1);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Petak 1'));
    await tester.pumpAndSettle();
    cekStatistik('Perlu Tindakan', 0);
    cekBadge(1);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Petak 2'));
    await tester.pumpAndSettle();
    cekStatistik('Total', 1);
    cekStatistik('Optimal', 0);
    cekStatistik('Perlu Tindakan', 1);
    expect(find.text('Petak 2 - Padi'), findsOneWidget);
    expect(find.text('Petak 1 - Padi'), findsNothing);
    expect(find.text('Waktu prediksi: 29/10/2026 10:05'), findsOneWidget);
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      0.8,
    );

    await tester.tap(find.widgetWithText(NavigationDestination, 'Beranda'));
    await tester.pumpAndSettle();
    cekBadge(1);
    await tester.tap(find.widgetWithText(NavigationDestination, 'Prediksi'));
    await tester.pumpAndSettle();
    expect(find.text('Petak 2 - Padi'), findsOneWidget);
    expect(bloc.state.filterPetak, 'Petak 2');

    await tester.tap(find.byTooltip('Hapus prediksi'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada data'), findsOneWidget);
    expect(bloc.state.daftar.single.petak, 'Petak 1');
    cekStatistik('Total', 0);
    cekStatistik('Optimal', 0);
    cekStatistik('Perlu Tindakan', 0);
    cekBadge(0);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Semua'));
    await tester.pumpAndSettle();
    cekStatistik('Total', 1);
    cekStatistik('Optimal', 1);
    cekStatistik('Perlu Tindakan', 0);
    expect(find.text('Petak 1 - Padi'), findsOneWidget);
    expect(find.text('Petak 2 - Padi'), findsNothing);
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      0.5,
    );
    expect(tester.takeException(), isNull);
  });
}
