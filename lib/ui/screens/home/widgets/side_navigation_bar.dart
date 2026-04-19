import '../../../../app_export.dart';
import '../../../../domain/entities/personal_info_entity.dart';

class SideNavigationBar extends StatelessWidget {
  final PersonalInfoEntity personal;
  final int selectedIndex;
  final Function(int)? onNavTap;

  const SideNavigationBar({
    super.key,
    required this.personal,
    this.selectedIndex = 0,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.sideBar,
        border: Border(right: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        children: [
          _buildProfile(context),
          const SizedBox(height: 40),
          _buildNavLinks(),
          const Spacer(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_outline,
              size: 45,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            personal.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'FLUTTER DEVELOPER',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.accent,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLinks() {
    final labels = [
      'Overview',
      'About Me',
      'Skills',
      'Experience',
      'Projects',
      'Contact',
    ];
    final icons = [
      Icons.grid_view_rounded,
      Icons.person_outline_rounded,
      Icons.terminal_rounded,
      Icons.history_edu_rounded,
      Icons.rocket_launch_outlined,
      Icons.alternate_email_rounded,
    ];

    return Column(
      children: List.generate(labels.length, (index) {
        return _NavLink(
          icon: icons[index],
          label: labels[index],
          isSelected: index == selectedIndex,
          onTap: () => onNavTap?.call(index),
        );
      }),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: personal.githubUrl,
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedinIn,
                url: personal.linkedInUrl,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2026 ABHISHEK',
            style: TextStyle(
              fontSize: 9,
              color: AppColors.onSurface.withValues(alpha: 0.4),
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _NavLink({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.onSurface.withValues(alpha: 0.7);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? activeColor.withValues(alpha: 0.1)
                    : _isHovered
                    ? activeColor.withValues(alpha: 0.05)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.isSelected
                      ? activeColor.withValues(alpha: 0.3)
                      : _isHovered
                      ? activeColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Active Indicator
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 4,
                    height: widget.isSelected ? 20 : 0,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      widget.icon,
                      size: 20,
                      color: widget.isSelected ? activeColor : inactiveColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: 14,
                        color: widget.isSelected ? Colors.white : inactiveColor,
                        fontWeight: widget.isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  if (widget.isSelected)
                    FadeInRight(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedScale(
            scale: _isHovered ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isHovered
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : Colors.transparent,
                ),
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: _isHovered
                    ? AppColors.primary
                    : AppColors.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
