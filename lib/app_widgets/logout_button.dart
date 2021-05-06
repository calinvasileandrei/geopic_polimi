import 'package:flutter/material.dart';
import 'package:geopic_polimi/app_widgets/logout_alertdialog.dart';

/// Logout Button which triggers the Logout Alert Dialog
class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()=> showDialog(
        context: context,
        builder: (context) {
          return LogoutAlertDialog();
        }), child: Text('Logout',style: Theme.of(context).textTheme.button,));
  }
}
