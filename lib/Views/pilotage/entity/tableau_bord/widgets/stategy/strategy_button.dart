import 'package:flutter/material.dart';

class StrategyButton extends StatefulWidget {
  final double postionLeft;
  final double postionBotton;
  final List<Widget> widgets;
  const StrategyButton({super.key, required this.postionLeft, required this.postionBotton, required this.widgets});

  @override
  State<StrategyButton> createState() => _StrategyButtonState();
}



class _StrategyButtonState extends State<StrategyButton> {
  double elevation = 20;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.postionLeft,
        bottom: widget.postionBotton,
        child: InkWell(
          onTap: () async{
            setState(() {
              elevation = 0;
            });
            await Future.delayed(Duration(milliseconds: 500));
            setState(() {
              elevation = 20;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 25,top: 25),
            width: 400,height: 250,
            child: Card(
              elevation: elevation,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF36C2B),
                        Color(0xFFF89D61),
                        Color(0xFFFABA8D),
                        Color(0xFFFDD6B9)
                      ],
                      stops: [0.3,0.5,0.7,0.9],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.widgets,
                ),
              ),
            ),
          ),
        )
    );
  }
}
