part of 'custom_dropdown.dart';

class _DropDownField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final String? hintText;
  final String? label;
  final String? Function(String?)? validator;

  const _DropDownField({
    required this.controller,
    required this.onTap,
    this.hintText,
    this.label,
    this.validator,
  });

  @override
  State<_DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<_DropDownField> {
  String? prevText;
  bool listenChanges = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listenItemChanges);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listenItemChanges);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DropDownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.controller.addListener(listenItemChanges);
  }

  void listenItemChanges() {
    if (listenChanges) {
      prevText = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(builder: (colors, controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: REdgeInsets.only(right: 6, bottom: 4),
              child: Text(
                "${AppHelpers.getTranslation(widget.label ?? '')} ${widget.validator != null ? '*' : ''}",
                style:
                    CustomStyle.interNormal(size: 14, color: colors.textBlack),
              ),
            ),
          TextFormField(
            controller: widget.controller,
            readOnly: true,
            onTap: widget.onTap,
            validator: widget.validator,
            style: CustomStyle.interNormal(size: 14, color: colors.textBlack),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: widget.controller.text.isNotEmpty &&
                        widget.validator == null
                    ? () {
                        widget.controller.clear();
                        setState(() {});
                      }
                    : null,
                icon: Icon(
                  widget.controller.text.isNotEmpty && widget.validator == null
                      ? Remix.close_line
                      : Remix.arrow_down_s_line,
                  color: colors.textBlack,
                  size: 18.r,
                ),
              ),
              contentPadding:
                  REdgeInsets.symmetric(horizontal: 12, vertical: 16),
              hintText: AppHelpers.getTranslation(widget.hintText ?? ''),
              hintStyle: CustomStyle.interNormal(
                size: 14,
                color: CustomStyle.textHint,
              ),
              hoverColor: CustomStyle.transparent,
              fillColor: colors.transparent,
              enabledBorder: _border(colors.border),
              errorBorder: _border(colors.border),
              border: _border(colors.border),
              focusedErrorBorder: _border(colors.border),
              disabledBorder: _border(colors.border),
              focusedBorder: _border(colors.border),
            ),
          ),
        ],
      );
    });
  }

  _border(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide.merge(
          BorderSide(color: color),
          BorderSide(color: color),
        ),
        borderRadius: BorderRadius.circular(AppConstants.radius.r));
  }
}
