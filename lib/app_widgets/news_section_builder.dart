import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/news_section.dart';

import 'news_card_large.dart';

/// The news Section Builder is a widget which contains all the logic to create a scrollable list of News, in this case the news are
/// displayed as Large Card
class NewsSectionBuilder extends StatelessWidget {
  NewsSectionBuilder({Key key,this.section,this.customAxis,@required this.customHeight,@required this.customWidth,@required this.activeHero,this.heroTag}):super(key: key);
  final NewsSection section;
  final Axis customAxis;
  final double customHeight;
  final double customWidth;
  final bool activeHero;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 40.w),
      width: customWidth,
      height: customHeight,
      child: new ListView.builder(
          itemCount: section.sectionDataList.length,
          scrollDirection: customAxis!=null? customAxis: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return new NewsCardLarge(section.sectionDataList[index], activeHero,customHeight,heroTag);
          }),
    );
  }
}
