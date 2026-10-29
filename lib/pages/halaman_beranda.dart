import 'package:flutter/material.dart';

import '../app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Selamat Datang di AgriClima LSTM',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aplikasi untuk mencatat hasil prediksi mikrokalimat tanaman di lahan Kelompok Tani Sri Mulya, agar kebutuhan penyiraman tiap petak mudah dipantau',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
            'Model: LSTM (Deep Learning)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

                  const SizedBox(height: 8),
                  const Text('Prediksi 24 jam ke depan'),
                  const SizedBox(height: 8),
                  const Text(
                    '3 Parameter: Suhu Udara, Kelembaban Udara, Kelembapan Tanah',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.tentang);
            },
            child: const Text('Tentang AgriClima'),
          ),
        ],
      ),
    );
  }
}
