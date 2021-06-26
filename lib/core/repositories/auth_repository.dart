// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import '../response_message.dart';


///This class manages the authentication request and local storage
class AuthRepository {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  ///This method execute the login if is successfully completed returns the user information
  Future<ResponseMessage<User>> authenticate({
    @required String email,
    @required String password,
  }) async {
    var body={
      'email':email,
      'password':password
    };

    try {
      final authResponse = await http.post(
          Uri.parse(DotEnv.env["BACKEND_URL"] + "api/authenticate"),
          headers: headers,
          body: json.encode(body));

      if (authResponse.statusCode == 200) {
        Map<String,dynamic> bodyParsed = json.decode(authResponse.body);
        User user = User.fromMapAPI(bodyParsed['user'],bodyParsed['id_token']);
        return ResponseMessage(status: 200,body: user,message: 'Autenticazione riuscita!');
      }
      return ResponseMessage(status: 401,body: null,message: 'Credenziali errata!');
    } catch (err) {
      return ResponseMessage(status: 500,body: null,message: 'Abbiamo riscontrato un problema!');
    }
  }

  ///This method delete the user from the local storage
  Future<void> deleteUser() async {
    // delete from keystore/keychain
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    return;
  }

  /// This method persist the user in the local storage
  Future<void> persistUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.toJson());
    return;
  }

  /// This method return the user saved on the local storage , null if none
  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userRaw =prefs.getString('user');
    if(userRaw != null){
      return User.fromJson(userRaw);
    }

    return null;
  }
}
