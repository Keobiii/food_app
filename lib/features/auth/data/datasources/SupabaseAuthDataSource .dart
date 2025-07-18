import 'package:food_app/core/models/UserModel.dart';
import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
import 'package:food_app/features/auth/domain/entities/UserEntity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthDataSource implements AuthRemoteDataSource {
  final SupabaseClient supabase;

  SupabaseAuthDataSource(this.supabase);

  @override
  Future<UserModel> login(String email, String password) async{
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password
    );

    final user = response.user;
    if (user == null) throw Exception("Login failed");
    return UserModel.fromSupabase(user);
  }

  @override
  Future<UserModel> register(UserEntity userEntity, String password) async {
    final response = await supabase.auth.signUp(
      email: userEntity.email,
      password: password,
      data: {
        'full_name': '${userEntity.firstName} ${userEntity.lastName}',
      },
    );

    final user = response.user;
    if (user == null) throw Exception("Signup failed");

    final uid = user.id;

    // Insert into your custom 'users' table
    await supabase.from('users').insert({
      'id': uid,
      'email': userEntity.email,
      'first_name': userEntity.firstName,
      'last_name': userEntity.lastName,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    return UserModel.fromSupabase(user);
  }

  @override
  Future<void> logout() async {
    final response = await supabase.auth.signOut();
  }
  
}