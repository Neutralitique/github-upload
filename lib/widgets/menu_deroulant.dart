import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MenuDeroulant extends StatefulWidget {
  final String indication;
  final List<String> items;
  final double? width;
  final double? dropdownwidth;
  final String? selectedValue;
  final Function(String?)? onChanged;
  final Function(String?)? onChanged2;
  final double? height;
  String? initValue;
  MenuDeroulant({Key? key,String? value, required this.indication, required this.items,@required this.onChanged2,
    @required this.width,@required this.dropdownwidth,@required this.selectedValue,@required this.height,@required this.onChanged,@required this.initValue}) : super(key: key);

  @override
  State<MenuDeroulant> createState() => _MenuDeroulantState();
}

class _MenuDeroulantState extends State<MenuDeroulant> {

  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    //   DropdownButton2(
    //   items: [],
    //   onChanged: (Object? value) {  },
    //
    // );
  }
}
