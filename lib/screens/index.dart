import 'dart:convert';
import 'package:http/http.dart' as http;

class getcat {
  String baseUrl = "http://10.0.2.2:3000/getcategory";
  Future<List> getAllCategory() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // print("object");
        // print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

class getservice {
  String baseUrl = "http://10.0.2.2:3000/getservice";
  Future<List> getAllCategory() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        //print(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
