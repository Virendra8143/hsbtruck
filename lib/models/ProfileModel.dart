// user_profile_model.dart
class UserProfile {
  String? id;
  String? workId;
  String? branch;
  String? name;
  String? phone;
  String? address;
  String? salary;
  String? aadharNumber;
  String? aadharFrontImage;
  String? aadharBackImage;
  String? shift;
  String? access;
  String? createdDate;

  UserProfile({
    this.id,
    this.workId,
    this.branch,
    this.name,
    this.phone,
    this.address,
    this.salary,
    this.aadharNumber,
    this.aadharFrontImage,
    this.aadharBackImage,
    this.shift,
    this.access,
    this.createdDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id']?.toString(),
      workId: json['work_id']?.toString(),
      branch: json['branch']?.toString(),
      name: json['name']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      salary: json['salary']?.toString(),
      aadharNumber: json['aadhar_number']?.toString(),
      aadharFrontImage: json['aadhar_front_image']?.toString(),
      aadharBackImage: json['aadhar_back_image']?.toString(),
      shift: json['shift']?.toString(),
      access: json['access']?.toString(),
      createdDate: json['created_date']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'work_id': workId,
      'branch': branch,
      'name': name,
      'phone': phone,
      'address': address,
      'salary': salary,
      'aadhar_number': aadharNumber,
      'aadhar_front_image': aadharFrontImage,
      'aadhar_back_image': aadharBackImage,
      'shift': shift,
      'access': access,
      'created_date': createdDate,
    };
  }
}