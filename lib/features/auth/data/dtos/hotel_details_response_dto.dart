class HotelDetailsDTO {
  Detail? detail;

  HotelDetailsDTO({this.detail});

  HotelDetailsDTO.fromJson(Map<String, dynamic> json) {
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? hotelName;
  String? description;
  String? currency;
  String? mapsLink;
  String? primaryColour;
  String? secondaryColour;
  String? hotelVerticalImage;
  String? aboutHotelBannerImage;
  String? termsAndConditions;
  String? hotelLogo;
  String? hotelImage;
  String? exploreServicesImage;
  String? exploreServicesTitle;
  String? exploreServicesDescription;
  String? defaultCheckinTime;
  String? defaultCheckoutTime;
  int? otherStaffTime;
  int? managerTime;
  List<EscalationStaff>? escalationStaff;

  Detail(
      {this.id,
      this.hotelName,
      this.description,
      this.currency,
      this.mapsLink,
      this.primaryColour,
      this.secondaryColour,
      this.hotelVerticalImage,
      this.aboutHotelBannerImage,
      this.termsAndConditions,
      this.hotelLogo,
      this.hotelImage,
      this.exploreServicesImage,
      this.exploreServicesTitle,
      this.exploreServicesDescription,
      this.defaultCheckinTime,
      this.defaultCheckoutTime,
      this.otherStaffTime,
      this.managerTime,
      this.escalationStaff});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotelName = json['hotel_name'];
    description = json['description'];
    currency = json['currency'];
    mapsLink = json['maps_link'];
    primaryColour = json['primary_colour'];
    secondaryColour = json['secondary_colour'];
    hotelVerticalImage = json['hotel_vertical_image'];
    aboutHotelBannerImage = json['about_hotel_banner_image'];
    termsAndConditions = json['terms_and_conditions'];
    hotelLogo = json['hotel_logo'];
    hotelImage = json['hotel_image'];
    exploreServicesImage = json['explore_services_image'];
    exploreServicesTitle = json['explore_services_title'];
    exploreServicesDescription = json['explore_services_description'];
    defaultCheckinTime = json['default_checkin_time'];
    defaultCheckoutTime = json['default_checkout_time'];
    otherStaffTime = json['other_staff_time'];
    managerTime = json['manager_time'];
    if (json['escalation_staff'] != null) {
      escalationStaff = <EscalationStaff>[];
      json['escalation_staff'].forEach((v) {
        escalationStaff!.add(EscalationStaff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hotel_name'] = hotelName;
    data['description'] = description;
    data['currency'] = currency;
    data['maps_link'] = mapsLink;
    data['primary_colour'] = primaryColour;
    data['secondary_colour'] = secondaryColour;
    data['hotel_vertical_image'] = hotelVerticalImage;
    data['about_hotel_banner_image'] = aboutHotelBannerImage;
    data['terms_and_conditions'] = termsAndConditions;
    data['hotel_logo'] = hotelLogo;
    data['hotel_image'] = hotelImage;
    data['explore_services_image'] = exploreServicesImage;
    data['explore_services_title'] = exploreServicesTitle;
    data['explore_services_description'] = exploreServicesDescription;
    data['default_checkin_time'] = defaultCheckinTime;
    data['default_checkout_time'] = defaultCheckoutTime;
    data['other_staff_time'] = otherStaffTime;
    data['manager_time'] = managerTime;
    if (escalationStaff != null) {
      data['escalation_staff'] =
          escalationStaff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EscalationStaff {
  String? name;
  String? phoneNumber;
  int? id;
  String? photo;

  EscalationStaff({this.name, this.phoneNumber, this.id, this.photo});

  EscalationStaff.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['id'] = id;
    data['photo'] = photo;
    return data;
  }
}
