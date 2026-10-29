import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_prediksi.dart';
import '../state/prediksi_bloc.dart';

class HalamanInputPrediksi extends StatefulWidget {
  const HalamanInputPrediksi({super.key});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  final _suhuController = TextEditingController();
  final _kelembapanUdaraController = TextEditingController();
  final _kelembapanTanahController = TextEditingController();
  final _namaPetugasController = TextEditingController();

  String _petak = 'Petak 1';
  String _tanaman = 'Padi';
  bool _dataBenar = false;
  String? _errorSuhu;
  String? _errorKelembapanUdara;
  String? _errorKelembapanTanah;
  String? _errorNamaPetugas;

  @override
  void dispose() {
    _suhuController.dispose();
    _kelembapanUdaraController.dispose();
    _kelembapanTanahController.dispose();
    _namaPetugasController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_dataBenar) return;

    final suhu = double.tryParse(_suhuController.text.trim());
    final kelembapanUdara = double.tryParse(
      _kelembapanUdaraController.text.trim(),
    );
    final kelembapanTanah = double.tryParse(
      _kelembapanTanahController.text.trim(),
    );
    final namaPetugas = _namaPetugasController.text.trim();

    setState(() {
      _errorSuhu = suhu == null || !suhu.isFinite
          ? 'Suhu harus berupa angka'
          : null;
      _errorKelembapanUdara =
          kelembapanUdara == null ||
              !kelembapanUdara.isFinite ||
              kelembapanUdara < 0 ||
              kelembapanUdara > 100
          ? 'Kelembapan udara harus berupa angka 0-100'
          : null;
      _errorKelembapanTanah =
          kelembapanTanah == null ||
              !kelembapanTanah.isFinite ||
              kelembapanTanah < 0 ||
              kelembapanTanah > 100
          ? 'Kelembapan tanah harus berupa angka 0-100'
          : null;
      _errorNamaPetugas = namaPetugas.isEmpty
          ? 'Nama petugas tidak boleh kosong'
          : null;
    });

    if (_errorSuhu != null ||
        _errorKelembapanUdara != null ||
        _errorKelembapanTanah != null ||
        _errorNamaPetugas != null) {
      return;
    }

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Simpan'),
        content: const Text('Simpan data hasil prediksi ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    );

    if (!mounted || konfirmasi != true) return;

    final hasil = HasilPrediksi(
      petak: _petak,
      tanaman: _tanaman,
      suhuUdara: suhu!,
      kelembapanUdara: kelembapanUdara!,
      kelembapanTanah: kelembapanTanah!,
      namaPetugas: namaPetugas,
      waktu: DateTime.now(),
    );

    context.read<PrediksiBloc>().add(TambahPrediksi(hasil));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data tersimpan')));
    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Petak'),
            ...['Petak 1', 'Petak 2'].map((petak) {
              return RadioListTile<String>(
                title: Text(petak),
                value: petak,
                // Mengikuti pola RadioListTile pada modul praktikum.
                // ignore: deprecated_member_use
                groupValue: _petak,
                // ignore: deprecated_member_use
                onChanged: (nilai) {
                  setState(() {
                    _petak = nilai!;
                  });
                },
              );
            }),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tanaman,
              decoration: const InputDecoration(labelText: 'Nama tanaman'),
              items: ['Padi', 'Jagung', 'Cabai'].map((tanaman) {
                return DropdownMenuItem(value: tanaman, child: Text(tanaman));
              }).toList(),
              onChanged: (nilai) {
                setState(() {
                  _tanaman = nilai!;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: 'Prediksi suhu udara (°C)',
                errorText: _errorSuhu,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _kelembapanUdaraController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Prediksi kelembapan udara (%)',
                errorText: _errorKelembapanUdara,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _kelembapanTanahController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Prediksi kelembapan tanah (%)',
                errorText: _errorKelembapanTanah,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _namaPetugasController,
              decoration: InputDecoration(
                labelText: 'Nama petugas',
                errorText: _errorNamaPetugas,
              ),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Data Sudah Benar'),
              value: _dataBenar,
              onChanged: (nilai) {
                setState(() {
                  _dataBenar = nilai ?? false;
                });
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _dataBenar ? _simpan : null,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
