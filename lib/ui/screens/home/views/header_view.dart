import '../../../../app_export.dart';
import '../../../../domain/entities/personal_info_entity.dart';
import '../../../widgets/typing_text.dart';

class HeaderView extends StatelessWidget {
  final PersonalInfoEntity personal;
  final VoidCallback? onContactTap;

  const HeaderView({
    super.key, 
    required this.personal,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 100 : 50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Glow Decoration
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.1),
                    AppColors.background.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1000),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: 50,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "HELLO WORLD, I'M",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  personal.name,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isDesktop ? 100 : 56,
                    height: 0.9,
                    foreground: Paint()
                      ..shader = AppColors.primaryGradient.createShader(
                        const Rect.fromLTWH(0.0, 0.0, 500.0, 100.0),
                      ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: TypingText(
                  text: personal.title.toUpperCase(),
                  duration: const Duration(milliseconds: 60),
                  style: TextStyle(
                    fontSize: isDesktop ? 28 : 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.onSurface.withValues(alpha: 0.8),
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: Container(
                  constraints: BoxConstraints(maxWidth: isDesktop ? 700 : double.infinity),
                  child: Text(
                    personal.summary,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.onSurface,
                      height: 1.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _EnhancedButton(
                      onPressed: () => launchUrl(Uri.parse(personal.resumeUrl)),
                      label: 'VIEW RESUME',
                      isPrimary: true,
                    ),
                    _EnhancedButton(
                      onPressed: () => onContactTap?.call(),
                      label: 'LET\'S TALK',
                      isPrimary: false,
                    ),
                    const SizedBox(width: 12),
                    _SocialIcon(
                      icon: FontAwesomeIcons.github,
                      url: personal.githubUrl,
                    ),
                    _SocialIcon(
                      icon: FontAwesomeIcons.linkedinIn,
                      url: personal.linkedInUrl,
                    ),
                    _SocialIcon(
                      icon: FontAwesomeIcons.envelope,
                      url: 'mailto:${personal.email}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.onSurface, size: 20),
      ),
    );
  }
}

class _EnhancedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isPrimary;

  const _EnhancedButton({
    required this.onPressed,
    required this.label,
    required this.isPrimary,
  });

  @override
  State<_EnhancedButton> createState() => _EnhancedButtonState();
}

class _EnhancedButtonState extends State<_EnhancedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: widget.isPrimary 
                ? (_isHovered ? AppColors.primary.withValues(alpha: 0.9) : AppColors.primary)
                : Colors.transparent,
            side: BorderSide(
              color: widget.isPrimary ? Colors.transparent : AppColors.border,
              width: 2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
