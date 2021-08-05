import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: '请输入昵称'),
            onChanged: (value){
              String str = base64Encode(utf8.encode(value));
              controller.uid.value = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(hintText: '请输入密码'),
            onChanged: (value){
              String str = base64Encode(utf8.encode(value));
              controller.token.value = str;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () async{
              controller.login();
            },
            child: Text('登陆'),
          ),
        ],
      ),
    );
  }
}
