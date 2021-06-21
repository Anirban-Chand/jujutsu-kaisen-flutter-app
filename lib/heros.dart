class Protagonist {
  static String tag = 'heros-page';
  late List<Characters> characters;

  Protagonist({required this.characters});

  Protagonist.fromJson(Map<String, dynamic> json) {
    if (json['characters'] != null) {
      characters = [];
      json['characters'].forEach((v) {
        characters.add(new Characters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['characters'] = this.characters.map((v) => v.toJson()).toList();
    return data;
  }
}

class Characters {
  var malId;
  var url;
  var imageUrl;
  var name;
  var role;

  Characters(
      {this.malId = null,
      this.url = null,
      this.imageUrl = null,
      this.name = null,
      this.role = null});

  Characters.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mal_id'] = this.malId;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    data['name'] = this.name;
    data['role'] = this.role;

    return data;
  }
}
