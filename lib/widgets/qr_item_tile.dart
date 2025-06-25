import 'package:flutter/material.dart';
import '../models/qr_history_model.dart';

class QRItemTile extends StatelessWidget {
  final QRHistoryModel qr;

  const QRItemTile({super.key, required this.qr});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Image.network(qr.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(qr.data),
      subtitle: Text("Uploaded: ${qr.createdAt}"),
    );
  }
}
