import 'package:flutter/material.dart';
import 'package:lotify/screen/component/common_layout.dart';
import 'package:intl/intl.dart';

class DetectionResultScreen extends StatelessWidget {
  final String imageUrl;
  final bool violation;
  final Map<String, dynamic> violationData;
  final TextEditingController feedbackController = TextEditingController();

  DetectionResultScreen({
    super.key,
    required this.imageUrl,
    required this.violation,
    required this.violationData,
  });

  @override
  Widget build(BuildContext context) {
    final String resultMessage = violation
        ? "⛔ 불법 주차 위반 차량"
        : "✅ 정상 주차 상태입니다.";
    final Color statusColor = violation ? Colors.redAccent : Colors.green;

    final String vehicleType = violation
        ? (violationData['vehicle']?['vehicle_type'] ?? '알 수 없음')
        : '';

    final String violationType = violation
        ? (violationData['violation_zone']?['korean_name'] ?? '위반 정보 없음')
        : '';

    final int? penaltyAmount = violationData['violation_zone']?['penalty'];
    final String penalty = (penaltyAmount != null)
        ? '벌금: ${NumberFormat('#,###').format(penaltyAmount)}원'
        : '벌금 정보 없음';

    return CommonLayout(
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resultMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Text("이미지를 불러올 수 없습니다")),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (violation) ...[
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.local_taxi),
                  title: Text("차량 종류: $vehicleType"),
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.warning_amber),
                  title: Text("위반 내용: $violationType"),
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.gavel),
                  title: Text(penalty),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("신고가 접수되었습니다.")),
                    );
                  },
                  icon: const Icon(Icons.report),
                  label: const Text("불법 주차 신고하기"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ] else ...[
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text("위반 사항이 감지되지 않았습니다."),
                ),
              ),
            ],
            const SizedBox(height: 40),
            const Text(
              "📝 피드백 남기기",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "AI 판단에 대해 의견이 있다면 입력해 주세요...",
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  final feedback = feedbackController.text;
                  if (feedback.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("피드백 제출됨: $feedback")),
                    );
                    feedbackController.clear();
                  }
                },
                child: const Text("제출"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
