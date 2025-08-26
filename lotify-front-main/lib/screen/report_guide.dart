import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lotify/screen/component/common_layout.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            const Text(
              '불법 주차 신고 가이드',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '간단한 4단계로 불법 주차를 신고해보세요',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

            // 가이드 스텝들
            _buildGuideStep(
              stepNumber: '1',
              title: '불법 주차 촬영',
              description: '소화전 앞, 장애인 전용 구역 등\n불법 주차 현장을 촬영하세요',
              icon: Icons.camera_alt,
              color: const Color(0xFF5B7CFA),
            ),
            const SizedBox(height: 20),

            _buildGuideStep(
              stepNumber: '2',
              title: '사진 업로드',
              description: '특별 구역 불법 주차 신고 버튼을 클릭하여\n촬영한 사진을 업로드하세요',
              icon: Icons.cloud_upload,
              color: const Color(0xFF20D4AA),
            ),
            const SizedBox(height: 20),

            _buildGuideStep(
              stepNumber: '3',
              title: 'AI 분석',
              description: 'AI가 업로드된 사진을 분석하여\n불법 주차 여부를 자동으로 판단합니다',
              icon: Icons.psychology,
              color: const Color(0xFFAB47BC),
            ),
            const SizedBox(height: 20),

            _buildGuideStep(
              stepNumber: '4',
              title: '신고 완료',
              description: '불법 주차로 판정되면 신고하기 버튼을\n클릭하여 신고를 완료하세요',
              icon: Icons.report,
              color: const Color(0xFFE74C3C),
            ),
            const SizedBox(height: 40),

            // 주의사항
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.orange.shade600,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '신고 전 확인사항',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• 명확한 불법 주차 증거가 담긴 사진을 촬영하세요\n'
                        '• 차량 번호판이 선명하게 보이도록 촬영하세요\n'
                        '• 주변 상황을 알 수 있는 전체적인 사진을 촬영하세요',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 시작하기 버튼
            SizedBox(
              width: double.infinity,
              height: 56,
              // child: ElevatedButton(
              //   onPressed: () {
              //     // 메인 페이지로 이동하거나 신고 페이지로 이동
              //     context.push('/report');
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xFF5B7CFA),
              //     foregroundColor: Colors.white,
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              //   // child: const Text(
              //   //   '신고하러 가기',
              //   //   style: TextStyle(
              //   //     fontSize: 18,
              //   //     fontWeight: FontWeight.bold,
              //   //   ),
              //   // ),
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideStep({
    required String stepNumber,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 스텝 번호와 아이콘
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        stepNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // 제목과 설명
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}