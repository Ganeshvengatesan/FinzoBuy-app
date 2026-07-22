class AddressModel {
  final String id;
  final String title;
  final String name;
  final String fullAddress;
  final String phone;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.name,
    required this.fullAddress,
    this.phone = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.isDefault = false,
  });

  AddressModel copyWith({
    String? id,
    String? title,
    String? name,
    String? fullAddress,
    String? phone,
    String? city,
    String? state,
    String? zipCode,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      fullAddress: fullAddress ?? this.fullAddress,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
