// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:equatable/equatable.dart';
import 'package:geopic_polimi/core/models/section.dart';

///Define an abstract class of the MacroCategoryState , this class extends
/// the Equatable witch helps with comparing two different states
abstract class MacroCategoryState extends Equatable{
  @override
  List<Object> get props =>[];
}

///Define an initial state with no data
class MacroCategoryInitState extends MacroCategoryState{}

///Define a loading state
class MacroCategoryLoading extends MacroCategoryState{}

///Define the state when loaded, in this case we have some data like the section
class MacroCategoryLoaded extends MacroCategoryState{
  final Section section;
  MacroCategoryLoaded({this.section});
}

///Define the state on error, in this case we have a variable witch contains the error
class MacroCategoryError extends MacroCategoryState{
  final error;
  MacroCategoryError({this.error});
}
