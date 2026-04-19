import '../../../../app_export.dart';
import '../../../../domain/entities/project_entity.dart';
import '../../../widgets/premium_card.dart';

class ProjectsView extends StatelessWidget {
  final List<ProjectEntity> projects;
  const ProjectsView({super.key, required this.projects});

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
                '04. KEY PROJECTS',
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
            mainAxisExtent: 420,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: _ProjectCard(project: projects[index]),
            );
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectEntity project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      padding: EdgeInsets.zero,
      glowColor: AppColors.neonPurple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Header / Image Placeholder with Painter
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.accent.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ProjectHeaderPainter(),
                  ),
                ),
                Center(
                  child: Icon(
                    FontAwesomeIcons.rocket, 
                    size: 40, 
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: _ProjectLinks(project: project),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      project.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onSurface,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11, 
                          color: AppColors.accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )).toList(),
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

class _ProjectLinks extends StatelessWidget {
  final ProjectEntity project;
  const _ProjectLinks({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (project.playStoreUrl != null)
          _LinkIcon(
            icon: FontAwesomeIcons.googlePlay,
            url: project.playStoreUrl!,
          ),
      ],
    );
  }
}

class _LinkIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _LinkIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white10),
        ),
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }
}

class _ProjectHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
