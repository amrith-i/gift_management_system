// lib/screens/auth/user_id_page.dart
import 'package:flutter/material.dart';
import 'package:daily_finance_manager/core_import.dart';

@RoutePage()
class UserIdPage extends StatefulWidget {
  const UserIdPage({super.key});

  @override
  State<UserIdPage> createState() => _UserIdPageState();
}

class _UserIdPageState extends State<UserIdPage> {
  final TextEditingController _userIdController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
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
                        // Blue Top Section - Takes 50% and centers content
                        SizedBox(
                          height: constraints.maxHeight * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Row: Logo on left, texts column on right
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppIconWidget(
                                    asset: AuthIcons.appLogo,
                                    size: context.sp(mobile: 70),
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: AuthPadding.medium(context)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'DailyColl',
                                        style: AuthTextStyles.appTitle(context),
                                      ),
                                      SizedBox(
                                        height: AuthPadding.small(context),
                                      ),
                                      Text(
                                        'Expense Tracker',
                                        style: AuthTextStyles.subtitle(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // White Container - Takes remaining space
                        Expanded(
                          child: Container(
                            decoration: AuthDecorations.whiteTopRounded,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: AuthPadding.large(context),
                                right: AuthPadding.large(context),
                                top: AuthPadding.xLarge(context),
                                bottom: AuthPadding.xxLarge(context),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Enter Your User ID',
                                    textAlign: TextAlign.center,
                                    style: AuthTextStyles.heading2(context),
                                  ),
                                  SizedBox(height: AuthPadding.xLarge(context)),
                                  AppFormField(
                                    controller: _userIdController,
                                    hint: 'User ID',
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    prefixIcon: Container(
                                      margin:
                                          AuthPadding.inputPrefixIconBoxPadding(
                                            context,
                                          ),
                                      padding:
                                          AuthPadding.inputPrefixIconPadding(
                                            context,
                                          ),
                                      decoration:
                                          AuthDecorations.inputPrefixIcon(
                                            context,
                                          ),
                                      child: AppIconWidget(
                                        asset: AuthIcons.authInputPrefixIcon,
                                        color: AuthColors.primaryBlue,
                                        size: context.w(mobile: 22),
                                      ),
                                    ),
                                    onChanged: (_) => setState(() {}),
                                    onFieldSubmitted: (_) {
                                      if (_userIdController.text
                                          .trim()
                                          .isNotEmpty) {
                                        _handleStart(context);
                                      }
                                    },
                                  ),
                                  SizedBox(height: AuthPadding.medium(context)),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: context.w(mobile: 22),
                                        height: context.h(mobile: 22),
                                        child: Checkbox(
                                          value: _rememberMe,
                                          onChanged: (v) => setState(
                                            () => _rememberMe = v ?? false,
                                          ),
                                          shape: AuthDecorations.checkboxShape,
                                          side: AuthDecorations.checkboxBorder,
                                          activeColor: AuthColors.primaryBlue,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ),
                                      SizedBox(
                                        width: AuthPadding.small(context),
                                      ),
                                      Text(
                                        'Remember me',
                                        style: AuthTextStyles.rememberMeText(
                                          context,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AuthPadding.xxLarge(context),
                                  ),
                                  SizedBox(
                                    height: context.h(mobile: 54),
                                    child: ElevatedButton(
                                      onPressed:
                                          _userIdController.text.trim().isEmpty
                                          ? null
                                          : () => _handleStart(context),
                                      style:
                                          AuthDecorations.elevatedButtonStyle,
                                      child: Text(
                                        'Start',
                                        style: AuthTextStyles.button(context),
                                      ),
                                    ),
                                  ),
                                  // Extra space to lift button above keyboard
                                  SizedBox(
                                    height: MediaQuery.of(
                                      context,
                                    ).viewInsets.bottom,
                                  ),
                                ],
                              ),
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

  void _handleStart(BuildContext context) {
    FocusScope.of(context).unfocus();
    final userId = _userIdController.text.trim();
    context.router.push(PasswordRoute(userId: userId));
  }
}
