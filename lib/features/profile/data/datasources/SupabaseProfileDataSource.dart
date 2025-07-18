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


}