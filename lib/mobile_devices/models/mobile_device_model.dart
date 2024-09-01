class MobileDeviceModel {
  final String? id;
  final String name;
  final String imei;

  //Required fields
  MobileDeviceModel({
    required this.id,
    required this.name,
    required this.imei,
  });

  //fromMap
  factory MobileDeviceModel.fromMap(Map<String, dynamic> map) {
    return MobileDeviceModel(
      id: map['id'],
      name: map['name'],
      imei: map['imei'],
    );
  }

//toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imei': imei,
    };
  }
}
