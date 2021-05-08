import 'package:flutter/material.dart';
import 'package:lit_ui_kit/styles.dart';
import 'package:lit_ui_kit/utility.dart';

class LitTextField extends StatefulWidget {
  final String label;
  final bool initialObsureTextValue;
  final bool allowObscuredText;
  final IconData? icon;
  final Function(String value) onChange;
  const LitTextField({
    Key? key,
    required this.label,
    this.initialObsureTextValue = false,
    this.allowObscuredText = false,
    this.icon,
    required this.onChange,
  }) : super(key: key);

  @override
  _LitInputAreaState createState() => _LitInputAreaState();
}

class _LitInputAreaState extends State<LitTextField> {
  final FocusNode _focus = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  String get _textInput {
    return _textEditingController.value.text;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      widget.onChange(_textInput);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.icon != null
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8.0,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(-2, 2),
                                color: Colors.black26,
                                blurRadius: 4.0,
                                spreadRadius: -2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              widget.icon,
                              color: LitColors.beigeGrey,
                              size: 17.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                      ],
                    )
                  : SizedBox(),
              Text(
                "${widget.label}".toUpperCase(),
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#A9A8A8'),
                  letterSpacing: 0.25,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: EditableText(
                cursorColor: Colors.grey,
                backgroundCursorColor: Colors.black,
                controller: _textEditingController,
                focusNode: _focus,
                textAlign: TextAlign.left,
                cursorRadius: Radius.circular(2.0),
                style: LitTextStyles.sansSerif.copyWith(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                  color: HexColor('#444444'),
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
