import 'package:flutter/material.dart';

/// 加载圈
class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        backgroundColor: Colors.deepPurple[600],
      ),
    );
  }
}
