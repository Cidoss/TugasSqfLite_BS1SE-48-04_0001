import 'package:msqflite/data/dao/barang_dao.dart';
import 'package:msqflite/model/barang.dart';

abstract class BarangRepo {
  Future<int> insert(Barang barang);
  Future<List<Barang>> getAllBarang();
  Future<int> update(Barang barang);
  Future<int> delete(int id);
}

class BarangRepoImpl implements BarangRepo {
  final BarangDao _barangDao;

  BarangRepoImpl(this._barangDao);

  @override
  Future<int> insert(Barang barang) async {
    return await _barangDao.insert(barang);
  }

  @override
  Future<List<Barang>> getAllBarang() async {
    return await _barangDao.getAllBarang();
  }

  @override
  Future<int> update(Barang barang) async {
    return await _barangDao.update(barang);
  }

  @override
  Future<int> delete(int id) async {
    return await _barangDao.delete(id);
  }
}