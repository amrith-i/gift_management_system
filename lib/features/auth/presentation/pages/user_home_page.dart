import 'package:daily_finance_manager/core_import.dart';

@RoutePage()
class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  // Mock Daily P&L Data
  final double todayProfit = 12450.75;
  final double todayExpense = 8750.50;
  final double netToday = 3700.25;

  final double monthlyProfit = 245680.00;
  final double monthlyExpense = 189450.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(context.w(mobile: 20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      radius: context.w(mobile: 24),
                      backgroundColor: AppColors.primaryBlue,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: context.w(mobile: 28),
                      ),
                    ),
                    SizedBox(width: context.w(mobile: 12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back",
                          style: AppTextStyles.heading2(context),
                        ),
                        Text(
                          "Guru Santhosh", // You can make this dynamic later
                          style: AppTextStyles.heading2(context),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: context.w(mobile: 28),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.h(mobile: 30)),

                // Today's P&L Card
                Container(
                  padding: EdgeInsets.all(context.w(mobile: 24)),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryBlueGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Profit & Loss",
                        style: TextStyle(
                          fontSize: context.sp(mobile: 18),
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: context.h(mobile: 12)),
                      Text(
                        "₹ ${netToday.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: context.sp(mobile: 42),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        netToday >= 0 ? "Net Profit" : "Net Loss",
                        style: TextStyle(
                          fontSize: context.sp(mobile: 16),
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: context.h(mobile: 20)),

                      // Income & Expense Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildTodayStat(
                              context,
                              "Income",
                              "₹ ${todayProfit.toStringAsFixed(0)}",
                              Icons.trending_up_rounded,
                              Colors.white,
                            ),
                          ),
                          SizedBox(width: context.w(mobile: 16)),
                          Expanded(
                            child: _buildTodayStat(
                              context,
                              "Expense",
                              "₹ ${todayExpense.toStringAsFixed(0)}",
                              Icons.trending_down_rounded,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: context.h(mobile: 28)),

                // Monthly Overview
                Text(
                  "This Month Overview",
                  style: AppTextStyles.heading2(context),
                ),

                SizedBox(height: context.h(mobile: 16)),

                Row(
                  children: [
                    Expanded(
                      child: _buildMonthlyCard(
                        context,
                        "Total Profit",
                        "₹ ${monthlyProfit.toStringAsFixed(0)}",
                        AppColors.primaryBlue,
                        Icons.arrow_upward_rounded,
                      ),
                    ),
                    SizedBox(width: context.w(mobile: 16)),
                    Expanded(
                      child: _buildMonthlyCard(
                        context,
                        "Total Expense",
                        "₹ ${monthlyExpense.toStringAsFixed(0)}",
                        AppColors.primaryRed,
                        Icons.arrow_downward_rounded,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.h(mobile: 28)),

                // Quick Actions
                Text("Quick Actions", style: AppTextStyles.heading2(context)),

                SizedBox(height: context.h(mobile: 16)),

                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        "Add Income",
                        Icons.add_circle_outline,
                        AppColors.primaryBlue,
                        () {},
                      ),
                    ),
                    SizedBox(width: context.w(mobile: 12)),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        "Add Expense",
                        Icons.remove_circle_outline,
                        AppColors.primaryRed,
                        () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.h(mobile: 40)),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_rounded),
            label: "Add Entry",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStat(
    BuildContext context,
    String label,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: context.w(mobile: 28)),
        SizedBox(height: context.h(mobile: 8)),
        Text(
          amount,
          style: TextStyle(
            fontSize: context.sp(mobile: 20),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.sp(mobile: 14),
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyCard(
    BuildContext context,
    String title,
    String amount,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(context.w(mobile: 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: context.w(mobile: 28)),
          SizedBox(height: context.h(mobile: 12)),
          Text(
            amount,
            style: TextStyle(
              fontSize: context.sp(mobile: 22),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(title, style: AppTextStyles.inputText(context)),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: context.h(mobile: 18)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: context.w(mobile: 32)),
            SizedBox(height: context.h(mobile: 8)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.sp(mobile: 15),
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
