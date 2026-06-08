import 'package:go_router/go_router.dart';
import 'package:hello/features/auth/presentation/pages/home_page.dart';
import 'package:hello/features/auth/presentation/pages/login_with_google.dart';
import 'package:hello/features/auth/presentation/pages/wrapper.dart';

final appRouter = GoRouter(
  initialLocation: "/",

  routes: [
    GoRoute(path: "/", builder: (context, state) => Wrapper()),
    GoRoute(
      path: "/loginWithGoogle",
      builder: (context, state) => LoginWithGoogle(),
    ),
    GoRoute(path: "/homePage", builder: (context, state) => HomePage()),
  ],
);
