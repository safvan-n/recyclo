/// Customer Review Model
class Review {
  final String author;
  final int rating;
  final String date;
  final String text;

  const Review({
    required this.author,
    required this.rating,
    required this.date,
    required this.text,
  });

  Map<String, dynamic> toMap() => {
    'author': author,
    'rating': rating,
    'date': date,
    'text': text,
  };

  factory Review.fromMap(Map<String, dynamic> map) => Review(
    author: map['author'] ?? '',
    rating: (map['rating'] as num?)?.toInt() ?? 5,
    date: map['date'] ?? '',
    text: map['text'] ?? '',
  );
}
