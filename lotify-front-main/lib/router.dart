import 'package:go_router/go_router.dart';
import 'package:lotify/screen/QnA_screen.dart';
import 'package:lotify/screen/SignUp.dart';
import 'package:lotify/screen/admin/admin_main_screen.dart';
import 'package:lotify/screen/admin/report_manage.dart';
import 'package:lotify/screen/admin/user_manage.dart';
import 'package:lotify/screen/admin_regi_screen.dart';
import 'package:lotify/screen/announcement_screen.dart';
import 'package:lotify/screen/board_screen.dart';
import 'package:lotify/screen/login_screen.dart';
import 'package:lotify/screen/report_guide.dart';
import 'screen/main_screen.dart';
import 'screen/vehicle_screen.dart';
import 'screen/detect_result_screen.dart';

final router = GoRouter(
  routes: [
// <<<<<<< HEAD
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
// =======
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const LoginPage(),
    // ),
// >>>>>>> 4cb4bd86a932a1e7f9953b9ab0221181ed445899
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path:'/main',
      builder: (context, state) => const MainPage()
    ),
    GoRoute(
      path: '/vehicle',
      builder: (context, state) => const Vehicle(),
    ),
    GoRoute(
      path: '/board',
      builder: (context, state) => const BoardPage(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};

        final rawViolationData = extra['violationData'] ?? {};
        final Map<String, dynamic> violationData =
        Map<String, dynamic>.from(rawViolationData);

        return DetectionResultScreen(
          imageUrl: extra['imageUrl'] ?? '',
          violation: extra['violation'] ?? false,
          violationData: violationData,
        );
      },
    ),
    GoRoute(
      path: '/adminRegi',
      builder: (context, state) =>  AdminRegiPage(),
    ),
    GoRoute(
      path: '/admin_main',
      builder: (context, state) =>  AdminMainPage(),
    ),
    GoRoute(
      path: '/report_manage',
      builder: (context, state) =>  ReportManagePage(),
    ),
    GoRoute(
      path: '/anno',
      builder: (context, state) =>  AnnoPage(),
    ),
    GoRoute(
      path: '/guide',
      builder: (context, state) =>  GuidePage(),
    ),
    GoRoute(
      path: '/qna',
      builder: (context, state) =>  QnaPage(),
    ),
    GoRoute(
      path: '/user/manage',
      builder: (context, state) =>  UserManagePage(),
    ),
  ],
);
