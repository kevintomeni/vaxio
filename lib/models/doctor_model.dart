class Slot {
  final String date;
  final List<String> times;
  Slot({required this.date, required this.times});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      date: json['date'],
      times: List<String>.from(json['times']),
    );
  }
}

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String avatar;
  final double rating;
  final int reviews;
  final String category;
  final double price;
  final int patients;
  final String experience;
  final String about;
  final String address;
  final String college;
  final double lat;
  final double lng;
  final List<String> schedule;
  final List<Slot> slots;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.avatar,
    required this.rating,
    required this.reviews,
    required this.category,
    required this.price,
    required this.patients,
    required this.experience,
    required this.about,
    required this.address,
    required this.college,
    required this.lat,
    required this.lng,
    required this.schedule,
    required this.slots,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      name: json['name'],
      specialty: json['specialty'],
      avatar: json['avatar'],
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      patients: json['patients'],
      experience: json['experience'],
      about: json['about'],
      address: json['address'],
      college: json['college'],
      lat: (json['location']['lat'] as num).toDouble(),
      lng: (json['location']['lng'] as num).toDouble(),
      schedule: List<String>.from(json['schedule']),
      slots: (json['slots'] as List).map((e) => Slot.fromJson(e)).toList(),
    );
  }
} 