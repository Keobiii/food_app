import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/auth/domain/repositories/AuthRepository.dart';

class AuthRepositoryImpl implements Authrepository {
  final AuthRemoteDataSource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<Userentity> login(String email, String password) {
    return remoteDatasource.login(email, password);
  }

  @override
  Future<Userentity> register(String email, String password) {
    return remoteDatasource.register(email, password);
  }
}