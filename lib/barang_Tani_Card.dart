import 'package:flutter/material.dart';

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
  
}