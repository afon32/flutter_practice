import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/load_indicator_widget.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadIndicatorWidget(),
      
    );
  }
}
