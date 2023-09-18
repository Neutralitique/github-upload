import 'package:flutter/material.dart';

class DrawerEvaluation extends StatefulWidget {
  const DrawerEvaluation({super.key});

  @override
  State<DrawerEvaluation> createState() => _DrawerEvaluationState();
}

class _DrawerEvaluationState extends State<DrawerEvaluation> {
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0,left: 10,right:5,bottom: 20),
      child: Card(
        elevation:4,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width:2,
              color:Colors.grey
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          width:260,
          padding:
          const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 250,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color:Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(20),),
                      ),

                      child: TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Démarer une évaluation",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                          )),
                    ),
                    SizedBox(height: 13,),
                    Text(
                      "Menu Principal",
                      textAlign:TextAlign.center,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                width:240,
                padding: EdgeInsets.all(8),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              CustomMenuButton(
                pathMenu: '/accueil',
                image: "assets/icons/home.png",
                isFullPath: false,
                icon: Icons.home,
                label: "Accueil",
              ),
              SizedBox(height: 10),
              CustomMenuButton(
                pathMenu: '',
                image: "assets/icons/profil.png",
                icon: Icons.person,
                isFullPath: false,
                label: "Profil",
              ),
              SizedBox(height: 10),
              CustomMenuButton(
                pathMenu: '/gestion-audits',
                image: "assets/icons/table.png",
                icon: Icons.table_chart_rounded,
                isFullPath: false,
                label: "Gestion des audits",
              ),
              SizedBox(height: 10),
              CustomMenuButton(
                pathMenu: '/admin',
                image: "assets/icons/admin.png",
                icon: Icons.admin_panel_settings_outlined,
                isFullPath: false,
                label: "Administration",
              ),
              SizedBox(
                height: 10,
              ),
              CustomMenuButton(
                pathMenu: '/d',
                image: "",
                icon: Icons.track_changes_outlined,
                label: "Historiques",
                isFullPath: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width:240,
                padding: EdgeInsets.all(8),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              CustomMenuButton(
                pathMenu: '/d',
                image: "",
                icon: Icons.language,
                isFullPath: false,
                label: "Français",
              ),
              SizedBox(height: 10,),
              CustomMenuButton(
                pathMenu: '/',
                image: "assets/icons/back.png",
                isFullPath: true,
                icon: Icons.arrow_circle_left_sharp,
                label: "Accueil Général",
              ),
              SizedBox(height: 18),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SwitcherButton(
              //       value: true,
              //       onChange: (value) {
              //         print(value);
              //       },
              //     ),

              //     SizedBox(width: 7,),
              //     Text("Mode Nuit", style: TextStyle(fontSize: 18, color: Colors.black))

              // ],

              // ),
            ],
          ),
        ),
      ),
    );
    
  }
}

class CustomMenuButton extends StatefulWidget {
  final String pathMenu;
  // final bool isExtended;
  final String image;
  final bool isFullPath;
  final String label;
  final IconData icon;
  const CustomMenuButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.pathMenu,
      required this.isFullPath,
      required this.image})
      : super(key: key);

  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  bool _isHovering = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {},
      onHover: (isHovering) {
        setState(() {
          _isHovering = isHovering;
        });
      },
      child: Container(
        width: 260,
        height: 40,
        decoration: BoxDecoration(
            color: isSelected
                ? _isHovering
                    ? const Color(0xFFEEEEEE)
                    : const Color(0xFFE8F0FE)
                : Colors.transparent,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            side: const BorderSide(
              color: Colors.transparent,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              widget.image == ""
                  ? Icon(
                      widget.icon,
                      size: 25,
                      color:
                          isSelected ? const Color(0xFF114693) : Colors.black,
                    )
                  : Image.asset(
                      widget.image,
                      width: 25,
                    ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.label,
                style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? const Color(0xFF114693) : Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
