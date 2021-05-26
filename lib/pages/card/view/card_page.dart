// Copyright (c) 2021, Calin Vasile Andrei
//
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/core/models/structure.dart';
import 'package:geopic_polimi/core/repositories/main_repository.dart';
import 'package:geopic_polimi/tad_widgets/view/app_bar/cubit/locationapp_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

///Define Card Page Statefull Widget
class CardPage extends StatefulWidget {
  final int structureId;
  final Structure structure;
  final String heroTag;
  CardPage({Key key, this.structureId,this.structure,this.heroTag}): super(key:key);
  @override
  _CardPageState createState() => _CardPageState(this.structureId,this.structure,this.heroTag);
}

class _CardPageState extends State<CardPage> {
  final int structureId;
  Structure structure;
  final String heroTag;
  _CardPageState(this.structureId,this.structure,this.heroTag);


  /// url launcher for opening the google maps
  void launchUrl(String address) async {
    String query = Uri.encodeComponent(address);
    String url = "https://www.google.com/maps/search/?api=1&query='"+query+"'";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Launcher for website
  void  launchWebsite(String address)async{
    if (await canLaunch(address)) {
      await launch(address);
    } else {
      throw 'Could not launch $address';
    }
  }

  /// Emit the event to load the data on Init
  _loadData() async{
    MainRepository repo = new MainRepository();
    var _structure = await repo.getStructureByID(structureId,BlocProvider.of<LocationAppCubit>(context).positionLocation.position);
    setState(() {
      structure = _structure;
    });
  }

  @override
  void initState() {
    super.initState();
    // if no data was passed to the widget request it from the bloc
    if(structure ==null){
      _loadData();
    }
  }

  ///Define the UI when the state is Loaded
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: structure != null? CustomScrollView(
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
                  tag: structure.id.toString()+"_"+heroTag,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    height: ScreenUtil().screenHeight * 0.15,
                    width: ScreenUtil().screenWidth,
                    image: NetworkImage(structure.logo),
                    placeholder: AssetImage('assets/logo.png'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/logo.png',
                          fit: BoxFit.fitWidth);
                    },
                  )),
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

  ///Define the UI fragment for the sections
  Widget section() {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(structure.name,style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold),),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(structure.distanceFromYou.toStringAsFixed(1).toString()+" Km",style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).accentColor),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(structure.address,style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]),)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.directions,color: Colors.blue,), onPressed: ()=>launchUrl(structure.address)),
                  Text("Naviga",style: TextStyle(color: Colors.blue) )
                ],
              )
            ],
          ),
          categorySection(),
          descriptionSection(),
          refferalSection(),
          infoSection(),
          SizedBox(
            height: 250.h,
          )
        ],
      ),
    );
  }

  ///Define the UI fragment for the category
  Widget categorySection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 20.h,),
        structure.discount != null ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(structure.category.name,style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
            Text(structure.discount.toString()+'%',style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),),
          ],
        ):Text(structure.category.name,style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
        SizedBox(height: 20.h,),
      ],
    );
  }

  ///Define the UI fragment for the description
  Widget descriptionSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 20.h,),
        Text("Description:",style: TextStyle(fontSize: 48.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
        SizedBox(height: 20.h,),
        Text(
          structure.description.trim(),
          textAlign: TextAlign.justify,
          style:
          TextStyle(color: Colors.grey[650], fontSize: 14, height: 1.5),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  ///Define the UI fragment for the referral user
  Widget refferalSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 20.h,),
        Text("Persona di Riferimento: ",style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
        Padding(padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
            child: Text( "- Nome: "+ structure.referralPerson.surname +" "+structure.referralPerson.name,style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]) ,)),

        Padding(padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
            child: Text( "- Telefono: "+structure.referralPerson.phone,style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]) ,)),

        Padding(padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
            child: Text( "- Email: "+structure.referralPerson.email,style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]) ,)),

      ],
    );
  }

  ///Define the UI fragment for the info
  Widget infoSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        SizedBox(height: 20.h,),
        Text("Informazioni: ",style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold,color: Colors.grey[700]),),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
          child: Text("- Data Scadenza Convenzione: "+structure.expireDateConvention, style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
          child: Text("- Telefono: "+structure.phone, style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
          child: Text("- Email: "+structure.email, style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]),),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 50.w),
          child: Row(
            children: [
              Text("- Website: ", style: TextStyle(fontSize: 40.sp,color: Colors.grey[650]),),
              InkWell(
                  onTap: ()=>launchWebsite(structure.website),
                  child: Text(" Visita il sito!", style: TextStyle(fontSize: 40.sp,color: Colors.blue),)),
            ],
          ),
        ),

      ],
    );
  }

}
