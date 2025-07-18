import 'package:flutter/material.dart';
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

  Future<void> changePassword(String currentPassword, String newPassword) async {
    final user = client.auth.currentUser;

    if (user == null || user.email == null) {
      throw Exception("No authenticated user.");
    }

    try {
      // Re-authenticate
      await client.auth.signInWithPassword(
        email: user.email!,
        password: currentPassword,
      );

      // If sign-in succeeds, update the password
      final updateResult = await client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (updateResult.user == null) {
        throw Exception("Password update failed.");
      }

      debugPrint("✅ Password updated successfully");
    } on AuthException catch (e) {
      throw Exception("Incorrect current password: ${e.message}");
    } catch (e) {
      throw Exception("Failed to update password: $e");
    }
  }





}