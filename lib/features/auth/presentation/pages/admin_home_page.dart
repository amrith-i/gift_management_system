// import 'dart:math' as math;
// import 'package:daily_finance_manager/core_import.dart';

// @RoutePage()
// class AdminHomePage extends StatefulWidget {
//   const AdminHomePage({super.key});

//   @override
//   State<AdminHomePage> createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
//   int _navIndex = 0;

//   final List<AppUser> recentUsers = [
//     AppUser(
//       userId: 'arjun',
//       name: 'Arjun Sharma',
//       phone: '+91 123456789',
//       role: UserRole.user,
//       expiryDate: DateTime(2025, 1, 15),
//     ),
//     AppUser(
//       userId: 'rahul',
//       name: 'Rahul Varma',
//       phone: '+91 123456789',
//       role: UserRole.user,
//       expiryDate: DateTime(2025, 1, 10),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F4FF),
//       body: Column(
//         children: [
//           // ── Blue header ──────────────────────────────────────────────────
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Color(0xFF81C8F8), Color(0xFF3B82F6)],
//               ),
//             ),
//             child: SafeArea(
//               bottom: false,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: context.w(mobile: 20),
//                   vertical: context.h(mobile: 16),
//                 ),
//                 child: Row(
//                   children: [
//                     // Avatar
//                     CircleAvatar(
//                       radius: context.w(mobile: 26),
//                       backgroundColor: Colors.white.withOpacity(0.3),
//                       child: CircleAvatar(
//                         radius: context.w(mobile: 24),
//                         backgroundColor: Colors.white.withOpacity(0.15),
//                         child: Icon(
//                           Icons.person_rounded,
//                           color: Colors.white,
//                           size: context.w(mobile: 30),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: context.w(mobile: 14)),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Guru Santhosh',
//                           style: TextStyle(
//                             fontSize: context.sp(mobile: 18),
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           'Admin User',
//                           style: TextStyle(
//                             fontSize: context.sp(mobile: 13),
//                             color: Colors.white.withOpacity(0.85),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     // Logout button
//                     Container(
//                       width: context.w(mobile: 44),
//                       height: context.w(mobile: 44),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.25),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.logout_rounded,
//                         color: Colors.white,
//                         size: context.w(mobile: 22),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // ── Scrollable body ──────────────────────────────────────────────
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.fromLTRB(
//                 context.w(mobile: 16),
//                 context.h(mobile: 16),
//                 context.w(mobile: 16),
//                 context.h(mobile: 100),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // ── Gauge card ─────────────────────────────────────────
//                   Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFECF3FF),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     padding: EdgeInsets.all(context.w(mobile: 20)),
//                     child: Column(
//                       children: [
//                         // Speedometer
//                         SizedBox(
//                           height: context.h(mobile: 180),
//                           child: CustomPaint(
//                             painter: _SpeedometerPainter(
//                               activeRatio: 200 / 255,
//                             ),
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                   top: context.h(mobile: 40),
//                                 ),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       '255',
//                                       style: TextStyle(
//                                         fontSize: context.sp(mobile: 52),
//                                         fontWeight: FontWeight.w800,
//                                         color: const Color(0xFF1A1A1A),
//                                         height: 1.0,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Total Users',
//                                       style: TextStyle(
//                                         fontSize: context.sp(mobile: 14),
//                                         color: const Color(0xFF888888),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: context.h(mobile: 20)),

//                         // Active & Expired stat cards
//                         Row(
//                           children: [
//                             Expanded(
//                               child: _buildStatCard(
//                                 context,
//                                 count: '200',
//                                 label: 'Active Users',
//                                 iconWidget: Container(
//                                   width: context.w(mobile: 40),
//                                   height: context.w(mobile: 40),
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFF3B82F6),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.person_rounded,
//                                     color: Colors.white,
//                                     size: context.w(mobile: 22),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: context.w(mobile: 14)),
//                             Expanded(
//                               child: _buildStatCard(
//                                 context,
//                                 count: '55',
//                                 label: 'Expired Subs',
//                                 iconWidget: Container(
//                                   width: context.w(mobile: 40),
//                                   height: context.w(mobile: 40),
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFEF4444),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Icon(
//                                     Icons.warning_rounded,
//                                     color: Colors.white,
//                                     size: context.w(mobile: 22),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: context.h(mobile: 24)),

//                   // ── Recent Users header ────────────────────────────────
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Recent Users',
//                         style: TextStyle(
//                           fontSize: context.sp(mobile: 18),
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF1A1A1A),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'View All >>',
//                           style: TextStyle(
//                             fontSize: context.sp(mobile: 14),
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xFF3B82F6),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: context.h(mobile: 8)),

//                   // ── User cards ─────────────────────────────────────────
//                   ...recentUsers.map((user) => _buildUserCard(context, user)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       // ── FAB ──────────────────────────────────────────────────────────────
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF3B82F6),
//         elevation: 4,
//         shape: const CircleBorder(),
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: context.w(mobile: 30),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       // ── Bottom nav ───────────────────────────────────────────────────────
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 8,
//         color: Colors.white,
//         elevation: 8,
//         child: SizedBox(
//           height: context.h(mobile: 60),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(context, 0, Icons.home_rounded, 'Home'),
//               SizedBox(width: context.w(mobile: 60)), // FAB space
//               _buildNavItem(context, 1, Icons.group_rounded, 'Users'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard(
//     BuildContext context, {
//     required String count,
//     required String label,
//     required Widget iconWidget,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(context.w(mobile: 16)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFF0F0F0)),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 count,
//                 style: TextStyle(
//                   fontSize: context.sp(mobile: 28),
//                   fontWeight: FontWeight.w800,
//                   color: const Color(0xFF1A1A1A),
//                 ),
//               ),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: context.sp(mobile: 12),
//                   color: const Color(0xFF888888),
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           iconWidget,
//         ],
//       ),
//     );
//   }

//   Widget _buildUserCard(BuildContext context, AppUser user) {
//     final isExpired = user.isExpired;
//     final initials = user.name
//         .split(' ')
//         .take(2)
//         .map((e) => e[0].toUpperCase())
//         .join();

//     // Format dates
//     final startDateStr = '15 Jan 2024';
//     final expiryDateStr = isExpired ? '10 Jan 2025' : '15 Jan 2025';

//     return Container(
//       margin: EdgeInsets.only(bottom: context.h(mobile: 14)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFEEEEEE)),
//       ),
//       child: Column(
//         children: [
//           // Top row: avatar, name/phone, status badge
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               context.w(mobile: 14),
//               context.h(mobile: 14),
//               context.w(mobile: 14),
//               context.h(mobile: 12),
//             ),
//             child: Row(
//               children: [
//                 // Initials avatar
//                 Container(
//                   width: context.w(mobile: 46),
//                   height: context.w(mobile: 46),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF3B82F6),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     initials,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: context.sp(mobile: 15),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: context.w(mobile: 12)),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.name,
//                         style: TextStyle(
//                           fontSize: context.sp(mobile: 15),
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xFF1A1A1A),
//                         ),
//                       ),
//                       SizedBox(height: context.h(mobile: 2)),
//                       Text(
//                         user.phone,
//                         style: TextStyle(
//                           fontSize: context.sp(mobile: 12),
//                           color: const Color(0xFF888888),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Status badge
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: context.w(mobile: 12),
//                     vertical: context.h(mobile: 6),
//                   ),
//                   decoration: BoxDecoration(
//                     color: isExpired
//                         ? const Color(0xFFFFEEEE)
//                         : const Color(0xFFEEFFF5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 7,
//                         height: 7,
//                         decoration: BoxDecoration(
//                           color: isExpired
//                               ? const Color(0xFFEF4444)
//                               : const Color(0xFF22C55E),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: context.w(mobile: 5)),
//                       Text(
//                         isExpired ? 'Expired' : 'Active',
//                         style: TextStyle(
//                           fontSize: context.sp(mobile: 13),
//                           fontWeight: FontWeight.w600,
//                           color: isExpired
//                               ? const Color(0xFFEF4444)
//                               : const Color(0xFF22C55E),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Dashed divider
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: context.w(mobile: 14)),
//             child: _DashedLine(),
//           ),

//           // Bottom row: Start Date / Expiry Date
//           Padding(
//             padding: EdgeInsets.fromLTRB(
//               context.w(mobile: 14),
//               context.h(mobile: 10),
//               context.w(mobile: 14),
//               context.h(mobile: 14),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Start Date',
//                       style: TextStyle(
//                         fontSize: context.sp(mobile: 11),
//                         color: const Color(0xFF9E9E9E),
//                       ),
//                     ),
//                     SizedBox(height: context.h(mobile: 2)),
//                     Text(
//                       startDateStr,
//                       style: TextStyle(
//                         fontSize: context.sp(mobile: 14),
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFF1A1A1A),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       'Expiry Date',
//                       style: TextStyle(
//                         fontSize: context.sp(mobile: 11),
//                         color: const Color(0xFF9E9E9E),
//                       ),
//                     ),
//                     SizedBox(height: context.h(mobile: 2)),
//                     Text(
//                       expiryDateStr,
//                       style: TextStyle(
//                         fontSize: context.sp(mobile: 14),
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xFFEF4444),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     BuildContext context,
//     int index,
//     IconData icon,
//     String label,
//   ) {
//     final isSelected = _navIndex == index;
//     return GestureDetector(
//       onTap: () => setState(() => _navIndex = index),
//       behavior: HitTestBehavior.opaque,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             color: isSelected
//                 ? const Color(0xFF3B82F6)
//                 : const Color(0xFF9E9E9E),
//             size: context.w(mobile: 26),
//           ),
//           SizedBox(height: context.h(mobile: 2)),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: context.sp(mobile: 11),
//               fontWeight: FontWeight.w500,
//               color: isSelected
//                   ? const Color(0xFF3B82F6)
//                   : const Color(0xFF9E9E9E),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Dashed line widget ────────────────────────────────────────────────────────
// class _DashedLine extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 1,
//       child: CustomPaint(painter: _DashedLinePainter()),
//     );
//   }
// }

// class _DashedLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFFDDDDDD)
//       ..strokeWidth = 1;
//     double x = 0;
//     const dashW = 6.0;
//     const gapW = 4.0;
//     while (x < size.width) {
//       canvas.drawLine(Offset(x, 0), Offset(x + dashW, 0), paint);
//       x += dashW + gapW;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// // ── Speedometer gauge painter ─────────────────────────────────────────────────
// // Draws a large blue arc (left ~200°→0°) and a smaller red arc (right ~0°→short)
// // exactly matching the PNG: thick, rounded strokes, light blue background track.
// class _SpeedometerPainter extends CustomPainter {
//   final double activeRatio; // 200/255 ≈ 0.784

//   const _SpeedometerPainter({required this.activeRatio});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final cx = size.width / 2;
//     final cy = size.height * 0.70;
//     final radius = size.width * 0.40;
//     const strokeW = 28.0;

//     // Arc spans from 200° to 340° (bottom-left to bottom-right, opening downward)
//     // In Flutter radians: 200° = 200*pi/180, sweep = 140°
//     const startAngleDeg = 200.0;
//     const sweepDeg = 140.0;
//     final startRad = startAngleDeg * math.pi / 180;
//     final sweepRad = sweepDeg * math.pi / 180;

//     final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);

//     // Background track (very light blue/grey)
//     final trackPaint = Paint()
//       ..color = const Color(0xFFE2E8F0)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeW
//       ..strokeCap = StrokeCap.round;
//     canvas.drawArc(rect, startRad, sweepRad, false, trackPaint);

//     // Blue active arc (left portion, from start to activeRatio point)
//     final blueSweep = sweepRad * activeRatio;
//     final bluePaint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
//         begin: Alignment.topRight,
//         end: Alignment.bottomLeft,
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeW
//       ..strokeCap = StrokeCap.round;
//     canvas.drawArc(rect, startRad, blueSweep, false, bluePaint);

//     // Red arc (right portion, from activeRatio to end)
//     final redStart = startRad + blueSweep;
//     final redSweep = sweepRad * (1 - activeRatio);
//     final redPaint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFFFCA5A5), Color(0xFFEF4444)],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ).createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeW
//       ..strokeCap = StrokeCap.round;
//     canvas.drawArc(rect, redStart, redSweep, false, redPaint);
//   }

//   @override
//   bool shouldRepaint(covariant _SpeedometerPainter old) =>
//       old.activeRatio != activeRatio;
// }
