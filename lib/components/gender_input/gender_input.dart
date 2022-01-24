import 'package:chat_app/components/gender_input/gender_input_item.dart';
import 'package:chat_app/config/theme_colors.dart';
import 'package:chat_app/config/theme_sizes.dart';
import 'package:flutter/material.dart';

class GenderInput extends StatefulWidget {
  @override
  State<GenderInput> createState() => _GenderInputState();
}

class _GenderInputState extends State<GenderInput> {
  String? selectedGender;

  void handleGenderSelect(String newGender) {
    setState(() {
      selectedGender = newGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select your gender",
            style: TextStyle(color: white, fontSize: normal_font),
          ),
          SizedBox(
            height: normal_space,
          ),
          Row(
            children: [
              GenderInputItem(
                selected: selectedGender == "male",
                onSelect: handleGenderSelect,
                type: "male",
              ),
              SizedBox(
                width: normal_space,
              ),
              GenderInputItem(
                selected: selectedGender == "female",
                onSelect: handleGenderSelect,
                type: "female",
              )
            ],
          ),
        ],
      ),
    );
  }
}
