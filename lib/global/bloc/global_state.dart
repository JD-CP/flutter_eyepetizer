import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GlobalState extends Equatable {
  const GlobalState({@required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class GlobalStateInitial extends GlobalState {
  const GlobalStateInitial({@required ThemeMode themeMode})
      : super(themeMode: themeMode);
}
