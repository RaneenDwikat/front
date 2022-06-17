// ignore_for_file: unnecessary_new

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:Fluttertoast/Fluttertoast.dart';
class AuthService {
  Dio dio = new Dio();

  login(name, password) async {
    try {
      return await dio.post('http://10.0.2.2:3000/authenticate',
          data: {
            "name": name,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  loginw(name, password) async {
    try {
      return await dio.post('http://10.0.2.2:3000/authenticatew',
          data: {
            "name": name,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addUser(name, password, phonenumber) async {
    return await dio.post('http://10.0.2.2:3000/adduser',
        data: {"name": name, "password": password, "phonenumber": phonenumber},
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  addWorker(name, password, phonenumber, List<String> category, region) async {
    return await dio.post('http://10.0.2.2:3000/addworker',
        data: {
          "name": name,
          "password": password,
          "phonenumber": phonenumber,
          "category": category,
          "region": region
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  addOrder(
      name, List<String> address, category, service, List<String> time) async {
    return await dio.post('http://10.0.2.2:3000/addorder',
        data: {
          "name": name,
          "category": category,
          "service": service,
          "time": time,
          "address": address
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));
  }

  savelocation(latitude, longitude, name, region, address) async {
    try {
      return await dio.put('http://10.0.2.2:3000/savelocation',
          data: {
            "name": name,
            "latitude": latitude,
            "longitude": longitude,
            "region": region,
            "address": address,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getlocation(name) async {
    try {
      return await dio.get('http://10.0.2.2:3000/getlocation/$name');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getcategory() async {
    try {
      return await dio.get('http://10.0.2.2:3000/getcategory');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response!.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
