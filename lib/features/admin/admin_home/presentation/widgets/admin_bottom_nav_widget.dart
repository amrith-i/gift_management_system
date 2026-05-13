import 'package:daily_finance_manager/core_import.dart';

class AdminBottomNavWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const AdminBottomNavWidget({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: AdminHomeColors.white,
      shadowColor: AdminHomeColors.textPrimary,
      elevation: 8,
      child: SizedBox(
        height: AdminHomePadding.bottomNavHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 0, AdminHomeIcons.home, 'Home'),
            SizedBox(width: AdminHomePadding.fabSpace(context)),
            _buildNavItem(context, 1, AdminHomeIcons.users, 'Users'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
  ) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? AdminHomeColors.primaryBlue
                : AdminHomeColors.textLight,
            size: context.w(mobile: 26),
          ),
          SizedBox(height: AdminHomePadding.betweenRowsInNumpad(context)),
          Text(label, style: AdminHomeTextStyles.navLabel(context, isSelected)),
        ],
      ),
    );
  }
}
