import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/prediksi_bloc.dart';

class IkonPrediksi extends StatelessWidget {
  const IkonPrediksi({super.key, required this.ikon});

  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PrediksiBloc, PrediksiState, int>(
      selector: (state) => state.totalPerluTindakan,
      builder: (context, jumlah) {
        return Badge(
          label: Text('$jumlah'),
          isLabelVisible: jumlah > 0,
          child: Icon(ikon),
        );
      },
    );
  }
}
