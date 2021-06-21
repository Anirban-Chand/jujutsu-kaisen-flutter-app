class Picture {
  static String tag = 'pictures-page';
  List<Pictures> pictures=[];

  Picture({required this.pictures});

  Picture.fromJson(Map<String, dynamic> json) {
    if (json['pictures'] != null) {
      pictures = [];
      json['pictures'].forEach((v) {
        pictures.add(new Pictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pictures != null) {
      data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pictures {
  var large;
  var small;

  Pictures({required this.large, required this.small});

  Pictures.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['large'] = this.large;
    data['small'] = this.small;
    return data;
  }
}
