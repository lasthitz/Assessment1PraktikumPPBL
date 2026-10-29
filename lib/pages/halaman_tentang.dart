import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriClima')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Tujuan Aplikasi'),
          SizedBox(height: 8),
          Text(
            'Mencatat hasil prediksi mikroklimat tanaman di lahan Kelompok '
            'Tani Sri Mulya agar kebutuhan penyiraman tiap petak mudah dipantau.',
          ),
          SizedBox(height: 16),
          Text('Lokasi Pemantauan'),
          ListTile(title: Text('Petak 1')),
          ListTile(title: Text('Petak 2')),
          SizedBox(height: 16),
          Text('Parameter Mikroklimat'),
          ListTile(title: Text('Suhu udara')),
          ListTile(title: Text('Kelembapan udara')),
          ListTile(title: Text('Kelembapan tanah')),
        ],
      ),
    );
  }
}
