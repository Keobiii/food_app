import 'package:food_app/core/models/UserModel.dart';
import 'package:food_app/features/auth/data/datasources/AuthRemoteDatasource.dart';
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
  Future<UserModel> register(String email, String password) async{
    final response = await supabase.auth.signUp(
      email: email,
      password: password
    );

    final user = response.user;
    if (user == null) throw Exception("Signup failed");
    return UserModel.fromSupabase(user);
  }

  @override
  Future<void> logout() async {
    final response = await supabase.auth.signOut();
  }
  
}