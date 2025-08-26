// 관리자 신청 페이지
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lotify/screen/component/common_layout.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 관리자 등록 페이지
class AdminRegiPage extends StatefulWidget {
  AdminRegiPage({super.key});

  @override
  State<AdminRegiPage> createState() => _AdminRegiPageState();
}

class _AdminRegiPageState extends State<AdminRegiPage> {
  final TextEditingController adminIdController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 폼 섹션
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),

                  // 관리자 아이디 입력
                  _buildInputField(
                    controller: adminIdController,
                    label: '관리자 아이디',
                    icon: Icons.person,
                    hint: '사용하실 관리자 아이디를 입력하세요',
                  ),
                  const SizedBox(height: 40),

                  // 관리 지역 입력
                  _buildInputField(
                    controller: regionController,
                    label: '관리 지역',
                    icon: Icons.location_on,
                    hint: '담당하실 지역을 입력하세요',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 안내 정보
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '관리자 권한 안내',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• 해당 지역의 불법 주차 신고 내역을 확인할 수 있습니다\n'
                        '• 신고된 내용을 검토하고 승인/반려 처리할 수 있습니다\n'
                        '• 지역별 불법 주차 통계를 확인할 수 있습니다\n'
                        '• 관리자 승인은 검토 후 처리됩니다',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // 등록 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5B7CFA),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadowColor: const Color(0xFF5B7CFA).withOpacity(0.3),
                ),
                onPressed: _isLoading ? null : () => _registerAdmin(context),
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  '관리자 등록 신청',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.grey.shade600,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _registerAdmin(BuildContext context) async {
    print('registerAdmin 함수 시작됨');

    if (adminIdController.text.isEmpty || regionController.text.isEmpty) {
      _showSnackBar(
        context,
        '모든 항목을 입력해주세요.',
        Colors.red,
        Icons.error_outline,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    print('서버 요청 시작');
    try {
      final baseUrl = dotenv.env['API_URL'];
      final url = Uri.parse('$baseUrl/user/admin');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': adminIdController.text.trim(),
          'region': regionController.text.trim(),
        }),
      );
      print('서버 응답: ${response.statusCode}');
      print('응답 내용: ${response.body}');

      if (response.statusCode == 200) {
        _showSnackBar(
          context,
          '관리자 신청이 완료되었습니다.',
          Colors.green,
          Icons.check_circle_outline,
        );
        context.push('/admin_main');
      } else {
        final decodeBody = jsonDecode(utf8.decode(response.bodyBytes));
        var msg = decodeBody['detail'];
        _showSnackBar(
          context,
          '관리자 요청 실패: ${msg}',
          Colors.red,
          Icons.error_outline,
        );
      }
    } catch (e) {
      print('에러 발생: ${e}');
      _showSnackBar(
        context,
        '오류 발생: ${e}',
        Colors.red,
        Icons.error_outline,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(
      BuildContext context,
      String message,
      Color backgroundColor,
      IconData icon,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}