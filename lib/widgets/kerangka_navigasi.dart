import 'package:flutter/material.dart';

import '../pages/halaman_beranda.dart';
import '../pages/halaman_pengaturan.dart';
import '../pages/halaman_prediksi.dart';
import '../pages/halaman_statistik.dart';
import 'ikon_prediksi.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanPrediksi(),
    HalamanStatistik(),
    HalamanPengaturan(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Prediksi',
    'Statistik',
    'Pengaturan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AgriClima - ${_judul[_indeksTerpilih]}')),
      body: IndexedStack(index: _indeksTerpilih, children: _halaman),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeksTerpilih,
        onDestinationSelected: (indeks) {
          setState(() {
            _indeksTerpilih = indeks;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: IkonPrediksi(ikon: Icons.cloud_outlined),
            selectedIcon: IkonPrediksi(ikon: Icons.cloud),
            label: 'Prediksi',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
