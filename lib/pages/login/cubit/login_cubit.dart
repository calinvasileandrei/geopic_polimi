// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:bloc/bloc.dart';
import 'package:geopic_polimi/app/app.dart';
import 'package:flutter/material.dart';
import 'package:geopic_polimi/core/app_toast.dart';
import 'package:geopic_polimi/core/models/user.dart';
import 'package:geopic_polimi/core/repositories/auth_repository.dart';
import 'package:geopic_polimi/core/response_message.dart';
part 'login_state.dart';

///Define the Login possible Status
enum LoginStatus { Authenticated,Unauthenticated,Uninitialized}

///Define the Navigation Method for the routing
loadView(context,route) async{
  await Future.delayed(const Duration(seconds: 1), (){
    Navigator.pushNamedAndRemoveUntil(context, route,(Route<dynamic> route) => false);
  });
}

///Define the cubit for the login system
class LoginCubit extends Cubit<LoginState> {
  User user;
  LoginStatus status;
  final AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginState()) {
    ///Check if the user is logged in
    LoginOnStartUp();
  }

  ///If there is some user data in the local storage login automatically
  Future<void> LoginOnStartUp() async {
    emit(LoginState(loading: false, user: null, status: LoginStatus.Uninitialized));
    user = await authRepository.getUser();
    if(user !=null){
      emit(LoginState(user: user,status: LoginStatus.Authenticated, loading: false));
    }else{
      emit(LoginState(user: null,status: LoginStatus.Unauthenticated, loading: false));
    }
  }

  ///Login method given an email and password
  Future<void> Login({Key key,String email,String password}) async {
    emit(LoginState(user: user, status: status, loading: true));
    ResponseMessage<User> userResponse = await authRepository.authenticate(email: email, password: password);

    switch(userResponse.status){
      case 200:{
        user=userResponse.body;
        await authRepository.persistUser(userResponse.body);
        emit(LoginState(user: user,status: LoginStatus.Authenticated,loading: false));
        break;
      }
      default:{
        showToastTop(message: userResponse.message,bgColor: Theme.of(navigatorKey.currentContext).backgroundColor);
        emit(LoginState(user: null,status: LoginStatus.Unauthenticated,loading: false));
        break;
      }
    }
  }

  ///Logout the user
  Future<void> Logout() async {
    emit(LoginState(user: user, status: status, loading: true));
    await authRepository.deleteUser();
    emit(LoginState(user: null,status: LoginStatus.Unauthenticated,loading: false));
  }

  ///Return if the user is authenticated
  bool isAuth(){
    if(user != null && status == LoginStatus.Authenticated){
      return true;
    }
    return false;
  }
}
