class Post {
  int? categoryId;
  int? userId;
  String? title;
  String? description;
  List<MediaUrl>? mediaUrls;
  double? price;
  DateTime? date;
  int? subCategoryId;
  String? productCondition;
  Status? status;
  DateTime? expiresAt;
  int? buyerId;
  int reportCount = 0;
  int views = 0;
  bool negotiable = false;
  String? location;
  bool sold = false;

  List<Characteristics>? characteristics;

  Post({
    required this.categoryId,
    required this.userId,
    required this.title,
    required this.description,
    required this.mediaUrls,
    required this.price,
    required this.subCategoryId,
    required this.productCondition,
    this.date,
    this.status,
    this.expiresAt,
    this.buyerId,
    this.reportCount = 0,
    this.views = 0,
    this.negotiable = false,
    this.location,
    this.sold = false,
    required this.characteristics,
  });

  Post.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];

    if (json['mediaUrls'] != null) {
      mediaUrls = <MediaUrl>[];
      json['mediaUrls'].forEach((v) {
        mediaUrls!.add(MediaUrl.fromJson(v));
      });
    }

    price = json['price'];
    subCategoryId = json['subCategoryId'];
    productCondition = json['productCondition'];

    if (json['status'] != null) {
      status = Status.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => Status.INACTIVE,
      );
    }

    if (json['expiresAt'] != null) {
      date = DateTime.tryParse(json['createdAt']);
    }

    if (json['expiresAt'] != null) {
      expiresAt = DateTime.tryParse(json['expiresAt']);
    }

    buyerId = json['buyerId'];
    reportCount = json['reportCount'] ?? 0;
    views = json['views'] ?? 0;
    negotiable = json['negotiable'] ?? false;
    location = json['location'];
    sold = json['sold'] ?? false;

    if (json['characteristics'] != null) {
      characteristics = <Characteristics>[];
      json['characteristics'].forEach((v) {
        characteristics!.add(Characteristics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;

    if (mediaUrls != null) {
      data['mediaUrls'] = mediaUrls!.map((v) => v.toJson()).toList();
    }

    data['price'] = price;
    data['date'] = date;
    data['subCategoryId'] = subCategoryId;
    data['productCondition'] = productCondition;

    if (status != null) {
      data['status'] = status.toString().split('.').last;
    }

    if (expiresAt != null) {
      data['expiresAt'] = expiresAt!.toIso8601String();
    }

    data['buyerId'] = buyerId;
    data['reportCount'] = reportCount;
    data['views'] = views;
    data['negotiable'] = negotiable;
    data['location'] = location;
    data['sold'] = sold;

    if (characteristics != null) {
      data['characteristics'] =
          characteristics!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  /// 🔥 copyWith method
  Post copyWith({
    int? categoryId,
    int? userId,
    String? title,
    String? description,
    List<MediaUrl>? mediaUrls,
    double? price,
    DateTime? date,
    int? subCategoryId,
    String? productCondition,
    Status? status,
    DateTime? expiresAt,
    int? buyerId,
    int? reportCount,
    int? views,
    bool? negotiable,
    String? location,
    bool? sold,
    List<Characteristics>? characteristics,
  }) {
    return Post(
      categoryId: categoryId ?? this.categoryId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      price: price ?? this.price,
      date: date ?? this.date,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      productCondition: productCondition ?? this.productCondition,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      buyerId: buyerId ?? this.buyerId,
      reportCount: reportCount ?? this.reportCount,
      views: views ?? this.views,
      negotiable: negotiable ?? this.negotiable,
      location: location ?? this.location,
      sold: sold ?? this.sold,
      characteristics: characteristics ?? this.characteristics,
    );
  }

  @override
  String toString() {
    return '''
Post {
  categoryId: $categoryId,
  userId: $userId,
  title: $title,
  description: $description,
  mediaUrls: ${mediaUrls?.map((m) => m.toString()).join(", ")},
  price: $price,
  date: $date,
  subCategoryId: $subCategoryId,
  productCondition: $productCondition,
  status: $status,
  expiresAt: $expiresAt,
  buyerId: $buyerId,
  reportCount: $reportCount,
  views: $views,
  negotiable: $negotiable,
  location: $location,
  sold: $sold,
  characteristics: ${characteristics?.map((c) => c.toString()).join(", ")}
}
''';
  }
}

class MediaUrl {
  String? content;

  MediaUrl({this.content});

  MediaUrl.fromJson(Map<String, dynamic> json) {
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    return data;
  }

  /// 🔥 copyWith
  MediaUrl copyWith({String? content}) {
    return MediaUrl(content: content ?? this.content);
  }

  @override
  String toString() {
    return 'MediaUrl(content: $content)';
  }
}

class Characteristics {
  String? key;
  String? value;

  Characteristics({this.key, this.value});

  Characteristics.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }

  /// 🔥 copyWith
  Characteristics copyWith({String? key, String? value}) {
    return Characteristics(key: key ?? this.key, value: value ?? this.value);
  }

  @override
  String toString() {
    return '{key: $key, value: $value}';
  }
}

enum Status { ACTIVE, INACTIVE, EXPIRED, DISABLED }
