

class UpdateProfileModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String? imageUrl;

  UpdateProfileModel(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.imageUrl});

  factory UpdateProfileModel.fromJson({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    String? imageUrl,
  }) {
    return UpdateProfileModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        imageUrl: imageUrl);
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      if(phone.isNotEmpty) 'phone': phone,
      if(email.isNotEmpty)   'email': email,
      if (imageUrl != null) 'images': [imageUrl],
    };
  }
}
