class CollectionImage {
  final String id;
  final String smallUrl;
  final String thumbUrl;
  final String regularUrl;
  final String fullUrl;
  final String altDescription;
  final int height;
  final int width;
  final int likes;

  CollectionImage({
    required this.id,
    required this.smallUrl,
    required this.thumbUrl,
    required this.regularUrl,
    required this.fullUrl,
    required this.height,
    required this.width,
    required this.likes,
    required this.altDescription,
  });

  factory CollectionImage.fromJson(Map<String, dynamic> json) {
    return CollectionImage(
      id: json['id'],
      smallUrl: json['cover_photo']['urls']['small'],
      thumbUrl: json['cover_photo']['urls']['thumb'],
      regularUrl: json['cover_photo']['urls']['regular'],
      fullUrl: json['cover_photo']['urls']['full'],
       height: json['cover_photo']['height'] ?? 0, // Parse as int
      width: json['cover_photo']['width'] ?? 0,   // Parse as int
      likes: json['cover_photo']['likes'] ?? 0,
      altDescription: json['cover_photo']['alt_description'] ?? 'No altered description available',
    );
  }

}
