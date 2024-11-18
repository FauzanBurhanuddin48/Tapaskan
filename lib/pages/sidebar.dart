import 'package:flutter/material.dart';
import 'package:testapaskan/pages/beranda.dart';
import 'package:testapaskan/pages/datamaster.dart';
import 'package:testapaskan/pages/profil.dart'; 

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Fauzan', style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text('Level Superadmin'),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilPage()),
                );
              },
              child: CircleAvatar(
                child: const Icon(Icons.person, size: 40),
                backgroundColor: Colors.blueAccent.shade100,
              ),
            ),
            decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.lightBlue),
            title: const Text('Dashboard'),
            selectedTileColor: Colors.lightBlue.shade50,
            selected: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BerandaPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.store_mall_directory),
            title: const Text('Usaha'),
            onTap: () {},
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Proses',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Transaksi'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pembayaran'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.data_usage),
            title: const Text('Data Master'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataMasterPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
