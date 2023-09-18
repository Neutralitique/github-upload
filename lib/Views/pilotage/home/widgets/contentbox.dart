import 'package:flutter/material.dart';

class ContentBox extends StatefulWidget {
  final Widget? title;
  final double width;
  final double height;
  final List<Widget>children;
  const ContentBox({super.key,
   this.title, required this.children,required this.width,required this.height,
  });

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.width,
      height: widget.height,
      padding:EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20),
            border: Border.fromBorderSide(
          BorderSide(
            width: 1,
            color: Color(0xFFA4A6B3),
          )
      )
        //color:Colors.red,
      ),
      child:Scrollbar(
        isAlwaysShown: true,
        thickness: 4.0,
        child: SingleChildScrollView(
          child: Column(
              children:[
               Container(
                    height:40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color:Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)
                        )
                    ),
                  child: Center(
                    child: widget.title,
                  ),
                ),
                const SizedBox(height: 5,),
                Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children
                    ),
                ),
              ]
          ),
        ),
      )
    );
  }
}
