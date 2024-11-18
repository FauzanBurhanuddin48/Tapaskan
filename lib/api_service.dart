import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String _baseUrl = 'http://10.0.2.2:9900/api/v1'; // Ganti dengan IP Anda jika perlu
  final storage = FlutterSecureStorage();

  // Method untuk membuat user
  Future<void> createUser(List<Map<String, dynamic>> userData) async {
    final url = Uri.parse('$_baseUrl/user/create');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userData), // Kirim sebagai list
      );

      // Debugging response
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseBody = json.decode(response.body);
        final successMessage = responseBody['data'][0]['msg'] ?? 'User created successfully';
        print('Success Message: $successMessage'); // Mencetak pesan sukses
      } else {
        try {
          final responseBody = json.decode(response.body);
          final errorMessage = responseBody['data'][0]['msg'] ?? 'Tidak ada detail kesalahan';
          print('Error Message: $errorMessage'); // Mencetak pesan kesalahan
          throw Exception(errorMessage); // Menangkap pesan kesalahan
        } catch (e) {
          print('Error parsing response: $e');
          throw Exception('Failed to create user: Error parsing response'); // Menangkap kesalahan parsing
        }
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow untuk mempertahankan stack trace asli
    }
  }

  // Method untuk login
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://10.0.2.2:9900/api/auth/login'); // Update ke URL login yang tepat
    final body = json.encode({
      "user_nama": username,
      "user_password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseBody = json.decode(response.body);

        // Debugging response untuk memeriksa struktur
        print('Response body: ${response.body}');
        print('Decoded response body: $responseBody');

        final token = responseBody['data'][0]['values']['token']; // Ambil token dari 'values'
        final userUuid = responseBody['data'][0]['user_data']['user_uuid']; // Ambil user_uuid dari 'user_data'

        // Simpan token dan user_uuid di FlutterSecureStorage
        await storage.write(key: 'bearer_token', value: token);
        await storage.write(key: 'user_uuid', value: userUuid); // Simpan user_uuid

        print('Login successful, token: $token, user_uuid: $userUuid');
      } else {
        final responseBody = json.decode(response.body);
        final errorMessage = responseBody['message'] ?? 'Failed to login';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow untuk mempertahankan stack trace asli
    }
  }

  // Method untuk mendapatkan detail profil user
  Future<Map<String, dynamic>> getUserDetail(String userUuid) async {
    final url = Uri.parse('$_baseUrl/user/get_detail');
    final token = await storage.read(key: 'bearer_token'); // Ambil token dari storage

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token di header
        },
        body: json.encode({
          'user_uuid': userUuid, // Kirim UUID pengguna
        }),
      );

      print('Response status code: ${response.statusCode}'); // Debugging status code
      print('Response body: ${response.body}'); // Debugging response body

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody['data'][0]; // Kembalikan data pengguna
      } else {
        // Tambahkan pesan error dari server jika ada
        final errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['message'] ?? 'Failed to load user details';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow untuk mempertahankan stack trace asli
    }
  }

  // Method untuk mengupdate profil pengguna
  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    final url = Uri.parse('$_baseUrl/user/update');
    final token = await storage.read(key: 'bearer_token');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Sertakan token di header
        },
        body: json.encode([userData]), // Mengirim data sebagai array JSON
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseBody = json.decode(response.body);
        final successMessage = responseBody['data'][0]['msg'] ?? 'Update berhasil';
        print('Success Message: $successMessage'); // Mencetak pesan sukses
      } else {
        throw Exception('Failed to update profile. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Rethrow untuk mempertahankan stack trace asli
    }
  }
  
  // Method untuk mengganti password pengguna
Future<void> changePassword(String userUuid, String oldPassword, String newPassword) async {
  final url = Uri.parse('$_baseUrl/user/changepassword');
  final token = await storage.read(key: 'bearer_token'); // Ambil token dari storage

  final body = json.encode({
    'user_uuid': userUuid,
    'user_password': oldPassword,
    'user_newpassword': newPassword,
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Sertakan token di header
      },
      body: body,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 202) {
      final responseBody = json.decode(response.body);
      final successMessage = responseBody['data']['msg'] ?? 'Ganti password berhasil';
      print('Success Message: $successMessage');
    } else {
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['message'] ?? 'Failed to change password';
      throw Exception(errorMessage);
    }
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
}
