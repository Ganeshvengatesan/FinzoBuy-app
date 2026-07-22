import 'package:flutter/material.dart';
import '../data/models/address_model.dart';

class AddressController extends ChangeNotifier {
  static final AddressController _instance = AddressController._internal();
  factory AddressController() => _instance;
  AddressController._internal();

  int _selectedAddressIndex = 0;

  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      title: 'Home',
      name: 'John Deo',
      fullAddress: 'No: 4, White avenue Green park Extension, Madurai, Tamil Nadu - 625018, India',
      isDefault: true,
    ),
    AddressModel(
      id: '2',
      title: 'Office',
      name: 'John Deo',
      fullAddress: 'No: 21, Greams Lane, Off, Greams Road, Chennai, Tamil Nadu - 600006, India',
    ),
    AddressModel(
      id: '3',
      title: 'Others',
      name: 'John Deo',
      fullAddress: 'No: 21, Greams Lane, Off, Greams Road, Chennai, Tamil Nadu - 600006, India',
    ),
  ];

  int get selectedAddressIndex => _selectedAddressIndex;
  List<AddressModel> get addresses => List.unmodifiable(_addresses);

  AddressModel get selectedAddress => _addresses.isNotEmpty
      ? _addresses[_selectedAddressIndex]
      : AddressModel(
          id: '0',
          title: 'Home',
          name: 'John Deo',
          fullAddress: 'No: 4, White avenue Green park Extension, Madurai, Tamil Nadu - 625018, India',
        );

  void selectAddress(int index) {
    if (index >= 0 && index < _addresses.length) {
      _selectedAddressIndex = index;
      notifyListeners();
    }
  }

  void addAddress(AddressModel newAddress) {
    _addresses.add(newAddress);
    if (newAddress.isDefault) {
      _selectedAddressIndex = _addresses.length - 1;
    }
    notifyListeners();
  }
}
