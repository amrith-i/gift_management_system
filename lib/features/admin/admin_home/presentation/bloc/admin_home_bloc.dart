import 'package:daily_finance_manager/core_import.dart';

@injectable
class AdminHomeBloc extends Bloc<AdminHomeEvent, AdminHomeState> {
  AdminHomeBloc() : super(AdminHomeInitial()) {
    // TODO: register event handlers
  }
}
