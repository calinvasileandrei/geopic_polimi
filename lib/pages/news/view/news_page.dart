// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  final News news;
  final String heroTag;
  NewsPage({Key key, this.news,this.heroTag}): super(key:key);
  @override
  _NewsPageState createState() => _NewsPageState(this.news,this.heroTag);
}

class _NewsPageState extends State<NewsPage> {
  final News news;
  final String heroTag;
  _NewsPageState(this.news,this.heroTag);


  /// Helper method to open the web url
  void  launchWebsite(String address)async{
    if (await canLaunch(address)) {
      await launch(address);
    } else {
      throw 'Could not launch $address';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  ///Map an input event to some action and finally to a state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: news != null? CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: ScreenUtil().screenHeight*0.3,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Hero(
                transitionOnUserGestures: true,
                tag: news.id.toString()+"_"+heroTag,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  height: ScreenUtil().screenHeight * 0.15,
                  width: ScreenUtil().screenWidth,
                  image: NetworkImage(news.image),
                  placeholder: AssetImage('assets/logo.png'),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/logo.png',
                        fit: BoxFit.fitWidth);
                  },
                ),),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            section()
          ]))
        ],

      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(news.title != null ? news.title:'Senza titolo.',style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold),),
          descriptionSection(),
          SizedBox(
            height: 250.h,
          )
        ],
      ),
    );
  }


  Widget descriptionSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 20.h,),
        Text("Descrizione:",style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
        SizedBox(height: 20.h,),
        Text(
          news.description != null? news.description.trim():'Nessuna descrizione.',
          textAlign: TextAlign.justify,
          style:
          TextStyle(color: Colors.grey[650], fontSize: 14, height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }




}
