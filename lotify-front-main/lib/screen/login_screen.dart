import 'package:flutter/material.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로고 및 앱명
                Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      // color: const Color(0xFF6366F1),
                      color: const Color(0xFFFFFFFF),
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/lotify.png',
                    )
                ),
                const SizedBox(height: 16),
                const Text(
                  'Lotify',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '불법 주차를 방지하기 위해',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 28),

                // 로그인 폼
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 22),

                      // 이메일 입력
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '아이디',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _userIdController,
                            decoration: InputDecoration(
                              hintText: '아이디를 입력하세요',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color(0xFF9CA3AF),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6366F1),
                                  width: 2,
                                ),
                              ),
                              fillColor: const Color(0xFFF9FAFB),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 비밀번호 입력
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '비밀번호',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: '비밀번호를 입력하세요',
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF9CA3AF),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: const Color(0xFF9CA3AF),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6366F1),
                                  width: 2,
                                ),
                              ),
                              fillColor: const Color(0xFFF9FAFB),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // 로그인 버튼
                      ElevatedButton(
                        onPressed: () {
                          // 로그인 로직
                          _handleLogin();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          '로그인',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // 비밀번호 찾기
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // 비밀번호 찾기 로직
                            },
                            child: const Text(
                              '비밀번호 찾기',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6366F1),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 구분선
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'SNS LOGIN',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // SNS 로그인 버튼들
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 카카오 로그인
                    GestureDetector(
                      onTap: () {
                        // 카카오 로그인 로직
                        _handleSocialLogin('kakao');
                      },
                      child: Image.asset(
                        'assets/images/kakao.png',
                        width: 55,
                        height: 55,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 네이버 로그인
                    GestureDetector(
                      onTap: () {
                        // 네이버 로그인 로직
                        _handleSocialLogin('naver');
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: const BoxDecoration(
                          color: Color(0xFF03C75A),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'N',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // 구글 로그인
                    GestureDetector(
                      onTap: () {
                        // 구글 로그인 로직
                        _handleSocialLogin('google');
                      },
                      child: Image.asset(
                        'assets/images/google.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 회원가입 링크
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '계정이 없으신가요? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // 회원가입 화면으로 이동
                        context.go('/signup');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6366F1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSocialLogin(String provider) async {
    String providerName;
    switch (provider) {
      case 'kakao':
        providerName = '카카오';
        break;
      case 'naver':
        providerName = '네이버';
        break;
      case 'google':
        providerName = '구글';
        break;
      default:
        providerName = '소셜';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$providerName 로그인을 시작합니다...'),
        backgroundColor: const Color(0xFF6366F1),
      ),
    );

    try {
      late http.Response res;

      if (provider == 'google') {
        print('[디버그] 구글 로그인 시작');

        final GoogleSignIn googleSignIn = GoogleSignIn(
          serverClientId: '385351075584-k0521f22u25s99l91c29vseaq6v6ofum.apps.googleusercontent.com', // 🔁 이 부분 수정
          scopes: ['email', 'profile'],
        );

        final GoogleSignInAccount? account = await googleSignIn.signIn();
        if (account == null) {
          throw Exception('Google 계정 선택이 취소되었습니다.');
        }

        final GoogleSignInAuthentication auth = await account.authentication;
        final String? idToken = auth.idToken;
        if (idToken == null) {
          throw Exception('Google ID 토큰을 가져올 수 없습니다.');
        }

        print('[디버그] 구글 ID 토큰 발급됨');
        print('[디버그] idToken: $idToken');

        res = await http.post(
          Uri.parse("http://192.168.139.50:8000/auth/google/callback"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'id_token': idToken}),
        );

        print('[디버그] 구글 로그인 백엔드 응답 코드: ${res.statusCode}');
        print('[디버그] 응답 내용: ${res.body}');
      }


      else if (provider == 'kakao') {
        try {
          print('[디버그] 카카오 로그인 시작');
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          print('[디버그] 로그인 성공, accessToken: ${token.accessToken}');

          final accessToken = token.accessToken;

          res = await http.post(
            Uri.parse("http://192.168.139.50:8000/auth/kakao/callback"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'access_token': accessToken}),
          );

          print('[디버그] 백엔드 응답 코드: ${res.statusCode}');
          print('[디버그] 백엔드 응답 내용: ${res.body}');
        } catch (e) {
          print('[에러] 카카오 로그인 중 예외 발생: $e');
        }
      }


      else if (provider == 'naver') {
        final NaverLoginResult result = await FlutterNaverLogin.logIn();
        if (result.status != NaverLoginStatus.loggedIn) {
          throw Exception('네이버 로그인 실패: ${result.status}');
        }

        final token = await FlutterNaverLogin.getCurrentAccessToken();
        final accessToken = token.accessToken;

        res = await http.post(
          Uri.parse("http://192.168.139.50:8000/auth/naver/callback"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'access_token': accessToken}),
        );
      }

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final accessToken = data['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);


        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인 성공!'),
            backgroundColor: Colors.green,
          ),
        );

        context.push('/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패: ${res.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 오류: $e')),
      );
    }
  }

  void _handleLogin() async {
    // 간단한 유효성 검증
    if (_userIdController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디와 비밀번호를 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 로그인 로직 구현 필요
    print('Email: ${_userIdController.text}');
    print('Password: ${_passwordController.text}');
    print('Remember Me: $_rememberMe');

    // 성공 메시지 (실제로는 메인 화면으로 네비게이션)
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('로그인 성공!'),
    //     backgroundColor: Colors.green,
    //   ),
    // );



    print('서버 요청 시작');

    try {
      final baseUrl = dotenv.env['API_URL'];
      final url = Uri.parse('$baseUrl/user/login');
      // final url = Uri.parse('http://221.147.177.214:8000/user/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': _userIdController.text.trim(),
          'user_pw': _passwordController.text,
        }),
      );

      print('서버 응답: ${response.statusCode}');
      print('응답 내용: ${response.body}');

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['access_token'];
        final role = int.parse(jsonDecode(response.body)['role'].toString());
        print('로그인 성공:${response.body}');
        print('토큰: ${token}');
        print('role: ${role}');
        // 성공 메시지 (실제로는 메인 화면으로 네비게이션)

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        final prefs1 = await SharedPreferences.getInstance();
        final token1 = prefs1.getString('token');
        print('프론트 환경에서 token 사용: ${token1}');


        if (role == 1) {
          // 메인 화면으로 이동
          Future.delayed(const Duration(milliseconds: 100), () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('로그인 성공!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go('/admin_main');
            }
          });
        } else {
          // 메인 화면으로 이동
          Future.delayed(const Duration(milliseconds: 100), () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('로그인 성공!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go('/main');
            }
          });
        }
      }

      else {
        final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));
        var msg = decodedBody['detail'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 실패: ${msg}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('에러 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('오류 발생: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}