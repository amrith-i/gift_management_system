import 'package:daily_finance_manager/core_import.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // TODO: register event handlers
  }
}
