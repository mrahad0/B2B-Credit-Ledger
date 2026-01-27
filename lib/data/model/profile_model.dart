class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? role;
  bool? isVerified;
  UserProfile? userProfile;

  Data({this.id, this.email, this.role, this.isVerified, this.userProfile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    isVerified = json['is_verified'];
    userProfile = json['user_profile'] != null
        ? UserProfile.fromJson(json['user_profile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['role'] = role;
    data['is_verified'] = isVerified;
    if (userProfile != null) {
      data['user_profile'] = userProfile!.toJson();
    }
    return data;
  }
}

class UserProfile {
  int? id;
  int? user;
  String? fullName;
  String? shopName;
  String? email;
  String? address;
  String? profilePicture;
  String? joinedDate;

  UserProfile(
      {this.id,
      this.user,
      this.fullName,
      this.shopName,
      this.email,
      this.address,
      this.profilePicture,
      this.joinedDate});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    fullName = json['full_name'];
    shopName = json['shop_name'];
    email = json['email'];
    address = json['address'];
    profilePicture = json['profile_picture'];
    joinedDate = json['joined_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['full_name'] = fullName;
    data['shop_name'] = shopName;
    data['email'] = email;
    data['address'] = address;
    data['profile_picture'] = profilePicture;
    data['joined_date'] = joinedDate;
    return data;
  }
}
