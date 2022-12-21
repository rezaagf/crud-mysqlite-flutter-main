import 'package:flutter/material.dart';
import 'package:uap_pamp/model/book.dart';

// class BookDetail extends StatefulWidget {
//   @override
//   _BookDetailState createState() => _BookDetailState();
// }

// class _BookDetailState extends State<BookDetail> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
class BookDetail extends StatelessWidget {
  final Book book;
  BookDetail({@required this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book.judul),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Title"),
                        subtitle: Text(book.penerbit),
                      ),
                      ListTile(
                        title: Text("ID"),
                        subtitle: Text("${book.pengarang}"),
                      ),
                      ListTile(
                        title: Text("Body"),
                        subtitle: Text(book.kodeBuku.toString()),
                      ),
                      ListTile(
                        title: Text("User ID"),
                        subtitle: Text("${book.kodeBuku}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
