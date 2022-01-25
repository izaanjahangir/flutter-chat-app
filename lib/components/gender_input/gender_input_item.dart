import 'package:chat_app/config/theme_sizes.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class GenderInputItem extends StatelessWidget {
  final String type;
  final Function onSelect;
  final bool selected;
  late final String iconPath;

  GenderInputItem(
      {required this.type, required this.onSelect, this.selected = false});

  @override
  Widget build(BuildContext context) {
    iconPath =
        type == "male" ? "assets/icons/male.svg" : "assets/icons/female.svg";

    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: TouchableOpacity(
        onTap: () {
          onSelect(type);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          color: selected ? lightBlue : white,
          width: 50,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: small_space),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 25,
                height: 25,
                color: selected ? white : black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
