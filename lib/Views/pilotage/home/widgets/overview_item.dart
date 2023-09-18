import 'package:flutter/material.dart';

import '../../../../module/styled_scrollview.dart';
import '../../../../widgets/customtext.dart';


class OverviewExpansionItem extends StatefulWidget {
  final String title;
  final Color titleColor;
  final List<Widget> children;
  final Function()? onPressed;
  const OverviewExpansionItem(
      {Key? key,
      required this.title,
        @required this.onPressed,
      required this.titleColor,
      required this.children})
      : super(key: key);

  @override
  _OverviewExpansionItemState createState() => _OverviewExpansionItemState();
}

class _OverviewExpansionItemState extends State<OverviewExpansionItem> {
  late bool isVisible;
  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              mouseCursor: MouseCursor.uncontrolled,
              onTap:() async{setState(() {
                if (isVisible) {
                  isVisible = false;
                } else if (isVisible == false) {
                  isVisible = true;
                }
              });
              await Future.delayed(Duration(seconds: 1));
              setState(() {});
            },
              child: Container(
                width: 320,
                height: 50,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                   // borderRadius: BorderRadius.circular(10)
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          style: const ButtonStyle(alignment: Alignment.centerLeft),
                          onPressed: widget.onPressed,
                          child: CustomText(
                            text: widget.title,
                            color: widget.titleColor,
                            weight: FontWeight.bold,
                          )),
                      RotatedBox(
                        quarterTurns: isVisible == true ? 1 : 3,
                        child: InkWell(
                            onTap: () async{
                              setState(() {
                                if (isVisible) {
                                  isVisible = false;
                                } else if (isVisible == false) {
                                  isVisible = true;
                                }
                              });
                              await Future.delayed(Duration(seconds: 1));
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                               size: 20,
                              color: isVisible == true ? widget.titleColor : Colors.black,
                            )),
                      )
                    ],
                  )
                ),
              ),
            )
            // TextButton(
            //     style: const ButtonStyle(alignment: Alignment.centerLeft),
            //     onPressed: widget.onPressed,
            //     child: CustomText(
            //       text: widget.title,
            //       color: widget.titleColor,
            //       weight: FontWeight.bold,
            //     )),
            // RotatedBox(
            //   quarterTurns: isVisible == true ? 1 : 3,
            //   child: InkWell(
            //       onTap: () async{
            //         setState(() {
            //           if (isVisible) {
            //             isVisible = false;
            //           } else if (isVisible == false) {
            //             isVisible = true;
            //           }
            //         });
            //         await Future.delayed(Duration(seconds: 1));
            //         setState(() {});
            //       },
            //       child: Icon(
            //         Icons.arrow_back_ios_new,
            //         size: 20,
            //         color: isVisible == true ? widget.titleColor : Colors.black,
            //       )),
            // )
          ],
        ),
        Visibility(
            visible: widget.children==null? false:isVisible,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                padding: EdgeInsets.only(top:0.0),
                height: 100,
                width: 300,
                child: StyledScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children),
                ),
              ),
            ))
      ],
    );
  }
}

