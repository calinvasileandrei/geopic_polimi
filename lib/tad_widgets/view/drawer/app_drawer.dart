// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/app_widgets/logout_button.dart';
import 'package:geopic_polimi/pages/login/cubit/login_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///App Drawer Ui
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Define a default name
    String name = '';

    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    BlocBuilder<LoginCubit,LoginState>(
                        builder: (_, LoginState state) {
                            if(state.status == LoginStatus.Authenticated){
                              name = state.user.firstName;
                            }
                          return DrawerHeader(
                              child: _buildDrawerHeader(name,context)
                          );
                        }),
                    ListTile(leading: Icon(Icons.arrow_right), title: Text("Option1",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=> {} ,),
                    Divider(),
                    ListTile(leading: Icon(Icons.arrow_right),title: Text("Option2",style: Theme.of(context).textTheme.subtitle1,) ,onTap: ()=> {} ),
                    Divider(),
                    ListTile(leading: Icon(Icons.arrow_right),title: Text("Option3",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=> {} ),
                    Divider(),
                  ]),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100.h),
              child: LogoutButton(),
            )
          ],
        ),
      ),
    );
  }


  ///Show the proper UI based on the Name length
  Widget _buildDrawerHeader(String name,BuildContext context){
    return  name != null ?
    name.length<=16? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Benvenuto ",style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor),),
        Text(name,style: Theme.of(context).textTheme.headline2,),
      ],
    ):Column(
      children: [
        Text("Benvenuto ",style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor),),
        SingleChildScrollView(child: Text(name,style: Theme.of(context).textTheme.headline2,), physics: NeverScrollableScrollPhysics(),),
      ],
    ): Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Benvenuto ",style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor),),
      ],
    );
  }
}



