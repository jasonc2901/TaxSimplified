import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smart_select/smart_select.dart';
import 'package:tax_simplified/widgets/rounded_button.dart';
import '../constants.dart';

class NIPreferenceDropdown extends StatefulWidget {
  final Function updateState;
  final Function clearChoice;
  final String value;
  NIPreferenceDropdown(
      {Key? key,
      required this.updateState,
      required this.clearChoice,
      required this.value})
      : super(key: key);

  @override
  State<NIPreferenceDropdown> createState() => _NIPreferenceDropdownState();
}

class _NIPreferenceDropdownState extends State<NIPreferenceDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SmartSelect<String>.single(
          title: 'Please select one',
          value: widget.value,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Text(
                      "Please select one",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: RoundedButtonWidget(
                      color: orangeColor,
                      onPressed: () {
                        state.value = "";
                        widget.clearChoice();
                      },
                      text: "clear",
                      padding: 0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: RoundedButtonWidget(
                      color: Color.fromARGB(255, 33, 167, 40),
                      onPressed: () {
                        state.closeModal(confirmed: true);
                      },
                      text: "confirm",
                      padding: 0,
                    ),
                  ),
                ],
              ),
            );
          },
          choiceItems: ni_dropdown_options,
          onChange: (state) {
            widget.updateState(state.value);
          },
        ),
      ],
    );
  }
}
