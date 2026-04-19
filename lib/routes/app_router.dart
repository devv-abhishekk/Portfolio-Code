import 'package:go_router/go_router.dart';
import '../ui/screens/home/home_screen.dart';
import '../ui/screens/splash/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    // Map root to home if needed
    GoRoute(
      path: '/',
      redirect: (_, _) => '/splash',
    ),
  ],
);
