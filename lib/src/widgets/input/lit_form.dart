import 'package:flutter/material.dart';
import 'package:leitmotif/leitmotif.dart';

/// A Leitmotif `input` widget allowing to display multiple text fields on a
/// column view.
class LitForm extends StatefulWidget {
  /// The submit button's label.
  final String submitLabel;

  /// The data objects the text fields are based on.
  final List<TextFieldData> data;

  /// The inner margin.
  final EdgeInsets margin;

  /// States whether the form passes the validation.
  ///
  /// Validation is optional.
  final bool? inputValid;

  /// Handles the form's `onSubmit` action.
  final void Function() onSubmit;

  /// Creates a [LitForm].
  const LitForm({
    Key? key,
    required this.submitLabel,
    required this.data,
    this.margin = const EdgeInsets.all(16.0),
    this.inputValid,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<LitForm> createState() => _LitFormState();
}

class _LitFormState extends State<LitForm> {
  /// Unfocuses the currently focused text field.
  void _unfocus() => FocusScope.of(context).unfocus();

  List<TextFieldData> get data => widget.data;

  bool get _inputValidAvail => widget.inputValid != null;

  void _onSubmit() {
    if (_inputValidAvail) {
      if (!widget.inputValid!) {
        LitRouteController(context).showDialogWidget(
          InvalidInputDialog(),
        );
      } else {
        widget.onSubmit();
      }
    } else {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _unfocus,
        child: Padding(
          padding: widget.margin,
          child: Center(
            child: LitTitledActionCard(
              child: Builder(
                builder: (context) {
                  final List<Widget> children = [];
                  for (int i = 0; i < widget.data.length; i++) {
                    final item = widget.data[i];
                    children.add(
                      LitTextField(
                        data: TextFieldData(
                          icon: item.icon,
                          label: item.label,
                          invalidHint: item.invalidHint,
                          obscureText: item.obscureText,
                          onChange: item.onChange,
                          onValidate: item.onValidate,
                        ),
                      ),
                    );
                    if (i != data.length - 1) {
                      children.add(
                        LitDivider(),
                      );
                    }
                  }

                  return Column(
                    children: children,
                  );
                },
              ),
              actionButtonData: [
                ActionButtonData(
                  title: widget.submitLabel,
                  onPressed: _onSubmit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
