import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/custom_text_field.dart';
import 'package:geopic_polimi/core/app_shapes.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';

/// Custom Alert Dialog to allow the user to search for a new position by typing it, this alert dialog implements the typing suggestion
/// to help the user to find the right place, in addition the user can set the value to 'Ovunque' which allows him to search in the entire
/// database without any location restriction.
class PositionAlertDialog extends StatefulWidget {
  PositionAlertDialog({Key key }) : super(key: key);

  @override
  _PositionAlertDialogState createState() =>
      _PositionAlertDialogState();
}

class _PositionAlertDialogState extends State<PositionAlertDialog> {
  // Text controller to manage the input field
  TextEditingController _controller = TextEditingController();
  // Default suggestion list
  List<dynamic> _placeList = [{"comune":" "}];
  // Boolean variable to manage the global search on the database
  bool posizioneOvunque=false;

  @override
  void initState() {
    super.initState();
    // Controller listener to check the input changes (user typing) for triggering the suggestion
    _controller.addListener(() {
      _onChanged();
    });
  }

  /// Call the suggestion method
  _onChanged() {
    getSuggestion(_controller.text);
  }

  /// Display a popup toast (badge) to show some messsage to the user
  void showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor:  Theme.of(context).accentColor,
      textColor: Theme.of(context).primaryColor,
      fontSize: 16.0,
    );
  }

  /// Retrieve from the back end the relative suggestion
  void getSuggestion(String input) async {
    if (input.length > 1 && input != 'Ovunque') {
      var repo = MainRepository();
      var placeListResponse = await repo.getPositionSuggestions(input.trim());
      if(mounted) {
        if(placeListResponse != null){
          if(placeListResponse.length == 0){
            showToast('Nessuna località trovata');
          }
          setState(() {
            _placeList = placeListResponse;
          });
        }else{
          showToast('Errore di connessione!');
        }

      }
    }
  }

  /// Dispose the controller listener to avoid memory leaks
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// UI implementation of the Widget
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: appBorderRadius),
      title: Text("Cambia Zona",style: Theme.of(context).textTheme.headline1,),
      content: Container(
        height: ScreenUtil().screenHeight * 0.3,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            CustomTextField(width: ScreenUtil().screenWidth, controller: _controller, enabledTextField: !posizioneOvunque, icon: Icons.search, hintText: 'Scrivi un luogo...'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(

                children: [
                  CupertinoSwitch(
                    value: posizioneOvunque,
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (bool value) {
                      setState(() {
                        posizioneOvunque = value;
                        if(posizioneOvunque){
                          _controller.text = 'Ovunque';
                        }else{
                          _controller.clear();
                          _controller.text = '';
                        }
                      });
                    },
                  ),
                  Text('Ricerca Ovunque',style: Theme.of(context).textTheme.bodyText1,),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _placeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => {
                        _controller.value = TextEditingValue(
                          text: _placeList[index]["comune"],
                          selection: TextSelection.fromPosition(
                            TextPosition(
                                offset: _placeList[index]["comune"].length),
                          ),
                        )
                      },
                      title: Text(_placeList[index]["comune"],style: Theme.of(context).textTheme.bodyText1,),
                      leading: Icon(Icons.arrow_right_outlined),
                    );
                  },
                ),
              ),
              
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Annulla",
              style: Theme.of(context).textTheme.button.copyWith(color: Colors.red),
            )),
        TextButton(
            onPressed: () => Navigator.pop(context,_controller.text),
            child: Text(
              "Conferma",
              style: Theme.of(context).textTheme.button,
            )),
      ],
    );
  }
}
