import 'package:flutter/material.dart';

class PemilihJumlah extends StatefulWidget {
  final int stok;
  final int harga;

  const PemilihJumlah({
    super.key,
    required this.stok,
    required this.harga,
  });

  @override
  State<PemilihJumlah> createState() => _PemilihJumlahState();
}

class _PemilihJumlahState extends State<PemilihJumlah> {
  int jumlah = 0;

  double hitngTotalHarga(int jumlah, int hargaSatuan) {
    double total = (jumlah * hargaSatuan).toDouble();
    if (jumlah > 25) {
      return total - (total * 0.10);
    } else if (jumlah > 10) {
      return total - (total * 0.05);
    } else {
      return total;
    }
  }

  @override
  Widget build(BuildContext context) {
   
  if (widget.stok == 0) {
    return const Text(
      'STOK HABIS',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
  double totalHarga = hitngTotalHarga(jumlah, widget.harga);
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.remove_circle_outline, color: Colors.green),
        onPressed: () {
          setState(() {
            if (jumlah > 0) {
              jumlah--;
            }
          });
        },
      ),
      Text(jumlah.toString(),style: const TextStyle(fontSize: 16),),
      IconButton(
        icon: const Icon(Icons.add_circle_outline, color: Colors.green),
        onPressed: () {
          setState(() {
            if (jumlah < widget.stok) {
              jumlah++;
            }
          });
        },
      ),
      const SizedBox(width: 16),
      Text('Total Harga: Rp ${totalHarga.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16),),
    ]
  );
  }
}