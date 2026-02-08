class PhoneValidationResult {
  final String status;
  final bool? phoneValid;
  final String? phone;
  final String? countryCode;
  final String? countryPrefix;
  final String? carrier;
  final String? phoneType;

  PhoneValidationResult({
    required this.status,
    this.phoneValid,
    this.phone,
    this.countryCode,
    this.countryPrefix,
    this.carrier,
    this.phoneType,
  });

  factory PhoneValidationResult.fromJson(Map<String, dynamic> json) {
    return PhoneValidationResult(
      status: (json['status'] ?? '').toString(),
      phoneValid: json['phone_valid'] as bool?,
      phone: json['phone']?.toString(),
      countryCode: json['country_code']?.toString(),
      countryPrefix: json['country_prefix']?.toString(),
      carrier: json['carrier']?.toString(),
      phoneType: json['phone_type']?.toString(),
    );
  }
}
