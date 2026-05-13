// lib/widgets/admin_home/total_users_card_widget.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:daily_finance_manager/core_import.dart';

class TotalUsersCardWidget extends StatelessWidget {
  final int totalUsers;
  final int activeUsers;
  final int expiredUsers;

  const TotalUsersCardWidget({
    super.key,
    required this.totalUsers,
    required this.activeUsers,
    required this.expiredUsers,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = totalUsers > 0 ? activeUsers / totalUsers : 0.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(context.r(mobile: 10)),
        border: Border.all(color: const Color(0xFFD8E6FF), width: 1),
      ),
      padding: EdgeInsets.fromLTRB(
        context.w(mobile: 16),
        context.h(mobile: 24),
        context.w(mobile: 16),
        context.h(mobile: 20),
      ),
      child: Column(
        children: [
          // ── Speedometer gauge + text ────────────────────────────────────
          // We use a Stack: gauge on bottom, text overlaid at bottom-center.
          // The gauge paints a TRUE semicircle whose two bottom ends sit at
          // exactly the same y as "Total Users" text baseline.
          SizedBox(
            width: double.infinity,
            height: context.h(mobile: 200),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gauge fills the full width
                Positioned.fill(
                  child: CustomPaint(
                    painter: _SpeedometerPainter(activeRatio: ratio),
                  ),
                ),

                // "255\nTotal Users" sits at the bottom-center,
                // vertically aligned with where the arc ends
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$totalUsers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.sp(mobile: 52),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A1A),
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: context.h(mobile: 4)),
                      Text(
                        'Total Users',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.sp(mobile: 14),
                          color: const Color(0xFF888888),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: context.h(mobile: 20)),

          // ── Active & Expired stat cards ──────────────────────────────────
          Row(
            children: [
              // Active Users Card
              Expanded(
                child: _StatCard(
                  count: '$activeUsers',
                  label: 'Active Users',
                  iconColor: const Color(0xFF3B82F6),
                  icon: Icons.how_to_reg_rounded,
                ),
              ),
              SizedBox(width: context.w(mobile: 12)),
              // Expired Subs Card
              Expanded(
                child: _StatCard(
                  count: '$expiredUsers',
                  label: 'Expired Subs',
                  iconColor: const Color(0xFFEF4444),
                  icon: Icons.warning_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat card — exact layout from PNG close-ups:
//   Row 1: count (left)  |  circle icon (right)
//   Row 2: label text (left-aligned)
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String count;
  final String label;
  final Color iconColor;
  final IconData icon;

  const _StatCard({
    required this.count,
    required this.label,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.r(mobile: 10)),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
      ),
      padding: EdgeInsets.fromLTRB(
        context.w(mobile: 16),
        context.h(mobile: 14),
        context.w(mobile: 14),
        context.h(mobile: 14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: count + icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: context.sp(mobile: 30),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                  height: 1.0,
                ),
              ),
              const Spacer(),
              Container(
                width: context.w(mobile: 35),
                height: context.w(mobile: 35),
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: context.w(mobile: 24),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: context.h(mobile: 8)),

          // Row 2: label
          Text(
            label,
            style: TextStyle(
              fontSize: context.sp(mobile: 13),
              color: const Color(0xFF1A1A1A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Speedometer painter — exact match to PNG:
//
//  • TRUE semicircle: starts at 180° (left), sweeps +180° clockwise to 0° (right)
//    → both bottom ends are at the exact same horizontal y (the centre point y)
//  • Very thick strokes (stroke ≈ 13% of canvas width), round caps
//  • NO background track — gaps between arcs show the card's own bg colour
//  • Gap of ~10° between blue end and red start
//  • Blue arc  : from 180° sweeping RIGHT covering activeRatio of total sweep
//    gradient  : light-sky-blue (bottom-left) → cornflower-blue (top)
//  • Red arc   : remaining sweep on the RIGHT side
//    gradient  : light-pink (top) → vivid-red (bottom-right)
//  • Canvas centre (cx, cy) is set so the arc bottom ends sit at the very
//    bottom of the SizedBox, putting "Total Users" text exactly at that level
// ─────────────────────────────────────────────────────────────────────────────
class _SpeedometerPainter extends CustomPainter {
  final double activeRatio;

  const _SpeedometerPainter({required this.activeRatio});

  @override
  void paint(Canvas canvas, Size size) {
    // ── Dimensions ──────────────────────────────────────────────────────────
    final strokeW = size.width * 0.13;
    final cx = size.width / 2;
    final radius = (size.width / 2) - (strokeW / 2);
    // cy at canvas bottom so both arc endpoints land at the same horizontal
    // line as "Total Users" text beneath the SizedBox
    final cy = size.height - strokeW / 2;

    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

    // ── Fixed arc degrees measured from the PNG ──────────────────────────────
    // Total semicircle = 180°
    // Blue arc  :  115°  (left → past top → ~65% across)
    // Gap       :   30°  (large visible space between arcs)
    // Red arc   :   35°  (right side only)
    // 115 + 30 + 35 = 180 ✓
    //
    // Flutter canvas: startAngle=π (180° = left point),
    // positive sweepAngle = clockwise → goes UP over the top → right.
    const deg = math.pi / 180.0;

    const arcStart = math.pi; // 180° = left bottom endpoint
    // const blueDeg = 115.0;
    // const gapDeg = 25.0;
    // const redDeg = 40.0;
    const gapDeg = 25.0; // gap stays fixed always
    final blueDeg =
        (180.0 - gapDeg) * activeRatio; // blue grows with active users
    final redDeg = (180.0 - gapDeg) - blueDeg; // red takes the remainder

    final blueSweep = blueDeg * deg;
    final gapSweep = gapDeg * deg;
    final redSweep = redDeg * deg;

    final blueStart = arcStart;
    final redStart = arcStart + blueSweep + gapSweep;

    // ── Blue arc ─────────────────────────────────────────────────────────────
    // PNG: deep blue at bottom-left end → light sky-blue at the top peak
    final bluePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF74C0FF)],
        begin: Alignment.bottomLeft,
        end: Alignment.topCenter,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, blueStart, blueSweep, false, bluePaint);

    // ── Red arc ──────────────────────────────────────────────────────────────
    // PNG: light pink at top → vivid red at bottom-right end
    final redPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFAAAA), Color(0xFFEF3333)],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, redStart, redSweep, false, redPaint);
  }

  @override
  bool shouldRepaint(covariant _SpeedometerPainter old) =>
      old.activeRatio != activeRatio;
}
