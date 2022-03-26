import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_select/smart_select.dart';
import 'package:tax_simplified/widgets/rounded_button_no_padding.dart';

import '../constants.dart';

class NIPreferenceDropdown extends StatefulWidget {
  final Function updateState;
  final Function clearChoice;
  NIPreferenceDropdown(
      {Key? key, required this.updateState, required this.clearChoice})
      : super(key: key);

  @override
  State<NIPreferenceDropdown> createState() => _NIPreferenceDropdownState();
}

class _NIPreferenceDropdownState extends State<NIPreferenceDropdown> {
  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'ion', title: 'Ionic'),
    S2Choice<String>(value: 'flu', title: 'Flutter'),
    S2Choice<String>(value: 'rea', title: 'React Native'),
  ];

  var value = '';
  Future<void> updateDropdown(dropdownVal) async {
    widget.updateState(dropdownVal);
  }

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.single(
      title: 'Please select one',
      value: value,
      modalType: S2ModalType.bottomSheet,
      modalConfig: const S2ModalConfig(
        style: S2ModalStyle(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
        ),
      ),
      modalConfirm: true,
      modalHeaderBuilder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            color: darkPurple,
          ),
          height: kToolbarHeight * 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: RoundedButtonNoPaddingWidget(
                  color: orangeColor,
                  onPressed: () {
                    widget.clearChoice();
                  },
                  text: "clear",
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: RoundedButtonNoPaddingWidget(
                  color: Color.fromARGB(255, 33, 167, 40),
                  onPressed: () {
                    setState(() {
                      value = state.value;
                      updateDropdown(value);
                      state.closeModal(confirmed: true);
                    });
                  },
                  text: "confirm",
                ),
              ),
            ],
          ),
        );
      },
      choiceItems: options,
      onChange: (state) => {},
    );
  }
}
