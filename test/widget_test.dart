import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agriclima_lstm_707012400084/main.dart';

void main() {
  testWidgets('Beranda, tab, dan named route berjalan', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('AgriClima - Beranda'), findsOneWidget);
    expect(find.text('Selamat Datang di AgriClima LSTM'), findsOneWidget);
    expect(find.text('Model: LSTM (Deep Learning)'), findsOneWidget);
    expect(find.text('Prediksi 24 jam ke depan'), findsOneWidget);
    expect(
      find.text('3 Parameter: Suhu Udara, Kelembaban Udara, Kelembapan Tanah'),
      findsOneWidget,
    );

    await tester.tap(find.text('Tentang AgriClima'));
    await tester.pumpAndSettle();
    expect(find.text('Tentang AgriClima'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    for (final tab in ['Prediksi', 'Statistik', 'Pengaturan', 'Beranda']) {
      await tester.tap(find.widgetWithText(NavigationDestination, tab));
      await tester.pumpAndSettle();
      expect(find.text('AgriClima - $tab'), findsOneWidget);
    }

    await tester.tap(find.widgetWithText(NavigationDestination, 'Prediksi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Prediksi Baru'));
    await tester.pumpAndSettle();
    expect(find.text('Input Prediksi'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('AgriClima - Prediksi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
