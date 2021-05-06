import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/routing/router_constants.dart';

/// UI Class to create a unified type of large card for the structure
class StructureCardLarge extends StatelessWidget {
  final Structure structure;
  final bool activeHero;
  final customHeight;
  final String heroTag;
  StructureCardLarge(this.structure,this.activeHero,this.customHeight,this.heroTag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, cardPageRoute,
          arguments:{
            "structureId": structure.id,
            "structure": structure,
            "heroTag":heroTag
          }),
      child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3.0,
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: ScreenUtil().screenWidth*0.33,
                  height: customHeight,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      transitionOnUserGestures: activeHero,
                      tag: structure.id.toString()+"_"+heroTag,
                      child:FadeInImage(
                        fit: BoxFit.cover,
                        height: ScreenUtil().screenHeight * 0.15,
                        image: NetworkImage(structure.logo),
                        placeholder: AssetImage('assets/images/logo.png'),
                        imageErrorBuilder:
                            (context, error, stackTrace) {
                          return Image.asset('assets/images/logo.png',
                              height: ScreenUtil().screenHeight * 0.15,
                              fit: BoxFit.fitWidth);
                        },
                      ), )
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            structure.name,
                            style: Theme.of(context).textTheme.headline5
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(structure.distanceFromYou.toStringAsFixed(1).toString()+" Km",style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).accentColor),)),
                        Container(
                          height: 250.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              structure.description,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Divider(
                                thickness: 1,
                              ),
                              structure.discount != null ?Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Text(
                                      "SCONTO",
                                      style: Theme.of(context).textTheme.bodyText2
                                          .copyWith(
                                          color: Theme.of(context).accentColor),
                                    ),
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
                        )
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
