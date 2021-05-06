import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/section_builder.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/routing/router_constants.dart';

class ListSectionBuilder extends StatefulWidget {
  final List<Section> sections;
  final String location;
  ListSectionBuilder({Key key, @required this.sections,this.location}) : super(key: key);

  @override
  _ListSectionBuilderState createState() => _ListSectionBuilderState(sections,location);
}

class _ListSectionBuilderState extends State<ListSectionBuilder> {
  final List<Section> sections;
  final String location;
  _ListSectionBuilderState(this.sections,this.location);

  @override
  void initState() {
    super.initState();
  }

  bool isSectionValid(section){
    if(section.name != "" && section.name != null){
      return true;
    }
    return false;
  }


  navigateToMacroCategoryPage(String macroCategory,location){
    Navigator.pushNamed(context, macroCategoryPageRoute,arguments: {
      "macroCategory":macroCategory,
      "location": location
    });
  }



  @override
  Widget build(BuildContext context) {
    return sections.isEmpty  ?Container(
      margin: EdgeInsets.symmetric(vertical: 400.h, horizontal: 100.w),
      child: Text(
        "Ops qualcosa è andato storto...\nVerifica la tua connessione!",
        style: Theme.of(context).textTheme.headline5
      ),
    )
        : ListView.builder(
            itemCount: widget.sections.length,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return isSectionValid(sections[index]) ?  Container(
                  width: ScreenUtil().screenWidth,
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 40.w, right: 40.w, top: 40.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sections[index].name,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            IconButton(icon: Icon(Icons.read_more,),onPressed: ()=>navigateToMacroCategoryPage(sections[index].name,location))
                          ],
                        ),
                      ),
                      Divider(),
                      sections[index].structures.isNotEmpty
                          ? SectionBuilder(section: sections[index],activeHero: true,cardLarge: false, customWidth: ScreenUtil().screenWidth,customHeight: (ScreenUtil().screenHeight*0.37),heroTag:"Discovery")
                          : Container(
                              height: ScreenUtil().screenHeight * 0.35,
                              child: SizedBox(
                                  height: ScreenUtil().screenHeight * 0.35,
                                  width: ScreenUtil().screenWidth * 0.5,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    elevation: 3.0,
                                    color: Theme.of(context).backgroundColor,
                                    margin: EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      "Nessuna Struttura",
                                      style: Theme.of(context).textTheme.headline5,
                                      textAlign: TextAlign.start,
                                    )),
                                  )),
                            )
                      /*: CategoryBuilder(placeholderList,
                      widget.sections[index].category),*/
                    ],
                  )):Container();
            });
  }
}
