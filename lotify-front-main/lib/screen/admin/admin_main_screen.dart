import 'package:flutter/material.dart';
import 'package:lotify/screen/component/common_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:lotify/screen/component/common_layout.dart';
import 'package:lotify/screen/camera_handler.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int notificationCount = 3;

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      isMainPage: true,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: Column(
          children: [
            // 나머지 콘텐츠
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    // 주요 기능 버튼들
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _modernCircleButton(
                            context,
                            Icons.admin_panel_settings_outlined,
                            '사용자 관리',
                            '/user/manage',
                            [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          ),
                          _modernCircleButton(
                            context,
                            Icons.directions_car_outlined,
                            '차량 관리',
                            '/vehicle', // 수정 필요
                            [Color(0xFF06B6D4), Color(0xFF3B82F6)],
                          ),
                          _modernCircleButton(
                            context,
                            Icons.forum_outlined,
                            '게시판',
                            '/',
                            [Color(0xFF10B981), Color(0xFF059669)],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    // 주요 서비스 섹션
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '주요 서비스',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              // 신고 내역 관리
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {context.push('/report_manage');},
                                  child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFEF4444),
                                          Color(0xFFEA580C),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF3B82F6).withOpacity(0.3),
                                          blurRadius: 15,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Icon(
                                            Icons.report_problem_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          '신고 내역 관리',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              // 오른쪽 작은 카드들
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _modernSmallCard(
                                      context,
                                      '제보 내역',
                                      [Color(0xFFEC4899), Color(0xFFBE185D)],
                                      Icons.history_outlined,
                                      '/',
                                    ),
                                    const SizedBox(height: 12),
                                    _modernSmallCard(
                                      context,
                                      '주차장 공지사항',
                                      [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                                      Icons.announcement_outlined,
                                      '/anno',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    // 도움말 섹션
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '도움말',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _helpListTile(
                                  '자주 묻는 질문',
                                  Icons.help_outline,
                                    (){context.push('/qna');},
                                  isFirst: true,
                                ),
                                Divider(height: 1, color: Colors.grey[100]),
                                _helpListTile(
                                  '불법 주차 신고 가이드',
                                  Icons.menu_book_outlined,
                                      () {context.push('/guide');},
                                  isLast: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _modernCircleButton(
      BuildContext context,
      IconData icon,
      String label,
      String routePath,
      List<Color> gradientColors,
      ) {
    return GestureDetector(
      onTap: () => context.push(routePath),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _modernSmallCard(
      BuildContext context,
      String title,
      List<Color> gradientColors,
      IconData icon,
      String routePath,
      ) {
    return GestureDetector(
      onTap: () => context.push(routePath),
      child: Container(
        width: double.infinity, // 너비 고정
        height: 84, // 높이 고정
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // 컬럼 크기 최소화
            children: [
              Icon(
                icon,
                size: 28,
                color: Colors.white,
              ),
              const SizedBox(height: 6), // 간격 약간 줄임
              Flexible( // 텍스트 영역을 유연하게 만듦
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _helpListTile(
      String title,
      IconData icon,
      VoidCallback onTap, {
        bool isFirst = false,
        bool isLast = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(16) : Radius.zero,
          bottom: isLast ? Radius.circular(16) : Radius.zero,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Color(0xFF6366F1),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
    );
  }
}