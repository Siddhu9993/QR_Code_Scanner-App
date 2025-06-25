class QRHistoryModel {
  final String data;
  final String imageUrl;
  final String createdAt;

  QRHistoryModel(
      {required this.data, required this.imageUrl, required this.createdAt});

  factory QRHistoryModel.fromJson(Map<String, dynamic> json) {
    return QRHistoryModel(
      data: json['data'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'],
    );
  }
}
