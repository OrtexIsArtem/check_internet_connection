import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_cubit.dart';

import 'app.dart';

void bootstrap() async {
  final Connectivity connectivity = Connectivity();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<InternetCubit>(
        create: (_) => InternetCubit(connectivity: connectivity),
      ),
      //...
    ],
    child: App(),
  ));
}