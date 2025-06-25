import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/qr_history_model.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class ApiService {
  static final MobileScannerController controller = MobileScannerController();

  static const String uploadUrl =
      "https://qrgenrator.apluscrm.in/api/storeqrcode";
  static const String historyUrl =
      "https://qrgenrator.apluscrm.in/api/getScans";

  static Future<void> uploadQRCode(
      {required String data, required File imageFile}) async {
    var request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..fields['user_id'] = '2'
      ..fields['data'] = data
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      log("QR code uploaded successfully");
    } else {
      log("Failed to upload QR code: ${response.statusCode}");
    }
  }

  static Future<List<QRHistoryModel>> fetchHistory() async {
    var res = await http.post(Uri.parse(historyUrl), body: {"user_id": "2"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      return (data['data'] as List)
          .map((e) => QRHistoryModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to fetch history");
    }
  }

  static Future<String?> detectQRFromImage(File imageFile) async {
    try {
      final qrData = await QrCodeToolsPlugin.decodeFrom(imageFile.path);
      return qrData;
    } catch (e) {
      log("QR detection error: $e");
      return null;
    }
  }
}
