class PendingOrdersDto {
  final List<Order> escalatedOrders;
  final Map<String, List<dynamic>> otherCategories;

  PendingOrdersDto({
    required this.escalatedOrders,
    required this.otherCategories,
  });

  factory PendingOrdersDto.fromJson(Map<String, dynamic> json) {
    var escalatedOrdersJson = json['Escalated Orders'] as List<dynamic>;
    List<Order> escalatedOrders = escalatedOrdersJson
        .map((orderJson) => Order.fromJson(orderJson))
        .toList();

    // Extract other dynamic categories
    Map<String, List<dynamic>> otherCategories = {};

    json.forEach((key, value) {
      if (key != 'Escalated Orders') {
        otherCategories[key] = List<dynamic>.from(value);
      }
    });

    return PendingOrdersDto(
      escalatedOrders: escalatedOrders,
      otherCategories: otherCategories,
    );
  }

  Map<String, dynamic> toJson() {
    var dataMap = {
      'Escalated Orders':
          escalatedOrders.map((order) => order.toJson()).toList(),
    };

    // otherCategories.forEach((key, value) {
    //   dataMap[key] = value;
    // });

    return dataMap;
  }
}

class Order {
  final int id;
  final String phoneNumber;
  final int reservationId;
  final String roomNumber;
  final String roomType;
  final String? comment;
  final String category;
  final bool isEscalated;
  final DateTime timeStamp;
  final List<ItemDetails> items;

  Order({
    required this.id,
    required this.phoneNumber,
    required this.reservationId,
    required this.roomNumber,
    required this.roomType,
    this.comment,
    required this.category,
    required this.isEscalated,
    required this.timeStamp,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List<dynamic>;
    List<ItemDetails> items =
        itemsJson.map((itemJson) => ItemDetails.fromJson(itemJson)).toList();

    return Order(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      reservationId: json['reservationId'],
      roomNumber: json['roomNumber'],
      roomType: json['roomType'],
      comment: json['comment'],
      category: json['category'],
      isEscalated: json['isEscalated'],
      timeStamp: DateTime.parse(json['timeStamp']),
      items: items,
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
      'timeStamp': timeStamp.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class ItemDetails {
  final int id;
  final Item item;
  final List<dynamic> addonitem;
  final int quantity;
  final bool isAccepted;
  final dynamic housekeepingItem;
  final dynamic upsellItem;

  ItemDetails({
    required this.id,
    required this.item,
    required this.addonitem,
    required this.quantity,
    required this.isAccepted,
    this.housekeepingItem,
    this.upsellItem,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['id'],
      item: Item.fromJson(json['item']),
      addonitem: List<dynamic>.from(json['addonitem']),
      quantity: json['quantity'],
      isAccepted: json['isAccepted'],
      housekeepingItem: json['housekeepingItem'],
      upsellItem: json['upsellItem'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
      'addonitem': addonitem,
      'quantity': quantity,
      'isAccepted': isAccepted,
      'housekeepingItem': housekeepingItem,
      'upsellItem': upsellItem,
    };
  }
}

class Item {
  final int id;
  final String name;
  final double price;
  final double? discPrice;
  final bool isVeg;
  final String? image;
  final String? description;

  Item({
    required this.id,
    required this.name,
    required this.price,
    this.discPrice,
    required this.isVeg,
    this.image,
    this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      discPrice: json['discPrice']?.toDouble(),
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
