import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uap_pamp/helper/db.dart';
import 'package:uap_pamp/model/book.dart';
import 'package:uap_pamp/ui/book-detail.dart';
import 'package:uap_pamp/ui/entry-from.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Db database = Db();

  Future<List<Book>> getDataBooksFromSQL() async {
    List<Book> bookList;
    final Future<Database> dbFuture = database.initDb();

    // check database berhasil dibuka
    await dbFuture.then((databaseOPEN) async {
      // await database.dummyData();
      Future<List<Book>> bookListFuture = database.getBookList();
      bookList = await bookListFuture.then((value) => value);
    });
    print(bookList);
    return bookList;
  }

  Future<Book> navigateToEntryForm(BuildContext context, Book book) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(book);
    }));
    // result disini sebagai nilai dari buku pop up
    return result;
  }

  Future<Book> navigateToEntryFormUpdate(
      BuildContext context, Book book) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(book);
    }));
    // result disini sebagai nilai dari buku pop up
    return result;
  }

  // tambah data mahasiswa
  void addBook(Book book) async {
    await database.insert(book);
  }

  // update data terbaru dari database
  void editBook(Book book) async {
    await database.update(book);
  }

// menghapus data mahssiwa
  void deleteBook(Book book) async {
    await database.delete(book.kodeBuku);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              color: Colors.lightBlue,
              child: FutureBuilder(
                future: this.getDataBooksFromSQL(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
                  if (snapshot.hasData) {
                    List<Book> books = snapshot.data;
                    return ListView(
                      children: books
                          .map(
                            (Book book) => Container(
                              color: Colors.blue,
                              padding: EdgeInsets.all(10),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.people,
                                    size: 25,
                                  ),
                                ),
                                title: Text(
                                  book.judul,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(book.penerbit),
                                    Text(book.pengarang),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.amber,
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                      )),
                                  onTap: () {
                                    deleteBook(book);
                                    setState(() {
                                      getDataBooksFromSQL();
                                    });
                                  },
                                ),
                                onTap: () async {
                                  var bookUpdate =
                                      await navigateToEntryFormUpdate(
                                          context, book);
                                  if (bookUpdate != null) {
                                    editBook(bookUpdate);
                                  }
                                },
                              ),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Expanded(
              // decoration: BoxDecoration(color: Colors.red),
              // height: MediaQuery.of(context).size.height,
              child: Container(
                color: Colors.redAccent,
                child: Center(
                  child: Text(
                    "Septianton Rezki Rahmatulloh || 175150600111011",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        // onPressed: () {},
        onPressed: () async {
          var book = await navigateToEntryForm(context, null);

          if (book != null) {
            addBook(book);
          }
        },
      ),
    );
  }
}
