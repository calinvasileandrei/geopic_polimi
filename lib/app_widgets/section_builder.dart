import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/structure_card.dart';
import 'package:geopic_polimi/app_widgets/structure_card_large.dart';
import 'package:geopic_polimi/core/models/section.dart';

/// The Section Builder is a widget which contains all the logic to create a scrollable list of Structure, in this case the structures are
/// displayed as Large Card
class SectionBuilder extends StatelessWidget {
  SectionBuilder({Key key,this.section,this.customaxis,@required this.customHeight,@required this.customWidth,@required this.activeHero,@required this.cardLarge,this.heroTag}):super(key: key);
  final Section section;
  final Axis customaxis;
  final double customHeight;
  final double customWidth;
  final bool activeHero;
  final bool cardLarge;
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
          scrollDirection: customaxis!=null? customaxis: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return cardLarge? new StructureCardLarge(section.sectionDataList[index], activeHero,customHeight,heroTag): new StructureCard(section.sectionDataList[index],activeHero,heroTag);
          }),
    );
  }
}
