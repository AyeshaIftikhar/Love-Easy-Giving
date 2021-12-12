import 'package:flutter/material.dart';

var currencyDrop =[
  CurrencyModel(
    label: 'GBP', 
    ucode: '0x00A3', 
    value: 'GBP'
  ),
  CurrencyModel(
    label: 'USD', 
    ucode: '0x0024', 
    value: 'USD'
  ),
  CurrencyModel(
    label: 'EUR', 
    ucode: '0x20AC', 
    value: 'EUR'
  ),
  CurrencyModel(
    label: 'AUD', 
    ucode: '0x00024', 
    value: 'AUD'
  ),
  CurrencyModel(
    label: 'BDT', 
    ucode: '0x09F3', 
    value: 'BDT'
  ),
  CurrencyModel(
    label: 'CNY', 
    ucode: '0x05143', 
    value: 'CNY'
  ),
  CurrencyModel(
    label: 'CAD', 
    ucode: '0x00024', 
    value: 'CAD'
  ),
  CurrencyModel(
    label: 'ILS', 
    ucode: '0x020AA', 
    value: 'ILS'
  ),
  CurrencyModel(
    label: 'INR', 
    ucode: '0x20B9', 
    value: 'INR'
  ),
  CurrencyModel(
    label: 'JPY', 
    ucode: '0x000A5', 
    value: 'JPY'
  ),
  CurrencyModel(
    label: 'KRW', 
    ucode: '0x20A9', 
    value: 'KRW'
  ),
  CurrencyModel(
    label: 'MXN', 
    ucode: '0x00024', 
    value: 'MXN'
  ),
  CurrencyModel(
    label: 'NGN', 
    ucode: '0x020A6', 
    value: 'NGN'
  ),
  CurrencyModel(
    label: 'NZD', 
    ucode: '0x00024', 
    value: 'NZD'
  ),
  CurrencyModel(
    label: 'NZD', 
    ucode: '0x00024', 
    value: 'NZD'
  ),
  CurrencyModel(
    label: 'PKR', 
    ucode: '0x20A8', 
    value: 'PKR'
  ),
  CurrencyModel(
    label: 'PHP', 
    ucode: '0x20B1', 
    value: 'PHP'
  ),
  CurrencyModel(
    label: 'SGD', 
    ucode: '0x00024', 
    value: 'SGD'
  ),
  CurrencyModel(
    label: 'THB', 
    ucode: '0xE3F', 
    value: 'THB'
  ),
  CurrencyModel(
    label: 'VND', 
    ucode: '0x20AB', 
    value: 'VND'
  ),
];

class CurrencyModel {
  String ucode;
  String value;
  String label;
  
  CurrencyModel({
    @required this.ucode,
    @required this.value,
    @required this.label,
  });
}
