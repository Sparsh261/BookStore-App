import 'package:bookstore/Model/Book.dart';
import 'package:bookstore/Screens/BookAddScreen.dart';
import 'package:bookstore/Services/BookRemoteServices.dart';
import 'package:bookstore/Widgets/BookCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookHomeScreen extends StatefulWidget{
  @override
  State<BookHomeScreen> createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  
  List<Book> allBooks = [];
  bool isLoaded  = false;

  void initState(){
    super.initState();
    getData();
  }

  void refresh() {
    setState(() {
        isLoaded = false;
    });
    getData();
  }

  getData() async {
    allBooks = await BookRemoteServices().getAllBooks();
    if(allBooks.isNotEmpty){
      setState(() {
        isLoaded = true;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Store"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context)=>BookAddScreen());
      }, child: Icon(Icons.add),),
      body: Visibility(
        visible: isLoaded,
        replacement: Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async => refresh(),
          child: ListView.builder(
            itemCount: allBooks.length,
            itemBuilder: (context,index) => BookCard(book:allBooks[index])),
        ),
      ),
    );
  }
  
}