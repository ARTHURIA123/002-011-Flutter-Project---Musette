class Music{
  int? id;
  String? name;
  String? songName;
  String? artist;
  String? lyricist;
  String? composer;
  String? producer;
  String? label;
  String? isMonetize;
  musicMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['songName'] = songName!;
    mapping['artist'] = artist!;
    mapping['lyricist'] = lyricist;
    mapping['composer'] = composer;
    mapping['producer'] = producer;
    mapping['label'] = label;
    mapping['isMonetize'] = isMonetize;
    return mapping;
  }
}