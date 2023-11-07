import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/src/app.dart';
import 'package:flutter_taxiapp/src/bloc/auth_boc.dart';
import 'package:flutter_taxiapp/src/resources/dialog/msg_dialog.dart';
import 'package:flutter_taxiapp/src/resources/home_page.dart';
import 'package:flutter_taxiapp/src/resources/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _txtemail = new TextEditingController();
  TextEditingController _txtpass = new TextEditingController();
  AuthBloc _authBloc = new AuthBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    _authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 140,
              ),
              Image.asset('assets/ic_car_green.png'),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 10),
                child: StreamBuilder(
                    stream: _authBloc.emailStream,
                    builder: (context, snapshot) {
                      return TextField(
                        controller: _txtemail,
                        decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            labelText: "Email",
                            prefixIcon: Container(
                              width: 50,
                              child: Image.asset("assets/ic_mail.png"),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black87, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      );
                    }),
              ),
              StreamBuilder(
                  stream: _authBloc.passStream,
                  builder: (context, snapshot) {
                    return TextField(
                      controller: _txtpass,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          labelText: "Pass work",
                          prefixIcon: Container(
                            width: 50,
                            child: Image.asset("assets/ic_lock.png"),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black87, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                    );
                  }),
              Container(
                  // constraints: BoxConstraints.loose(Size(double.infinity, 30)),
                  constraints: BoxConstraints.loose(Size(double.infinity, 50)),
                  alignment: Alignment.centerRight,
                  child: Text("Forgot password?")),
              Container(
                constraints: BoxConstraints.tight(Size(double.infinity, 50)),
                child: ElevatedButton(
                  onPressed: _onSignInClicked,
                  child: Text(
                    "Log In",
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
                    text: "New user? ",
                    style: TextStyle(color: Color(0xff606470), fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterPage(),
                                  ));
                            },
                          text: "Sign up for a new account",
                          style:
                              TextStyle(color: Color(0xff3277D8), fontSize: 16))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSignInClicked() {
    if (_authBloc.isValid("1", "1", _txtemail.text, _txtpass.text)) {
      _authBloc.SignIp(_txtemail.text, _txtpass.text, () {
        {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
          (err) => {
                MsgDialog.ShowMsgDialog(context, "Sign-Up", err),
              });
    }
  }
}
