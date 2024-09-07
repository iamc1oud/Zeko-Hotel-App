class StaffLoginRequestDTO {
  String phoneNumber;
  String password;

  StaffLoginRequestDTO({required this.phoneNumber, required this.password});

  factory StaffLoginRequestDTO.fromJson(Map<String, dynamic> json) {
    return StaffLoginRequestDTO(
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
