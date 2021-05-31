/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:ncf_covid_screening/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ncf_covid_screening/services/login_service.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;
  final BlocProvider blocProvider;
  const AppStateContainer({
    Key key,
    @required this.child,
    @required this.blocProvider,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();

  static AppState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_AppStoreContainer>() as _AppStoreContainer)?.appData;
  }
}

class AppState extends State<AppStateContainer> {
  BlocProvider get blocProvider => widget.blocProvider;

  @override
  Widget build(BuildContext context) {
    return _AppStoreContainer(
      appData: this,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }

  void dispose() {
    super.dispose();
  }

  // 'LIFTING STATE UP' REGION:
  String IDNumber = "";
  void updateIDNumber(String idNumber) {
    setState(() => IDNumber = idNumber);
  }
}

class _AppStoreContainer extends InheritedWidget {
  final AppState appData;
  final BlocProvider blocProvider;

  _AppStoreContainer({
    Key key,
    @required this.appData,
    @required child,
    @required this.blocProvider,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_AppStoreContainer oldWidget) => oldWidget.appData != this.appData;
}

class ServiceProvider {
  final LoginService loginService;

  ServiceProvider({
    @required this.loginService,
  });
}

class BlocProvider {
  LoginBloc loginBloc;

  BlocProvider({
    @required this.loginBloc,
  });
}
