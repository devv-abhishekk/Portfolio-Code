import '../../../../app_export.dart';
import '../../../../domain/entities/experience_entity.dart';
import '../../../widgets/premium_card.dart';

class ExperienceView extends StatelessWidget {
  final List<ExperienceEntity> experiences;
  const ExperienceView({super.key, required this.experiences});

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
                '03. EXPERIENCE',
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
        const SizedBox(height: 48),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: _ExperienceTimelineItem(
                exp: experiences[index],
                isLast: index == experiences.length - 1,
                isDesktop: isDesktop,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ExperienceTimelineItem extends StatelessWidget {
  final ExperienceEntity exp;
  final bool isLast;
  final bool isDesktop;

  const _ExperienceTimelineItem({
    required this.exp,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Column
          SizedBox(
            width: isDesktop ? 60 : 40,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: PremiumCard(
                glowColor: AppColors.accent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp.role,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.w900, 
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                exp.company,
                                style: TextStyle(
                                  color: AppColors.primaryLight, 
                                  fontWeight: FontWeight.w700, 
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          exp.duration,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accent.withValues(alpha: 0.8),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ...exp.points.map((point) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Icon(FontAwesomeIcons.chevronRight, size: 10, color: AppColors.accent),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              point, 
                              style: TextStyle(
                                fontSize: 14, 
                                color: AppColors.onSurface,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
