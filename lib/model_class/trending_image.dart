class TrendingImage {
  final String id;
  final String thumbUrl;
  final String fullUrl;
  final String smallUrl;
  final String regularUrl;
  final String rawUrl;
  final String altDescription;
  final String color;
  final int height;
  final int width;
  final int likes;

  bool isFavorite;

  TrendingImage({
    required this.height,
    required this.width,
    required this.likes,
    required this.color,
    required this.id,
    required this.thumbUrl,
    required this.fullUrl,
    required this.smallUrl,
    required this.regularUrl,
    required this.rawUrl,
    required this.altDescription,
    this.isFavorite = false,
  });

  factory TrendingImage.fromJson(Map<String, dynamic> json) {
    return TrendingImage(
      id: json['id'],
      color: json['color'],
      thumbUrl: json['urls']['thumb'],
      fullUrl: json['urls']['full'],
      rawUrl: json['urls']['raw'],
      smallUrl: json['urls']['small'],
      regularUrl: json['urls']['regular'],
      altDescription:
          json['alt_description'] ?? 'No altered description available',
      height: json['height'] ?? 0, // Parse as int
      width: json['width'] ?? 0,
      likes: json['likes'] ?? 0,
    );
  }
}
