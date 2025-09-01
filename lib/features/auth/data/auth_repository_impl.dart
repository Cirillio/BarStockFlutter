import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import './auth_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/core/utils/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource ds;
  AuthRepositoryImpl(this.ds);

  @override
  bool get isSignIn => ds.session != null;

  @override
  Future<Result<void>> signIn(String email, String password) async {
    try {
      final res = await ds.signIn(email, password);
      final user = res.user ?? ds.user;
      if (user == null) return const Failure('Нет данных пользователя');
      return Success(null);
    } on AuthException catch (e) {
      return Failure(
        e.statusCode == '400' ? 'Указаны некорректные данные' : e.message,
      );
    } catch (_) {
      return const Failure('Неизвестная ошибка при входе');
    }
  }

  @override
  Future<Result<void>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await ds.signUp(name, email, password);
      if (res.user == null) return const Failure('Нет данных пользователя');
      return Success(null);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (_) {
      return const Failure('Неизвестная ошибка при регистрации');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await ds.signOut();
      return const Success(null);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (_) {
      return const Failure('Неизвестная ошибка при выходе');
    }
  }
}
