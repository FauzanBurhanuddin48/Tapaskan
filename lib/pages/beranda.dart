// import 'package:flutter/material.dart';
// import 'package:testapaskan/pages/profil.dart';

// class BerandaPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               // Navigasi halaman profil
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ProfilPage()),
//               );
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Section for Transaction Stats
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildStatsCard(
//                   title: '5',
//                   subTitle: 'Jumlah Transaksi Paket Yang Belum Selesai',
//                   color: Colors.orange,
//                   icon: Icons.refresh,
//                 ),
//                 _buildStatsCard(
//                   title: '10',
//                   subTitle: 'Jumlah Transaksi Yang Sudah Selesai',
//                   color: Colors.blue,
//                   icon: Icons.check,
//                 ),
//                 _buildStatsCard(
//                   title: '15',
//                   subTitle: 'Jumlah Histori Semua Transaksi',
//                   color: Colors.grey,
//                   icon: Icons.history,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Daftar Transaksi Yang Sedang Berjalan',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     _buildTransactionListItem(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


//   Widget _buildStatsCard({
//     required String title,
//     required String subTitle,
//     required Color color,
//     required IconData icon,
//   }) {
//     return Card(
//       color: color,
//       child: Container(
//         width: 100,
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, size: 40, color: Colors.white),
//             SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               subTitle,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


// Widget _buildTransactionListItem() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//     child: ListTile(
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Fauzan',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Jemput (Selesai)',
//             style: TextStyle(color: Colors.grey),
//           ),
//           Text(
//             'Fauzan',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Antar (Proses antrian cucian)',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }

import 'package:flutter/material.dart';
import 'sidebar.dart'; // Mengimpor file sidebar.dart

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const Sidebar(), //Tambahkan Sidebar di sini
      backgroundColor: Colors.blueGrey[50],
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildLaundryCard(
            context,
            name: 'Nizar Laundry',
            address: 'jl Gunung Runggig Martapura',
          ),
          const SizedBox(height: 16),
          _buildLaundryCard(
            context,
            name: 'Nizar Laundry 2',
            address: 'jl Pelita, Mabuun, Tanjung',
          ),
          //card lain jika diperlukan
        ],
      ),
    );
  }

  Widget _buildLaundryCard(BuildContext context, {required String name, required String address}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.store, size: 50, color: Colors.lightBlueAccent),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              address,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman Dashboard
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Dashboard', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

