import 'package:daily_finance_manager/core_import.dart';

class RecentUsersWidget extends StatelessWidget {
  final List<AppUser> users;
  final VoidCallback onViewAll;

  const RecentUsersWidget({
    super.key,
    required this.users,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Users',
              style: AdminHomeTextStyles.sectionTitle(context),
            ),
            TextButton(
              onPressed: onViewAll,
              child: Text(
                'View All >>',
                style: AdminHomeTextStyles.viewAllText(context),
              ),
            ),
          ],
        ),
        SizedBox(height: AdminHomePadding.betweenRowsInNumpad(context)),
        ...users.map((user) => _buildUserCard(context, user)),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context, AppUser user) {
    final isExpired = user.isExpired;
    final initials = user.name
        .split(' ')
        .take(2)
        .map((e) => e[0].toUpperCase())
        .join();

    final startDateStr = '15 Jan 2024';
    final expiryDateStr = isExpired ? '10 Jan 2025' : '15 Jan 2025';

    return Container(
      margin: EdgeInsets.only(bottom: AdminHomePadding.betweenCards(context)),
      decoration: AdminHomeDecorations.userCard(context),
      child: Column(
        children: [
          Padding(
            padding: AdminHomePadding.userCardTopPadding(context),
            child: Row(
              children: [
                Container(
                  width: context.w(mobile: 46),
                  height: context.w(mobile: 46),
                  decoration: AdminHomeDecorations.avatarDecoration(context),
                  alignment: Alignment.center,
                  child: Text(
                    initials,
                    style: AdminHomeTextStyles.initialsText(context),
                  ),
                ),
                SizedBox(width: AdminHomePadding.betweenAvatarAndText(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: AdminHomeTextStyles.userNameCard(context),
                      ),
                      SizedBox(
                        height: AdminHomePadding.betweenRowsInNumpad(context),
                      ),
                      Text(
                        user.phone,
                        style: AdminHomeTextStyles.userPhone(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: AdminHomePadding.statusBadgePadding(context),
                  decoration: AdminHomeDecorations.statusBadgeDecoration(
                    context,
                    isExpired,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isExpired
                              ? AdminHomeColors.redAccent
                              : AdminHomeColors.greenSuccess,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: AdminHomePadding.betweenStatusDotAndText(
                          context,
                        ),
                      ),
                      Text(
                        isExpired ? 'Expired' : 'Active',
                        style: AdminHomeTextStyles.statusText(
                          context,
                          isExpired,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _DashedLine(),
          Padding(
            padding: AdminHomePadding.userCardBottomPadding(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Date',
                      style: AdminHomeTextStyles.dateLabel(context),
                    ),
                    SizedBox(
                      height: AdminHomePadding.betweenRowsInNumpad(context),
                    ),
                    Text(
                      startDateStr,
                      style: AdminHomeTextStyles.dateValue(context),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expiry Date',
                      style: AdminHomeTextStyles.dateLabel(context),
                    ),
                    SizedBox(
                      height: AdminHomePadding.betweenRowsInNumpad(context),
                    ),
                    Text(
                      expiryDateStr,
                      style: AdminHomeTextStyles.expiryDateValue(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 1,
      child: CustomPaint(painter: _DashedLinePainter()),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AdminHomeColors.dashedLine
      ..strokeWidth = 1;
    double x = 0;
    const dashW = 8.0;
    const gapW = 6.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashW, 0), paint);
      x += dashW + gapW;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
