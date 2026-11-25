import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msqflite/presentation/controller/barang_controller.dart';
import 'package:msqflite/model/barang.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFormDialog(BuildContext context, BarangController ctr, {Barang? barang}) {
    final namaC = TextEditingController(text: barang?.nama ?? '');
    final stokC = TextEditingController(text: barang != null ? barang.stok.toString() : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(barang == null ? "Tambah Barang" : "Edit Barang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: stokC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Stok"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final nama = namaC.text.trim();
              final stok = int.tryParse(stokC.text.trim()) ?? 0;
              if (nama.isEmpty) return;

              if (barang == null) {
                // CREATE
                ctr.tambahBarang(Barang(nama: nama, stok: stok));
              } else {
                // UPDATE
                ctr.updateBarang(barang.copyWith(nama: nama, stok: stok));
              }
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, BarangController ctr, Barang barang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Barang"),
        content: Text("Yakin ingin menghapus '${barang.nama}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              //delete
              ctr.deleteBarang(barang.id!, barang);
              Navigator.pop(context);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          Text("LIST BARANG"),
          Expanded(
            child: Obx(() {
              if (ctr.barangList.isEmpty) {
                return Center(child: Text("Data Belum Ada"));
              }

              return ListView.builder(
                itemCount: ctr.barangList.length,
                itemBuilder: (context, index) {
                  final barang = ctr.barangList[index];
                  return Card(
                    child: ListTile(
                      title: Text(barang.nama),
                      subtitle: Text("Stok Barang ${barang.stok}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showFormDialog(context, ctr, barang: barang),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteDialog(context, ctr, barang),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context, ctr),
        child: Icon(Icons.add),
      )
    );
  }
}