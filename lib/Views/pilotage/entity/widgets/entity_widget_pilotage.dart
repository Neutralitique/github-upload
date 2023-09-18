import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/Views/pilotage/controllers/controllerEntity.dart';

class EntityWidget extends StatefulWidget {
  const EntityWidget({super.key});

  @override
  State<EntityWidget> createState() => _EntityWidgetState();
}

class _EntityWidgetState extends State<EntityWidget> {

  final ControllerEntity _controllerEntity =Get.find();

  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 30,
      onTap: () {},
      onHover: (value) {
        setState(() {
          _isHovering = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Text(
              _controllerEntity.headerNom.value,
              style: TextStyle(
                  fontSize: 20,
                  color: _isHovering ? Colors.red : Colors.black),
            ),
            Icon(
              _isHovering ? Icons.arrow_drop_up_outlined : Icons.arrow_drop_down_outlined,
              color: _isHovering ? Color(0xFF019FE6) : Color(0xFF476282),
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}