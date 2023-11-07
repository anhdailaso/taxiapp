import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/src/bloc/auth_boc.dart';
import 'package:flutter_taxiapp/src/fire_base/fire_base_auth.dart';
import 'package:flutter_taxiapp/src/resources/dialog/LoadingDialog.dart';
import 'package:flutter_taxiapp/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_taxiapp/src/resources/home_page.dart';
import 'package:flutter_taxiapp/src/resources/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc _authBloc = AuthBloc();

  TextEditingController _txtname = TextEditingController();
  TextEditingController _txtphone = TextEditingController();
  TextEditingController _txtemail = TextEditingController();
  TextEditingController _txtpass = TextEditingController();

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black38),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset("assets/ic_car_red.png"),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: Text(
                  "Wellcome back!",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54,
                  ),
                ),
              ),
              Text("login to continue using iCab",
                  style: TextStyle(color: Colors.black54)),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: _authBloc.nameStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _txtname,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          labelText: "Name",
                          prefixIcon: Container(
                            width: 50,
                            child: Image.asset("assets/ic_user.png"),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: _authBloc.phoneStream,
                builder: (context, snapshot) => TextField(
                  controller: _txtphone,
                  decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Phone",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("assets/ic_phone.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder(
                stream: _authBloc.emailStream,
                builder: (context, snapshot) => TextField(
                  controller: _txtemail,
                  decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Email",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("assets/ic_mail.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder(
                stream: _authBloc.passStream,
                builder: (context, snapshot) => TextField(
                  controller: _txtpass,
                  obscureText: true,
                  decoration: InputDecoration(
                      errorText:
                          snapshot.hasError ? snapshot.error.toString() : null,
                      labelText: "Password",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("assets/ic_lock.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black87, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              SizedBox(height: 20),
              Container(
                constraints: BoxConstraints.tight(Size(double.infinity, 50)),
                child: ElevatedButton(
                  onPressed: _onSigUpClicked,
                  child: Text(
                    "Sigup",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: RichText(
                  text: TextSpan(
                    text: "Already a User? ",
                    style: TextStyle(color: Color(0xff606470), fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                          text: "Login now",
                          style:
                              TextStyle(color: Color(0xff3277D8), fontSize: 16))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _onSigUpClicked() {
    if (_authBloc.isValid(
        _txtname.text, _txtphone.text, _txtemail.text, _txtpass.text)) {
      //kiểm tra thành công đăng tạo tài khoản ở firebase
      LoadingDialog.showLoadingDialog(context, "Loading...!");
      _authBloc.SignUp(
        _txtname.text,
        _txtphone.text,
        _txtemail.text,
        _txtpass.text,
        () {
          //thành công
          LoadingDialog.HideLoadingDialog(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
        },
        (err) => {
          LoadingDialog.HideLoadingDialog(context),
        },
      );
    }
  }
}
