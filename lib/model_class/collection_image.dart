class CollectionImage {
  final String id;
  final String smallUrl;
  final String thumbUrl;
  final String regularUrl;
  final String fullUrl;

  CollectionImage({
    required this.id,
    required this.smallUrl,
    required this.thumbUrl,
    required this.regularUrl,
    required this.fullUrl,
  });

  factory CollectionImage.fromJson(Map<String, dynamic> json) {
    return CollectionImage(
      id: json['id'],
      smallUrl: json['cover_photo']['urls']['small'],
      thumbUrl: json['cover_photo']['urls']['thumb'],
      regularUrl: json['cover_photo']['urls']['regular'],
      fullUrl: json['cover_photo']['urls']['full'],
    );
  }
}
