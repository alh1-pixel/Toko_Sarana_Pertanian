import 'package:flutter/material.dart';
import 'barang_Tani_Card.dart';
import 'pemilih_Jumlah.dart';
final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String kataCari = '';
  String kategoriTerpilih = 'Semua';
  int resetCounter = 0;
  final Map <String, int> jumlahTerpilih = {};
  final List<BarangTani> barangTaniList = [
    BarangTani(nama: 'Bibit Padi', kategori: 'Bibit', harga: 10000, satuan: 'Karung', stok: 10, gambar: 'assets/images/Benih_Padi.jpeg' ),
    BarangTani(nama: 'Bibit Jagung', kategori: 'Bibit', harga: 8000, satuan: 'Karung', stok: 20, gambar: 'assets/images/Benih_Jagung.jpeg' ),
    BarangTani(nama: 'Bibit Cabai', kategori: 'Bibit', harga: 15000, satuan: 'Karung', stok: 5, gambar: 'assets/images/Benih_Cabai.jpeg' ),
    BarangTani(nama: 'Pupuk Organik', kategori: 'Pupuk', harga: 20000, satuan: 'Karung', stok: 3, gambar: 'assets/images/Pupuk_Organik.jpeg'),
    BarangTani(nama: 'Tomat', kategori: 'Sayuran', harga: 25000, satuan: 'Bungkus', stok: 0, gambar: 'assets/images/Tomat.jpg' ),
    BarangTani(nama: 'Wortel', kategori: 'Sayuran',harga: 30000,satuan: 'Bungkus',stok: 8, gambar: 'assets/images/Wortel.jpeg'),
    BarangTani(nama: 'Pupuk NPK', kategori: 'Pupuk', harga: 18000, satuan: 'Karung', stok: 2, gambar: 'assets/images/Pupuk_NPK.jpg'),
    BarangTani(nama: 'Bibit Bawang Merah', kategori: 'Bibit', harga: 12000, satuan: 'Karung', stok: 0, gambar: 'assets/images/Benih_Bawang_Merah.jpeg'),
    BarangTani(nama: 'Cangkul', kategori: 'Alat', harga: 14000, satuan: 'Buah', stok: 6, gambar: 'assets/images/Cangkul.jpg'),
  ];
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  List<String> get daftarKategori {
    final unik = barangTaniList.map((barang) => barang.kategori).toSet().toList();
    return ['Semua', ...unik];
  }
  int get jumlahJenisDipilih => jumlahTerpilih.values.where((j) => j > 0).length;
  int get totalBanyakBarang => jumlahTerpilih.values.fold(0, (a, b) => a + b);
  double get totalHargaKeseluruhan {
    double total = 0;
    jumlahTerpilih.forEach((nama, jumlah) {
      if (jumlah <= 0) return;
      final barang = barangTaniList.firstWhere((b) => b.nama == nama);
      total += hitungTotalHarga(jumlah, barang.harga);
    });
    return total;
  }
  @override
  Widget build(BuildContext context) {
    final hasilCari = barangTaniList.where ((barang) {
      final cocokKategori = kategoriTerpilih == 'Semua' || barang.kategori == kategoriTerpilih;
      final kunci = kataCari.toLowerCase();
      final cocokKataKunci = kunci.isEmpty ||
        barang.nama.toLowerCase().contains(kunci) ||
        barang.kategori.toLowerCase().contains(kunci);
      return cocokKategori && cocokKataKunci;
    }).toList();
    return MaterialApp(
      scaffoldMessengerKey: messengerKey,
      home: Scaffold(
        backgroundColor: Colors.grey.shade200,
        
        appBar: AppBar(
          backgroundColor: const Color(0xFFE53935),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          title : Row(children: const [
            Icon(Icons.eco, color: Colors.white),
            SizedBox(width: 8.0),
            Text('Tani Maju Jaya', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ],
          ),
        ),
        
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Cari barang tani',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      kataCari = value;
                    });
                  },
                ),
              ),
            ),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: daftarKategori.map((kategori) {
                    final terpilih = kategori == kategoriTerpilih;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        backgroundColor: terpilih ? Colors.deepOrange : Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() => kategoriTerpilih = kategoriTerpilih = kategori);
                        },
                        child: Text(kategori),  
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Menampilkan ${hasilCari.length} barang',
                  style: const TextStyle(color: Colors.deepOrange)),
                ),
              ),
              const SizedBox(height: 6.0),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(6.0),
                decoration : BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: hasilCari.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.deepOrange.withOpacity(0.8)),
                        const SizedBox(height: 12),
                        const Text(
                          'Barang tidak ditemukan',
                          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Coba ubah kata kunci atau pilih kategori lain',
                          style: TextStyle(color: Colors.deepOrange.withOpacity(0.8), fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(
                  builder: (context, constraints) {
                    int kolom;
                    if (constraints.maxWidth < 600) {
                      kolom = 1;
                    } else if (constraints.maxWidth < 900) {
                      kolom = 2;
                    } else {
                      kolom = 3;
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kolom,
                        mainAxisExtent: 320,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        ),
                        itemCount:  hasilCari.length,
                        itemBuilder: (context, index) {
                          final barang = hasilCari[index];
                          return BarangTaniCard(
                            key: ValueKey('${barang.nama}_$resetCounter'),
                            nama: barang.nama, 
                            kategori: barang.kategori, 
                            harga: barang.harga, 
                            satuan: barang.satuan, 
                            stok: barang.stok,
                            gambar: barang.gambar,
                            onJumlahBerubah:(jumlahBaru) {
                              setState(() {
                                jumlahTerpilih[barang.nama] = jumlahBaru;
                              });
                            },
                          );
                        },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: jumlahJenisDipilih > 0    
            ? FloatingActionButton.extended(
                onPressed: () {
                  final totalBarangDibeli = totalBanyakBarang;
                  final totalHargaDibeli = totalHargaKeseluruhan;

                  messengerKey.currentState?.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green.shade700,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 3),
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
                                  'Berhasil membeli $totalBarangDibeli barang',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Total: Rp ${formatRupiah(totalHargaDibeli)}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
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

                  setState(() {
                    jumlahTerpilih.clear();
                    resetCounter++;
                  });
                },
            backgroundColor: Colors.deepOrange.shade700,        
              icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
              label: Text(
                'Beli $totalBanyakBarang barang ~ Rp${formatRupiah(totalHargaKeseluruhan)}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),            
          )
        : null,
      ),
    );
  }
}