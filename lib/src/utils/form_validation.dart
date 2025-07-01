import 'package:flutter/material.dart';

import '../localization/find_translation.dart';
import 'brands.dart';

String formValidation(
    String fieldName,
    TextEditingController cardController,
    String lang,
    ) {
  String fieldText = cardController.text.trim();
  switch (fieldName) {
    case 'cardNumber':
      if (fieldText.isEmpty) {
        return findTranslation(lang, 'begateway_card_number_required');
      } else if (fieldText.length < 19 || findCardBrand(fieldText).name == '') {
        return findTranslation(lang, 'begateway_card_number_invalid');
      }
      break;

    case 'expiration':
      if (fieldText.isEmpty) {
        return findTranslation(lang, 'begateway_expiration_required');
      }
      final expFormat = RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$');
      if (!expFormat.hasMatch(fieldText)) {
        return findTranslation(lang, 'begateway_expiration_invalid');
      }
      final parts = fieldText.split('/');
      final month = int.tryParse(parts[0]) ?? 0;
      final year = int.tryParse(parts[1]) ?? 0;
      final now = DateTime.now();
      final currentMonth = now.month;
      final lastTwoDigitsOfYear = now.year % 100;

      if (month < 1 || month > 12) {
        return findTranslation(lang, 'begateway_expiration_invalid');
      }
      if (year < lastTwoDigitsOfYear ||
          (year == lastTwoDigitsOfYear && month < currentMonth)) {
        return findTranslation(lang, 'begateway_expiration_invalid');
      }
      break;

    case 'cvv':
      if (fieldText.isEmpty) {
        return findTranslation(lang, 'begateway_cvv_required');
      }
      final cvvFormat = RegExp(r'^\d{3,4}$');
      if (!cvvFormat.hasMatch(fieldText)) {
        return findTranslation(lang, 'begateway_cvv_invalid');
      }
      break;

    case 'holderName':
      if (fieldText.isEmpty) {
        return findTranslation(lang, 'begateway_cardholder_name_required');
      }
      final parts = fieldText.split(RegExp(r'\s+'));
      if (parts.length < 2) {
        return findTranslation(lang, 'begateway_cardholder_name_required');
      }
      break;
  }
  return '';
}
