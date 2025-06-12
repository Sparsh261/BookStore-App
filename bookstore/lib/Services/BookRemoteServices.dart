import 'dart:convert';

import 'package:bookstore/Model/Book.dart';
import 'package:http/http.dart' as http;

class BookRemoteServices {
  getAllBooks() async {
    var httpClient = http.Client();
    // var url = Uri.parse("http://localhost:3000/books");
    var url = Uri.parse("http://64.227.179.213:3000/books");
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return bookListfromJson(jsonData);
    }
  }

  Future<bool> addBook(Book book) async {
    var httpClient = http.Client();
    var url = Uri.parse("http://64.227.179.213:3000/addBook");
    var response = await httpClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(book.toJson()),
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<Book?> addBookById(int id) async {
    var httpClient = http.Client();
    var url = Uri.parse("http://64.227.179.213:3000/book/$id");
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return Book.fromJson(jsonData);
    }
    return null;
  }
}
