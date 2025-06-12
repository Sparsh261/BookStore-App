const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

let books = [
  {
    id: 1,
    author: "Paulo Coelho",
    addedBy: "admin",
    title: "The Alchemist",
    desc: "A journey of a shepherd...",
    coverPageUrl: "https://m.media-amazon.com/images/W/MEDIAX_1215821-T2/images/I/41ziEX0PJgL.SY445_SX342.jpg",
    year: 1988,
    genre: "Adventure",
    language: "English",
    pages: 208,
    publisher: "HarperOne",
    rating: 4.5
  },
  {
    id: 2,
    author: "George Orwell",
    addedBy: "admin",
    title: "1984",
    desc: "A dystopian future under surveillance...",
    coverPageUrl: "https://m.media-amazon.com/images/W/MEDIAX_1215821-T2/images/I/41gklC3UGbL.SY445_SX342.jpg",
    year: 1949,
    genre: "Dystopian",
    language: "English",
    pages: 328,
    publisher: "Secker & Warburg",
    rating: 4.7
  }
];
let currentId = 3;

// Create
app.post('/addbook', (req, res) => {
  const newBook = {
    id: currentId++,
    ...req.body
  };
  books.push(newBook);
  res.status(201).json(newBook);
});

// Read all
app.get('/books', (req, res) => {
  res.status(200).json(books);
});

// Read by ID
app.get('/books/:id', (req, res) => {
  const book = books.find(b => b.id === parseInt(req.params.id));
  if (!book) return res.status(404).json({ error: 'Book not found' });
  res.status(200).json(book);
});

// Update
app.put('/updatebook/:id', (req, res) => {
  const book = books.find(b => b.id === parseInt(req.params.id));
  if (!book) return res.status(404).json({ error: 'Book not found' });

  Object.assign(book, req.body);
  res.json(book);
});

// Delete
app.delete('/deletebook/:id', (req, res) => {
  books = books.filter(b => b.id !== parseInt(req.params.id));
  res.status(204).send();
});

app.listen(port, () => {
  console.log( `📚 Book API running at http://localhost:${port}`);
});