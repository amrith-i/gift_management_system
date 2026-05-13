// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AdminHomePage]
class AdminHomeRoute extends PageRouteInfo<void> {
  const AdminHomeRoute({List<PageRouteInfo>? children})
    : super(AdminHomeRoute.name, initialChildren: children);

  static const String name = 'AdminHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminHomePage();
    },
  );
}

/// generated route for
/// [NoInternetPage]
class NoInternetRoute extends PageRouteInfo<void> {
  const NoInternetRoute({List<PageRouteInfo>? children})
    : super(NoInternetRoute.name, initialChildren: children);

  static const String name = 'NoInternetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NoInternetPage();
    },
  );
}

/// generated route for
/// [PasswordPage]
class PasswordRoute extends PageRouteInfo<PasswordRouteArgs> {
  PasswordRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
         PasswordRoute.name,
         args: PasswordRouteArgs(key: key, userId: userId),
         initialChildren: children,
       );

  static const String name = 'PasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordRouteArgs>();
      return PasswordPage(key: args.key, userId: args.userId);
    },
  );
}

class PasswordRouteArgs {
  const PasswordRouteArgs({this.key, required this.userId});

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'PasswordRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PasswordRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}

/// generated route for
/// [UserHomePage]
class UserHomeRoute extends PageRouteInfo<void> {
  const UserHomeRoute({List<PageRouteInfo>? children})
    : super(UserHomeRoute.name, initialChildren: children);

  static const String name = 'UserHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserHomePage();
    },
  );
}

/// generated route for
/// [UserIdPage]
class UserIdRoute extends PageRouteInfo<void> {
  const UserIdRoute({List<PageRouteInfo>? children})
    : super(UserIdRoute.name, initialChildren: children);

  static const String name = 'UserIdRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserIdPage();
    },
  );
}
