class UserProfile {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? profilePicture;
  String? createdAt;
  Map<String, dynamic>? subscription;
  List<dynamic>? reviews;

  UserProfile({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.profilePicture,
    this.createdAt,
    this.subscription,
    this.reviews,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    profilePicture = json['profilePicture'];
    createdAt = json['createdAt'];
    subscription = json['subscription'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['profilePicture'] = profilePicture;
    data['createdAt'] = createdAt;
    data['subscription'] = subscription;
    data['reviews'] = reviews;
    return data;
  }
}
