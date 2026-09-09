import 'package:flutter/material.dart';
import 'barang_Tani_Card.dart';

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
  final List<BarangTani> barangTaniList = [
    BarangTani(nama: 'Bibit Padi', kategori: 'Bibit', harga: 10000, satuan: 'Karung', stok: 10, ),
    BarangTani(nama: 'Bibit Jagung', kategori: 'Bibit', harga: 8000, satuan: 'Karung', stok: 20, ),
    BarangTani(nama: 'Bibit Cabai', kategori: 'Bibit', harga: 15000, satuan: 'Karung', stok: 5, ),
    BarangTani(nama: 'Pupuk Organik', kategori: 'Pupuk', harga: 20000, satuan: 'Karung', stok: 3, ),
    BarangTani(nama: 'Tomat', kategori: 'Sayuran', harga: 25000, satuan: 'Bungkus', stok: 0, ),
    BarangTani(nama: 'Wortel', kategori: 'Sayuran',harga: 30000,satuan: 'Bungkus',stok: 8, ),
    BarangTani(nama: 'Pupuk NPK', kategori: 'Pupuk', harga: 18000, satuan: 'Karung', stok: 2, ),
    BarangTani(nama: 'Bibit Bawang Merah', kategori: 'Bibit', harga: 12000, satuan: 'Karung', stok: 0, ),
    BarangTani(nama: 'Cangkul', kategori: 'Alat', harga: 14000, satuan: 'Buah', stok: 6, ),
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
      home: Scaffold(
        backgroundColor: const Color(0xFFEF5350),
         endDrawer: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE53935),
                  Color(0xFFFFA726),
                ],
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _menuItem('Beranda'),
                  const SizedBox(height: 12.0),
                  _menuItem('Produk Saya'),
                  const SizedBox(height: 12.0),
                  _menuItem('Pengaturan'),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE53935),
          title : Row(children: const [
            Icon(Icons.eco, color: Colors.white),
            SizedBox(width: 8.0),
            Text('Tani Maju Jaya', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    hintText: 'Cari barang tani...',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                  style: const TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 6.0),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(6.0),
                decoration : BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: hasilCari.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.white.withOpacity(0.8)),
                        const SizedBox(height: 12),
                        const Text(
                          'Barang tidak ditemukan',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Coba ubah kata kunci atau pilih kategori lain',
                          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
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
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        ),
                        itemCount:  hasilCari.length,
                        itemBuilder: (context, index) {
                          final barang = hasilCari[index];
                          return BarangTaniCard(
                            nama: barang.nama, 
                            kategori: barang.kategori, 
                            harga: barang.harga, 
                            satuan: barang.satuan, 
                            stok: barang.stok,
                          );
                        },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _menuItem(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style:  const TextStyle(color: Colors.black87)),
    );
  }
}