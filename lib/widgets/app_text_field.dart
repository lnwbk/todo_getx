import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool hideText;

  AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hideText = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hideText;
  @override
  void initState() {
    super.initState();
    _hideText = widget.hideText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 8),

        TextField(
          controller: widget.controller,
          obscureText: _hideText,
          decoration: InputDecoration(
            suffixIcon:
                widget.hideText
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _hideText = !_hideText;
                        });
                      },
                      icon: Icon(
                        _hideText ? Icons.visibility : Icons.visibility_off,
                      ),
                    )
                    : null,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
