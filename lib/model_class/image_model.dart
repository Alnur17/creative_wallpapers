class ImageModel {
  final String thumbUrl;
  final String fullUrl;
  final String smallUrl;
  final String regularUrl;
  final String rawUrl;
  final String altDescription;
  final String height;
  final String width;
  final String likes;

  bool isFavorite;

  ImageModel({
    required this.height,
    required this.width,
    required this.likes,
    required this.thumbUrl,
    required this.fullUrl,
    required this.smallUrl,
    required this.regularUrl,
    required this.rawUrl,
    required this.altDescription,
    this.isFavorite = false,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      thumbUrl: json['urls']['thumb'],
      fullUrl: json['urls']['full'],
      rawUrl: json['urls']['raw'],
      smallUrl: json['urls']['small'],
      regularUrl: json['urls']['regular'],
      altDescription:
          json['alt_description'] ?? 'No altered description available',
      height: json['height'],
      width: json['width'],
      likes: json['likes'],
    );
  }
}
