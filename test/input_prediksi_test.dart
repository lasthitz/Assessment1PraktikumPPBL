import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_lstm_707012400084/main.dart';
import 'package:agriclima_lstm_707012400084/models/catatan_perawatan.dart';
import 'package:agriclima_lstm_707012400084/widgets/prediksi_card.dart';

void main() {
  testWidgets('Validasi, batal, dan simpan hasil prediksi', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.widgetWithText(NavigationDestination, 'Prediksi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Prediksi Baru'));
    await tester.pumpAndSettle();

    final tombolSimpan = find.widgetWithText(ElevatedButton, 'Simpan');
    expect(tester.widget<ElevatedButton>(tombolSimpan).onPressed, isNull);

    final isian = find.byType(TextField);
    await tester.enterText(isian.at(0), 'abc');
    await tester.enterText(isian.at(1), '101');
    await tester.enterText(isian.at(2), '-1');
    await tester.enterText(isian.at(3), '   ');
    await tester.ensureVisible(find.byType(CheckboxListTile));
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();
    expect(tester.widget<ElevatedButton>(tombolSimpan).onPressed, isNotNull);
    await tester.ensureVisible(tombolSimpan);
    await tester.tap(tombolSimpan);
    await tester.pumpAndSettle();

    expect(find.text('Suhu harus berupa angka'), findsOneWidget);
    expect(
      find.text('Kelembapan udara harus berupa angka 0-100'),
      findsOneWidget,
    );
    expect(
      find.text('Kelembapan tanah harus berupa angka 0-100'),
      findsOneWidget,
    );
    expect(find.text('Nama petugas tidak boleh kosong'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);

    await tester.ensureVisible(find.text('Petak 2'));
    await tester.tap(find.text('Petak 2'));
    await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cabai').last);
    await tester.pumpAndSettle();

    await tester.enterText(isian.at(0), '30.5');
    await tester.enterText(isian.at(1), '80');
    await tester.enterText(isian.at(2), '40');
    await tester.enterText(isian.at(3), 'Petugas Uji');
    await tester.ensureVisible(tombolSimpan);
    await tester.tap(tombolSimpan);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Input Prediksi'), findsOneWidget);
    expect(find.text('Data tersimpan'), findsNothing);
    expect(find.text('Petak 2 - Cabai'), findsNothing);

    await tester.tap(tombolSimpan);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ya, Simpan'));
    await tester.pumpAndSettle();

    expect(find.text('AgriClima - Prediksi'), findsOneWidget);
    expect(find.text('Input Prediksi'), findsNothing);
    expect(find.text('Data tersimpan'), findsOneWidget);
    expect(find.text('Petak 2 - Cabai'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(PrediksiCard),
        matching: find.text('Optimal'),
      ),
      findsOneWidget,
    );
    expect(find.text('Suhu udara: 30.5 °C'), findsOneWidget);
    expect(
      find.text('Rekomendasi: Pertahankan pola perawatan saat ini'),
      findsOneWidget,
    );
    expect(
      find.text('Catatan perawatan: ${catatanPerawatan['Cabai']}'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(NavigationDestination, 'Beranda'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NavigationDestination, 'Prediksi'));
    await tester.pumpAndSettle();
    expect(find.text('Petak 2 - Cabai'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
