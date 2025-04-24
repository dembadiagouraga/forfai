import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'helper.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  factory CurrencyTextInputFormatter(
    NumberFormat format, {
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    num? minValue,
    num? maxValue,
    Function(String)? onChange,
  }) {
    return CurrencyTextInputFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
    );
  }

  CurrencyTextInputFormatter._(
    this.format,
    this.enableNegative,
    this.inputDirection,
    this.minValue,
    this.maxValue,
    this.onChange,
  );

  factory CurrencyTextInputFormatter.currency({
    bool turnOffGrouping = false,
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    num? minValue,
    num? maxValue,
    Function(String)? onChange,
  }) {
    final NumberFormat format = AppHelpers.format();

    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    return CurrencyTextInputFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
    );
  }

  factory CurrencyTextInputFormatter.simpleCurrency({
    String? locale,
    String? name,
    int decimalDigits = 0,
    bool turnOffGrouping = false,
    bool enableNegative = true,
    InputDirection inputDirection = InputDirection.right,
    num? minValue,
    num? maxValue,
    Function(String)? onChange,
  }) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: '',
      decimalDigits: decimalDigits,
    );

    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    return CurrencyTextInputFormatter._(
      format,
      enableNegative,
      inputDirection,
      minValue,
      maxValue,
      onChange,
    );
  }

   NumberFormat format =AppHelpers.format();
  final bool enableNegative;
  final InputDirection inputDirection;
  final num? minValue;
  final num? maxValue;
  final Function(String)? onChange;

  num _newNum = 0;
  String _newString = '';
  bool _isNegative = false;

  NumberFormat get numberFormat => format;

  void _formatter(String newText) {
    _newNum = _parseStrToNum(newText);
    _newString = (_isNegative ? '-' : '') + format.format(_newNum).trim();
  }

  num _parseStrToNum(String text) {
    num value = num.tryParse(text) ?? 0;
    if (format.decimalDigits! > 0) {
      value /= pow(10, format.decimalDigits!);
    }
    return value;
  }

  bool _isLessThanMinValue(num value) {
    if (minValue == null) {
      return false;
    }
    return value < minValue!;
  }

  bool _isMoreThanMaxValue(num value) {
    if (maxValue == null) {
      return false;
    }
    return value > maxValue!;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool isLeft = inputDirection == InputDirection.left;
    if (isLeft) {
      final List<String> nums = newValue.text.split('.');
      if (nums.length > 2) {
        return oldValue;
      }
      if (nums.length == 2 && (nums[1].length > (format.decimalDigits ?? 2))) {
        return oldValue;
      }
      final double? v = double.tryParse(newValue.text);
      if (v == null) {
        return oldValue;
      }
      if (_isLessThanMinValue(v) || _isMoreThanMaxValue(v)) {
        return oldValue;
      }
      _newNum = v;
      _newString = newValue.text;
      return newValue;
    }

    final bool isRemovedCharacter =
        oldValue.text.length - 1 == newValue.text.length &&
            oldValue.text.startsWith(newValue.text);

    if (enableNegative) {
      _isNegative = newValue.text.startsWith('-');
    } else {
      _isNegative = false;
    }

    String newText = newValue.text.replaceAll(RegExp('[^0-9]'), '');
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    final num value = _parseStrToNum(newText);

    if (_isLessThanMinValue(value) || _isMoreThanMaxValue(value)) {
      return oldValue;
    }

    _formatter(newText);

    if (newText.trim() == '' || newText == '00' || newText == '000') {
      return TextEditingValue(
        text: _isNegative ? '-' : '',
        selection: TextSelection.collapsed(offset: _isNegative ? 1 : 0),
      );
    }

    if (onChange != null) {
      onChange!(_newString);
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp('[0-9]').hasMatch(lastChar);
  }

  String getFormattedValue() {
    return _newString;
  }

  num getUnformattedValue() {
    return _isNegative ? (_newNum * -1) : _newNum;
  }

  String formatString(String value) {
    if (enableNegative) {
      _isNegative = value.startsWith('-');
    } else {
      _isNegative = false;
    }
    final String newText = value.replaceAll(RegExp('[^0-9]'), '');
    _formatter(newText);
    return _newString;
  }

  String formatDouble(double value) {
    if (enableNegative) {
      _isNegative = value.isNegative;
    } else {
      _isNegative = false;
    }

    final String newText = value
        .toStringAsFixed(format.decimalDigits ?? 0)
        .replaceAll(RegExp('[^0-9]'), '');
    _formatter(newText);
    return _newString;
  }

  double getDouble() {
    return getUnformattedValue().toDouble();
  }
}

enum InputDirection { left, right }
