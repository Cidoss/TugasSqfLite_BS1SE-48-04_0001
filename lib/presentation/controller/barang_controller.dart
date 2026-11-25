import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msqflite/data/repo/barang_repo.dart';
import 'package:msqflite/model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;
  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBarang();
  }

  //read
  Future<void> getBarang() async {
    try {
      barangList.value = await repo.getAllBarang();
    } catch (e) {
      Get.snackbar("Error", "Gagal", backgroundColor: Colors.red);
    }
  }

  //create
  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil ditambahkan",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal", backgroundColor: Colors.red);
    }
  }

  //update
  Future<void> updateBarang(Barang barang) async {
    try {
      await repo.update(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil diupdate",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal", backgroundColor: Colors.red);
    }
  }

  //delete
  Future<void> deleteBarang(int id, Barang barang) async {
    try {
      await repo.delete(id);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama${barang.nama} Berhasil dihapus",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal", backgroundColor: Colors.red);
    }
  }
}