import 'package:daily_finance_manager/core_import.dart';

@RoutePage()
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _navIndex = 0;

  final List<AppUser> recentUsers = [
    AppUser(
      userId: 'arjun',
      name: 'Arjun Sharma',
      phone: '+91 123456789',
      role: UserRole.user,
      expiryDate: DateTime(2025, 1, 15),
    ),
    AppUser(
      userId: 'rahul',
      name: 'Rahul Varma',
      phone: '+91 123456789',
      role: UserRole.user,
      expiryDate: DateTime(2025, 1, 10),
    ),
    AppUser(
      userId: 'rahul',
      name: 'Rahul Varma',
      phone: '+91 123456789',
      role: UserRole.user,
      expiryDate: DateTime(2026, 6, 10),
    ),
  ];

  final int totalUsers = 255;
  final int activeUsers = 200;
  final int expiredUsers = 55;

  void _handleLogout() {
    context.router.replace(const UserIdRoute());
  }

  void _handleViewAll() {
    setState(() {
      _navIndex = 1;
    });
  }

  void _handleAddUser() {
    // Add user functionality here
  }

  void _handleTabSelected(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminHomeColors.background,
      body: Container(
        decoration:
            AdminHomeDecorations.adminHomePrimaryBlueGradientHeaderBottom,
        child: Column(
          children: [
            AdminHeaderWidget(
              userName: 'Guru Santhosh',
              userRole: 'Admin User',
              onLogout: _handleLogout,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AdminHomeColors.background,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                clipBehavior: Clip.hardEdge,
                child: SingleChildScrollView(
                  padding: AdminHomePadding.scrollViewBodyPadding(context),
                  child: _navIndex == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TotalUsersCardWidget(
                              totalUsers: totalUsers,
                              activeUsers: activeUsers,
                              expiredUsers: expiredUsers,
                            ),
                            SizedBox(
                              height: AdminHomePadding.betweenSections(context),
                            ),
                            RecentUsersWidget(
                              users: recentUsers,
                              onViewAll: _handleViewAll,
                            ),
                          ],
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              'Users Page - Coming Soon',
                              style: AdminHomeTextStyles.sectionTitle(context),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddUser,
        backgroundColor: AdminHomeColors.primaryBlue,
        elevation: 4,
        shape: const CircleBorder(),
        child: Icon(
          AdminHomeIcons.add,
          color: AdminHomeColors.white,
          size: context.w(mobile: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AdminBottomNavWidget(
        currentIndex: _navIndex,
        onTabSelected: _handleTabSelected,
      ),
    );
  }
}
