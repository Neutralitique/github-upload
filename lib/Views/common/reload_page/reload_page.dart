import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../helpers/helper_methods.dart';

class ReloadScreen extends StatefulWidget {
  final String redirection;
  const ReloadScreen({super.key, required this.redirection});
  @override
  State<ReloadScreen> createState() => _ReloadScreenState();
}

class _ReloadScreenState extends State<ReloadScreen> {

  void redirection() async {
    await Future.delayed(Duration(seconds: 1));
    context.go(widget.redirection);
  }

  @override
  void initState() {
    redirection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loadingPageWidget(),
      ),
    );
  }
}