import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uap_pamp/model/book.dart';

class Db {
  static Db _db;
  static Database _database;

  Db._createObject();

  factory Db() {
    if (_db == null) {
      _db = Db._createObject();
    }
    return _db;
  }
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'book.db';
//create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
//mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

//buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE buku (kode_buku INTEGER PRIMARY KEY AUTOINCREMENT, judul TEXT, pengarang TEXT, penerbit TEXT)''',
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('buku', orderBy: 'kode_buku');
    return mapList;
  }

// fungsi tambah data
  Future<int> insert(Book book) async {
    Database db = await this.database;
    int count = await db.insert('buku', book.toMap());
    return count;
  }

  Future<int> dummyData() async {
    Database db = await this.database;
    Map<String, dynamic> bukuSatu = Map<String, dynamic>();
    bukuSatu['kode_buku'] = "1";
    bukuSatu['judul'] = "Pemograman Dasar";
    bukuSatu['pengarang'] = "Septianton";
    bukuSatu['penerbit'] = "Surabaya Gajah Mada";
    Map<String, dynamic> bukuDua = Map<String, dynamic>();
    bukuDua['kode_buku'] = "2";
    bukuDua['judul'] = "Pemograman Lanjut";
    bukuDua['pengarang'] = "Rezki";
    bukuDua['penerbit'] = "Yogyakarta Terusan Bintang";
    int count = await db.insert('buku', bukuSatu);
    int count2 = await db.insert('buku', bukuDua);
    if (count == 1 && count2 == 1) {
      return 1;
    }
    return 0;
  }

// fungsi update data
  Future<int> update(Book book) async {
    Database db = await this.database;
    int count = await db.update('buku', book.toMap(),
        where: 'kode_buku=?', whereArgs: [book.kodeBuku]);
    return count;
  }

// fungsi hapus data
  Future<int> delete(int kodeBuku) async {
    Database db = await this.database;
    int count =
        await db.delete('buku', where: 'kode_buku=?', whereArgs: [kodeBuku]);
    return count;
  }

  Future<List<Book>> getBookList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<Book> bookList = List<Book>();
    for (int i = 0; i < count; i++) {
      bookList.add(Book.fromMap(contactMapList[i]));
    }
    return bookList;
  }
}
