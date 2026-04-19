import '../../../../app_export.dart';
import '../../../../domain/entities/personal_info_entity.dart';
import '../../../../domain/entities/education_entity.dart';
import '../../../widgets/premium_card.dart';

class AboutView extends StatelessWidget {
  final PersonalInfoEntity personal;
  final List<EducationEntity> education;
  
  const AboutView({super.key, required this.personal, required this.education});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Row(
            children: [
              Text(
                '01. ABOUT ME',
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
        const SizedBox(height: 60),
        
        // Main Content Area
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Biography and Stats
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    FadeInLeft(
                      duration: const Duration(milliseconds: 1000),
                      child: _buildBiographyCard(),
                    ),
                    const SizedBox(height: 32),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: _buildStatsBar(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Right side: Personal Info & Education
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    FadeInRight(
                      delay: const Duration(milliseconds: 400),
                      child: _buildQuickInfoCol(),
                    ),
                    const SizedBox(height: 48),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: _buildEducationSection(),
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              FadeInDown(child: _buildBiographyCard()),
              const SizedBox(height: 32),
              FadeInUp(child: _buildStatsBar()),
              const SizedBox(height: 60),
              _buildQuickInfoCol(),
              const SizedBox(height: 60),
              _buildEducationSection(),
            ],
          ),
      ],
    );
  }

  Widget _buildBiographyCard() {
    return PremiumCard(
      glowColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(FontAwesomeIcons.idCard, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 20),
              const Text(
                'TECHNICAL IDENTITY',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            personal.summary,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.onSurface.withValues(alpha: 0.9),
              height: 1.8,
              wordSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),
          // Tech Tags
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildBioTag('PROBLEM SOLVER', AppColors.accent),
              _buildBioTag('FLUTTER ARCHITECT', AppColors.primary),
              _buildBioTag('CLEAN CODE ENTHUSIAST', AppColors.neonPurple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBioTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(30),
        color: color.withValues(alpha: 0.05),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildStatsBar() {
    return Row(
      children: [
        _buildStatItem('3+', 'YEARS\nEXP', AppColors.accent),
        const SizedBox(width: 20),
        _buildStatItem('15+', 'PROJECTS\nCORE', AppColors.primary),
        const SizedBox(width: 20),
        _buildStatItem('10+', 'HAPPY\nCLIENTS', AppColors.success),
      ],
    );
  }

  Widget _buildStatItem(String val, String label, Color color) {
    return Expanded(
      child: PremiumCard(
        glowColor: color,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Text(
              val,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: color,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: AppColors.onSurface.withValues(alpha: 0.5),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoCol() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildMiniInfo(FontAwesomeIcons.solidEnvelope, personal.email, AppColors.primary),
        _buildMiniInfo(FontAwesomeIcons.locationArrow, 'INDIA', AppColors.accent),
        _buildMiniInfo(FontAwesomeIcons.whatsapp, personal.phone, AppColors.success),
      ],
    );
  }

  Widget _buildMiniInfo(IconData icon, String val, Color color) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              val,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MILESTONES',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),
        ...education.map((e) => _buildTimelineItem(e)),
      ],
    );
  }

  Widget _buildTimelineItem(EducationEntity e) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 10),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.degree.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    e.institution,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
