import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class TechBackgroundPainter extends CustomPainter {
  final double animationValue;

  TechBackgroundPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const spacing = 120.0;
    
    // Draw Grid (using DrawLines for efficiency if possible, but manual is fine)
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw fewer Circuit-like patterns for better performance
    final circuitPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); 
    for (int i = 0; i < 8; i++) { // Reduced from 15
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      
      final path = Path();
      path.moveTo(startX, startY);
      
      double currentX = startX;
      double currentY = startY;
      
      for (int j = 0; j < 3; j++) { // Reduced from 4
        final direction = random.nextInt(4);
        final length = 60.0 + random.nextDouble() * 80.0;
        
        if (direction == 0) {
          currentX += length;
        } else if (direction == 1) {
          currentX -= length;
        } else if (direction == 2) {
          currentY += length;
        } else if (direction == 3) {
          currentY -= length;
        }
        
        path.lineTo(currentX, currentY);
      }
      
      canvas.drawPath(path, circuitPaint);
      canvas.drawCircle(Offset(startX, startY), 2, dotPaint);
    }
    
    // Animated glowing "nodes"
    final glowOpacity = 0.12 * (math.sin(animationValue * 2 * math.pi) + 1) / 2;
    final glowPaint = Paint()
      ..color = AppColors.accent.withValues(alpha: glowOpacity)
      ..style = PaintingStyle.fill;
      
    for (int i = 0; i < 6; i++) { // Reduced from 10
      final nodeX = (random.nextDouble() * size.width + animationValue * 40) % size.width;
      final nodeY = (random.nextDouble() * size.height) % size.height;
      canvas.drawCircle(Offset(nodeX, nodeY), 3, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TechBackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
