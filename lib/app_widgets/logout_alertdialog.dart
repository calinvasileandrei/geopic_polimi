import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/app_shapes.dart';
import 'package:geopic_polimi/pages/login/cubit/login_cubit.dart';

/// Pop up alert dialog to have a user confirmation if he really wants to logout
class LogoutAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: appCardShape,
      title: Text("Attenzione",style: Theme.of(context).textTheme.subtitle2,),
      content: Text('Sei sicuro di voler uscire?',style: Theme.of(context).textTheme.bodyText1,),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Annulla",
              style: TextStyle(
                color: Colors.red,
              ),
            )),
        TextButton(
            onPressed: () => {
              BlocProvider.of<LoginCubit>(context).Logout(),
              Navigator.pop(context),
            },
            child: Text(
              "Conferma",
              style: TextStyle(color: Colors.black),
            )),
      ],
    );
  }
}
