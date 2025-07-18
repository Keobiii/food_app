import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';

class AuthRepositoryImpl implements Authrepository {
  final AuthRemoteDataSource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthRepositoryImpl({required this.remoteDatasource, required this.localDatasource});

  @override
  Future<UserEntity> login(String email, String password) async{
    final user = await remoteDatasource.login(email, password);
    await localDatasource.cachedUserId(user.id);
    return user;
  }

  @override
  Future<UserEntity> register(UserEntity user, String password) {
    return remoteDatasource.register(user, password);
  }

  @override
  Future<void> logout() async{
    await remoteDatasource.logout();
    await localDatasource.clearUserId();
  }
}