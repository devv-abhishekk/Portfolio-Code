import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PremiumCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final bool useGlow;
  final Color? glowColor;

  const PremiumCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.border,
    this.boxShadow,
    this.useGlow = true,
    this.glowColor,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ?? BorderRadius.circular(24);
    final baseGlowColor = widget.glowColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) {
        _controller.forward();
      },
      onExit: (_) {
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: radius,
              boxShadow: [
                if (widget.useGlow)
                  BoxShadow(
                    color: baseGlowColor.withValues(alpha: 0.1 * _controller.value),
                    blurRadius: 20 * _controller.value,
                    spreadRadius: 2 * _controller.value,
                  ),
                ...?widget.boxShadow,
              ],
            ),
            child: RepaintBoundary(
              child: CustomPaint(
                painter: widget.useGlow ? _PremiumBorderPainter(
                  progress: _controller.value,
                  color: baseGlowColor,
                  radius: radius,
                ) : null,
                child: ClipRRect(
                  borderRadius: radius,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      padding: widget.padding ?? const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: widget.color ?? AppColors.surface.withValues(alpha: 0.8),
                        borderRadius: radius,
                        border: widget.border ?? Border.all(
                          color: AppColors.glassBorder.withValues(alpha: 0.1 + (0.1 * _controller.value)),
                          width: 1,
                        ),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _PremiumBorderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final BorderRadius radius;

  _PremiumBorderPainter({
    required this.progress,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.5 * progress)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4 * progress);

    final rect = Offset.zero & size;
    final rRect = radius.toRRect(rect);
    
    // Draw a partial glowing border based on progress
    final path = Path()..addRRect(rRect);
    
    // Create a gradient sweep for the glowing effect
    final gradient = SweepGradient(
      colors: [
        color.withValues(alpha: 0),
        color.withValues(alpha: 0.8 * progress),
        color.withValues(alpha: 0),
      ],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(progress * 2 * 3.14159),
    );
    
    paint.shader = gradient.createShader(rect);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _PremiumBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
