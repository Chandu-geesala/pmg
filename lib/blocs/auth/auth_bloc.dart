import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
  }

  void _onSignInRequested(AuthSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError('Sign in failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onForgotPasswordRequested(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.sendPasswordResetEmail(event.email);
      emit(AuthPasswordResetSent('Password reset link sent to ${event.email}. Please check your email (including spam folder).'));
    } catch (e) {
      emit(AuthError('Failed to send reset email: ${e.toString()}'));
    }
  }

  void _onSignOutRequested(AuthSignOutRequested event, Emitter<AuthState> emit) async {
    await _authService.signOut();
    emit(AuthUnauthenticated());
  }
}
