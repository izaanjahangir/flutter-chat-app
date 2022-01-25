import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      if (url != null) {
        return Image.network(
          url!,
          width: _avatarSize,
          height: _avatarSize,
        );
      }

      return SvgPicture.asset(
        "assets/icons/default-avatar.svg",
        width: _avatarSize,
        height: _avatarSize,
      );
    }

    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(size),
            child: AbsorbPointer(
              absorbing: onTap == null,
              child: GestureDetector(
                onTap: () {
                  onTap!();
                },
                child: Container(
                  color: url != null ? Colors.transparent : white,
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
