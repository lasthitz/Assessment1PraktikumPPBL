import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'state/prediksi_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrediksiBloc(),
      child: MaterialApp(
        title: 'AgriClima',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
      ),
    );
  }
}
