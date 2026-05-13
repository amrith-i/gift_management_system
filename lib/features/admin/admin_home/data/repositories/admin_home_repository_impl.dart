import 'package:daily_finance_manager/core_import.dart';

@LazySingleton(as: AdminHomeRepository)
class AdminHomeRepositoryImpl extends BaseRepository
    implements AdminHomeRepository {
  final AdminHomeRemoteDatasource remote;

  AdminHomeRepositoryImpl(super.dio, this.remote);
}
