import 'package:flutter/material.dart';
import 'package:lotify/screen/component/common_layout.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

final TextEditingController vehicleNumController = TextEditingController();
final TextEditingController adminIdController = TextEditingController();

class _VehicleState extends State<Vehicle> {
  String? _selected = 'no';

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      currentIndex: 0, // 필요에 따라 탭 인덱스 조절
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 84,
              alignment: Alignment.center,
              child: const Text(
                '차량 등록',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 10,
              height: 1,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: vehicleNumController,
              decoration: InputDecoration(labelText: '차량 번호'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '장애인 여부',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    const Text('예'),
                    Radio<String>(
                      value: 'yes',
                      groupValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                    ),
                    const Text('아니오'),
                    Radio<String>(
                      value: 'no',
                      groupValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: adminIdController,
              decoration: InputDecoration(labelText: '관리자 아이디'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDCEEFF),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  registerVehicle();
                },
                child: const Text('등록'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //차량 등록 요청 함수
  Future<void> registerVehicle() async {
    final url = Uri.parse('http://localhost:8000/vehicle/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        //토큰
      },
      body: jsonEncode({
        "vehicle_num": vehicleNumController.text,
        "is_disabled": false,
        "approved_by": adminIdController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('차량이 등록되었습니다.')),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('등록 실패!\n ${response.body}')),
      );

    }
    //장애인 여부 "예"일 경우 승인 요청
    //   if(_selected == 'yes')
    //     {
    //       final urlForApproval = Uri.parse('http://localhost:8000/disabled_request');
    //       final approvalResponse = await http.post(
    //           urlForApproval,
    //           headers: {
    //           'Content-Type': 'application/json',
    //           },
    //           body: jsonEncode({
    //           "vehicle_num": vehicleNumController.text,
    //           "requested_by": //user_id 세션에서 추출 추가,
    //         "admin_id": adminIdController.text,
    //           }));
    //
    //           if (approvalResponse.statusCode == 200 || approvalResponse.statusCode == 201) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(content: Text('승인 요청이 전송되었습니다.'));
    //           )
    //       } else {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(content: Text('승인 요청 전송에 실패하였습니다\n ${approvalResponse.body}'));
    //               )
    //   }
    // }
  }
}
