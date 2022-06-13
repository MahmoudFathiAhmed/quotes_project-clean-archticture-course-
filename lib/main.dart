import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'package:quotes/injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
        () {
      runApp(const QuoteApp());
    },
    blocObserver: AppBlocObserver(),
  );
  runApp(const QuoteApp());
}
