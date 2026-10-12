class Artwork {
  final String id, title, artist, period, image, story;
  final int year, price;
  const Artwork({
    required this.id,
    required this.title,
    required this.artist,
    required this.period,
    required this.image,
    required this.story,
    required this.year,
    required this.price,
  });
  factory Artwork.fromJson(Map<String, dynamic> json) => Artwork(
        id: json['id'] as String,
        title: json['title'] as String,
        artist: json['artist'] as String,
        period: json['period'] as String,
        image: json['image'] as String,
        story: json['story'] as String,
        year: json['year'] as int,
        price: json['price'] as int,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'artist': artist,
        'period': period,
        'image': image,
        'story': story,
        'year': year,
        'price': price,
      };
}
