import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  final SupabaseClient client;

  AuthDataSource(this.client);

  Future<AuthResponse> signIn(String email, String password) async {
    return client.auth.signInWithPassword(password: password, email: email);
  }

  Future<void> signOut() async => client.auth.signOut();

  Future<AuthResponse> signUp(
    String name,
    String email,
    String password,
  ) async {
    return client.auth.signUp(
      password: password,
      email: email,
      data: {'name': name},
    );
  }

  Session? get session => client.auth.currentSession;
  User? get user => client.auth.currentUser;
}
