import 'package:bar_stock/core/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDataSource {
  final SupabaseClient client;
  ProfileDataSource(this.client);

  static const String currentAuthReq =
      "user_id, username, email, full_name, avatar_url, role, invited_at";

  Session? getCurrentSession() {
    try {
      final Session? session = client.auth.currentSession;
      if (session != null) {
        log.i('ProfileDataSource | Current session: $session');
      } else {
        log.i('ProfileDataSource | No current session');
      }
      return session;
    } catch (e) {
      log.e('ProfileDataSource | Error getting current session: $e');
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final Session? session = getCurrentSession();

      if (session != null) {
        final user = session.user;
        log.i('ProfileDataSource | Current user: $user');
        return user;
      }

      return null;
    } catch (e) {
      log.e('ProfileDataSource | Error getting current user: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCurrentAuthEmployer() async {
    try {
      final User? user = await getCurrentUser();

      if (user != null) {
        final authEmployer = await client
            .from('employees')
            .select(currentAuthReq)
            .eq('user_id', user.id)
            .single();

        log.i('ProfileDataSource | Current auth employer: $authEmployer');
        return authEmployer;
      }

      return null;
    } catch (e) {
      log.e('ProfileDataSource | Error getting current auth employer: $e');
      return null;
    }
  }
}
