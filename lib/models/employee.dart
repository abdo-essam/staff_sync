class Employee {
  final int id;
  final String imageUrl;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final int age;
  final String dob;
  final double salary;
  final String address;

  Employee({
    required this.id,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.age,
    required this.dob,
    required this.salary,
    required this.address,
  });

  String get fullName => '$firstName $lastName';

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      imageUrl: json['imageUrl'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      age: json['age'],
      dob: json['dob'],
      salary: json['salary'].toDouble(),
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'age': age,
      'dob': dob,
      'salary': salary,
      'address': address,
    };
  }

  String get formattedSalary {
    return '${salary.toStringAsFixed(2)}k';
  }

  String get formattedPhone {
    String phone = contactNumber;
    return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
  }
}