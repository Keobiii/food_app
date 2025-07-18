import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:food_app/features/profile/data/datasources/ProfileRemoteDatasource.dart';
import 'package:food_app/features/profile/domain/repositories/ProfileRepository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> getUserById(String uid) async {
    final userModel = await remoteDataSource.getUserById(uid);
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
    );
  }
  
  @override
  Future<void> updateProfile(String userId, String firstName, String lastName) {
    return remoteDataSource.updateProfile(userId, firstName, lastName);
  }
  
  @override
  Future<void> changePassword(String oldPassword, String newPassword) {
    return remoteDataSource.changePassword(oldPassword, newPassword);
  }
}