import 'package:flutter/material.dart';

class PemilihJumlah extends StatefulWidget {
  final int stok;
  final int harga;
  final String nama;
  final void Function(int jumlah, double totalHarga)? onBeli;

  const PemilihJumlah({
    super.key,
    required this.stok,
    required this.harga,
    required this.nama,
    this.onBeli,
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
  String formatRupiah(double angka) {
    final bulat = angka.round().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < bulat.length; ++i){
      final posisiDariBelakang = bulat.length - i;
      buffer.write(bulat[i]);
      if (posisiDariBelakang > 1 && posisiDariBelakang % 3 == 1) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }
  @override
  Widget build(BuildContext context) {
   
  double totalHarga = hitngTotalHarga(jumlah, widget.harga);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Rp ${formatRupiah(totalHarga)}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _tombolStepper(
                    icon: Icons.remove,
                    onTap: () {
                      setState(() {
                        if (jumlah > 0) jumlah--;
                      });
                    },
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      jumlah.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                         color: Colors.black87,
                      ),
                    ),
                  ),
                  _tombolStepper(
                    icon: Icons.add,
                    onTap: () {
                      if (widget.stok == 0 || jumlah >= widget.stok){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFFE53935),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            content: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Stok Telah Habis',
                                  style:  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        if (jumlah < widget.stok) jumlah++;
                        });
                    },
                  ),
                ],
              ),          
            ],
          ),
        ),
        const SizedBox(height: 6),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: jumlah == 0
              ? null : () => widget.onBeli?.call(jumlah, totalHarga),
            child: const Text('Beli', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }
  Widget _tombolStepper({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        alignment: Alignment.center,
        color: Colors.green.shade600,
        child:  Icon(icon, color: Colors.white, size: 12),
      ),
    );
  }
}