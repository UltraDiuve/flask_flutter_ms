class Profile {
  late final String name;
  late final num id;

  Profile.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
  }
}
