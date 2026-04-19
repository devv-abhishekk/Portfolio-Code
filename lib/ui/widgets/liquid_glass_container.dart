import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LiquidGlassContainer extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final double blurSigma;
  final List<Color>? blobColors;
  final double opacity;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.blurSigma = 40.0,
    this.blobColors,
    this.opacity = 0.1,
  });

  @override
  State<LiquidGlassContainer> createState() => _LiquidGlassContainerState();
}

class _LiquidGlassContainerState extends State<LiquidGlassContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.blobColors ?? [
      AppColors.primary,
      AppColors.accent,
      AppColors.primaryLight,
      const Color(0xFF64FFDA),
    ];
    
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Animated Blobs
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    // Blob 1: Top-Left
                    _PositionedBlob(
                      top: -100 + (60 * math.sin(_controller.value * 2 * math.pi)),
                      left: -80 + (80 * math.cos(_controller.value * 2 * math.pi)),
                      size: 300,
                      color: colors[0].withValues(alpha: 0.15),
                    ),
                    // Blob 2: Bottom-Right
                    _PositionedBlob(
                      bottom: -80 + (70 * math.sin((_controller.value + 0.2) * 2 * math.pi)),
                      right: -100 + (60 * math.cos((_controller.value + 0.2) * 2 * math.pi)),
                      size: 280,
                      color: colors[1].withValues(alpha: 0.12),
                    ),
                    // Blob 3: Mid-Right
                    _PositionedBlob(
                      top: 100 + (90 * math.sin((_controller.value + 0.5) * 2 * math.pi)),
                      right: -50 + (70 * math.cos((_controller.value + 0.5) * 2 * math.pi)),
                      size: 220,
                      color: colors[2 % colors.length].withValues(alpha: 0.1),
                    ),
                    // Blob 4: Bottom-Left
                    _PositionedBlob(
                      bottom: 50 + (80 * math.sin((_controller.value + 0.8) * 2 * math.pi)),
                      left: -40 + (60 * math.cos((_controller.value + 0.8) * 2 * math.pi)),
                      size: 250,
                      color: colors[3 % colors.length].withValues(alpha: 0.08),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Blur & Glass Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: widget.blurSigma, sigmaY: widget.blurSigma),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardGlass.withValues(alpha: widget.opacity),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.glassBorder.withValues(alpha: 0.5),
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          widget.child,
        ],
      ),
    );
  }
}

class _PositionedBlob extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double size;
  final Color color;

  const _PositionedBlob({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
