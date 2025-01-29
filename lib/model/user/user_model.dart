class User {

  String? name;
  String? email;
  String? createdAt;
  String? userUid;

  User({

    this.createdAt,
    this.email,
    this.userUid,
    this.name,

  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      createdAt: data['createdAt'] ?? '',

      email: data['email'] ?? '',

      name: data['fullName'] ?? '',

      userUid: data['userUid'] ?? '',
    );
  }
}
class Vendor {
  String? invitations;
  String? company;
  String? country;
  String? createdAt;
  String? email;
  String? firstName;
  String? lastName;
  bool? isChecked;
  String? password;
  String? phoneNumber;
  String? status;
  String? userId;

  Vendor({
    this.invitations,
    this.company,
    this.country,
    this.createdAt,
    this.email,
    this.firstName,
    this.lastName,
    this.isChecked,
    this.password,
    this.phoneNumber,
    this.status,
    this.userId,
  });

  // Factory constructor to create a UserModel from a map
  factory Vendor.fromMap(Map<String, dynamic> data) {
    return Vendor(
      invitations: data['invitations'] ?? '',
      company: data['company'] ?? '',
      country: data['country'] ?? '',
      createdAt: data['createdAt'] ?? '',
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      isChecked: data['isChecked'] ?? false,
      password: data['password'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      status: data['status'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  // Convert UserModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'invitations': invitations,
      'company': company,
      'country': country,
      'createdAt': createdAt,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isChecked': isChecked,
      'password': password,
      'phoneNumber': phoneNumber,
      'status': status,
      'userId': userId,
    };
  }
}

class VendorListing {
  final String? id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String listingStatus;
  final String createdAt;
  final String userUid;
  final Vendor vendor;  // Combined vendor info


  VendorListing({
     this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.listingStatus,
    required this.createdAt,
    required this.userUid,
    required this.vendor,
  });

  factory VendorListing.fromMap(Map<String, dynamic> supplierData, Vendor vendor) {
    return VendorListing(
      title: supplierData['title'],
      category: supplierData['category'],
      listingStatus: supplierData['listingStatus'],
      userUid: supplierData['userUid'],
      vendor: vendor,
      id: supplierData['id'],
      description: supplierData['description'],
      imageUrl: supplierData['imageUrl'],
      createdAt: supplierData['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'listingStatus': listingStatus,
      'createdAt': createdAt,
      'userUid': userUid,
    };
  }
}
