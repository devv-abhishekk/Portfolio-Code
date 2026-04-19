import '../../../../app_export.dart';
import '../../../../domain/entities/skill_entity.dart';
import '../../../widgets/premium_card.dart';

class SkillsView extends StatelessWidget {
  final List<SkillCategoryEntity> skills;
  const SkillsView({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Row(
            children: [
              Text(
                '02. TECHNICAL SKILLS',
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size.width > 1400 ? 3 : (size.width > 900 ? 2 : 1),
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            mainAxisExtent: 260,
          ),
          itemCount: skills.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: _buildSkillCategory(skills[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSkillCategory(SkillCategoryEntity cat) {
    IconData icon = FontAwesomeIcons.layerGroup;
    Color glowColor = AppColors.primary;

    if (cat.category.toLowerCase().contains('mobile')) {
      icon = FontAwesomeIcons.mobileButton;
      glowColor = AppColors.accent;
    } else if (cat.category.toLowerCase().contains('frontend') || cat.category.toLowerCase().contains('web')) {
      icon = FontAwesomeIcons.code;
      glowColor = AppColors.neonPurple;
    } else if (cat.category.toLowerCase().contains('backend') || cat.category.toLowerCase().contains('database')) {
      icon = FontAwesomeIcons.server;
      glowColor = AppColors.neonPink;
    } else if (cat.category.toLowerCase().contains('tool')) {
      icon = FontAwesomeIcons.listCheck;
      glowColor = AppColors.success;
    }

    return PremiumCard(
      glowColor: glowColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: glowColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: glowColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  cat.category.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.w900, 
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: cat.skills.map((skill) => _SkillChip(skill: skill, color: glowColor)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skill;
  final Color color;
  const _SkillChip({required this.skill, required this.color});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? widget.color.withValues(alpha: 0.1) : AppColors.border.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered ? widget.color : AppColors.border.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Text(
          widget.skill,
          style: TextStyle(
            fontSize: 13, 
            color: _isHovered ? Colors.white : AppColors.onSurface,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
