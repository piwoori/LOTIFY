import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ImagePicker _picker = ImagePicker();

void showImageSourceActionSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('카메라로 촬영'),
            onTap: () {
              Navigator.pop(context);
              _pickAndSendImage(context, ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('갤러리에서 선택'),
            onTap: () {
              Navigator.pop(context);
              _pickAndSendImage(context, ImageSource.gallery);
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _pickAndSendImage(BuildContext context, ImageSource source) async {
  final XFile? pickedFile = await _picker.pickImage(source: source);
  if (pickedFile == null) {
    debugPrint("이미지 선택이 취소됨");
    return;
  }

  final aiBaseUrl = dotenv.env['AI_API_URL'];
  final uri = Uri.parse('$aiBaseUrl/detect-file');

  try {
    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        pickedFile.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final result = json.decode(responseBody);
      print("서버 응답 결과 : $result");

      final detections = result['detections'] ?? {};
      final violations = detections['violations'] ?? [];
      final isViolation = violations.isNotEmpty;
      final imageUrl = result['image_url'] ?? '';

      context.go('/result', extra: {
        'imageUrl': imageUrl,
        'violation': isViolation,
        'violationData': isViolation ? violations[0] : {},
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("서버 오류: ${response.statusCode}")),
      );
    }
  } catch (e) {
    debugPrint("예외 발생: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("에러 발생: $e")),
    );
  }
}