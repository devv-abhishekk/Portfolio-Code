import '../../../app_export.dart';
import '../../widgets/tech_background_painter.dart';
import 'cubit/splash_cubit.dart';
import 'cubit/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _bgAnimationController;

  @override
  void initState() {
    super.initState();
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _bgAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            context.go('/home');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              // Layer 1: Tech Background Painter
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _bgAnimationController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: TechBackgroundPainter(
                        animationValue: _bgAnimationController.value,
                      ),
                    );
                  },
                ),
              ),
              
              // Layer 2: Subtle Radial Glow
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.0,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.05),
                        AppColors.background.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: _buildPremiumLogo(),
                    ),
                    const SizedBox(height: 48),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        children: [
                          _buildPremiumBrandName(),
                          const SizedBox(height: 16),
                          _buildRoleSubtitle(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    FadeIn(
                      delay: const Duration(milliseconds: 800),
                      child: _buildNeonLoadingBar(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumLogo() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cardGlass,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'AK',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBrandName() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'ABHISHEK',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 32,
              letterSpacing: 8,
            ),
          ),
          TextSpan(
            text: '.dev',
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w900,
              fontSize: 32,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSubtitle() {
    return Text(
      AppStrings.role.toUpperCase(),
      style: TextStyle(
        color: AppColors.onSurface.withValues(alpha: 0.4),
        fontSize: 10,
        fontWeight: FontWeight.w900,
        letterSpacing: 6,
      ),
    );
  }

  Widget _buildNeonLoadingBar() {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: const LinearProgressIndicator(
              backgroundColor: AppColors.cardGlass,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'INITIALIZING CORE SYSTEMS',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: AppColors.primary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
