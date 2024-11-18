import 'package:flutter/material.dart';
import 'package:testapaskan/pages/sidebar.dart';

class DataMasterPage extends StatelessWidget {
  const DataMasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Master',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const Sidebar(),
      backgroundColor: Colors.blueGrey[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDataCard(
              context,
              icon: Icons.grid_view,
              count: 74,
              label: 'Jenis Aset',
              color: Colors.lightBlueAccent,
            ),
            _buildDataCard(
              context,
              icon: Icons.shopping_bag,
              count: 74,
              label: 'Produk',
              color: Colors.redAccent,
            ),
            _buildDataCard(
              context,
              icon: Icons.category,
              count: 74,
              label: 'Jenis Produk',
              color: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(
    BuildContext context, {
    required IconData icon,
    required int count,
    required String label,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigasi
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Detail', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
