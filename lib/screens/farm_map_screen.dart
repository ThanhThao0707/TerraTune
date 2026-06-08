

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';

class FarmMapScreen extends StatelessWidget {
  const FarmMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TerraAppHeader(subtitle: 'Vườn xoài Hà Nội'),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row với Satellite toggle
                Row(
                  children: [
                    const Icon(Icons.map_outlined,
                        color: AppColors.textDark, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Farm Map',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryGreen,
                          ),
                    ),
                    const Spacer(),

                    // Satellite toggle
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.layers_outlined,
                              size: 16, color: AppColors.primaryGreen),
                          const SizedBox(width: 6),
                          Text(
                            'Satellite',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Location button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.my_location_rounded,
                          size: 18, color: AppColors.primaryGreen),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Map container
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.mediumGreen.withOpacity(0.3),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Map placeholder background
                        Container(
                          color: const Color(0xFFD4E8D0),
                          child: CustomPaint(
                            painter: _MapGridPainter(),
                            size: const Size(double.infinity, 500),
                          ),
                        ),

                        // Center info
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(Icons.map_rounded,
                                        size: 40,
                                        color: AppColors.primaryGreen),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Google Maps Integration',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Thêm google_maps_flutter\nvào pubspec.yaml',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Mock tree pins
                        Positioned(
                          top: 150,
                          left: 100,
                          child: _TreePin(label: '1', isHealthy: true),
                        ),
                        Positioned(
                          top: 220,
                          left: 200,
                          child: _TreePin(label: '2', isHealthy: false),
                        ),
                        Positioned(
                          top: 300,
                          left: 150,
                          child: _TreePin(label: '3', isHealthy: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class _TreePin extends StatelessWidget {
  final String label;
  final bool isHealthy;

  const _TreePin({required this.label, required this.isHealthy});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isHealthy ? AppColors.healthy : AppColors.drought,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}


class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB8D4B0)
      ..strokeWidth = 1;

   
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vẽ đường dọc
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
