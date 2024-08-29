class StaffLoginDto {
  bool? isPasswordCorrect;
  List<Department>? departments;
  bool? isSuperuser;
  Token? token;

  StaffLoginDto(
      {this.isPasswordCorrect, this.departments, this.isSuperuser, this.token});

  factory StaffLoginDto.fromJson(Map<String, dynamic> json) {
    return StaffLoginDto(
      isPasswordCorrect: json['isPasswordCorrect'],
      departments: json['departments'] != null
          ? (json['departments'] as List)
              .map((department) => Department.fromJson(department))
              .toList()
          : [],
      isSuperuser: json['isSuperuser'],
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPasswordCorrect': isPasswordCorrect,
      'departments':
          departments?.map((department) => department.toJson()).toList(),
      'isSuperuser': isSuperuser,
      'token': token?.toJson(),
    };
  }
}

class Department {
  int? id;
  bool? isDisabled;
  String? disabledAt;
  String? name;
  String? menuName;
  int? menuId;
  int? createdBy;
  int? updatedBy;
  int? disabledBy;
  int? hotel;

  Department(
      {this.id,
      this.isDisabled,
      this.disabledAt,
      this.name,
      this.menuName,
      this.menuId,
      this.createdBy,
      this.updatedBy,
      this.disabledBy,
      this.hotel});

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      isDisabled: json['isDisabled'],
      disabledAt: json['disabledAt'],
      name: json['name'],
      menuName: json['menuName'],
      menuId: json['menuId'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      disabledBy: json['disabledBy'],
      hotel: json['hotel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDisabled': isDisabled,
      'disabledAt': disabledAt,
      'name': name,
      'menuName': menuName,
      'menuId': menuId,
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'disabledBy': disabledBy,
      'hotel': hotel,
    };
  }
}

class Token {
  String? access;
  String? refresh;

  Token({this.access, this.refresh});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      access: json['access'],
      refresh: json['refresh'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
}
