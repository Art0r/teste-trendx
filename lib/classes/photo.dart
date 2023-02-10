class Photo {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo(this.id, this.albumId, this.title, this.url, this.thumbnailUrl);

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(json["id"], json["albumId"], json["title"], json["url"],
        json["thumbnailUrl"]);
  }
}
