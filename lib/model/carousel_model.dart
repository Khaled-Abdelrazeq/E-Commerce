class CarouselModel {
  String? imageUrl;
  String? title;
  dynamic? endedTime;
  // String? endedDate;

  CarouselModel({this.imageUrl, this.title, this.endedTime});

  CarouselModel.fromJson(dynamic data) {
    if (data == null) return;

    imageUrl = data['imageUrl'];
    title = data['title'];
    // endedDate = data['endedDate'];
    endedTime = data['endedTime'];
  }

  toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      // 'endedDate': endedDate,
      'endedTime': endedTime,
    };
  }
}
