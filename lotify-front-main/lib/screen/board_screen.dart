import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lotify/screen/component/common_layout.dart';

class Post {
  final String writer;
  final String title;
  final String contents;
  final int viewCount;
  final DateTime createdAt;

  Post
  ({
    required this.writer,
    required this.title,
    required this.contents,
    required this.viewCount,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json)
  {
    return Post
      (
      writer: json['writer'],
      title: json['title'],
      contents: json['contents'],
      viewCount: json['view_count'],
      createdAt: DateTime.parse(json['created_at']),
      );
  }
}

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final List<Post> _allPosts = [];
  final List<Post> _displayedPosts = [];
  final int _pageSize = 10;
  int _currentIndex = 0;
  bool _isLoading = false;
  bool _hasError = false;
  bool _hasMore = true;
  final ScrollController _scrollController = ScrollController();
  final String _baseUrl = 'http://10.0.2.2:8000';

  @override
  void initState()
  {
    super.initState();
    _loadPosts();
    _scrollController.addListener(()
    {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadMorePosts();
      }
    });
  }

  //scrollController 해제
  @override
  void dispose()
  {
    _scrollController.dispose();
    super.dispose();
  }

  //전체 게시글 가져옴
  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try
        {
          final response = await http.get(
            Uri.parse('$_baseUrl/posts'),);

          if (response.statusCode == 200)
            {
              final decodedBody = utf8.decode(response.bodyBytes);
              List<dynamic> data = jsonDecode(decodedBody);
              List<Post> posts = data.map((json) => Post.fromJson(json)).toList();

              setState(() {
                _allPosts.addAll(posts);
                _loadMorePosts();
                _isLoading = false;
              });
            } else
              {
                setState(() {
                  _isLoading = false;
                  _hasError = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content:
                  Text('게시글을 불러오는데 실패했습니다...:\n${response.statusCode}')),
                );
              }
        }
    catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    }
  }

  void _loadMorePosts() {
    setState(() {
      _isLoading = true;
    });

    //다음 데이터 조각의 인덱스 계산
    int nextIndex = _currentIndex + _pageSize;
    if (nextIndex >= _allPosts.length) {
      nextIndex = _allPosts.length; // 데이터 끝에 도달 시
      _hasMore = false; // 더 이상 표시할 데이터 없음
    }

    setState(() {
      _displayedPosts.addAll(
        _allPosts.sublist(_currentIndex, nextIndex),
      );
      _currentIndex = nextIndex;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/board_write');
          },
          backgroundColor: Color(0xFFC7E8BE),
          child: const Icon(Icons.edit),
        ),
        body: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: Color(0xFFC7E8BE),
              child: const Text(
                '게시판',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F3B33),
                ),
              ),
            ),
//검색바
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: SearchBar(
                hintText: '검색',
                hintStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 16,
                    )
                ),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      print('Searching');
                    }, //검색 로직 으로 변경 필요
                  ),
                ],
                textStyle: WidgetStateProperty.all(
                  TextStyle(
                    color: Color(0xFF2F3B33),
                    fontSize: 16,
                  ),
                ),
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) {
                    if (states.contains(WidgetState.focused)) {
                      return Color(0xFFEEEEEF);
                    }
                    return Colors.white;
                  },
                ),
                elevation: WidgetStateProperty.all(0),
                shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(
                          color: Color(0xFF2F3B33),
                          width: 1,
                        )
                    )
                ),
                onChanged: (value) {
                  print('검색어: $value');
                },
              ),
            ),
            //게시글
            Expanded(
                child: _isLoading && _displayedPosts.isEmpty
              ? Center(child: CircularProgressIndicator())
              : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('게시글을 불러오는데 실패하였습니다...',
                        style: TextStyle(
                          color: Color(0xFF2F3B33)
                        ),),
                        SizedBox(height: 16),
                        ElevatedButton(onPressed: _loadPosts,
                            child: Text('재시도',
                            style: TextStyle(
                              color: Color(0xFFBE185D)
                            ),),
                        ),
                      ],
                  ),
                )
              : _displayedPosts.isEmpty
                    ? Center(child: Text('게시글이 없음',
                style: TextStyle(
                  color: Color(0xFF2F3B33)
                ),))
                    : ListView.builder(
                  controller: _scrollController,
                  itemCount: _displayedPosts.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index)
                  {
                    if (index == _displayedPosts.length && _isLoading)
                      {
                        return Center(
                          child: Padding(
                              padding:const EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    final post = _displayedPosts[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFFC7E8BE), width: 1),    // 위쪽 border
                          //bottom: BorderSide(color: Color(0xFFC7E8BE), width: 1), // 아래쪽 border
                        ),
                      ),
                      child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        title: Text(
                          post.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F3B33),
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(//작성자
                              '${post.writer} | ${post.createdAt.toString().substring(0, 10)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF767676),
                              ),
                            ),
                            Text(
                              '${post.viewCount}',//조회수
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF767676),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          context.push('/board_post');
                          print('${post.title} << 선택됨');
                        },
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}