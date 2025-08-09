import 'package:bar_stock/features/auth/domain/entities/user_entity.dart';
import 'package:bar_stock/features/auth/domain/repos/auth_repository.dart';
import './auth_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bar_stock/features/auth/domain/result.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource ds;
  AuthRepositoryImpl(this.ds);

  @override
  Future<Result<UserEntity>> signIn(String email, String password) async {
    try {
      final res = await ds.signIn(email, password);
      final user = res.user ?? ds.user;
      if (user == null) return const Failure('Нет данных пользователя');

      final entity = UserEntity(
        id: user.id,
        email: user.email ?? '',
        name: user.userMetadata?['name'] as String?,
      );
      return Success(entity);
    } on AuthException catch (e) {
      return Failure(e.message);
    } catch (_) {
      return const Failure('Неизвестная ошибка при входе');
    }
  }

  @override
  Future<Result<UserEntity>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await ds.signUp(name, email, password);
      if (res.user == null) return const Failure('Нет данных пользователя');

      final entity = UserEntity(
        id: res.user?.id ?? '',
        email: res.user?.email ?? '',
        name: name,
      );
      return Success(entity);
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

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    final u = ds.user;
    if (u == null) return const Success<UserEntity?>(null);
    return Success(
      UserEntity(id: u.id, email: u.email ?? '', name: u.userMetadata?['name']),
    );
  }
}
