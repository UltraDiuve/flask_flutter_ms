class Profile {
  late final String name;

  Profile.fromJson(dynamic json) : name = json['name'];
}
