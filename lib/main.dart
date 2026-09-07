import 'package:flutter/material.dart';
import 'barang_Tani_Card.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late TextEditingController _controller;
  String kataCari = '';
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
  @override
  Widget build(BuildContext context) {
    final hasilCari = barangTaniList.where(
      (barang) => barang.nama.toLowerCase().contains(
      kataCari.toLowerCase())).toList();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tani Maju Jaya')),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Cari Barang',
              ),
              onChanged: (value) {
                setState(() {
                  kataCari = value;
                });
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder:(context, constraints) {
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
                      childAspectRatio: 3,
                    ),
                    itemCount: hasilCari.length,
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
          ]
        )
      )
    );
  }
}