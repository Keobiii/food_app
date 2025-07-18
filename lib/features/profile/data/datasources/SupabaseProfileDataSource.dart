import 'package:food_app/core/models/UserModel.dart';
import 'package:food_app/features/profile/data/datasources/ProfileRemoteDatasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileDataSource implements ProfileRemoteDataSource {
  final SupabaseClient client;

  SupabaseProfileDataSource(this.client);
  
  @override
  Future<UserModel> getUserById(String uid) async{
    final response = await client
        .from('users')
        .select()
        .eq('id', uid)
        .single(); 

    if (response == null) throw Exception("User not found");

    return UserModel.fromJson(response);
  }

  Future<void> updateProfile(String uid, String firstName, String lastName) async {
    if (uid == null) throw Exception("User not logged in");

    try {
      await client
          .from('users')
          .update({
            'first_name': firstName,
            'last_name': lastName,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', uid);
    } catch (e) {
      throw Exception("Failed to update user: $e");
    }
  }



}