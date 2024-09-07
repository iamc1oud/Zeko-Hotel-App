class PendingOrdersDTO {
  final Map<String, List<OrderCategory>> categories;

  PendingOrdersDTO({required this.categories});

  factory PendingOrdersDTO.fromJson(Map<String, dynamic> json) {
    final Map<String, List<OrderCategory>> parsedCategories = {};

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
    final Map<String, dynamic> json = {};
    categories.forEach((key, value) {
      json[key] = value.map((item) => item.toJson()).toList();
    });
    return json;
  }
}

class OrderCategory {
  final int id;
  final String phoneNumber;
  final int reservationId;
  final String roomNumber;
  final String roomType;
  final String comment;
  final String category;
  final bool isEscalated;
  final String timeStamp;
  final List<OrderItem> items;

  OrderCategory({
    required this.id,
    required this.phoneNumber,
    required this.reservationId,
    required this.roomNumber,
    required this.roomType,
    required this.comment,
    required this.category,
    required this.isEscalated,
    required this.timeStamp,
    required this.items,
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
      items: (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList(),
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
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class OrderItem {
  final int id;
  final ItemDetails item;
  final int quantity;
  final bool isAccepted;

  OrderItem({
    required this.id,
    required this.item,
    required this.quantity,
    required this.isAccepted,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      item: ItemDetails.fromJson(json['item']),
      quantity: json['quantity'],
      isAccepted: json['isAccepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item.toJson(),
      'quantity': quantity,
      'isAccepted': isAccepted,
    };
  }
}

class ItemDetails {
  final int id;
  final String? name;
  final double? price;
  final double? discPrice;
  final bool? isVeg;
  final String? image;
  final String? description;

  ItemDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.discPrice,
    required this.isVeg,
    this.image,
    this.description,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      discPrice: (json['discPrice'] as num).toDouble(),
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
