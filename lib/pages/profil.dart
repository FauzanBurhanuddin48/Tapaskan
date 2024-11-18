import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testapaskan/api_service.dart';
import 'package:testapaskan/pages/gantipassword.dart';
import 'package:testapaskan/pages/editprofil.dart'; 

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: () async {
          //Ambil UUID pengguna dari storage
          String? userUuid = await storage.read(key: 'user_uuid');
          print('User UUID: $userUuid'); // Debugging user UUID
          
          if (userUuid == null || userUuid.isEmpty) {
            throw Exception("User UUID tidak ditemukan. Silakan login ulang.");
          }
          
          return ApiService().getUserDetail(userUuid);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          // Ambil data pengguna
          final userDetail = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/op.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  userDetail['user_namalengkap'] ?? 'Nama tidak tersedia',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Email: ${userDetail['user_email'] ?? 'Email tidak tersedia'}'),
                const SizedBox(height: 5),
                Text('Tempat Lahir: ${userDetail['user_tempatlahir'] ?? 'Tidak Diketahui'}'),
                const SizedBox(height: 5),
                Text('Tanggal Lahir: ${userDetail['user_tanggallahir'] ?? 'Tidak Diketahui'}'),
                const SizedBox(height: 5),
                Text('Alamat: ${userDetail['user_alamat'] ?? 'Tidak Diketahui'}'),
                const SizedBox(height: 5),
                Text('No HP: ${userDetail['user_nohp'] ?? 'Tidak Diketahui'}'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilPage(userUuid: snapshot.data!['user_uuid']),  //Pass user UUID
                          ),
                        );
                      },
                      child: const Text('Edit'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GantiPasswordPage()),
                        );
                      },
                      child: const Text('Ganti Password'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Hapus token dan UUID dari secure storage untuk logout
                    // await storage.deleteAll();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const MyApp()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
