import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// Custom widget for input

// ignore: must_be_immutable
class InputType extends StatefulWidget {
  InputType({
    super.key,
    this.controller,
    this.validator,
    //this.multiSelectKey,
    required this.type,
    required this.inputType,
    required this.placeholder,
    required this.mustBeFilled,
    this.passwordVisible = false,
    this.dropdownList = const [DropdownMenuEntry(value: null, label: '')],
    this.multiselectList = const [DropdownMenuEntry(value: 1, label: '')],
    this.dropdownWidth,
    this.calendarStart,
    this.calendarEnd,
    //required this.action,
    //required this.onSubmitted
  });
  TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  //final GlobalKey<MultiSelect>? multiSelectKey;
  final String type;
  final TextInputType inputType;
  final String placeholder;
  final bool mustBeFilled;
  final List<DropdownMenuEntry> dropdownList;
  final List<DropdownMenuEntry> multiselectList;
  bool passwordVisible;
  double? dropdownWidth;
  DateTime? calendarStart;
  DateTime? calendarEnd;
  //final TextInputAction action;
  //final void Function(String) onSubmitted;

  @override
  State<InputType> createState() => _InputTypeState();
}

class _InputTypeState extends State<InputType> {
  List<DateTime?> _dates = [DateTime.now()];
  
  @override
  Widget build(BuildContext context) {
    final items = widget.multiselectList
        .map((option) =>
            MultiSelectItem<DropdownMenuEntry>(option, option.label))
        .toList();
    widget.dropdownWidth ?? context.width;
    widget.calendarStart ?? DateTime.now();
    widget.calendarEnd ?? DateTime(2026);
    // ignore: unused_local_variable
    List<Object?> selectedItems = [];

    return widget.type == "one-line"
        ? TextFormField(
            controller: widget.controller,
            validator: widget.validator ?? (value) {return null;},
            keyboardType: widget.inputType,
            //textInputAction: action,
            obscureText: false,
            showCursor: true,
            cursorColor: red5,
            cursorErrorColor: red5,
            maxLines: 1,
            //onSubmitted: onSubmitted,
            style: tParagraph.copyWith(color: black),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: blue7, width: 1)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: blue7, width: 2)),
              labelText: widget.placeholder,
              labelStyle: tInput.copyWith(color: blue7),
              floatingLabelStyle: tInputSmall.copyWith(color: blue7),
              filled: true,
              fillColor: offwhite1,
              focusColor: grey2,
              contentPadding: const EdgeInsets.all(8),
              alignLabelWithHint: false,
              errorMaxLines: 2,
              errorStyle: tInput.copyWith(color: red5),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: red5, width: 1)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: red5, width: 2)),
            ))
        : widget.type == "password"
            ? TextFormField(
                controller: widget.controller,
                validator: widget.validator ?? (value) {return null;},
                keyboardType: TextInputType.visiblePassword,
                //textInputAction: action,
                obscureText: !widget.passwordVisible,
                showCursor: true,
                cursorColor: red5,
                cursorErrorColor: red5,
                maxLines: 1,
                //onSubmitted: onSubmitted,
                style: tParagraph.copyWith(color: black),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: blue7, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blue7, width: 2)),
                  labelText: widget.placeholder,
                  labelStyle: tInput.copyWith(color: blue7),
                  floatingLabelStyle: tInputSmall.copyWith(color: blue7),
                  suffixIcon: IconButton(
                      icon: Icon(
                          widget.passwordVisible
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          color: blue7,
                          size: 20),
                      onPressed: () => {
                            setState(() {
                              widget.passwordVisible = !widget.passwordVisible;
                            })
                          }),
                  filled: true,
                  fillColor: offwhite1,
                  focusColor: grey2,
                  contentPadding: const EdgeInsets.all(8),
                  alignLabelWithHint: false,
                  errorMaxLines: 2,
                  errorStyle: tInput.copyWith(color: red5),
                  errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: red5, width: 1)),
                  focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: red5, width: 2)),
                ))
            : widget.type == "dropdown"
                ? DropdownMenu(
                    controller: widget.controller,
                    width: widget.dropdownWidth,
                    label: Text(widget.placeholder),
                    enableFilter: true,
                    requestFocusOnTap: true,
                    textStyle: tParagraph.copyWith(color: black),
                    inputDecorationTheme: InputDecorationTheme(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: blue7, width: 1)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blue7, width: 2)),
                      labelStyle: tInput.copyWith(color: blue7),
                      floatingLabelStyle: tInputSmall.copyWith(color: blue7),
                      filled: true,
                      fillColor: offwhite1,
                      focusColor: grey2,
                      contentPadding: const EdgeInsets.all(8),
                      alignLabelWithHint: false,
                      errorMaxLines: 2,
                      errorStyle: tInput.copyWith(color: red5),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: red5, width: 1)),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: red5, width: 2)),
                    ),
                    trailingIcon: Icon(CupertinoIcons.chevron_down,
                        color: blue7, size: 20),
                    selectedTrailingIcon:
                        Icon(CupertinoIcons.chevron_up, color: blue7, size: 20),
                    //menuStyle: MenuStyle(
                    //  backgroundColor:,
                    //),
                    dropdownMenuEntries: widget.dropdownList,
                  )
                : widget.type == "text-area"
                    ? TextFormField(
                        controller: widget.controller,
                        validator: widget.validator ?? (value) {return null;},
                        keyboardType: TextInputType.multiline,
                        //textInputAction: action,
                        obscureText: false,
                        showCursor: true,
                        cursorColor: red5,
                        cursorErrorColor: red5,
                        maxLines: null,
                        //onSubmitted: onSubmitted,
                        style: tParagraph.copyWith(color: black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: blue7, width: 1)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: blue7, width: 2)),
                          labelText: widget.placeholder,
                          labelStyle: tInput.copyWith(color: blue7),
                          floatingLabelStyle:
                              tInputSmall.copyWith(color: blue7),
                          filled: true,
                          fillColor: offwhite1,
                          focusColor: grey2,
                          contentPadding: const EdgeInsets.all(8),
                          alignLabelWithHint: false,
                          errorMaxLines: 2,
                          errorStyle: tInput.copyWith(color: red5),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: red5, width: 1)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: red5, width: 2)),
                        ))
                    : widget.type == "calendar"
                        ? TextFormField(
                            controller: widget.controller,
                            validator: widget.validator ?? (value) {return null;},
                            keyboardType: TextInputType.datetime,
                            showCursor: true,
                            cursorColor: red5,
                            cursorErrorColor: red5,
                            maxLines: 1,
                            style: tParagraph.copyWith(color: black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: blue7, width: 1)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: blue7, width: 2)),
                              labelText: widget.placeholder,
                              labelStyle: tInput.copyWith(color: blue7),
                              floatingLabelStyle:
                                  tInputSmall.copyWith(color: blue7),
                              suffixIcon: IconButton(
                                  icon: Icon(CupertinoIcons.calendar,
                                      color: blue7, size: 20),
                                  onPressed: () => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Dialog(
                                                    child:
                                                        CalendarDatePicker2WithActionButtons(
                                                  config: CalendarDatePicker2WithActionButtonsConfig(
                                                      calendarType: CalendarDatePicker2Type
                                                          .single,
                                                      firstDate:
                                                          widget.calendarStart,
                                                      lastDate:
                                                          widget.calendarEnd,
                                                      weekdayLabelTextStyle:
                                                          tParagraph.copyWith(
                                                              color: black),
                                                      lastMonthIcon:
                                                          Icon(CupertinoIcons.chevron_left,
                                                              color: black,
                                                              size: 24),
                                                      nextMonthIcon:
                                                          Icon(CupertinoIcons.chevron_right,
                                                              color: black,
                                                              size: 24),
                                                      customModePickerIcon:
                                                          const SizedBox(),
                                                      controlsTextStyle:
                                                          tParagraph.copyWith(
                                                              color: black),
                                                      centerAlignModePicker:
                                                          true,
                                                      dayTextStyle: tParagraph.copyWith(
                                                          color: grey8),
                                                      todayTextStyle: tParagraph
                                                          .copyWith(color: grey8),
                                                      disabledDayTextStyle: tParagraph.copyWith(color: grey3),
                                                      selectedDayTextStyle: tParagraph.copyWith(color: white1),
                                                      selectedDayHighlightColor: blue7,
                                                      daySplashColor: blue7,
                                                      yearTextStyle: tParagraph.copyWith(color: grey8),
                                                      selectedYearTextStyle: tParagraph.copyWith(color: white1)),
                                                  value: _dates,
                                                  onValueChanged: (dates) => {
                                                    setState(() {
                                                      _dates = dates;
                                                      var date = dates[0];
                                                      if(date != null) widget.controller!.text = DateFormat('dd-MM-yyyy').format(date);
                                                    })
                                                  },
                                                  onCancelTapped: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  onOkTapped: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                )))
                                      }),
                              filled: true,
                              fillColor: offwhite1,
                              focusColor: grey2,
                              contentPadding: const EdgeInsets.all(8),
                              alignLabelWithHint: false,
                              errorMaxLines: 2,
                              errorStyle: tInput.copyWith(color: red5),
                              errorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: red5, width: 1)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: red5, width: 2)),
                            ))
                        :
                        // widget.type == multi-select
                        Container(
                            decoration: BoxDecoration(
                              color: offwhite1,
                              border: Border(
                                  bottom: BorderSide(color: blue7, width: 1)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Text(widget.placeholder,
                                      style: tInputSmall.copyWith(
                                          fontSize: 11, color: blue7)),
                                ),
                                MultiSelectChipField(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: offwhite1)),
                                  chipShape: RoundedRectangleBorder(
                                      side: BorderSide(color: grey8, width: 1),
                                      borderRadius: BorderRadius.circular(100)),
                                  selectedChipColor: blue4ltrans,
                                  textStyle: tParagraph.copyWith(color: grey8),
                                  selectedTextStyle:tParagraph.copyWith(color: black),
                                  onTap: (values) {
                                    selectedItems = values;
                                  },
                                  scroll: false,
                                  showHeader: false,
                                  items: items,
                                  initialValue: const [],
                                ),
                              ],
                            ),
                          );
  }
}

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x59223944),
            spreadRadius: 0,
            blurRadius: 30,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          //textInputAction: action,
          obscureText: false,
          showCursor: true,
          cursorColor: red5,
          cursorErrorColor: red5,
          maxLines: 1,
          //onSubmitted: onSubmitted,
          style: tParagraph.copyWith(color: black),
          decoration: InputDecoration(
            prefixIcon: Icon(CupertinoIcons.search, color: blue7, size: 20),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(0, 0, 0, 0), width: 0),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(0, 0, 0, 0), width: 0),
                borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(0, 0, 0, 0), width: 0),
                borderRadius: BorderRadius.circular(20)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(0, 0, 0, 0), width: 0),
                borderRadius: BorderRadius.circular(20)),
            labelText: 'Search...',
            labelStyle: tInput.copyWith(color: blue7),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: true,
            fillColor: offwhite1,
            focusColor: grey2,
            contentPadding: const EdgeInsets.all(8),
          )),
    );
  }
}