import 'package:flutter/material.dart';

/// UI Class to create a unified type of container with rounded borders
class CircularRoundedContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double paddingHorizzontal;
  const CircularRoundedContainer(
      {Key key, this.child, this.height, this.width, this.paddingHorizzontal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHorizzontal != null ? paddingHorizzontal : 0),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(18))),
        child: this.child);
  }
}
