import 'package:flutter/material.dart';
import 'package:testapaskan/api_service.dart';
import 'package:testapaskan/pages/login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _fullnameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: const [
                  Icon(Icons.wifi, size: 50, color: Colors.orange),
                  SizedBox(height: 10),
                  Text(
                    'Daftar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Daftar disini dan dapatkan informasi detail dari proses laundry milik anda.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mudah dan bisa booking laundry dari rumah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fullnameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Saya setuju dengan syarat dan ketentuan'),
              value: true,
              onChanged: (newValue) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text.isEmpty ||
                    _fullnameController.text.isEmpty ||
                    _emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Silakan isi semua field')),
                  );
                  return;
                }

                // Mengemas data ke dalam list
                List<Map<String, dynamic>> userData = [
                  {
                    'user_nama': _usernameController.text,
                    'user_namalengkap': _fullnameController.text,
                    'user_email': _emailController.text,
                    'user_password': _passwordController.text,
                  }
                ];

                print('Data yang akan dikirim: $userData'); // Debug data

                try {
                  await ApiService().createUser(userData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registrasi berhasil')), // Pesan ini hanya ditampilkan jika tidak ada error
                  );

                  // Pindah ke halaman login setelah sukses
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } catch (e) {
                  // Tampilkan error message jika terjadi kesalahan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registrasi gagal: $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
