import 'dart:convert';

import 'package:bookstore/Model/Book.dart';
import 'package:http/http.dart' as http;

class BookRemoteServices {

  // String uri = "http://64.227.179.213:3000";
  String uri = "http://localhost:3000";

  getAllBooks() async {
    var httpClient = http.Client();
    var url = Uri.parse("$uri/books");
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      return bookListfromJson(jsonData);
    }
  }

  Future<bool> addBook(Book book) async {
    var httpClient = http.Client();
    var url = Uri.parse("$uri/addBook");
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
    var url = Uri.parse("$uri/books/$id");
    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return Book.fromJson(jsonData);
    }
    return null;
  }

  Future<bool> deleteBookById(int id) async{
    var httpClient = http.Client();
    var url = Uri.parse("$uri/deletebook/$id");
    var response = await httpClient.delete(url);
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  updateBookById(int id,Book book) async {
    var httpClient = http.Client();
    var url = Uri.parse("$uri/updatebook/$id");
    var response = await httpClient.put(
      url,
      headers: {'Content-type':'application/json'},
      body: json.encode(book.toJson())
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
