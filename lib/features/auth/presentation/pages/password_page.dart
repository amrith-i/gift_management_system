// lib/screens/auth/password_page.dart
import 'package:flutter/material.dart';
import 'package:daily_finance_manager/core_import.dart';

@RoutePage()
class PasswordPage extends StatefulWidget {
  final String userId;

  const PasswordPage({super.key, required this.userId});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final List<String> _pin = List.filled(4, '');
  int _currentIndex = 0;

  void _onNumberPressed(String number) {
    if (_currentIndex < 4) {
      setState(() {
        _pin[_currentIndex] = number;
        _currentIndex++;
      });
      if (_currentIndex == 4) {
        _verifyPassword();
      }
    }
  }

  void _onBackspace() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = '';
      });
    }
  }

  Future<void> _verifyPassword() async {
    final password = _pin.join();
    final user = await AuthService.login(widget.userId, password);

    if (!mounted) return;

    if (user != null) {
      if (user.role == UserRole.admin) {
        context.router.replace(const AdminHomeRoute());
      } else {
        context.router.replace(const UserHomeRoute());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Password'),
          backgroundColor: AuthColors.errorAccent,
        ),
      );
      setState(() {
        _pin.fillRange(0, 4, '');
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AuthDecorations.primaryGradient,
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Blue Top Section - Takes 30%
                        SizedBox(
                          height: constraints.maxHeight * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo
                              AppIconWidget(
                                asset: AuthIcons.appLogo,
                                size: context.sp(mobile: 70),
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: context.h(mobile: 30)),
                              // Welcome Back text
                              Text(
                                'Welcome Back',
                                style: AuthTextStyles.welcomeTitle(context),
                              ),
                              SizedBox(height: context.h(mobile: 10)),
                              // User ID
                              Text(
                                widget.userId,
                                style: AuthTextStyles.userIdText(context),
                              ),
                            ],
                          ),
                        ),

                        // White Container - Takes remaining space
                        Expanded(
                          child: Container(
                            decoration: AuthDecorations.whiteTopRounded,
                            padding:
                                AuthPadding.passwordWhiteContainerInPadding(
                                  context,
                                ),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Enter Your Password',
                                  textAlign: TextAlign.center,
                                  style: AuthTextStyles.heading2(context),
                                ),
                                SizedBox(height: context.h(mobile: 30)),

                                // PIN underline dots
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(4, (i) {
                                    final isFilled = i < _currentIndex;
                                    final isActive = i == _currentIndex;
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: context.w(mobile: 7),
                                      ),
                                      width: context.w(mobile: 40),
                                      child: Column(
                                        children: [
                                          // Show asterisk when filled
                                          SizedBox(
                                            height: context.h(mobile: 32),
                                            child: Center(
                                              child: isFilled
                                                  ? Text(
                                                      '*',
                                                      style:
                                                          AuthTextStyles.pinAsterisk(
                                                            context,
                                                          ),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: context.h(mobile: 4),
                                          ),
                                          // Underline
                                          AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 150,
                                            ),
                                            height: 2.5,
                                            decoration: BoxDecoration(
                                              color: (isFilled || isActive)
                                                  ? AuthColors.primaryBlue
                                                  : AuthColors.border,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),

                                SizedBox(height: context.h(mobile: 35)),

                                // Number pad with symmetric spacing
                                _buildNumpad(context),

                                // Extra space to lift content above keyboard
                                SizedBox(
                                  height: MediaQuery.of(
                                    context,
                                  ).viewInsets.bottom,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNumpad(BuildContext context) {
    const rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', '⌫'],
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rows.map((row) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.h(mobile: 8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              if (key.isEmpty) {
                // Replace empty SizedBox with an invisible placeholder that maintains layout
                return Opacity(
                  opacity: 0.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(mobile: 8),
                    ),
                    child: _NumKey(
                      label: '',
                      isBackspace: false,
                      onTap: () {},
                      width: context.w(mobile: 90),
                      height: context.h(mobile: 64),
                      fontSize: context.sp(mobile: 24),
                    ),
                  ),
                );
              }

              final isBack = key == '⌫';

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(mobile: 8)),
                child: _NumKey(
                  label: key,
                  isBackspace: isBack,
                  onTap: isBack ? _onBackspace : () => _onNumberPressed(key),
                  width: context.w(mobile: 90),
                  height: context.h(mobile: 64),
                  fontSize: context.sp(mobile: isBack ? 20 : 24),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _NumKey extends StatefulWidget {
  final String label;
  final bool isBackspace;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double fontSize;

  const _NumKey({
    required this.label,
    required this.isBackspace,
    required this.onTap,
    required this.width,
    required this.height,
    required this.fontSize,
  });

  @override
  State<_NumKey> createState() => _NumKeyState();
}

class _NumKeyState extends State<_NumKey> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _pressed
              ? AuthColors.pinKeyPressed
              : AuthColors.pinKeyBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuthColors.border, width: 1),
        ),
        alignment: Alignment.center,
        child: widget.isBackspace
            ? Icon(
                Icons.backspace_outlined,
                size: widget.fontSize,
                color: AuthColors.textPrimary,
              )
            : Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w500,
                  color: AuthColors.textPrimary,
                ),
              ),
      ),
    );
  }
}
