import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomMenuItem extends StatefulWidget {
  const BottomMenuItem({
    Key? key,
    required this.assetName,
    required this.callback,
    required this.title,
    required this.screenNumber,
    required this.activeScreen,
  }) : super(key: key);

  final String assetName;
  final Function callback;
  final String title;
  final int screenNumber;
  final int activeScreen;

  @override
  _BottomMenuItemState createState() => _BottomMenuItemState();
}

class _BottomMenuItemState extends State<BottomMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(widget.screenNumber);
      },
      child: SizedBox(
        //! old value width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
                'assets/icons/menu_${widget.assetName}_${widget.activeScreen == widget.screenNumber ? 'active' : 'inactive'}.svg'),
            const SizedBox(height: 5),
            Text(
              widget.title,
              style: widget.activeScreen == widget.screenNumber
                  ? AllStyles.primary11
                  : AllStyles.gray11,
            ),
          ],
        ),
      ),
    );
  }
}
