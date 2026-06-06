import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlabTechnologyFormField extends StatefulWidget {
  final TextEditingController textEditingController;

  // FormField
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  // TextField properties
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool showCursor;
  final bool autofocus;
  final String? obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final MouseCursor? mouseCursor;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets scrollPadding;
  final Brightness? keyboardAppearance;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Clip clipBehavior;
  final bool canRequestFocus;
  final bool enableIMEPersonalizedLearning;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  const AlabTechnologyFormField({
    super.key,
    required this.textEditingController,
    this.validator,
    this.autovalidateMode,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor = true,
    this.autofocus = false,
    this.obscuringCharacter,
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    this.scrollPadding = const EdgeInsets.all(20),
    this.keyboardAppearance,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.clipBehavior = Clip.hardEdge,
    this.canRequestFocus = true,
    this.enableIMEPersonalizedLearning = true,
    this.undoController,
    this.spellCheckConfiguration,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
  });

  @override
  State<AlabTechnologyFormField> createState() =>
      _AlabTechnologyFormFieldState();
}

class _AlabTechnologyFormFieldState extends State<AlabTechnologyFormField>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  double _shakeCal(double t, double shakeCount, double movePixels) {
    return sin(t * 1 * pi * shakeCount) * movePixels;
  }

  bool _wasError = false;

  void shakeIfNeeded(bool hasError) {
    if (hasError && !_wasError) {
      animationController.forward(from: 0);
    }

    _wasError = hasError;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (animationContext, _) {
        final double shake = _shakeCal(animationController.value, 3, 3);
        return Transform.translate(
          offset: Offset(shake, 0),
          child: _CustomAlabTextFormField(
            shakeIt: shakeIfNeeded,
            validator: widget.validator,
            autovalidateMode:
                widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
            textEditingController: widget.textEditingController,
            textCapitalization: widget.textCapitalization,
            textAlign: widget.textAlign,
            readOnly: widget.readOnly,
            showCursor: widget.showCursor,
            autofocus: widget.autofocus,
            obscuringCharacter: widget.obscuringCharacter ?? "*",
            obscureText: widget.obscureText,
            autocorrect: widget.autocorrect,
            enableSuggestions: widget.enableSuggestions,
            expands: widget.expands,
            enabled: widget.enabled,
            scrollPadding: widget.scrollPadding,
            dragStartBehavior: widget.dragStartBehavior,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            clipBehavior: widget.clipBehavior,
            canRequestFocus: widget.canRequestFocus,
            onTapOutside: widget.onTapOutside,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            decoration: widget.decoration,
            cursorColor: widget.cursorColor,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
          ),
        );
      },
    );
  }
}

class _CustomAlabTextFormField extends FormField<String> {
  final Function(bool) shakeIt;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final MouseCursor? mouseCursor;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final EdgeInsets scrollPadding;
  final Brightness? keyboardAppearance;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final bool? cursorOpacityAnimates;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Clip clipBehavior;
  final bool canRequestFocus;
  final bool enableIMEPersonalizedLearning;
  final UndoHistoryController? undoController;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  _CustomAlabTextFormField({
    super.validator,
    super.autovalidateMode,
    required this.shakeIt,
    required this.textEditingController,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    required this.textCapitalization,
    this.style,
    this.strutStyle,
    required this.textAlign,
    this.textAlignVertical,
    this.textDirection,
    required this.readOnly,
    required this.showCursor,
    required this.autofocus,
    required this.obscuringCharacter,
    required this.obscureText,
    required this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    required this.enableSuggestions,
    this.maxLines,
    this.minLines,
    required this.expands,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    required this.enabled,
    this.mouseCursor,
    this.scrollController,
    this.scrollPhysics,
    required this.scrollPadding,
    this.keyboardAppearance,
    required this.dragStartBehavior,
    required this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    required this.clipBehavior,
    required this.canRequestFocus,
    required this.enableIMEPersonalizedLearning,
    this.undoController,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.contentInsertionConfiguration,
    this.contextMenuBuilder,
  }) : super(
         initialValue: textEditingController.text,
         builder: (state) {
           return SizedBox(
             height: state.hasError ? 70 : 56,
             child: Stack(
               children: [
                 if (state.hasError)
                   Positioned(
                     top: 20,
                     left: 0,
                     right: 0,
                     child: Container(
                       padding: const EdgeInsets.fromLTRB(18, 28, 18, 2),
                       decoration: BoxDecoration(
                         color: const Color.fromARGB(255, 255, 214, 211),
                         borderRadius: BorderRadius.vertical(
                           bottom: Radius.circular(14),
                         ),
                       ),
                       child: Text(
                         state.errorText!,
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w600,
                           color: Colors.red,
                         ),
                       ),
                     ),
                   ),
                 TextField(
                   mouseCursor: mouseCursor,
                   scrollController: scrollController,
                   maxLengthEnforcement: maxLengthEnforcement,
                   smartDashesType: smartDashesType,
                   smartQuotesType: smartQuotesType,
                   scrollPhysics: scrollPhysics,
                   strutStyle: strutStyle,
                   textDirection: textDirection,
                   keyboardAppearance: keyboardAppearance,
                   contextMenuBuilder: contextMenuBuilder,
                   contentInsertionConfiguration: contentInsertionConfiguration,
                   spellCheckConfiguration: spellCheckConfiguration,
                   undoController: undoController,
                   cursorOpacityAnimates: cursorOpacityAnimates,
                   selectionControls: selectionControls,
                   controller: textEditingController,
                   focusNode: focusNode,
                   decoration: decoration,
                   keyboardType: keyboardType,
                   textInputAction: textInputAction,
                   textCapitalization: textCapitalization,
                   style: style,
                   textAlign: textAlign,
                   textAlignVertical: textAlignVertical,
                   readOnly: readOnly,
                   autofocus: autofocus,
                   obscureText: obscureText,
                   obscuringCharacter: obscuringCharacter,
                   autocorrect: autocorrect,
                   enableSuggestions: enableSuggestions,
                   maxLines: maxLines,
                   minLines: minLines,
                   maxLength: maxLength,
                   onChanged: (text) {
                     state.didChange(text);
                     final hassError = validator?.call(text) != null;
                     shakeIt(hassError);
                     if (onChanged != null) {
                       onChanged(text);
                     }
                   },
                   onEditingComplete: onEditingComplete,
                   onSubmitted: onSubmitted,
                   inputFormatters: inputFormatters,
                   enabled: enabled,
                   cursorColor: cursorColor,
                   cursorErrorColor: cursorErrorColor,
                   cursorWidth: cursorWidth ?? 2,
                   cursorHeight: cursorHeight,
                   magnifierConfiguration: magnifierConfiguration,
                   cursorRadius: cursorRadius,
                   onTap: onTap,
                   onTapOutside: (event) {
                     if (onTapOutside != null) {
                       final hassError =
                           validator?.call(
                             textEditingController.text.isEmpty
                                 ? null
                                 : textEditingController.text,
                           ) !=
                           null;
                       debugPrint("OnTapOutside : $hassError");
                       shakeIt(hassError);
                       onTapOutside(event);
                     }
                   },
                 ),
               ],
             ),
           );
         },
       );
}
