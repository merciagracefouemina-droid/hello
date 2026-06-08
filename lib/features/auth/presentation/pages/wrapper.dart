import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is AuthLoadingState) {
        //   Scaffold(body: Center(child: CircularProgressIndicator()));
        // }
        // if (state is AuthauthenticatedState) {
        //   context.push("/homePage");
        // }
        // if (state is AuthauthenticatedState) {
        //   context.push("/loginWithGoogle");
        // }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is AuthauthenticatedState) {
          context.push("/homePage");
        }
        if (state is AuthauthenticatedState) {
          context.push("/loginWithGoogle");
        }
        return Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                context.push("/loginWithGoogle");
              },
              child: Text(
                "Aller sur login",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        );
      },
    );
  }
}
