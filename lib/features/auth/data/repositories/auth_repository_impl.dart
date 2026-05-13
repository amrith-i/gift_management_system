import 'package:daily_finance_manager/core_import.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDatasource remote;

  AuthRepositoryImpl(super.dio, this.remote);
}
