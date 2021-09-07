import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class ModalSheetDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.0,
      width: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: AllColors.modalSheetLine,
      ),
    );
  }
}
