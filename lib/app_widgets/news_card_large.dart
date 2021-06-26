import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/news.dart';
import 'package:geopic_polimi/routing/router_constants.dart';

/// UI Class to create a unified type of card for the news
class NewsCardLarge extends StatelessWidget {
  final News news;
  final bool activeHero;
  final customHeight;
  final String heroTag;
  NewsCardLarge(this.news,this.activeHero,this.customHeight,this.heroTag);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, newsPageRoute,
          arguments:{
            "news":news,
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
                        tag: news.id.toString()+"_"+heroTag,
                        child:FadeInImage(
                          fit: BoxFit.cover,
                          height: ScreenUtil().screenHeight * 0.15,
                          image: news.image == null ? AssetImage('assets/logo.png') : NetworkImage(news.image),
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
                           Text(
                            news.title != null ?
                              news.title.length > 40 ? news.title.substring(0,40)+'...': news.title
                            : 'Senza Titolo',
                            style: Theme.of(context).textTheme.subtitle1
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        Container(
                          height: 250.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: news.description != null ?
                            Text(news.description.length > 120 ? news.description.substring(0,120)+'...' :news.description,
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.start,
                            ): Text('Nessuna descrizione',style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.start,)
                          ),
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
