class VisionDescription {
  String? modelVersion;
  Astica? astica;
  String? status;
  String? captionGPTS;
  int? gPTLevel;
  Caption? caption;
  List<CaptionList>? captionList;
  List<Objects>? objects;
  List<Tags>? tags;
  Metadata? metadata;

  VisionDescription(
      {this.modelVersion,
      this.astica,
      this.status,
      this.captionGPTS,
      this.gPTLevel,
      this.caption,
      this.captionList,
      this.objects,
      this.tags,
      this.metadata});

  VisionDescription.fromJson(Map<String, dynamic> json) {
    modelVersion = json['modelVersion'];
    astica = json['astica'] != null ? Astica.fromJson(json['astica']) : null;
    status = json['status'];
    captionGPTS = json['caption_GPTS'];
    gPTLevel = json['GPT_level'];
    caption =
        json['caption'] != null ? Caption.fromJson(json['caption']) : null;
    if (json['caption_list'] != null) {
      captionList = <CaptionList>[];
      json['caption_list'].forEach((v) {
        captionList!.add(CaptionList.fromJson(v));
      });
    }
    if (json['objects'] != null) {
      objects = <Objects>[];
      json['objects'].forEach((v) {
        objects!.add(Objects.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modelVersion'] = modelVersion;
    if (astica != null) {
      data['astica'] = astica!.toJson();
    }
    data['status'] = status;
    data['caption_GPTS'] = captionGPTS;
    data['GPT_level'] = gPTLevel;
    if (caption != null) {
      data['caption'] = caption!.toJson();
    }
    if (captionList != null) {
      data['caption_list'] = captionList!.map((v) => v.toJson()).toList();
    }
    if (objects != null) {
      data['objects'] = objects!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Astica {
  String? request;
  String? requestType;
  String? modelVersion;
  double? apiQty;

  Astica({this.request, this.requestType, this.modelVersion, this.apiQty});

  Astica.fromJson(Map<String, dynamic> json) {
    request = json['request'];
    requestType = json['requestType'];
    modelVersion = json['modelVersion'];
    apiQty = json['api_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request'] = request;
    data['requestType'] = requestType;
    data['modelVersion'] = modelVersion;
    data['api_qty'] = apiQty;
    return data;
  }
}

class Caption {
  String? text;
  double? confidence;

  Caption({this.text, this.confidence});

  Caption.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['confidence'] = confidence;
    return data;
  }
}

class CaptionList {
  String? text;
  double? confidence;
  Rectangle? rectangle;

  CaptionList({this.text, this.confidence, this.rectangle});

  CaptionList.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    confidence = json['confidence'];
    rectangle = json['rectangle'] != null
        ? Rectangle.fromJson(json['rectangle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['confidence'] = confidence;
    if (rectangle != null) {
      data['rectangle'] = rectangle!.toJson();
    }
    return data;
  }
}

class Rectangle {
  int? x;
  int? y;
  int? w;
  int? h;

  Rectangle({this.x, this.y, this.w, this.h});

  Rectangle.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['w'] = w;
    data['h'] = h;
    return data;
  }
}

class Objects {
  String? name;
  double? confidence;
  Rectangle? rectangle;

  Objects({this.name, this.confidence, this.rectangle});

  Objects.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    confidence = json['confidence'];
    rectangle = json['rectangle'] != null
        ? Rectangle.fromJson(json['rectangle'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['confidence'] = confidence;
    if (rectangle != null) {
      data['rectangle'] = rectangle!.toJson();
    }
    return data;
  }
}

class Tags {
  String? name;
  double? confidence;

  Tags({this.name, this.confidence});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['confidence'] = confidence;
    return data;
  }
}

class Metadata {
  int? width;
  int? height;

  Metadata({this.width, this.height});

  Metadata.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
