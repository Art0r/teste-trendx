class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String imgUrl;

  Post(this.id, this.userId, this.title, this.body, this.imgUrl);

  factory Post.fromJson(Map<String, dynamic> json, String imgUrl) {
    return Post(
        json["id"], json["userId"], json["title"], json["body"], imgUrl);
  }
}
