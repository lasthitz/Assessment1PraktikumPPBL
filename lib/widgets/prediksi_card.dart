import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

class PrediksiCard extends StatelessWidget {
  const PrediksiCard({super.key, required this.hasil, required this.onHapus});

  final HasilPrediksi hasil;
  final VoidCallback onHapus;

  String get waktuTeks {
    final waktu = hasil.waktu;
    return '${waktu.day}/${waktu.month}/${waktu.year} '
        '${waktu.hour.toString().padLeft(2, '0')}:'
        '${waktu.minute.toString().padLeft(2, '0')}';
  }

  Color get warnaStatus {
    switch (hasil.status) {
      case 'Kering':
        return Colors.orange;
      case 'Optimal':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  IconData get ikonStatus {
    switch (hasil.status) {
      case 'Kering':
        return Icons.wb_sunny;
      case 'Optimal':
        return Icons.check_circle;
      default:
        return Icons.water_drop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('${hasil.petak} - ${hasil.tanaman}')),
                IconButton(
                  onPressed: onHapus,
                  tooltip: 'Hapus prediksi',
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(ikonStatus, color: warnaStatus),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    hasil.status,
                    style: TextStyle(color: warnaStatus),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Kelembapan tanah: ${hasil.kelembapanTanah}%'),
            const SizedBox(height: 4),
            LinearProgressIndicator(value: hasil.kelembapanTanah / 100),
            const SizedBox(height: 8),
            Text('Suhu udara: ${hasil.suhuUdara} °C'),
            Text('Kelembapan udara: ${hasil.kelembapanUdara}%'),
            Text('Petugas: ${hasil.namaPetugas}'),
            Text('Waktu prediksi: $waktuTeks'),
            const SizedBox(height: 8),
            Text('Rekomendasi: ${hasil.rekomendasi}'),
            const SizedBox(height: 8),
            Text('Catatan perawatan: ${hasil.catatan}'),
          ],
        ),
      ),
    );
  }
}
