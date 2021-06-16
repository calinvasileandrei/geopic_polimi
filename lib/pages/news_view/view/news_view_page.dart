import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geopic_polimi/app_widgets/circular_rounded_container.dart';
import 'package:geopic_polimi/app_widgets/news_section_builder.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/pages/news_view/bloc/news_view_bloc.dart';
import 'package:geopic_polimi/pages/news_view/bloc/news_view_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsViewPage extends StatefulWidget {
  final String newsSection;
  NewsViewPage({Key key,this.newsSection}) : super(key: key);

  @override
  _NewsViewPageState createState() =>
      _NewsViewPageState(this.newsSection);
}

/// This page show the all the list of news
class _NewsViewPageState extends State<NewsViewPage> {
  TextEditingController _textEditingController;
  Section section;
  String newsSection;
  _NewsViewPageState(this.newsSection);

  @override
  void initState() {
    super.initState();
    // Init the News Bloc
    BlocProvider.of<NewsViewBloc>(context).add(new NewsViewEvent(status: NewsViewStatus.Init,newsSection: newsSection));
  }

  ///Define the UI when the state is Loaded
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularRoundedContainer(
                  paddingHorizzontal: 40.w,
                  child: Text(newsSection,style: Theme.of(context).textTheme.bodyText1,),
                  height: 120.h,
                ),
              ],
            ),
          )),
      body: SafeArea(
        child: BlocBuilder<NewsViewBloc, NewsViewState>(
            builder: (_, NewsViewState state) {
              if (state is NewsLoaded) {
                var _section =  state.section;
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                        child: CircularRoundedContainer(
                          child: TextField(
                            onSubmitted: (textString)=> textString.length<2?
                            BlocProvider.of<NewsViewBloc>(context).add(new NewsViewEvent(status: NewsViewStatus.Fetch, newsSection: newsSection)):
                            BlocProvider.of<NewsViewBloc>(context).add(new NewsViewEvent(status: NewsViewStatus.FetchFromInput,newsSection: newsSection,newsName: textString )) ,
                            controller: _textEditingController,
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                hintStyle: Theme.of(context).textTheme.bodyText1,
                                hintText: 'Cerca una news...'),
                          ),
                        ),
                      ),
                      Expanded(
                          child: _section != null
                              ? _section.sectionDataList.isNotEmpty
                              ? NewsSectionBuilder(
                            section: _section,
                            customAxis: Axis.vertical,
                            customHeight: ScreenUtil().screenHeight*0.17,
                            customWidth: ScreenUtil().screenWidth,
                            activeHero: true,
                            heroTag: "NewsPage",
                          )
                              : Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 40.w),
                                child: Text("Nessuna news trovata",style: Theme.of(context).textTheme.bodyText1,)),
                          )
                              : Center(
                            child: CircularProgressIndicator(),
                          ))
                    ],
                  ),
                );
              }  else if (state is NewsError){
                return Center(
                    child:Text("Ops.. Qualcosa è andato storto \n "+state.error.toString())
                );
              } else{
                return Center(
                    child: CircularProgressIndicator()
                );
              }
            }),
      ),
    );
  }
}
