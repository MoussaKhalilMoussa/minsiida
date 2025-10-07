class UserProfile {
  int? id;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? profilePicture;
  String? createdAt;
  Subscription? subscription;
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
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
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
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    data['reviews'] = reviews;
    return data;
  }

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, username: $username, email: $email, phone: $phone, profilePicture: $profilePicture, createdAt: $createdAt, subscription: $subscription, reviews: $reviews)';
  }
}


class Subscription {
  int? id;
  String? plan;
  int? activeAdsLimit;
  int? monthlyAdsLimit;
  int? adExpirationDays;
  int? boosts;
  String? createdAt;
  String? expiresAt;

  Subscription({
    this.id,
    this.plan,
    this.activeAdsLimit,
    this.monthlyAdsLimit,
    this.adExpirationDays,
    this.boosts,
    this.createdAt,
    this.expiresAt,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan = json['plan'];
    activeAdsLimit = json['activeAdsLimit'];
    monthlyAdsLimit = json['monthlyAdsLimit'];
    adExpirationDays = json['adExpirationDays'];
    boosts = json['boosts'];
    createdAt = json['createdAt'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan'] = plan;
    data['activeAdsLimit'] = activeAdsLimit;
    data['monthlyAdsLimit'] = monthlyAdsLimit;
    data['adExpirationDays'] = adExpirationDays;
    data['boosts'] = boosts;
    data['createdAt'] = createdAt;
    data['expiresAt'] = expiresAt;
    return data;
  }

  @override
  String toString() {
    return 'Subscription(id: $id, plan: $plan, activeAdsLimit: $activeAdsLimit, monthlyAdsLimit: $monthlyAdsLimit, adExpirationDays: $adExpirationDays, boosts: $boosts, createdAt: $createdAt, expiresAt: $expiresAt)';
  }
}
