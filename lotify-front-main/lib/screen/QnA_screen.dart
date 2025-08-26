import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lotify/screen/component/common_layout.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({super.key});

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  final List<bool> _isExpanded = [false, false, false];

  final List<Map<String, String>> _faqData = [
    {
      'question': '불법 주차는 어떤 경우에 신고할 수 있나요?',
      'answer': '소화전 앞, 장애인 주차구역 등 주차가 금지된 구역에 주차된 차량을 신고할 수 있습니다.',
      'category': '신고 기준',
    },
    {
      'question': '신고를 위해 꼭 사진을 첨부해야 하나요?',
      'answer': '네, 정확한 증거를 위해 차량의 위치와 번호판이 잘 보이도록 사진을 첨부해야 합니다.',
      'category': '증거 자료',
    },
    {
      'question': '신고 후 처리 결과는 어떻게 확인할 수 있나요?',
      'answer': '신고 내역 관리를 통해 접수 현황과 처리 결과를 실시간으로 확인하실 수 있습니다.',
      'category': '결과 확인',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),

            // FAQ 리스트
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqData.length,
              itemBuilder: (context, index) {
                return _buildFaqCard(index);
              },
            ),
            const SizedBox(height: 32),

            // 추가 도움말 섹션
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
                        Icons.support_agent,
                        color: Colors.blue.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '더 많은 도움이 필요하신가요?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '위 질문들로 해결되지 않는 문제가 있으시면,\n고객센터로 문의하시거나 앱 내 피드백 기능을 이용해주세요.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // 고객센터 연결
                          },
                          icon: Icon(
                            Icons.phone,
                            size: 18,
                            color: Colors.blue.shade600,
                          ),
                          label: Text(
                            '고객센터',
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue.shade600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // 피드백 페이지 이동
                          },
                          icon: Icon(
                            Icons.feedback,
                            size: 18,
                            color: Colors.blue.shade600,
                          ),
                          label: Text(
                            '피드백',
                            style: TextStyle(
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue.shade600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickHelpCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard(int index) {
    final faq = _faqData[index];
    final isExpanded = _isExpanded[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded[index] = expanded;
            });
          },
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getCategoryColor(faq['category']!).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getCategoryIcon(faq['category']!),
              color: _getCategoryColor(faq['category']!),
              size: 20,
            ),
          ),
          title: Text(
            faq['question']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          trailing: AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
            ),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                faq['answer']!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case '신고 기준':
        return const Color(0xFF5B7CFA);
      case '증거 자료':
        return const Color(0xFF20D4AA);
      case '결과 확인':
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFF6366F1);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case '신고 기준':
        return Icons.rule;
      case '증거 자료':
        return Icons.photo_camera;
      case '결과 확인':
        return Icons.track_changes;
      default:
        return Icons.help_outline;
    }
  }
}