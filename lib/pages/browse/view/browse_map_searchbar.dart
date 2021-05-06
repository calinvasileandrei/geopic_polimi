import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/pages/browse/bloc/browse_bloc.dart';

class BrowseSearchBar extends StatelessWidget {
  TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (textString) => textString.length >= 2
          ? BlocProvider.of<BrowseBloc>(context).add(new BrowseEvent(
        status: BrowseStatus.UpdateCameraPosition,
        location: textString,))
          : {},
      controller: _textEditingController,
      style: Theme.of(context).textTheme.bodyText1,
      textAlignVertical: TextAlignVertical.center,
      decoration: new InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          hintText: 'Scrivi un luogo...'),
    );
  }
}
