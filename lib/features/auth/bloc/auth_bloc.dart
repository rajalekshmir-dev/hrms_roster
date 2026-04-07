
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hrms_roster/core/network/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();
  
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    
    // Check auth status on initialization
    add(CheckAuthStatus());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final tokenType = prefs.getString('token_type') ?? 'Bearer';
    final username = prefs.getString('username');
    final rememberMe = prefs.getBool('remember_me') ?? false;
    
    if (token != null && username != null && token.isNotEmpty) {
      // Restore token in service
      AuthService.setAuthToken(token);
      
      emit(Authenticated(
        username: username,
        rememberMe: rememberMe,
        token: token,
        tokenType: tokenType,
      ));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
     
      final result = await _authService.login(
        username: event.username,
        password: event.password,
      );
      
      final token = result['token'] as String;
      final tokenType = result['tokenType'] as String;
      
      // Save login state if rememberMe is true
      if (event.rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('token_type', tokenType);
        await prefs.setString('username', event.username);
        await prefs.setBool('remember_me', event.rememberMe);
      }
      
      emit(Authenticated(
        username: event.username,
        rememberMe: event.rememberMe,
        token: token,
        tokenType: tokenType,
      ));
    } catch (error) {
      String errorMessage = error.toString().replaceFirst('Exception: ', '');
      emit(AuthError(errorMessage));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
   
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('token_type');
    await prefs.remove('username');
    await prefs.remove('remember_me');
  
    AuthService.clearAuthToken();
    
    emit(Unauthenticated());
  }
}