import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/core/router/app_router.dart';
import 'package:hello/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hello/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hello/firebase_options.dart';

import 'features/auth/data/services/firebase_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepositoryImp = AuthRepositoryImpl(FirebaseAuthService());
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc(authRepositoryImp))],

      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        routerConfig: appRouter,
      ),
    );
  }
}
