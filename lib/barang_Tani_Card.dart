import 'package:flutter/material.dart';
import 'pemilih_Jumlah.dart';

class BarangTani {
  final String nama;
  final String kategori;
  final int harga;
  final String satuan;
  final int stok;

  BarangTani({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.satuan,
    required this.stok,
  });

  bool isStokHabis() {
    return stok == 0;
  } 
}
class BarangTaniCard extends StatelessWidget {
  final String nama;
  final String kategori;
  final int harga;
  final String satuan;
  final int stok;

  const BarangTaniCard({
    super.key,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.satuan,
    required this.stok,
  });
  
  IconData getIkonKategori(String kategori) {
    if (kategori.toLowerCase().contains('bibit')) {
      return Icons.grass;
    } else if (kategori.toLowerCase().contains('pupuk')) {
      return Icons.agriculture;
    } else if (kategori.toLowerCase().contains('sayuran')) {
      return Icons.local_florist;
    } else if (kategori.toLowerCase().contains('alat')) {
      return Icons.build;
    } else {
      return Icons.shopping_bag;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(getIkonKategori(kategori), size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    nama,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Kategori: $kategori'),
            Text('Harga: Rp $harga / $satuan'),
            Text('Stok: $stok'),
            const Spacer(),
            Align(alignment: Alignment.centerRight,
            child: PemilihJumlah(stok: stok, harga: harga,))
          ],
        ),
      ),
    );
  }
}