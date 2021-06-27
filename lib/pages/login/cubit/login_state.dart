// Copyright (c) 2021, Calin Vasile Andrei
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
part of 'login_cubit.dart';

///Define the State for the Login Cubit
class LoginState {
  LoginState({Key key, this.user,this.status,this.loading});

  final User user;
  final LoginStatus status;
  final bool loading;

  @override
  String toString() {
    return 'LoadingState(user: $user, status: $status, loading: $loading)';
  }
}
