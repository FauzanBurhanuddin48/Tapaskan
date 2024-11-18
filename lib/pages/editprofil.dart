import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:testapaskan/api_service.dart';
import 'package:testapaskan/pages/profil.dart';

class EditProfilPage extends StatefulWidget {
  final String userUuid;  //UUID Pengguna untuk mendapatkan detail

  const EditProfilPage({required this.userUuid, Key? key}) : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  late TextEditingController _userNamaLengkapController;
  late TextEditingController _userEmailController;
  late TextEditingController _userNoHpController;
  late TextEditingController _userAlamatController;
  late TextEditingController _userTempatLahirController;
  late TextEditingController _userTanggalLahirController;
  
  bool _isLoading = false;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();

    _userNamaLengkapController = TextEditingController();
    _userEmailController = TextEditingController();
    _userNoHpController = TextEditingController();
    _userAlamatController = TextEditingController();
    _userTempatLahirController = TextEditingController();
    _userTanggalLahirController = TextEditingController();

    _getUserData();
  }

  Future<void> _getUserData() async {
    try {
      final userDetail = await ApiService().getUserDetail(widget.userUuid);
      setState(() {
        _userNamaLengkapController.text = userDetail['user_namalengkap'] ?? '';
        _userEmailController.text = userDetail['user_email'] ?? '';
        _userNoHpController.text = userDetail['user_nohp'] ?? '';
        _userAlamatController.text = userDetail['user_alamat'] ?? '';
        _userTempatLahirController.text = userDetail['user_tempatlahir'] ?? '';
        _userTanggalLahirController.text = userDetail['user_tanggallahir'] ?? '';
      });
    } catch (e) {
      print('Error getting user details: $e');
    }
  }

  Future<void> _updateProfil() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final data = {
          'user_uuid': widget.userUuid,
          'user_namalengkap': _userNamaLengkapController.text,
          'user_email': _userEmailController.text,
          'user_nohp': _userNoHpController.text,
          'user_alamat': _userAlamatController.text,
          'user_tempatlahir': _userTempatLahirController.text,
          'user_tanggallahir': _userTanggalLahirController.text,
        };

        await ApiService().updateUserProfile(data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui')),
        );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilPage()),
          );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal memperbarui profil')),
            );
          } finally {
            setState(() {
              _isLoading = false;
            });
          }
        }
      }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _userTanggalLahirController.text.isNotEmpty
          ? _dateFormat.parse(_userTanggalLahirController.text)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _userTanggalLahirController.text = _dateFormat.format(picked);
      });
    }
  }

  @override
  void dispose() {
    _userNamaLengkapController.dispose();
    _userEmailController.dispose();
    _userNoHpController.dispose();
    _userAlamatController.dispose();
    _userTempatLahirController.dispose();
    _userTanggalLahirController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.teal, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildTextField(
                      controller: _userNamaLengkapController,
                      label: 'Nama Lengkap',
                      validator: 'Nama lengkap tidak boleh kosong',
                    ),
                    _buildTextField(
                      controller: _userEmailController,
                      label: 'Email',
                      validator: 'Email tidak boleh kosong',
                    ),
                    _buildTextField(
                      controller: _userNoHpController,
                      label: 'Nomor HP',
                      validator: 'Nomor HP tidak boleh kosong',
                    ),
                    _buildTextField(
                      controller: _userAlamatController,
                      label: 'Alamat',
                      validator: 'Alamat tidak boleh kosong',
                    ),
                    _buildTextField(
                      controller: _userTempatLahirController,
                      label: 'Tempat Lahir',
                      validator: 'Tempat lahir tidak boleh kosong',
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _userTanggalLahirController,
                          decoration: const InputDecoration(
                            labelText: 'Tanggal Lahir',
                            hintText: 'Pilih Tanggal Lahir',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal lahir tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _updateProfil,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Update Profil'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal, // Tombol warna teal
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  //Widget text field dengan label dan validasi
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validator;
          }
          return null;
        },
      ),
    );
  }
}
