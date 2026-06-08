import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({super.key});

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ui pour le login avec google
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenue Ui pour login google
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignInWithGoogleEvent());
                context.go("/HomePage");
              },
              child: Text('Se connecter avec Google'),
            ),
          ],
        ),
      ),
    );
  }
}
