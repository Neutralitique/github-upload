import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CardTile extends StatelessWidget {
  final String cardTitle;
  final IconData icon;
  final Color iconBgColor;
  final String mainText;
  final String subText;
  final Color ColorContainer;

  const CardTile(
      {Key? key,
        required this.cardTitle,
        required this.icon,
        required this.iconBgColor,
        required this.mainText,
        required this.subText, required this.ColorContainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height:130,
          width:250,
        )
        ,
        Positioned(
          top:40,
            child:Material(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.grey,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 100,
            width: 250,
            padding: EdgeInsets.only(left: 10, right: 10, top: 0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 10,),
                Text(
                  cardTitle,
                  style:TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  mainText,
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  height: 3,
                  width: double.infinity,
                  color: ColorContainer,
                ),
                const SizedBox(height: 4,),
                Align(
                    alignment: Alignment.topLeft,
                    child: FittedBox(
                      child: Text(
                        subText,
                        style:TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.normal),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )),
        Positioned(
          top: 15,
          left: 15,
          child: Material(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(4),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              height:50,
              width: 50,
              child: Icon(
                icon,
                size: 38,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
