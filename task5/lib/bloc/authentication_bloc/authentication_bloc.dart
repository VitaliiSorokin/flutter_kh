import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dating_app/bloc/authentication_bloc/bloc.dart';
import 'package:dating_app/repository/user_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;
  final UserRepository _userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    } else if (event is SignUpWithCredentialsPressed) {
      yield* _mapSignUpWithCredentialsPressedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _userRepository.getFBUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getFBUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _userRepository.signOut();
    yield Unauthenticated();
  }

  Stream<AuthenticationState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield Authenticating();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield Authenticated(await _userRepository.getFBUser());
    } catch (err) {
      if (err.code == 'ERROR_USER_NOT_FOUND') {
        await _userRepository.signUp(email, password);
        yield Authenticated(await _userRepository.getFBUser());
      } else {
        yield Unauthenticated();
      }
    }
  }

  Stream<AuthenticationState> _mapSignUpWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield Authenticating();
    try {
      await _userRepository.signUp(email, password);
      yield Authenticated(await _userRepository.getFBUser());
    } catch (_) {
      yield Unauthenticated();
    }
  }
}
