import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/pages/pages.dart';

import 'internet_cubit.dart';
import 'internet_state.dart';

final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: kNavigatorKey,
      builder: (context, child) {
        return BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            late final Widget page;
            switch (state.type) {
              case InternetTypes.connected:
                page = const HomePage();
                break;
              case InternetTypes.offline:
                page = const NoInternetPage();
                break;
              default:
                page = const LoadingPage();
            }
            kNavigatorKey.currentState!.push(MaterialPageRoute(
              builder: (_) => page,
            ));
          },
          child: child,
        );
      },
      home: const LoadingPage(),
    );
  }
}
