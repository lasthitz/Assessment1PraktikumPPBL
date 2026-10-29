import 'package:flutter/material.dart';

class KartuStatistik extends StatelessWidget {
  const KartuStatistik({super.key, required this.judul, required this.jumlah});

  final String judul;
  final int jumlah;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(judul, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('$jumlah'),
          ],
        ),
      ),
    );
  }
}
