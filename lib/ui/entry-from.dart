import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uap_pamp/model/book.dart';

class EntryForm extends StatefulWidget {
  final Book book;
  EntryForm(this.book);
  @override
  EntryFormState createState() => EntryFormState(this.book);
}

class EntryFormState extends State<EntryForm> {
  Book book;
  EntryFormState(this.book);
  TextEditingController judulController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController pengarangController = TextEditingController();
  // TextEditingController kodeBukuController = TextEditingController();

  void cetak() {
    book.kodeBuku != null ? print('ada') : print('tidak ada');
  }

  @override
  Widget build(BuildContext context) {
    if (book != null) {
      judulController.text = book.judul;
      penerbitController.text = book.penerbit;
      pengarangController.text = book.pengarang;
      // kodeBukuController.text = book.kodeBuku.toInt();
    }
    return Scaffold(
        appBar: AppBar(
          title: book == null ? Text('Tambah') : Text('Rubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // Judul
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: judulController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Judul Buku',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // penerbit
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: penerbitController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Penertbit Buku',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              // pengarang
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: pengarangController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Pengarang Buku',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),

              // button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // save
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          // cetak();
                          if (book == null) {
                            // random unique key number
                            book = Book(
                                judulController.text,
                                pengarangController.text,
                                penerbitController.text);
                          } else {
                            book.judul = judulController.text;
                            book.pengarang = pengarangController.text;
                            book.penerbit = penerbitController.text;
                          }
                          Navigator.pop(context, book);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // cancel
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
