// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class RequestOTP {
//   Future<Map<String, dynamic>> generateOTP(String phoneNumber) async {
//     final url = Uri.parse('http://famlaika.com/generate_otp');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'mobile': phoneNumber,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to generate OTP');
//     }
//   }
// }
