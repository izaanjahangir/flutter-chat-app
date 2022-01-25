import 'package:chat_app/config/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Avatar extends StatelessWidget {
  final double _size = 50;
  final String? url;
  final Function? onTap;

  Avatar({this.url, this.onTap});

  @override
  Widget build(BuildContext context) {
    final double _avatarSize = _size * 0.75;

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(_size),
      child: AbsorbPointer(
        absorbing: onTap == null,
        child: GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Container(
            color: url != null ? Colors.transparent : white,
            width: _size,
            height: _size,
            alignment: Alignment.center,
            child: getImage(),
          ),
        ),
      ),
    );
  }
}
