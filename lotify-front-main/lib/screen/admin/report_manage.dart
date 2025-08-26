// 신고내역 관리
import 'package:flutter/material.dart';
import 'package:lotify/screen/component/common_layout.dart';

class ReportManagePage extends StatefulWidget {
  @override
  _ReportManagePageState createState() => _ReportManagePageState(); // 클래스명 수정
}

class _ReportManagePageState extends State<ReportManagePage> { // 클래스명 수정
  String _selectedDate = '2024-06-03';
  String _selectedFilter = '전체';
  final TextEditingController _searchController = TextEditingController();

  // 더미 영상 데이터
  final List<VideoRecord> _videoRecords = [
    VideoRecord(
      id: 1,
      time: '10:18',
      location: '소화전 앞',
      status: '불법주차',
      duration: '2:34',
    ),
    VideoRecord(
      id: 2,
      time: '08:45',
      location: '주차장 입구',
      status: '정상주차',
      duration: '1:12',
    ),
    VideoRecord(
      id: 3,
      time: '15:22',
      location: '장애인 주차구역',
      status: '불법주차',
      duration: '3:45',
    ),
    VideoRecord(
      id: 4,
      time: '12:30',
      location: '일반 주차구역',
      status: '정상주차',
      duration: '0:58',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // 날짜 선택기
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Color(0xFF3182CE),
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          '날짜 선택',
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFE5E7EB)),
                        ),
                        child: Text(
                          _selectedDate,
                          style: TextStyle(
                            color: Color(0xFF2D3748),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // 필터 옵션
              Row(
                children: [
                  Expanded(
                    child: _buildFilterButton('전체'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildFilterButton('불법주차'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildFilterButton('정상주차'),
                  ),
                ],
              ),

              SizedBox(height: 24),

              // 영상 목록
              Column(
                children: _getFilteredVideos().map((video) =>
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: _buildVideoItem(video),
                    )
                ).toList(),
              ),

              SizedBox(height: 24),

              // 검색 바
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFF9CA3AF),
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: '위치나 시간으로 검색...',
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Color(0xFF2D3748),
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100), // 하단 네비게이션 공간
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    bool isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFEBF8FF) : Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFFBBE1FF) : Color(0xFFE5E7EB),
          ),
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              color: isSelected ? Color(0xFF1E3A8A) : Color(0xFF6B7280),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoItem(VideoRecord video) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // 이미지 썸네일
          Container(
            width: 96,
            height: 64,
            decoration: BoxDecoration(
              color: Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/normal2.jpg',
                width: 96,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // 이미지 로딩 실패 시 기본 컨테이너 표시
                  return Container(
                    width: 96,
                    height: 64,
                    color: Color(0xFFD1D5DB),
                    child: Icon(
                      Icons.image,
                      color: Color(0xFF6B7280),
                      size: 32,
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(width: 16),

          // 비디오 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      video.time,
                      style: TextStyle(
                        color: Color(0xFF2D3748),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: video.status == '불법주차'
                            ? Color(0xFFFEF2F2)
                            : Color(0xFFF0FDF4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        video.status,
                        style: TextStyle(
                          color: video.status == '불법주차'
                              ? Color(0xFFB91C1C)
                              : Color(0xFF166534),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Color(0xFF6B7280),
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      video.location,
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<VideoRecord> _getFilteredVideos() {
    List<VideoRecord> filtered = _videoRecords;

    // 필터 적용
    if (_selectedFilter != '전체') {
      filtered = filtered.where((video) => video.status == _selectedFilter).toList();
    }

    // 검색 적용
    if (_searchController.text.isNotEmpty) {
      String searchTerm = _searchController.text.toLowerCase();
      filtered = filtered.where((video) =>
      video.location.toLowerCase().contains(searchTerm) ||
          video.time.contains(searchTerm)
      ).toList();
    }

    return filtered;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_selectedDate),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class VideoRecord {
  final int id;
  final String time;
  final String location;
  final String status;
  final String duration;

  VideoRecord({
    required this.id,
    required this.time,
    required this.location,
    required this.status,
    required this.duration,
  });
}