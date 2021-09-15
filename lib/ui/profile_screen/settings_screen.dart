// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/ui/widgets/modal_sheet_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DateTime selectedDate = DateTime(1990);
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _notificationSales = false;
  bool _notificationNewArrivals = false;
  bool _notificationDeliveryStatus = false;

  //DateFormat format = DateFormat("dd/MM/yyyy");

  // void _selectDate(BuildContext context) async {
  //   final DateTime? selected = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(1990),
  //     firstDate: DateTime(1960),
  //     lastDate: DateTime(2006),
  //   );
  //   if (selected != null && selected != selectedDate)
  //     setState(() {
  //       selectedDate = selected;
  //     });
  // }

  void _showDatePicker(ctx) {
    //print(format.parse(_dateController.text));
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate.isAfter(DateTime(2007))
                    ? DateTime(1990)
                    : selectedDate,
                minimumDate: DateTime(1960),
                maximumDate: DateTime(2006),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    selectedDate = val;
                  });
                },
              ),
            ),
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () {
                _dateController.text =
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AllColors.appBackgroundColor,
        elevation: 0,
        shadowColor: AllColors.black.withOpacity(0.25),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AllColors.dark),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const SizedBox(
            width: 24,
            height: 24,
            child: Icon(CupertinoIcons.back),
          ),
        ),
        leadingWidth: 40,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              color: AllColors.dark,
              size: 26,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: AllStyles.headlineActive,
              ),
              const SizedBox(height: 23),
              const Text(
                'Personal Information',
                style: AllStyles.dark16w600,
              ),
              const SizedBox(height: 23),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 4),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    errorStyle: AllStyles.bigTextFieldError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: AllColors.white,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
                    hintText: 'Full name',
                    hintStyle: AllStyles.gray14,
                  ),
                  style: const TextStyle(
                    color: AllColors.bigTextFieldTextColor,
                    fontFamily: AllStrings.fontFamily,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.bottom,
                ),
              ),
              const SizedBox(height: 23),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                      onTap: () async {
                        //_selectDate(context);
                        _showDatePicker(context);
                      },
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      obscureText: false,
                      //readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        errorStyle: AllStyles.bigTextFieldError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AllColors.white,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 38, 24, 18),
                      ),
                      style: const TextStyle(
                        color: AllColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                    ),
                  ),
                  const Positioned(
                    left: 18,
                    top: 16,
                    child: Text(
                      'Date of Birth',
                      style: AllStyles.gray11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Password',
                    style: AllStyles.dark16w600,
                  ),
                  const Text(
                    'Change',
                    style: AllStyles.gray14w500,
                  ),
                ],
              ),
              const SizedBox(height: 21),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      obscureText: true,
                      //readOnly: true,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        errorStyle: AllStyles.bigTextFieldError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AllColors.white,
                        filled: true,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 38, 24, 18),
                      ),
                      style: const TextStyle(
                        color: AllColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.bottom,
                    ),
                  ),
                  const Positioned(
                    left: 18,
                    top: 16,
                    child: Text(
                      'Password',
                      style: AllStyles.gray11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              const Text(
                'Notifications',
                style: AllStyles.dark16w600,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sales',
                    style: AllStyles.dark14w500,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _notificationSales = !_notificationSales;
                  //     });
                  //   },
                  //   child: SvgPicture.asset(
                  //     _notificationSales
                  //         ? 'assets/icons/switch_on.svg'
                  //         : 'assets/icons/switch_off.svg',
                  //   ),
                  // ),
                  Platform.isIOS
                      ? CupertinoSwitch(
                          value: _notificationSales,
                          onChanged: (val) {
                            setState(() {
                              _notificationSales = val;
                            });
                          },
                        )
                      : Switch(
                          value: _notificationSales,
                          onChanged: (val) {
                            setState(() {
                              _notificationSales = val;
                            });
                          },
                        ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'New arrivals',
                    style: AllStyles.dark14w500,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _notificationNewArrivals = !_notificationNewArrivals;
                  //     });
                  //   },
                  //   child: SvgPicture.asset(
                  //     _notificationNewArrivals
                  //         ? 'assets/icons/switch_on.svg'
                  //         : 'assets/icons/switch_off.svg',
                  //   ),
                  // ),
                  Platform.isIOS
                      ? CupertinoSwitch(
                          value: _notificationNewArrivals,
                          onChanged: (val) {
                            setState(() {
                              _notificationNewArrivals = val;
                            });
                          },
                        )
                      : Switch(
                          value: _notificationNewArrivals,
                          onChanged: (val) {
                            setState(() {
                              _notificationNewArrivals = val;
                            });
                          },
                        ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Delivery status changes',
                    style: AllStyles.dark14w500,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _notificationDeliveryStatus = !_notificationDeliveryStatus;
                  //     });
                  //   },
                  //   child: SvgPicture.asset(
                  //     _notificationDeliveryStatus
                  //         ? 'assets/icons/switch_on.svg'
                  //         : 'assets/icons/switch_off.svg',
                  //   ),
                  // ),
                  Platform.isIOS
                      ? CupertinoSwitch(
                          value: _notificationDeliveryStatus,
                          onChanged: (val) {
                            setState(() {
                              _notificationDeliveryStatus = val;
                            });
                          },
                        )
                      : Switch(
                          value: _notificationDeliveryStatus,
                          onChanged: (val) {
                            setState(() {
                              _notificationDeliveryStatus = val;
                            });
                          },
                        ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

void sortingTypeSheet(BuildContext context, Function onPress) {
  showModalBottomSheet(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: AllColors.appBackgroundColor,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          height: 352,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalSheetDivider(),
              const SizedBox(height: 16),
              const Text(
                'Sort by',
                style: AllStyles.dark18w600,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      });
}
