import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hello/features/auth/presentation/bloc/auth_event.dart';
import 'package:hello/features/auth/presentation/bloc/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger(
            child: SnackBar(content: Text("une erreur s'est produit")),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthCheckConnectionState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthSignOutEvent());
                  },
                  icon: Icon(Icons.logout_outlined),
                ),
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Text("connectez vous à internet"),
                  ElevatedButton(onPressed: () {}, child: Text("Verifiez")),

                  // ElevatedButton(onPressed: (){}, child: )
                ],
              ),
            ),
          );
        }
        if (state is AuthauthenticatedState) {
          return Scaffold(body: Center(child: Text(state.userId)));
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
