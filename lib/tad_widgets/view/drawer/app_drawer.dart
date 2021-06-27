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
import 'package:geopic_polimi/routing/router_constants.dart';

///App Drawer Ui
class AppDrawer extends StatefulWidget {
  //Define a default name
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  /// Simple Redirect to the News View Page
  redirect(String newsSection,BuildContext context){
    Navigator.pushNamed(context, newsViewPageRoute,arguments:{
      "newsSection": newsSection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: _buildDrawerHeader(context)),
            Expanded(
                flex: 3,
                child:  _buildOptions(context: context)),
            Container(
              margin: EdgeInsets.only(bottom: 100.h),
              child: LogoutButton(),
            )
          ],
        ),
      )
    );
  }

  /// Generate the options listTails
  Widget _buildOptions({BuildContext context}){
    return Column(
      children: [
        ListTile(leading: Icon(Icons.arrow_right), title: Text("News",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=>  redirect('News',context),),
        Divider(),
        ListTile(leading: Icon(Icons.arrow_right),title: Text("Comunicazioni",style: Theme.of(context).textTheme.subtitle1,) ,onTap: ()=> redirect('Comunicazioni',context)  ),
        Divider(),
        ListTile(leading: Icon(Icons.arrow_right),title: Text("Eventi",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=> redirect('Eventi',context) ),
        Divider(),
      ],
    );
  }

  /// Generate the drawer header with the user's name
  Widget _buildDrawerHeader(BuildContext context){
    return DrawerHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Benvenuto ",style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).accentColor)
          ),
          BlocBuilder<LoginCubit,LoginState>(builder: (_,LoginState state){
            if(state.status == LoginStatus.Authenticated && state.user != null){
              return Text(state.user.firstName,style: Theme.of(context).textTheme.headline2);
            }
            return Text("Utente",style: Theme.of(context).textTheme.headline2);
          })
        ],
      ),
    );
  }
}



