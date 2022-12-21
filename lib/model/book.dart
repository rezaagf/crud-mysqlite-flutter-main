import 'dart:math';

class Book {
  int _kodeBuku;
  String _judul, _pengarang, _penerbit;

  // constructor
  Book(this._judul, this._pengarang, this._penerbit);
  Book.addKode(this._kodeBuku);

  //constructor factory
  Book.fromMap(Map<String, dynamic> books) {
    this._kodeBuku = books['kode_buku'];
    this._judul = books['judul'];
    this._pengarang = books['pengarang'];
    this._penerbit = books['penerbit'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['kode_buku'] = kodeBuku;
    map['judul'] = judul;
    map['pengarang'] = pengarang;
    map['penerbit'] = penerbit;
    return map;
  }

  // setter dan gettter
  int get kodeBuku => _kodeBuku;
  String get judul => _judul;
  String get pengarang => _pengarang;
  String get penerbit => _penerbit;
  // &&
  set kodeBuku(int value) => _kodeBuku = value;
  set judul(String value) => _judul = value;
  set pengarang(String value) => _pengarang = value;
  set penerbit(String value) => _penerbit = value;
}
