import 'dart:io';

import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? url;
  final Function? onTap;
  final Function? onImageSelect;

  Avatar({this.url, this.onTap, this.size = 50, this.onImageSelect});

  @override
  Widget build(BuildContext context) {
    final double _avatarSize = size * 0.75;
    final double _editContainerSize = size * 0.22;
    final double _editIconSize = _editContainerSize * 0.6;

    Widget getImage() {
      if (url != null && url!.startsWith("http")) {
        return Image.network(
          url!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );
      }

      if (url != null && !url!.startsWith("http")) {
        File imageFile = File(url as String);

        return Image.file(
          imageFile,
          width: size,
          height: size,
          fit: BoxFit.cover,
        );
      }

      return SvgPicture.asset(
        "assets/icons/default-avatar.svg",
        width: _avatarSize,
        height: _avatarSize,
        fit: BoxFit.cover,
      );
    }

    Future<void> handleImageSelect() async {
      try {
        final ImagePicker _picker = ImagePicker();
        // Pick an image
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);

        if (image != null) {
          onImageSelect!(image);
        }
      } catch (e) {
        print("Error happened");
        print(e);
      }
    }

    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: AbsorbPointer(
              absorbing: onTap == null && onImageSelect == null,
              child: GestureDetector(
                onTap: () {
                  print("here");

                  if (onTap != null) {
                    onTap!();
                  }
                  if (onImageSelect != null) {
                    handleImageSelect();
                  }
                },
                child: Container(
                  color: white,
                  width: size,
                  height: size,
                  alignment: Alignment.center,
                  child: getImage(),
                ),
              ),
            ),
          ),
          if (onImageSelect != null)
            Positioned(
              bottom: _editContainerSize / 4,
              right: _editContainerSize / 4,
              child: Container(
                width: _editContainerSize,
                height: _editContainerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_editContainerSize),
                  color: lightBlue,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/icons/pencil.svg",
                  width: _editIconSize,
                  height: _editIconSize,
                  color: white,
                ),
              ),
            )
        ],
      ),
    );
  }
}
