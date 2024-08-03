import 'package:demo_revised_project/app_bloc_observer.dart';
import 'package:demo_revised_project/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInit {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDependencyInjection();
    Bloc.observer = AppBlocObserver();
  }
}
