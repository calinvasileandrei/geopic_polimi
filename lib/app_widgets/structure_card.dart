import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/routing/router_constants.dart';

/// UI Class to create a unified type of card for the structures
class StructureCard extends StatelessWidget {
  final Structure structure;
  final bool activeHero;
  final String heroTag;

  StructureCard(this.structure, this.activeHero, this.heroTag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, cardPageRoute, arguments: {
        "structureId": structure.id,
        "structure": structure,
        "heroTag": heroTag
      }),
      child: SizedBox(
          height: ScreenUtil().screenHeight * 0.38,
          width: ScreenUtil().screenWidth * 0.55,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3.0,
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Hero(
                        transitionOnUserGestures: activeHero,
                        tag: structure.id.toString() + "_" + heroTag,
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          height: ScreenUtil().screenHeight * 0.15,
                          width: ScreenUtil().screenWidth,
                          image: NetworkImage(structure.logo),
                          placeholder: AssetImage('assets/images/logo.png'),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/images/logo.png',
                                height: ScreenUtil().screenHeight * 0.15,
                                width: ScreenUtil().screenWidth,
                                fit: BoxFit.fitWidth);
                          },
                        ),
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                structure.name?.trim(),
                                style: Theme.of(context).textTheme.bodyText2
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(structure.distanceFromYou.toStringAsFixed(1).toString()+" Km",style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor),),
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              height: 220.h,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                  structure.description?.trim(),
                                  style: Theme.of(context).textTheme.caption,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            structure.discount != null ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "SCONTO",
                                  style: Theme.of(context).textTheme.bodyText2
                                      .copyWith(color: Theme.of(context).accentColor),
                                ),
                                Text(
                                  structure.discount.toString()+'%',
                                  style: Theme.of(context).textTheme.bodyText2
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ):Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
