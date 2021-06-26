// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/circular_rounded_container.dart';
import 'package:geopic_polimi/app_widgets/section_builder.dart';
import 'package:geopic_polimi/app_widgets/simple_app_bar.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/pages/macro_category/bloc/macro_category_bloc.dart';
import 'package:geopic_polimi/pages/macro_category/bloc/macro_category_state.dart';

///Defines the Macro Category Page UI
class MacroCategoryPage extends StatefulWidget {
  final String macrocategory;
  final String location;

  MacroCategoryPage({Key key, this.macrocategory, this.location})
      : super(key: key);

  @override
  _MacroCategoryPageState createState() =>
      _MacroCategoryPageState(this.macrocategory, this.location);
}

class _MacroCategoryPageState extends State<MacroCategoryPage> {
  //Text Field controller to manage the input field
  TextEditingController _textEditingController;
  //Parameters
  final String macroCategory;
  final String location;

  _MacroCategoryPageState(this.macroCategory, this.location);

  ///Load Data with a new Bloc Event
  _loadData() async {
    BlocProvider.of<MacroCategoryBloc>(context).add(new MacroCategoryEvent(
        status: MacroCategoryStatus.Init,
        location: location,
        macroCategory: macroCategory));
  }

  ///Initialize the component
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  ///Bloc Builder Logic base on the Bloc state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: SimpleAppBar(
        text: this.macroCategory,
      ),
      body: SafeArea(
        child: BlocBuilder<MacroCategoryBloc, MacroCategoryState>(
            builder: (_, MacroCategoryState state) {
          if (state is MacroCategoryLoaded) {
            //If loaded
            Section _section = state.section;
            return _buildSectionLoaded(_section);
          } else if (state is MacroCategoryError) {
            //If error
            return Center(child: Text("Ops.. Qualcosa è andato storto"));
          } else {
            //If loading
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }

  ///Defines the UI for the Loaded State
  Widget _buildSectionLoaded(Section _section){
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          _buildSearchBar(),
          Expanded(
              child: _section != null
                  ? _section.sectionDataList.isNotEmpty
                  ? SectionBuilder(
                section: _section,
                customaxis: Axis.vertical,
                customHeight:
                ScreenUtil().screenHeight * 0.17,
                customWidth: ScreenUtil().screenWidth,
                activeHero: true,
                cardLarge: true,
                heroTag: "MacroCategory",
              )
                  : Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 40.w),
                    child: Text(
                      "Nessuna struttura trovata",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1,
                    )),
              )
                  : Center(
                child: CircularProgressIndicator(),
              ))
        ],
      ),
    );
  }

  ///Define the Search Bar Ui / Logic
  Widget _buildSearchBar(){
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      child: CircularRoundedContainer(
        child: TextField(
          onSubmitted: (textString) => textString.length < 2
              ? BlocProvider.of<MacroCategoryBloc>(context).add(
              new MacroCategoryEvent(
                  status: MacroCategoryStatus.Fetch,
                  location: location,
                  macroCategory: macroCategory))
              : BlocProvider.of<MacroCategoryBloc>(context).add(
              new MacroCategoryEvent(
                  status: MacroCategoryStatus.FetchFromInput,
                  location: location,
                  macroCategory: this.macroCategory,
                  structureName: textString)),
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
              hintText: 'Scrivi un luogo...'),
        ),
      ),
    );
  }
}
