import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class SuiviMonth extends StatefulWidget {
  const SuiviMonth({super.key});

  @override
  State<SuiviMonth> createState() => _SuiviMonthState();
}

class _SuiviMonthState extends State<SuiviMonth> {
  final IFrameElement _iFrameElement = IFrameElement();
  bool _isLoaded = false ;

  void initialisation() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  void initState() {
    initialisation();
    _iFrameElement.style.height = '100%';
    _iFrameElement.style.width = '100%';
    _iFrameElement.src = 'http://test.visionstrategie.com/radar/index1.html';
    _iFrameElement.style.border = 'none';

// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iFrameElement,
    );
    super.initState();
  }

  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _isLoaded ? _iframeWidget : Stack(
        alignment: AlignmentDirectional.center,
        children: const [
          SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: 4,
              )),
          SizedBox(
              height: 30,
              width: 30,
              child:
              CircularProgressIndicator(color: Colors.amber, strokeWidth: 4)),
        ],
      ),
    );
  }
}
