import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// ReCyclo Handcrafted Custom Icon System
/// Direct match with web brand specification:
/// - Inactive: 2px stroke outline, rounded caps/joins
/// - Active: Primary-filled / active state
class ReCycloIcon extends StatelessWidget {
  final String name;
  final double size;
  final Color? color;
  final bool active;

  const ReCycloIcon(
    this.name, {
    super.key,
    this.size = 24,
    this.color,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? (active ? ReCycloColors.primary : ReCycloColors.textSecondary);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ReCycloIconPainter(
          name: name.toLowerCase(),
          color: effectiveColor,
          active: active,
        ),
      ),
    );
  }
}

class _ReCycloIconPainter extends CustomPainter {
  final String name;
  final Color color;
  final bool active;

  _ReCycloIconPainter({
    required this.name,
    required this.color,
    required this.active,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    canvas.save();
    canvas.scale(scale, scale);

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final whiteStroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final whiteFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    switch (name) {
      case 'home':
        final path = Path();
        path.moveTo(3, 10.25);
        path.lineTo(12, 3);
        path.lineTo(21, 10.25);
        path.lineTo(21, 20);
        path.arcToPoint(const Offset(19.5, 21.5), radius: const Radius.circular(1.5));
        path.lineTo(4.5, 21.5);
        path.arcToPoint(const Offset(3, 20), radius: const Radius.circular(1.5));
        path.close();

        if (active) {
          canvas.drawPath(path, fillPaint);
          canvas.drawPath(path, strokePaint);
          final door = Path();
          door.moveTo(9, 21.5);
          door.lineTo(9, 14.5);
          door.arcToPoint(const Offset(10.5, 13), radius: const Radius.circular(1.5));
          door.lineTo(13.5, 13);
          door.arcToPoint(const Offset(15, 14.5), radius: const Radius.circular(1.5));
          door.lineTo(15, 21.5);
          canvas.drawPath(door, whiteStroke);
        } else {
          canvas.drawPath(path, strokePaint);
          final door = Path();
          door.moveTo(9, 21.5);
          door.lineTo(9, 14.5);
          door.arcToPoint(const Offset(10.5, 13), radius: const Radius.circular(1.5));
          door.lineTo(13.5, 13);
          door.arcToPoint(const Offset(15, 14.5), radius: const Radius.circular(1.5));
          door.lineTo(15, 21.5);
          canvas.drawPath(door, strokePaint);
        }
        break;

      case 'requests':
      case 'clipboard':
        final rrect = RRect.fromRectAndRadius(
          const Rect.fromLTWH(4, 4, 16, 17),
          const Radius.circular(2.5),
        );
        if (active) {
          canvas.drawRRect(rrect, fillPaint);
          canvas.drawRRect(rrect, strokePaint);
          canvas.drawRRect(
            RRect.fromRectAndRadius(const Rect.fromLTWH(8.5, 2, 7, 3), const Radius.circular(1)),
            whiteFill,
          );
          canvas.drawLine(const Offset(8, 10), const Offset(16, 10), whiteStroke);
          canvas.drawLine(const Offset(8, 14), const Offset(13, 14), whiteStroke);
        } else {
          canvas.drawRRect(rrect, strokePaint);
          canvas.drawRRect(
            RRect.fromRectAndRadius(const Rect.fromLTWH(8.5, 2, 7, 3), const Radius.circular(1)),
            strokePaint,
          );
          canvas.drawLine(const Offset(8, 10), const Offset(16, 10), strokePaint);
          canvas.drawLine(const Offset(8, 14), const Offset(13, 14), strokePaint);
        }
        break;

      case 'add':
      case 'add-waste':
      case 'plus':
        final boldStroke = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round;
        canvas.drawLine(const Offset(12, 5), const Offset(12, 19), boldStroke);
        canvas.drawLine(const Offset(5, 12), const Offset(19, 12), boldStroke);
        break;

      case 'collectors':
      case 'truck':
        final cab = Path()
          ..moveTo(1, 5)
          ..lineTo(14, 5)
          ..lineTo(14, 17)
          ..lineTo(1, 17)
          ..close();
        final nose = Path()
          ..moveTo(14, 9)
          ..lineTo(18, 9)
          ..lineTo(21, 12)
          ..lineTo(21, 17)
          ..lineTo(14, 17)
          ..close();

        if (active) {
          canvas.drawPath(cab, fillPaint);
          canvas.drawPath(cab, strokePaint);
          canvas.drawPath(nose, fillPaint);
          canvas.drawPath(nose, strokePaint);
          canvas.drawCircle(const Offset(6, 18.5), 2.5, whiteFill);
          canvas.drawCircle(const Offset(6, 18.5), 2.5, strokePaint);
          canvas.drawCircle(const Offset(17, 18.5), 2.5, whiteFill);
          canvas.drawCircle(const Offset(17, 18.5), 2.5, strokePaint);
        } else {
          canvas.drawPath(cab, strokePaint);
          canvas.drawPath(nose, strokePaint);
          canvas.drawCircle(const Offset(6, 18.5), 2.5, strokePaint);
          canvas.drawCircle(const Offset(17, 18.5), 2.5, strokePaint);
        }
        break;

      case 'profile':
      case 'user':
        if (active) {
          canvas.drawCircle(const Offset(12, 7), 4.5, fillPaint);
          canvas.drawCircle(const Offset(12, 7), 4.5, strokePaint);
          final body = Path()
            ..moveTo(4, 20.5)
            ..cubicTo(4, 16.5, 7.5, 14, 12, 14)
            ..cubicTo(16.5, 14, 20, 16.5, 20, 20.5)
            ..close();
          canvas.drawPath(body, fillPaint);
          canvas.drawPath(body, strokePaint);
        } else {
          canvas.drawCircle(const Offset(12, 7), 4.5, strokePaint);
          final body = Path()
            ..moveTo(4, 20.5)
            ..cubicTo(4, 16.5, 7.5, 14, 12, 14)
            ..cubicTo(16.5, 14, 20, 16.5, 20, 20.5);
          canvas.drawPath(body, strokePaint);
        }
        break;

      case 'plastic':
        final cap = RRect.fromRectAndRadius(const Rect.fromLTWH(8, 2, 8, 2), const Radius.circular(1));
        canvas.drawRRect(cap, active ? fillPaint : strokePaint);
        final bottle = Path()
          ..moveTo(9, 4)
          ..lineTo(9, 6.5)
          ..lineTo(6, 9)
          ..lineTo(6, 20)
          ..arcToPoint(const Offset(8, 22), radius: const Radius.circular(2))
          ..lineTo(16, 22)
          ..arcToPoint(const Offset(18, 20), radius: const Radius.circular(2))
          ..lineTo(18, 9)
          ..lineTo(15, 6.5)
          ..lineTo(15, 4)
          ..close();
        if (active) {
          canvas.drawPath(bottle, fillPaint);
          canvas.drawLine(const Offset(9, 13), const Offset(15, 13), whiteStroke);
          canvas.drawLine(const Offset(9, 17), const Offset(15, 17), whiteStroke);
        } else {
          canvas.drawPath(bottle, strokePaint);
          canvas.drawLine(const Offset(9, 13), const Offset(15, 13), strokePaint);
          canvas.drawLine(const Offset(9, 17), const Offset(15, 17), strokePaint);
        }
        break;

      case 'paper':
        final doc = Path()
          ..moveTo(5, 3)
          ..lineTo(14, 3)
          ..lineTo(19, 8)
          ..lineTo(19, 21)
          ..arcToPoint(const Offset(17, 23), radius: const Radius.circular(2))
          ..lineTo(7, 23)
          ..arcToPoint(const Offset(5, 21), radius: const Radius.circular(2))
          ..close();
        if (active) {
          canvas.drawPath(doc, fillPaint);
          canvas.drawLine(const Offset(9, 12), const Offset(15, 12), whiteStroke);
          canvas.drawLine(const Offset(9, 16), const Offset(13, 16), whiteStroke);
        } else {
          canvas.drawPath(doc, strokePaint);
          canvas.drawLine(const Offset(14, 3), const Offset(14, 8), strokePaint);
          canvas.drawLine(const Offset(14, 8), const Offset(19, 8), strokePaint);
          canvas.drawLine(const Offset(9, 12), const Offset(15, 12), strokePaint);
          canvas.drawLine(const Offset(9, 16), const Offset(13, 16), strokePaint);
        }
        break;

      case 'metal':
        final ingot = RRect.fromRectAndRadius(const Rect.fromLTWH(3, 6, 18, 12), const Radius.circular(2.5));
        if (active) {
          canvas.drawRRect(ingot, fillPaint);
          canvas.drawCircle(const Offset(8, 12), 2, whiteFill);
          canvas.drawCircle(const Offset(16, 12), 2, whiteFill);
        } else {
          canvas.drawRRect(ingot, strokePaint);
          canvas.drawCircle(const Offset(8, 12), 2, strokePaint);
          canvas.drawCircle(const Offset(16, 12), 2, strokePaint);
        }
        break;

      case 'glass':
        final bottle = Path()
          ..moveTo(8, 2)
          ..lineTo(16, 2)
          ..moveTo(9, 2)
          ..lineTo(9, 6)
          ..lineTo(5, 13)
          ..lineTo(5, 20)
          ..arcToPoint(const Offset(7, 22), radius: const Radius.circular(2))
          ..lineTo(17, 22)
          ..arcToPoint(const Offset(19, 20), radius: const Radius.circular(2))
          ..lineTo(19, 13)
          ..lineTo(15, 6)
          ..lineTo(15, 2);
        if (active) {
          final closed = Path.from(bottle)..close();
          canvas.drawPath(closed, fillPaint);
          final smile = Path()
            ..moveTo(10, 13)
            ..quadraticBezierTo(12, 15, 14, 13);
          canvas.drawPath(smile, whiteStroke);
        } else {
          canvas.drawPath(bottle, strokePaint);
          final smile = Path()
            ..moveTo(10, 13)
            ..quadraticBezierTo(12, 15, 14, 13);
          canvas.drawPath(smile, strokePaint);
        }
        break;

      case 'clothes':
        final shirt = Path()
          ..moveTo(6, 3)
          ..lineTo(12, 6)
          ..lineTo(18, 3)
          ..lineTo(21, 8)
          ..lineTo(18, 10)
          ..lineTo(18, 21)
          ..arcToPoint(const Offset(16, 23), radius: const Radius.circular(2))
          ..lineTo(8, 23)
          ..arcToPoint(const Offset(6, 21), radius: const Radius.circular(2))
          ..lineTo(6, 10)
          ..lineTo(3, 8)
          ..close();
        if (active) {
          canvas.drawPath(shirt, fillPaint);
        } else {
          canvas.drawPath(shirt, strokePaint);
        }
        break;

      case 'e-waste':
        final screen = RRect.fromRectAndRadius(const Rect.fromLTWH(3, 4, 18, 12), const Radius.circular(2));
        if (active) {
          canvas.drawRRect(screen, fillPaint);
          canvas.drawLine(const Offset(12, 16), const Offset(12, 20), strokePaint);
          canvas.drawLine(const Offset(8, 20), const Offset(16, 20), strokePaint);
          canvas.drawRect(const Rect.fromLTWH(8, 9, 2, 2), whiteFill);
          canvas.drawRect(const Rect.fromLTWH(14, 9, 2, 2), whiteFill);
        } else {
          canvas.drawRRect(screen, strokePaint);
          canvas.drawLine(const Offset(12, 16), const Offset(12, 20), strokePaint);
          canvas.drawLine(const Offset(8, 20), const Offset(16, 20), strokePaint);
          canvas.drawRect(const Rect.fromLTWH(8, 9, 2, 2), fillPaint);
          canvas.drawRect(const Rect.fromLTWH(14, 9, 2, 2), fillPaint);
        }
        break;

      case 'other':
        final hex = Path()
          ..moveTo(12, 2)
          ..lineTo(20, 6.5)
          ..lineTo(20, 17.5)
          ..lineTo(12, 22)
          ..lineTo(4, 17.5)
          ..lineTo(4, 6.5)
          ..close();
        if (active) {
          canvas.drawPath(hex, fillPaint);
          canvas.drawCircle(const Offset(12, 12), 3, whiteFill);
        } else {
          canvas.drawPath(hex, strokePaint);
          canvas.drawCircle(const Offset(12, 12), 3, strokePaint);
        }
        break;

      case 'bell':
        final bell = Path()
          ..moveTo(18, 8)
          ..cubicTo(18, 4.68, 15.32, 2, 12, 2)
          ..cubicTo(8.68, 2, 6, 4.68, 6, 8)
          ..cubicTo(6, 15, 3, 17, 3, 17)
          ..lineTo(21, 17)
          ..cubicTo(21, 17, 18, 15, 18, 8)
          ..close();
        final clapper = Path()
          ..moveTo(10.27, 21)
          ..arcToPoint(const Offset(13.73, 21), radius: const Radius.circular(2));
        if (active) {
          canvas.drawPath(bell, fillPaint);
          canvas.drawPath(clapper, strokePaint);
        } else {
          canvas.drawPath(bell, strokePaint);
          canvas.drawPath(clapper, strokePaint);
        }
        break;

      case 'camera':
        final cam = Path()
          ..moveTo(21, 19)
          ..arcToPoint(const Offset(19, 21), radius: const Radius.circular(2))
          ..lineTo(5, 21)
          ..arcToPoint(const Offset(3, 19), radius: const Radius.circular(2))
          ..lineTo(3, 8)
          ..arcToPoint(const Offset(5, 6), radius: const Radius.circular(2))
          ..lineTo(7, 6)
          ..lineTo(9, 3)
          ..lineTo(15, 3)
          ..lineTo(17, 6)
          ..lineTo(19, 6)
          ..arcToPoint(const Offset(21, 8), radius: const Radius.circular(2))
          ..close();
        if (active) {
          canvas.drawPath(cam, fillPaint);
          canvas.drawCircle(const Offset(12, 13), 4, whiteFill);
        } else {
          canvas.drawPath(cam, strokePaint);
          canvas.drawCircle(const Offset(12, 13), 4, strokePaint);
        }
        break;

      case 'gallery':
      case 'image':
        final box = RRect.fromRectAndRadius(const Rect.fromLTWH(3, 3, 18, 18), const Radius.circular(3));
        if (active) {
          canvas.drawRRect(box, fillPaint);
          canvas.drawCircle(const Offset(8.5, 8.5), 1.5, whiteFill);
          final mtn = Path()
            ..moveTo(21, 15)
            ..lineTo(16, 10)
            ..lineTo(5, 21);
          canvas.drawPath(mtn, whiteStroke);
        } else {
          canvas.drawRRect(box, strokePaint);
          canvas.drawCircle(const Offset(8.5, 8.5), 1.5, strokePaint);
          final mtn = Path()
            ..moveTo(21, 15)
            ..lineTo(16, 10)
            ..lineTo(5, 21);
          canvas.drawPath(mtn, strokePaint);
        }
        break;

      case 'chat':
      case 'message':
        final bubble = Path()
          ..moveTo(21, 11.5)
          ..arcToPoint(const Offset(12.5, 20), radius: const Radius.circular(8.5))
          ..lineTo(8.7, 19.1)
          ..lineTo(3, 21)
          ..lineTo(4.9, 15.3)
          ..arcToPoint(const Offset(4, 11.5), radius: const Radius.circular(8.5))
          ..arcToPoint(const Offset(12.5, 3), radius: const Radius.circular(8.5))
          ..arcToPoint(const Offset(21, 11.5), radius: const Radius.circular(8.5))
          ..close();
        if (active) {
          canvas.drawPath(bubble, fillPaint);
        } else {
          canvas.drawPath(bubble, strokePaint);
        }
        break;

      case 'phone':
        final handset = Path()
          ..moveTo(22, 16.92)
          ..lineTo(22, 19.92)
          ..arcToPoint(const Offset(19.82, 21.92), radius: const Radius.circular(2))
          ..cubicTo(11.19, 21.92, 4.08, 14.81, 4.08, 6.18)
          ..arcToPoint(const Offset(6.08, 4), radius: const Radius.circular(2))
          ..lineTo(9.08, 4)
          ..arcToPoint(const Offset(11.08, 5.72), radius: const Radius.circular(2))
          ..cubicTo(11.3, 6.66, 11.66, 7.56, 12.16, 8.39)
          ..arcToPoint(const Offset(11.71, 10.5), radius: const Radius.circular(2))
          ..lineTo(10.09, 11.91)
          ..cubicTo(11.5, 14.6, 13.4, 16.5, 16.09, 17.91)
          ..lineTo(17.36, 16.64)
          ..arcToPoint(const Offset(19.47, 16.19), radius: const Radius.circular(2))
          ..cubicTo(20.3, 16.69, 21.2, 17.05, 22.14, 17.27)
          ..close();
        if (active) {
          canvas.drawPath(handset, fillPaint);
        } else {
          canvas.drawPath(handset, strokePaint);
        }
        break;

      case 'search':
        canvas.drawCircle(const Offset(11, 11), 7.5, strokePaint);
        canvas.drawLine(const Offset(16.5, 16.5), const Offset(21, 21), strokePaint);
        break;

      case 'location':
      case 'map-pin':
        final pin = Path()
          ..moveTo(12, 2)
          ..cubicTo(7.58, 2, 4, 5.58, 4, 10)
          ..cubicTo(4, 16, 12, 22, 12, 22)
          ..cubicTo(12, 22, 20, 16, 20, 10)
          ..cubicTo(20, 5.58, 16.42, 2, 12, 2)
          ..close();
        if (active) {
          canvas.drawPath(pin, fillPaint);
          canvas.drawCircle(const Offset(12, 10), 3, whiteFill);
        } else {
          canvas.drawPath(pin, strokePaint);
          canvas.drawCircle(const Offset(12, 10), 3, strokePaint);
        }
        break;

      case 'calendar':
        final cal = RRect.fromRectAndRadius(const Rect.fromLTWH(3, 4, 18, 18), const Radius.circular(2));
        if (active) {
          canvas.drawRRect(cal, fillPaint);
          canvas.drawLine(const Offset(16, 2), const Offset(16, 6), whiteStroke);
          canvas.drawLine(const Offset(8, 2), const Offset(8, 6), whiteStroke);
          canvas.drawLine(const Offset(3, 10), const Offset(21, 10), whiteStroke);
        } else {
          canvas.drawRRect(cal, strokePaint);
          canvas.drawLine(const Offset(16, 2), const Offset(16, 6), strokePaint);
          canvas.drawLine(const Offset(8, 2), const Offset(8, 6), strokePaint);
          canvas.drawLine(const Offset(3, 10), const Offset(21, 10), strokePaint);
        }
        break;

      case 'clock':
        canvas.drawCircle(const Offset(12, 12), 9, active ? fillPaint : strokePaint);
        if (active) {
          canvas.drawLine(const Offset(12, 6), const Offset(12, 12), whiteStroke);
          canvas.drawLine(const Offset(12, 12), const Offset(16, 14), whiteStroke);
        } else {
          canvas.drawLine(const Offset(12, 6), const Offset(12, 12), strokePaint);
          canvas.drawLine(const Offset(12, 12), const Offset(16, 14), strokePaint);
        }
        break;

      case 'card':
      case 'credit-card':
        final card = RRect.fromRectAndRadius(const Rect.fromLTWH(2, 5, 20, 14), const Radius.circular(2.5));
        if (active) {
          canvas.drawRRect(card, fillPaint);
          canvas.drawLine(const Offset(2, 10), const Offset(22, 10), whiteStroke);
          canvas.drawLine(const Offset(6, 15), const Offset(10, 15), whiteStroke);
        } else {
          canvas.drawRRect(card, strokePaint);
          canvas.drawLine(const Offset(2, 10), const Offset(22, 10), strokePaint);
          canvas.drawLine(const Offset(6, 15), const Offset(10, 15), strokePaint);
        }
        break;

      case 'cash':
        final note = RRect.fromRectAndRadius(const Rect.fromLTWH(2, 6, 20, 12), const Radius.circular(2));
        if (active) {
          canvas.drawRRect(note, fillPaint);
          canvas.drawCircle(const Offset(12, 12), 2.5, whiteStroke);
          canvas.drawCircle(const Offset(6, 12), 1, whiteFill);
          canvas.drawCircle(const Offset(18, 12), 1, whiteFill);
        } else {
          canvas.drawRRect(note, strokePaint);
          canvas.drawCircle(const Offset(12, 12), 2.5, strokePaint);
          canvas.drawCircle(const Offset(6, 12), 1, strokePaint);
          canvas.drawCircle(const Offset(18, 12), 1, strokePaint);
        }
        break;

      case 'star':
        final starPath = Path()
          ..moveTo(12, 2)
          ..lineTo(15.09, 8.26)
          ..lineTo(22, 9.27)
          ..lineTo(17, 14.14)
          ..lineTo(18.18, 21.02)
          ..lineTo(12, 17.77)
          ..lineTo(5.82, 21.02)
          ..lineTo(7, 14.14)
          ..lineTo(2, 9.27)
          ..lineTo(8.91, 8.26)
          ..close();
        final starPaint = Paint()
          ..color = active ? const Color(0xFFF59E0B) : color
          ..style = active ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeJoin = StrokeJoin.round;
        canvas.drawPath(starPath, starPaint);
        break;

      case 'check':
        final checkPath = Path()
          ..moveTo(4, 12.5)
          ..lineTo(9.5, 17.5)
          ..lineTo(20, 6.5);
        canvas.drawPath(checkPath, strokePaint);
        break;

      default:
        // Generic circle fallback
        canvas.drawCircle(const Offset(12, 12), 8, strokePaint);
        break;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ReCycloIconPainter oldDelegate) {
    return oldDelegate.name != name ||
        oldDelegate.color != color ||
        oldDelegate.active != active;
  }
}
