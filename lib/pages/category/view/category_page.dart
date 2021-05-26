import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geopic_polimi/app_widgets/circular_rounded_container.dart';
import 'package:geopic_polimi/app_widgets/section_builder.dart';
import 'package:geopic_polimi/app_widgets/simple_app_bar.dart';
import 'package:geopic_polimi/core/models/category.dart';
import 'package:geopic_polimi/core/models/section.dart';
import 'package:geopic_polimi/pages/category/bloc/category_bloc.dart';
import 'package:geopic_polimi/pages/category/bloc/category_state.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  final String location;

  CategoryPage({Key key, this.category, this.location}) : super(key: key);

  @override
  _CategoryPageState createState() =>
      _CategoryPageState(this.category, this.location);
}

class _CategoryPageState extends State<CategoryPage> {
  //Text Controller for the searchbar input field
  TextEditingController _textEditingController;
  //Defines the local variables
  Section section;
  final Category category;
  final String location;

  _CategoryPageState(this.category, this.location);

  ///On Init Emit the Init Event for the CategoryBloc
  _loadData() async {
    BlocProvider.of<CategoryBloc>(context).add(new CategoryEvent(
        status: CategoryStatus.Init, location: location, category: category));
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Defines the UI base on the State of the Bloc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: SimpleAppBar(text: this.category.name),
      body: SafeArea(
        child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (_, CategoryState state) {
              if (state is CategoryLoaded) {
                var _section = state.section;
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                        child: CircularRoundedContainer(
                          child: TextField(
                            onSubmitted: (textString) => textString.length < 2
                                ? BlocProvider.of<CategoryBloc>(context).add(
                                new CategoryEvent(
                                    status: CategoryStatus.Fetch,
                                    location: location,
                                    category: category))
                                : BlocProvider.of<CategoryBloc>(context).add(
                                new CategoryEvent(
                                    status: CategoryStatus.FetchFromInput,
                                    location: location,
                                    category: this.category,
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
                      ),
                      Expanded(
                          child: _section != null
                              ? _section.structures.isNotEmpty
                              ? SectionBuilder(
                            section: _section,
                            customaxis: Axis.vertical,
                            customHeight:
                            ScreenUtil().screenHeight * 0.17,
                            customWidth: ScreenUtil().screenWidth,
                            activeHero: true,
                            cardLarge: true,
                            heroTag: "Category",
                          )
                              : Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 40.w),
                                child: Text(
                                  "Nessuna struttura trovata",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )),
                          )
                              : Center(
                            child: CircularProgressIndicator(),
                          ))
                    ],
                  ),
                );
              } else if(state is CategoryError){
                return Center(
                  child: Text("Ops... Qualcosa è andato storto!"),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
