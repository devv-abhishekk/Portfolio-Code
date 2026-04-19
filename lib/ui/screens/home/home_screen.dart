import '../../../../app_export.dart';
import '../../../../presentation/cubit/portfolio_cubit.dart';
import '../../../../core/services/service_locator.dart';
import 'views/header_view.dart';
import 'views/about_view.dart';
import 'views/projects_view.dart';
import 'views/contact_view.dart';
import 'views/experience_view.dart';
import 'views/skills_view.dart';
import 'widgets/side_navigation_bar.dart';
import '../../widgets/tech_background_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final headerKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  late final PortfolioCubit _portfolioCubit;
  late final AnimationController _bgAnimationController;
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  bool _isScrollingProgrammatically = false;

  @override
  void initState() {
    super.initState();
    _portfolioCubit = sl<PortfolioCubit>()..loadPortfolioData();
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _portfolioCubit.close();
    _bgAnimationController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isScrollingProgrammatically) return;

    final sectionKeys = [headerKey, aboutKey, skillsKey, experienceKey, projectsKey, contactKey];
    int newIndex = _selectedIndex;
    double minDistance = double.infinity;

    for (int i = 0; i < sectionKeys.length; i++) {
      final context = sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy.abs();
          if (position < minDistance) {
            minDistance = position;
            newIndex = i;
          }
        }
      }
    }

    if (newIndex != _selectedIndex) {
      setState(() => _selectedIndex = newIndex);
    }
  }

  Future<void> _scrollToSection(GlobalKey key, int index) async {
    debugPrint('Scrolling to section $index');
    _isScrollingProgrammatically = true;
    setState(() => _selectedIndex = index);
    
    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutQuart,
        alignment: 0.1,
      );
    }
    
    // Brief delay to ensure scroll is finished before re-enabling listener
    await Future.delayed(const Duration(milliseconds: 100));
    _isScrollingProgrammatically = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;

    return BlocProvider.value(
      value: _portfolioCubit,
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: !isDesktop 
          ? Drawer(child: BlocBuilder<PortfolioCubit, PortfolioState>(
              builder: (context, state) => state is PortfolioLoaded 
                ? SideNavigationBar(
                    personal: state.portfolio.personalInfo,
                    selectedIndex: _selectedIndex,
                    onNavTap: (index) => _handleNavTap(index),
                  )
                : const SizedBox(),
            ))
          : null,
        body: Stack(
          children: [
            // Layer 1: Tech Background Painter
            RepaintBoundary(
              child: Positioned.fill(
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
            ),
            
            // Layer 2: Subtle Gradients
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(-0.8, -0.6),
                    radius: 1.5,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.05),
                      AppColors.background.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            
            // Content
            RepaintBoundary(
              child: BlocBuilder<PortfolioCubit, PortfolioState>(
              builder: (context, state) {
                if (state is PortfolioLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PortfolioLoaded) {
                  final sectionKeys = [headerKey, aboutKey, skillsKey, experienceKey, projectsKey, contactKey];
                  return Row(
                    children: [
                      if (isDesktop) SideNavigationBar(
                        personal: state.portfolio.personalInfo,
                        selectedIndex: _selectedIndex,
                        onNavTap: (index) => _scrollToSection(sectionKeys[index], index),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 100 : 24,
                            vertical: 80,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeaderView(
                                    key: headerKey, 
                                    personal: state.portfolio.personalInfo,
                                    onContactTap: () => _scrollToSection(contactKey, 5),
                                  ),
                                  const SizedBox(height: 160),
                                  AboutView(
                                    key: aboutKey,
                                    personal: state.portfolio.personalInfo, 
                                    education: state.portfolio.education,
                                  ),
                                  const SizedBox(height: 160),
                                  SkillsView(
                                    key: skillsKey,
                                    skills: state.portfolio.skills,
                                  ),
                                  const SizedBox(height: 160),
                                  ExperienceView(
                                    key: experienceKey,
                                    experiences: state.portfolio.experiences,
                                  ),
                                  const SizedBox(height: 160),
                                  ProjectsView(
                                    key: projectsKey,
                                    projects: state.portfolio.projects,
                                  ),
                                  const SizedBox(height: 160),
                                  ContactView(
                                    key: contactKey,
                                    personal: state.portfolio.personalInfo,
                                  ),
                                  const SizedBox(height: 100),
                                  _buildFooter(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is PortfolioError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          Divider(color: AppColors.border.withValues(alpha: 0.3)),
          const SizedBox(height: 40),
          Text(
            'DESIGNED & BUILT BY ABHISHEK KUMAR',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 3,
              fontWeight: FontWeight.w900,
              color: AppColors.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2026 • FLUTTER PORTFOLIO',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              color: AppColors.onSurface.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavTap(int index) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    final sectionKeys = [headerKey, aboutKey, skillsKey, experienceKey, projectsKey, contactKey];
    _scrollToSection(sectionKeys[index], index);
  }
}

