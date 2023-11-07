import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  void SignIn(
      String email, String pass, Function onSuccess, Function(String) onError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) => {
              onSuccess(),
            })
        // ignore: body_might_complete_normally_catch_error
        .catchError((err) {
      _onErrorFirebase(err, onError);
    });
  }

  void SignUp(String name, String phone, String email, String pass,
      Function onSuccess, Function(String) onError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) => {
              _createUser(
                  value.user?.uid ?? '', name, phone, onSuccess, onError),
            })
        // ignore: body_might_complete_normally_catch_error
        .catchError((err) {
      _onErrorFirebase(err, onError);
    });
  }

  // ignore: unused_element
  _createUser(String userID, String name, String phone, Function onSuccess,
      Function(String) onError) {
    var user = {'name': name, 'phone': phone};
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userID).set(user).then((_) {
      onSuccess();
    })
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {
      onError(onError.toString());
    });
  }

//tạo hàm trả về chuỗi lỗi khi làm việc với firebase
  _onErrorFirebase(dynamic err, Function(String) onError) {
    if (err is FirebaseAuthException) {
      onError(err.message.toString());
    } else {
      onError('Lỗi không xác định');
    }
  }
}
