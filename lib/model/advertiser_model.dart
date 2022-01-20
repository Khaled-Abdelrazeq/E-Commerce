class AdvertiserModel {
  String? imageUrl;
  String? title;
  String? content;

  AdvertiserModel({this.title, this.imageUrl, this.content});

  AdvertiserModel.fromJson(dynamic data) {
    if (data == null) return;

    imageUrl = data['imageUrl'];
    title = data['title'];
    content = data['content'];
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'content': content,
    };
  }
}
