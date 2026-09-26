import 'package:flutter/material.dart';
import '../constants/assets.dart';

/// ReCyclo Official Brand Logo Widget
/// Strict rules: Uses the EXACT provided logo from assets/recyclo-logo.jpg
/// Preserves exact proportions, colors, and design.
class ReCycloLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ReCycloLogo({
    super.key,
    this.width,
    this.height = 48,
    this.fit = BoxFit.contain,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      ReCycloAssets.logo,
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        // Safe fallback in case of asset bundling issues during early build
        return Container(
          width: width ?? 120,
          height: height ?? 48,
          decoration: BoxDecoration(
            color: const Color(0xFF00A884),
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: const Text(
            'ReCyclo',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      },
    );

    if (borderRadius != null) {
      image = ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }
}
