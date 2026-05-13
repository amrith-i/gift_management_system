import 'package:daily_finance_manager/core_import.dart';

class AdminHeaderWidget extends StatelessWidget {
  final String userName;
  final String userRole;
  final VoidCallback onLogout;

  const AdminHeaderWidget({
    super.key,
    required this.userName,
    required this.userRole,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AdminHomeDecorations.blueHeader,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: AdminHomePadding.headerPadding(context),
          child: Row(
            children: [
              CircleAvatar(
                radius: context.w(mobile: 26),
                backgroundColor: AdminHomeColors.white.withOpacity(0.3),
                child: CircleAvatar(
                  radius: context.w(mobile: 24),
                  backgroundColor: AdminHomeColors.white.withOpacity(0.15),
                  child: Icon(
                    AdminHomeIcons.person,
                    color: AdminHomeColors.white,
                    size: context.w(mobile: 30),
                  ),
                ),
              ),
              SizedBox(width: AdminHomePadding.betweenAvatarAndText(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AdminHomeTextStyles.userName(context),
                    ),
                    Text(
                      userRole,
                      style: AdminHomeTextStyles.userRole(context),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onLogout,
                child: Container(
                  width: context.w(mobile: 44),
                  height: context.w(mobile: 44),
                  decoration: AdminHomeDecorations.logoutButtonDecoration(
                    context,
                  ),
                  child: Icon(
                    AdminHomeIcons.logout,
                    color: AdminHomeColors.white,
                    size: context.w(mobile: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
