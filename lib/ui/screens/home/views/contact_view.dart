import '../../../../app_export.dart';
import '../../../../domain/entities/personal_info_entity.dart';
import '../../../widgets/premium_card.dart';

class ContactView extends StatelessWidget {
  final PersonalInfoEntity personal;
  const ContactView({super.key, required this.personal});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Row(
            children: [
              Text(
                '05. GET IN TOUCH',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        const SizedBox(height: 100),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                FadeInDown(
                  child: Text(
                    "Let's Build Something Together",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isDesktop ? 48 : 32, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.white,
                      letterSpacing: -1,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    "I'm currently looking for new opportunities as a Flutter Developer. Whether you have a project in mind or just want to say hi, my inbox is always open!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16, 
                      color: AppColors.onSurface,
                      height: 1.8,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: PremiumCard(
                    glowColor: AppColors.primary,
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.paperPlane, color: AppColors.primary, size: 40),
                        const SizedBox(height: 32),
                        const Text(
                          "Ready to start your next project?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 48),
                        _ContactButton(email: personal.email),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _QuickContact(
                              icon: FontAwesomeIcons.linkedinIn,
                              label: 'LINKEDIN',
                              url: personal.linkedInUrl,
                            ),
                            const SizedBox(width: 32),
                            _QuickContact(
                              icon: FontAwesomeIcons.github,
                              label: 'GITHUB',
                              url: personal.githubUrl,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickContact extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _QuickContact({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.onSurface.withValues(alpha: 0.6)),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: AppColors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final String email;
  const _ContactButton({required this.email});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse('mailto:${widget.email}')),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 24),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Text(
              'SEND AN EMAIL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
