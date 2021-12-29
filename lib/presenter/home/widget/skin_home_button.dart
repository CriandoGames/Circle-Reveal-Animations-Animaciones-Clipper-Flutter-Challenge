import 'package:circle_reveal_animations_animaciones/domain/entities/skins/skin.dart';
import 'package:flutter/material.dart';

class SkinHomeButton extends StatelessWidget {
  final Skin skin;
  final VoidCallback onPressed;
  final bool selected;
  const SkinHomeButton({ Key? key,required this.skin,required this.onPressed,  this.selected = false }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return InkWell(
         borderRadius: BorderRadius.circular(25),
         onTap: onPressed,
         child: Container(
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             border: Border.all(
               color: Colors.white,
               width: selected ? 5.0 : 1,
             ),
           ),
           child: DecoratedBox(
             decoration: BoxDecoration(
               shape: BoxShape.circle,
               color: Color(skin.color),
             ),
           ),
         ),
       );
  }
}