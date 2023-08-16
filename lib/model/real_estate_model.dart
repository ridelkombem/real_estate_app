class RealEstateModel {
  String? heading;
  String? abstractUrl;
  List<RelatedTopics>? relatedTopics;

  RealEstateModel(
    this.heading,
    this.abstractUrl,
    this.relatedTopics,
  );

  RealEstateModel.fromJson(Map<String, dynamic> json) {
    heading = json['Heading'];
    relatedTopics = json['RelatedTopics'];
    abstractUrl = json['AbstractURL'];
    if (json['RelatedTopics'] != null) {
      relatedTopics = <RelatedTopics>[];
      (json['RelatedTopics'] as List).forEach((e) {
        relatedTopics!.add(RelatedTopics.fromJson(e));
      });
    }
  }
}

class RelatedTopics {
  String? firstUrl;

  String? result;

  String? text;

  Iconss? icon;
  RelatedTopics(this.firstUrl, this.result, this.text, this.icon);
  RelatedTopics.fromJson(Map<String, dynamic> json) {
    firstUrl = json['FirstURL'];
    result = json['Result'];
    text = json['Text'];
    icon = Iconss.fromJson(json['Icon']);
    // if (json['Icon'] != null) {
    //   icon = <Iconss>[];
    //   (json['Icon'] as List).forEach((e) {
    //     icon!.add(Iconss.fromJson(e));
    //   });
    // }
  }
}

class Iconss {
  String? height;

  String? url = "";

  String? width;
  Iconss(
    this.height,
    this.url,
    this.width,
  );
  Iconss.fromJson(Map<String, dynamic> json) {
    url = json['URL'];
    height = json['Height'];
    width = json['Width'];
  }
}
