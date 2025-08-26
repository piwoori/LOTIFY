import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final bool isMainPage;
  final int notificationCount; // 알림 개수 추가

  const CommonLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    this.isMainPage = false,
    this.notificationCount = 2, // 기본값 0
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 상단 AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCEEFF),
        elevation: 0,
        title: Text('LOTIFY',
        style: TextStyle(color: Color(0xFF4A4A4A)),),
        centerTitle: true,
        
        leading: isMainPage
            ? null
            : IconButton(
          padding: const EdgeInsets.all(8.0),
          icon: Image.asset("assets/images/backBtn.png"),
          onPressed: () {
            context.pop();
          },
        ),
        actions: [
          // 알림 아이콘 (개수 표시 포함)
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: Icon(
                  notificationCount > 0
                      ? Icons.notifications // 알림이 있을 때 색칠된 아이콘
                      : Icons.notifications_none, // 알림이 없을 때 빈 아이콘
                  color: notificationCount > 0
                      ? const Color(0xFF667EEA) // 알림이 있을 때 색상
                      : null, // 기본 색상
                ),
                onPressed: () {
                  // 알림 페이지로 이동하거나 알림 처리 로직
                },
              ),
              // 알림
              if (notificationCount > 0)
                Positioned(
                  right: 3,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      notificationCount > 99 ? '99+' : notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Container(
            color: Color(0xFFF5F5F7),
            child: Column(
              children: [
                // 헤더 부분
                Container(
                  padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x1A667EEA),
                        Color(0x0D764BA2),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 프로필 아바타
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF667EEA).withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'L',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 18),
                      // 프로필 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                              ).createShader(bounds),
                              child: Text(
                                'Lotify',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'lotify@naver.com',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF888888),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 메뉴 아이템들
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      _buildMenuItem(Icons.home, '홈', () {
                        context.go('/main');
                      }),
                      _buildMenuItem(Icons.check_circle_outline, '수정할거 1', () {
                        // 할일 페이지로 이동
                      }, badge: '3'),
                      _buildMenuItem(Icons.folder_copy_outlined, '신고내역', () {
                        // 신고내역 페이지로 이동
                      }),
                      _buildMenuItem(Icons.description_outlined, '사용 가이드', () {
                        context.push('/guide');
                      }),

                      // 구분선
                      Container(
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        color: Color(0x1A000000),
                      ),

                      _buildMenuItem(Icons.people_outline, '수정할거 2', () {
                        // 수정
                      }),
                      _buildMenuItem(Icons.settings_outlined, '설정', () {
                        // 수정
                      }),
                    ],
                  ),
                ),

                // 하단 로그아웃
                Padding(
                  padding: EdgeInsets.all(30),
                  child: _buildMenuItem(Icons.logout, '로그아웃', () {
                    // 로그아웃 처리
                    context.go('/');
                  }, isLogout: true),
                ),
              ],
            ),
          ),
        ),
      ),

      // 중심 Body
      body: child,

      // 하단 BottomNavigationBar: 경로 전체 다 수정해야함
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFDCEEFF),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/');
              break;
            case 2:
              context.go('/');
              break;
            case 3:
              context.go('/');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: '마이 페이지'),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: '공유'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: '즐겨찾기'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {String? badge, bool isLogout = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Color(0xFF888888) : Color(0xFF333333),
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Color(0xFF888888) : Color(0xFF333333),
          ),
        ),
        trailing: badge != null
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFFF3B30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badge,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
            : null,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hoverColor: Color(0x1A667EEA),
      ),
    );
  }
}