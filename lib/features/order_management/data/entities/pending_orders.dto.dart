import 'package:zeko_hotel_crm/features/order_management/data/entities/all_orders.dto.dart';

class PendingOrdersDTO {
  Map<String, List<OrderCategory>> categories;

  PendingOrdersDTO({required this.categories});

  factory PendingOrdersDTO.fromJson(Map<String, dynamic> json) {
    Map<String, List<OrderCategory>> parsedCategories = {};

    json.forEach((key, value) {
      if (value is List) {
        parsedCategories[key] =
            value.map((item) => OrderCategory.fromJson(item)).toList();
      } else {
        parsedCategories[key] = [];
      }
    });

    return PendingOrdersDTO(categories: parsedCategories);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    categories.forEach((key, value) {
      json[key] = value.map((item) => item.toJson()).toList();
    });
    return json;
  }
}

class OrderCategory {
  int id;
  String? phoneNumber;
  int? reservationId;
  String? roomNumber;
  String? roomType;
  String? comment;
  String? category;
  bool? isEscalated;
  String? timeStamp;
  List<OrderItem>? items;

  OrderCategory({
    required this.id,
    this.phoneNumber,
    this.reservationId,
    this.roomNumber,
    this.roomType,
    this.comment,
    this.category,
    this.isEscalated,
    this.timeStamp,
    this.items,
  });

  factory OrderCategory.fromJson(Map<String, dynamic> json) {
    return OrderCategory(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      reservationId: json['reservationId'],
      roomNumber: json['roomNumber'],
      roomType: json['roomType'],
      comment: json['comment'] ?? '',
      category: json['category'],
      isEscalated: json['isEscalated'],
      timeStamp: json['timeStamp'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'reservationId': reservationId,
      'roomNumber': roomNumber,
      'roomType': roomType,
      'comment': comment,
      'category': category,
      'isEscalated': isEscalated,
      'timeStamp': timeStamp,
      'items': items?.map((i) => i.toJson()).toList(),
    };
  }
}

class OrderItem {
  int? id;
  ItemDetails? item;
  int? quantity;
  bool? isAccepted;
  HousekeepingItem? housekeepingItem;

  OrderItem(
      {this.id,
      this.item,
      this.quantity,
      this.isAccepted,
      this.housekeepingItem});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json['id'],
        item: json['item'] != null ? ItemDetails.fromJson(json['item']) : null,
        quantity: json['quantity'],
        isAccepted: json['isAccepted'],
        housekeepingItem: json['housekeepingItem'] != null
            ? HousekeepingItem.fromJson(json['housekeepingItem'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item?.toJson(),
      'quantity': quantity,
      'isAccepted': isAccepted,
    };
  }
}

class ItemDetails {
  int? id;
  String? name;
  double? price;
  double? discPrice;
  bool? isVeg;
  String? image;
  String? description;

  ItemDetails({
    this.id,
    this.name,
    this.price,
    this.discPrice,
    this.isVeg,
    this.image,
    this.description,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['id'],
      name: json['name'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      discPrice: json['discPrice'] != null
          ? (json['discPrice'] as num).toDouble()
          : null,
      isVeg: json['isVeg'],
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discPrice': discPrice,
      'isVeg': isVeg,
      'image': image,
      'description': description,
    };
  }
}
