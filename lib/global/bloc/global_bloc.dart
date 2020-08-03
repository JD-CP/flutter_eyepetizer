import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc(this.themeMode);

  final ThemeMode themeMode;

  @override
  GlobalState get initialState => GlobalStateInitial(themeMode: themeMode);

  @override
  Stream<GlobalState> mapEventToState(
    GlobalEvent event,
  ) async* {}
}
