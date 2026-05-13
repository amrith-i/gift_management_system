import 'package:daily_finance_manager/core_import.dart';

@LazySingleton(as: AdminHomeRemoteDatasource)
class AdminHomeRemoteDatasourceImpl implements AdminHomeRemoteDatasource {
  final Dio dio;

  AdminHomeRemoteDatasourceImpl(this.dio);
}
