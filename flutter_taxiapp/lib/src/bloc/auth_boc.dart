import 'dart:async';

import 'package:flutter_taxiapp/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  StreamController _namecontroller = StreamController();
  StreamController _phonecontroller = StreamController();
  StreamController _emailcontroller = StreamController();
  StreamController _passcontroller = StreamController();

  FirAuth _firAuth = FirAuth();

  Stream get nameStream => _namecontroller.stream;
  Stream get phoneStream => _phonecontroller.stream;
  Stream get emailStream => _emailcontroller.stream;
  Stream get passStream => _passcontroller.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if (!_checkEmpty(name, _namecontroller, "Nhập tên")) {
      return false;
    }
    if (!_checkEmpty(phone, _phonecontroller, "Nhập số điện thoại")) {
      return false;
    }
    if (!_checkEmpty(email, _emailcontroller, "Nhập email")) {
      return false;
    }
    if (!_checkEmpty(pass, _passcontroller, "Nhập mật khẩu")) {
      return false;
    }
    return true;
  }

  void SignUp(String name, String phone, String email, String pass,
      Function OnSuccess, Function(String) onError) {
    _firAuth.SignUp(name, phone, email, pass, OnSuccess, onError);
  }

  void SignIp(
      String email, String pass, Function OnSuccess, Function(String) onError) {
    _firAuth.SignIn(email, pass, OnSuccess, onError);
  }

  bool _checkEmpty(String chuoi, StreamController controller, String error) {
    if (chuoi == null || chuoi.length == 0) {
      controller.sink.addError(error);
      return false;
    }
    controller.add("OK");
    return true;
  }

  void dispose() {
    _namecontroller.close();
    _phonecontroller.close();
    _emailcontroller.close();
    _passcontroller.close();
  }
}
