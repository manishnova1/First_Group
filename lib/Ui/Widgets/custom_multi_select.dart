import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../data/model/toc_selected_model.dart';
import 'PrimaryButton.dart';
import 'SecondryButton.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow(
      {Key? key,
      required this.onChange,
      required this.selected,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
      child: Container(
        height: kMinInteractiveDimension,
        child: Row(
          children: [
            Checkbox(
                value: selected,
                onChanged: (x) {
                  onChange(x!);
                  _theState.notify();
                }),
            Text(text)
          ],
        ),
      ),
    );
  }
}

///
/// A Dropdown multiselect menu
///
///
class CustomDropDownMultiSelect extends StatefulWidget {
  /// The options form which a user can select
  final List<TocSelectedModel> options;

  /// Selected Values
  final List<TocSelectedModel> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<TocSelectedModel>) onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// Input decoration
  final InputDecoration? decoration;

  /// this text is shown when there is no selection
  final TocSelectedModel? whenEmpty;

  /// a function to build custom childern
  final Widget Function(List<TocSelectedModel> selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(TocSelectedModel option)? menuItembuilder;

  /// a function to validate
  final TocSelectedModel Function(String? selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  /// icon shown on the right side of the field
  final Widget? icon;

  /// Textstyle for the hint
  final TextStyle? hintStyle;

  /// hint to be shown when there's nothing else to be shown
  final Widget? hint;

  const CustomDropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.whenEmpty,
    this.icon,
    this.hint,
    this.hintStyle,
    this.childBuilder,
    this.menuItembuilder,
    this.isDense = true,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomDropDownMultiSelectState createState() =>
      _CustomDropDownMultiSelectState();
}

class _CustomDropDownMultiSelectState extends State<CustomDropDownMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _theState.rebuild(() => widget.childBuilder != null
              ? widget.childBuilder!(widget.selectedValues)
              : Padding(
                  padding: widget.decoration != null
                      ? widget.decoration!.contentPadding != null
                          ? widget.decoration!.contentPadding!
                          : EdgeInsets.symmetric(horizontal: 10)
                      : EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(widget.whenEmpty?.toc_name ?? ""),
                  ))),
          Container(
            child: Theme(
              data: Theme.of(context).copyWith(),
              child: DropdownButtonFormField<TocSelectedModel>(
                hint: widget.hint,
                style: widget.hintStyle,
                icon: widget.icon,
                decoration: widget.decoration != null
                    ? widget.decoration
                    : InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                isDense: widget.isDense,
                onChanged: widget.enabled ? (x) {} : null,
                isExpanded: false,
                value: widget.selectedValues.length > 1
                    ? widget.selectedValues[1]
                    : null,
                selectedItemBuilder: (context) {
                  return widget.options
                      .map((e) => DropdownMenuItem(
                            child: Container(),
                          ))
                      .toList();
                },
                items: widget.options
                    .map(
                      (x) => DropdownMenuItem<TocSelectedModel>(
                        enabled: x.toc_name == null ? false : true,
                        value: x,
                        onTap: !widget.readOnly
                            ? () {
                                if (widget.selectedValues.contains(x)) {
                                  var ns = widget.selectedValues;
                                  ns.remove(x);
                                  widget.onChanged(ns);
                                } else {
                                  var ns = widget.selectedValues;
                                  ns.add(x);
                                  widget.onChanged(ns);
                                }
                              }
                            : null,
                        child: _theState.rebuild(() {
                          return widget.menuItembuilder != null
                              ? widget.menuItembuilder!(x)
                              : x.toc_controls != null
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: SecondryButton(
                                              title: "Clear",
                                              onAction: () {
                                                widget.onChanged([]);
                                                Navigator.pop(context);
                                              }),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: PrimaryButton(
                                              title: "Select",
                                              onAction: () {
                                                //   widget.onChanged();

                                                Navigator.pop(context);
                                              }),
                                        ),
                                      ],
                                    )
                                  : x.toc_heading != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          child: Text(x.toc_heading ?? '',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                        )
                                      : _SelectRow(
                                          selected:
                                              widget.selectedValues.contains(x),
                                          text: x.toc_name.toString(),
                                          onChange: (isSelected) {
                                            if (isSelected) {
                                              var ns = widget.selectedValues;
                                              ns.add(x);
                                              widget.onChanged(ns);
                                            } else {
                                              var ns = widget.selectedValues;
                                              ns.remove(x);
                                              widget.onChanged(ns);
                                            }
                                          },
                                        );
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
