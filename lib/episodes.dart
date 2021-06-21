class Episode {
  static String tag = 'episode-page';
  List<Episodes> episodes=[];

  Episode({required this.episodes});

  Episode.fromJson(Map<String, dynamic> json) {
    if (json['episodes'] != null) {
      episodes = [];
      json['episodes'].forEach((v) {
        episodes.add(new Episodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.episodes != null) {
      data['episodes'] = this.episodes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodes {
  var episodeId;
  var title;
  var titleJapanese;
  var titleRomanji;
  var aired;
  var filler;
  var recap;
  var videoUrl;
  var forumUrl;

  Episodes(
      {this.episodeId,
      this.title,
      this.titleJapanese,
      this.titleRomanji,
      this.aired,
      this.filler,
      this.recap,
      this.videoUrl,
      this.forumUrl});

  Episodes.fromJson(Map<String, dynamic> json) {
    episodeId = json['episode_id'];
    title = json['title'];
    titleJapanese = json['title_japanese'];
    titleRomanji = json['title_romanji'];
    aired = json['aired'];
    filler = json['filler'];
    recap = json['recap'];
    videoUrl = json['video_url'];
    forumUrl = json['forum_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode_id'] = this.episodeId;
    data['title'] = this.title;
    data['title_japanese'] = this.titleJapanese;
    data['title_romanji'] = this.titleRomanji;
    data['aired'] = this.aired;
    data['filler'] = this.filler;
    data['recap'] = this.recap;
    data['video_url'] = this.videoUrl;
    data['forum_url'] = this.forumUrl;
    return data;
  }
}
