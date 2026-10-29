import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_routes.dart';
import '../state/prediksi_bloc.dart';
import '../widgets/prediksi_card.dart';
import '../widgets/kartu_statistik.dart';

class HalamanPrediksi extends StatelessWidget {
  const HalamanPrediksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PrediksiBloc, PrediksiState>(
        builder: (context, state) {
          final daftar = state.daftarTerfilter;

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            itemCount: daftar.isEmpty ? 2 : daftar.length + 1,
            itemBuilder: (context, indeks) {
              if (indeks == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Riwayat Prediksi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: ['Semua', 'Petak 1', 'Petak 2'].map((petak) {
                        return ChoiceChip(
                          label: Text(petak),
                          selected: state.filterPetak == petak,
                          onSelected: (terpilih) {
                            if (!terpilih) return;
                            context.read<PrediksiBloc>().add(
                              UbahFilterPetak(petak),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: KartuStatistik(
                            judul: 'Total',
                            jumlah: state.total,
                          ),
                        ),
                        Expanded(
                          child: KartuStatistik(
                            judul: 'Optimal',
                            jumlah: state.optimal,
                          ),
                        ),
                        Expanded(
                          child: KartuStatistik(
                            judul: 'Perlu Tindakan',
                            jumlah: state.perluTindakan,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }

              if (daftar.isEmpty) {
                return const Text(
                  'Belum ada data',
                  textAlign: TextAlign.center,
                );
              }

              final hasil = daftar[indeks - 1];
              return PrediksiCard(
                hasil: hasil,
                onHapus: () {
                  context.read<PrediksiBloc>().add(HapusPrediksi(hasil));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.inputPrediksi);
        },
        icon: const Icon(Icons.add),
        label: const Text('Prediksi Baru'),
      ),
    );
  }
}
