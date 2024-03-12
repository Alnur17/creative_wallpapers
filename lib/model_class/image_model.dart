class UnsplashImage {
  final String thumbUrl;
  final String fullUrl;
  final String smallUrl;
  final String regularUrl;
  final String rawUrl;
  final String altDescription;

  bool isFavorite;

  UnsplashImage({
    required this.thumbUrl,
    required this.fullUrl,
    required this.smallUrl,
    required this.regularUrl,
    required this.rawUrl,
    required this.altDescription,
    this.isFavorite = false,
  });

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      thumbUrl: json['urls']['thumb'],
      fullUrl: json['urls']['full'],
      rawUrl: json['urls']['raw'],
      smallUrl: json['urls']['small'],
      regularUrl: json['urls']['regular'],
      altDescription:
          json['alt_description'] ?? 'No altered description available',
    );
  }
}


