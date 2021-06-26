// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/app_shapes.dart';
import 'package:geopic_polimi/pages/login/cubit/login_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/input_textfield.dart';

///Defining the UI of the Login Page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Defining the controller for the input field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Remove the keyboard when the user press anywhere on the screen
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 100.h),
                    width: 200,
                    height: 200,
                    child: new Image.asset('assets/images/splash.png')),
                InputTextField(
                    width: ScreenUtil().screenWidth * 0.8,
                    height: 150.h,
                    marginVertical: 30.h,
                    controller: emailController,
                    enabledTextField: true,
                    icon: Icons.email,
                    hintText: "Inserire l'email"),
                InputTextField(
                    width: ScreenUtil().screenWidth * 0.8,
                    height: 150.h,
                    obfuscatedText: true,
                    marginVertical: 30.h,
                    controller: passwordController,
                    enabledTextField: true,
                    icon: Icons.security,
                    hintText: 'Inserire la password'),
                Container(
                    margin: EdgeInsets.only(top: 50.h),
                    width: ScreenUtil().screenWidth * 0.8,
                    height: 150.h,
                    child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          //Execute login on button click with a new event on the Login Cubit
                          BlocProvider.of<LoginCubit>(context).Login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          shape: appCardShape,
                        ),
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Theme.of(context).primaryColor),
                        ))),
                BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                  //Show loading indicator on login click
                  if (state.loading) {
                    return Container(
                        margin: EdgeInsets.only(top: 100.h),
                        child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
