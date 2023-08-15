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
  }
}

class RelatedTopics {
  String? firstUrl;

  String? result;

  String? text;

  List<Icon>? icon;
  RelatedTopics(this.firstUrl, this.result, this.text, this.icon);
  RelatedTopics.fromJson(Map<String, dynamic> json) {
    firstUrl = json['FirstURL'];
    result = json['Result'];
    text = json['Text'];
    icon = json['Icon'];
  }
}

class Icon {
  double? height;

  String? url;

  double? width;
  Icon(
    this.height,
    this.url,
    this.width,
  );
  Icon.fromJson(Map<String, dynamic> json) {
    url = json['URL'];
    height = json['Height'];
    width = json['Width'];
  }
}
