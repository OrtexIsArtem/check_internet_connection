import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connectivity;
  late final StreamSubscription _connectivityStream;

  InternetCubit({
    required Connectivity connectivity,
  })  : _connectivity = connectivity,
        super(InternetState()) {
    _connectivityStream =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult res) {
      if (res == ConnectivityResult.wifi || res == ConnectivityResult.mobile) {
        emit(InternetState(type: InternetTypes.connected));
      } else if (res == ConnectivityResult.none) {
        emit(InternetState(type: InternetTypes.offline));
      } else {
        emit(InternetState(type: InternetTypes.unknown));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivityStream.cancel();
    return super.close();
  }
}
