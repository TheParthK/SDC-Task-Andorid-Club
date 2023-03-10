import 'package:flutter/material.dart';
import 'auth.dart';
import 'login.dart';
import 'profile.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot){
        return AnimatedSwitcher(
          switchInCurve: Curves.easeInOutCubicEmphasized,
          switchOutCurve: Curves.elasticInOut,
          duration: const Duration(seconds: 1),
          // ignore: prefer_const_constructors
          child: snapshot.hasData?ProfilePage():LoginPage(),
        );
      }
    );
  }
}