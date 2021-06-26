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
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Define a default name
    String name = '';

    /// Simple Redirect to the News View Page
    redirect(newsSection){
      Navigator.pushNamed(context, newsViewPageRoute,arguments:{
        "newsSection": newsSection
      });
    }

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
                          return DrawerHeader(child: _buildDrawerHeader(name,context));
                        }),
                    ListTile(leading: Icon(Icons.arrow_right), title: Text("News",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=>  redirect('News'),),
                    Divider(),
                    ListTile(leading: Icon(Icons.arrow_right),title: Text("Comunicazioni",style: Theme.of(context).textTheme.subtitle1,) ,onTap: ()=> redirect('Comunicazioni')  ),
                    Divider(),
                    ListTile(leading: Icon(Icons.arrow_right),title: Text("Eventi",style: Theme.of(context).textTheme.subtitle1,),onTap: ()=> redirect('Eventi') ),
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



