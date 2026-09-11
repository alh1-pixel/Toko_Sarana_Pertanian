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
    final habis = stok == 0;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [  
            Container(
              height: 95,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child:  Center(
                child: Icon(getIkonKategori(kategori), size: 32, color:  Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              nama,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '$kategori ~ Rp $harga/$satuan',
              style: const TextStyle(fontSize: 11, color: Colors.black54),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            const SizedBox(height: 4),
            Container(
              padding:  const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: habis ? Colors.red.shade50 : Colors.green.shade50,
                borderRadius: BorderRadius.circular(6),
                border:  Border.all(color: habis ? Colors.red : Colors.green),
              ),
              child: Text(
                habis ? 'STOK HABIS' : 'Tersedia (stok: $stok)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: habis ? Colors.red : Colors.green.shade800,
                ),
              ),
            ),
            const SizedBox(height: 6),
            PemilihJumlah(
              nama: nama, 
              stok: stok, 
              harga: harga,
              onBeli: (jumlahBeli, totalBeli) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.amber.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    duration:  const Duration(seconds: 3),
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$nama x$jumlahBeli berhasil dibeli',
                                style:  const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Total: Rp ${totalBeli.toStringAsFixed(0)}',
                                style: TextStyle(
                                  color:  Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}