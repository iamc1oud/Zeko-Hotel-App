class AllOrders {
  List<OrderPlaced>? data;
  String? message;
  bool? status;

  AllOrders({this.data, this.message, this.status});

  AllOrders.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OrderPlaced>[];

      json['data'].forEach((v) {
        data!.add(OrderPlaced.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;

    return data;
  }
}

class OrderPlaced {
  int? id;
  String? phoneNumber;
  int? reservationId;
  String? roomNumber;
  String? roomType;
  String? comment;
  String? orderStatus;
  String? paymentStatus;
  String? orderTime;
  String? rejectedAt;
  String? rejectedBy;
  String? acceptedAt;
  String? acceptedBy;
  bool? isEscalated;
  String? coupon;
  String? rejectReason;
  BillingDetails? billingDetails;
  List<Items>? items;

  OrderPlaced(
      {this.id,
      this.phoneNumber,
      this.reservationId,
      this.roomNumber,
      this.roomType,
      this.comment,
      this.orderStatus,
      this.paymentStatus,
      this.orderTime,
      this.rejectedAt,
      this.rejectedBy,
      this.acceptedAt,
      this.acceptedBy,
      this.isEscalated,
      this.coupon,
      this.rejectReason,
      this.billingDetails,
      this.items});

  OrderPlaced.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    reservationId = json['reservationId'];
    roomNumber = json['roomNumber'];
    roomType = json['roomType'];
    comment = json['comment'];
    orderStatus = json['orderStatus'];
    paymentStatus = json['paymentStatus'];
    orderTime = json['orderTime'];
    rejectedAt = json['rejectedAt'];
    rejectedBy = json['rejectedBy'];
    acceptedAt = json['acceptedAt'];
    acceptedBy = json['acceptedBy'];
    isEscalated = json['isEscalated'];
    // coupon = json['coupon'];
    rejectReason = json['rejectReason'];
    billingDetails = json['billingDetails'] != null
        ? BillingDetails.fromJson(json['billingDetails'])
        : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['reservationId'] = reservationId;
    data['roomNumber'] = roomNumber;
    data['roomType'] = roomType;
    data['comment'] = comment;
    data['orderStatus'] = orderStatus;
    data['paymentStatus'] = paymentStatus;
    data['orderTime'] = orderTime;
    data['rejectedAt'] = rejectedAt;
    data['rejectedBy'] = rejectedBy;
    data['acceptedAt'] = acceptedAt;
    data['acceptedBy'] = acceptedBy;
    data['isEscalated'] = isEscalated;
    data['coupon'] = coupon;
    data['rejectReason'] = rejectReason;
    if (billingDetails != null) {
      data['billingDetails'] = billingDetails!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillingDetails {
  double? itemTotal;
  double? totalTaxCharges;
  double? totalDue;
  double? totalDiscount;

  BillingDetails(
      {this.itemTotal,
      this.totalTaxCharges,
      this.totalDue,
      this.totalDiscount});

  BillingDetails.fromJson(Map<String, dynamic> json) {
    itemTotal = json['itemTotal'];
    totalTaxCharges = json['totalTaxCharges'];
    totalDue = json['totalDue'];
    totalDiscount = json['totalDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemTotal'] = itemTotal;
    data['totalTaxCharges'] = totalTaxCharges;
    data['totalDue'] = totalDue;
    data['totalDiscount'] = totalDiscount;
    return data;
  }
}

class Items {
  int? id;
  Item? item;
  List<Item>? addonitem;
  int? quantity;
  bool? isAccepted;
  HousekeepingItem? housekeepingItem;
  Item? upsellItem;

  Items(
      {this.id,
      this.item,
      this.addonitem,
      this.quantity,
      this.isAccepted,
      this.housekeepingItem,
      this.upsellItem});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    if (json['addonitem'] != null) {
      addonitem = <Item>[];
      json['addonitem'].forEach((v) {
        addonitem!.add(Item.fromJson(v));
      });
    }
    quantity = json['quantity'];
    isAccepted = json['isAccepted'];
    housekeepingItem = json['housekeepingItem'] != null
        ? HousekeepingItem.fromJson(json['housekeepingItem'])
        : null;
    upsellItem =
        json['upsellItem'] != null ? Item.fromJson(json['upsellItem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (addonitem != null) {
      data['addonitem'] = addonitem!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = quantity;
    data['isAccepted'] = isAccepted;
    data['housekeepingItem'] = housekeepingItem;
    data['upsellItem'] = upsellItem;
    return data;
  }
}

class Item {
  int? id;
  String? name;
  num? price;
  num? discPrice;
  bool? isVeg;
  String? image;
  String? description;

  Item(
      {this.id,
      this.name,
      this.price,
      this.discPrice,
      this.isVeg,
      this.image,
      this.description});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discPrice = json['discPrice'];
    isVeg = json['isVeg'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discPrice'] = discPrice;
    data['isVeg'] = isVeg;
    data['image'] = image;
    data['description'] = description;
    return data;
  }
}

class HousekeepingItem {
  int? id;
  String? name;
  String? photo;

  HousekeepingItem({this.id, this.name, this.photo});

  HousekeepingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    return data;
  }
}
