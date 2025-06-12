import 'package:bookstore/Model/Book.dart';
import 'package:bookstore/Screens/BookDetailScreen.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>BookDetailScreen(bookId: book.id!)));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.coverPageUrl,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
      
              const SizedBox(width: 16),
      
              // Book details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'by ${book.author}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.desc,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
      
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _infoChip(Icons.calendar_today, book.year.toString()),
                        _infoChip(Icons.category, book.genre),
                        _infoChip(Icons.language, book.language),
                        _infoChip(Icons.pages, '${book.pages} pages'),
                        _infoChip(Icons.publish, book.publisher),
                        _infoChip(Icons.star, book.rating.toStringAsFixed(1)),
                      ],
                    ),
      
                    const SizedBox(height: 8),
                    Text(
                      'Added by: ${book.addedBy}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.blueAccent),
      label: Text(label),
      backgroundColor: Colors.blue.withOpacity(0.1),
      visualDensity: VisualDensity.compact,
    );
  }
}