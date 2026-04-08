import 'package:bloc/bloc.dart';
import 'package:hrms_roster/presentation/bloc/auth_event.dart';
import 'package:hrms_roster/presentation/bloc/auth_state.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/check_auth_usecase.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.checkAuthUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    
    add(CheckAuthStatus());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final result = await checkAuthUseCase.execute();
    
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await loginUseCase.execute(
      username: event.username,
      password: event.password,
      rememberMe: event.rememberMe,
    );
    
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user: user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await logoutUseCase.execute();
    emit(Unauthenticated());
  }
}