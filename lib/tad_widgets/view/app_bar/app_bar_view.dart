import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/core/app_constants.dart';
import 'package:geopic_polimi/core/app_theme/app_theme.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCustom({Key key}) : super(key: key);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 2,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        title: const Text(appName));
  }
}
