import 'dart:convert';

class PlayerRequest {
  final String secChUaPlatform;
  final String referer;
  final bool xYoutubeBootstrapLoggedIn;
  final String xYoutubeClientName;
  final String xYoutubeClientVersion;
  final String xGoogVisitorId;
  final String userAgent;
  final String contentType;

  PlayerRequest({
    required this.secChUaPlatform,
    required this.referer,
    required this.xYoutubeBootstrapLoggedIn,
    required this.xYoutubeClientName,
    required this.xYoutubeClientVersion,
    required this.xGoogVisitorId,
    required this.userAgent,
    required this.contentType,
  });

  factory PlayerRequest.fromJson(Map<String, dynamic> json) {
    return PlayerRequest(
      secChUaPlatform: json['sec-ch-ua-platform'],
      referer: json['referer'],
      xYoutubeBootstrapLoggedIn: json['x-youtube-bootstrap-logged-in'],
      xYoutubeClientName: json['x-youtube-client-name'],
      xYoutubeClientVersion: json['x-youtube-client-version'],
      xGoogVisitorId: json['x-goog-visitor-id'],
      userAgent: json['user-agent'],
      contentType: json['content-type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sec-ch-ua-platform': secChUaPlatform,
      'referer': referer,
      'x-youtube-bootstrap-logged-in': xYoutubeBootstrapLoggedIn,
      'x-youtube-client-name': xYoutubeClientName,
      'x-youtube-client-version': xYoutubeClientVersion,
      'x-goog-visitor-id': xGoogVisitorId,
      'user-agent': userAgent,
      'content-type': contentType,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerRequest &&
          runtimeType == other.runtimeType &&
          secChUaPlatform == other.secChUaPlatform &&
          referer == other.referer &&
          xYoutubeBootstrapLoggedIn == other.xYoutubeBootstrapLoggedIn &&
          xYoutubeClientName == other.xYoutubeClientName &&
          xYoutubeClientVersion == other.xYoutubeClientVersion &&
          xGoogVisitorId == other.xGoogVisitorId &&
          userAgent == other.userAgent &&
          contentType == other.contentType;

  @override
  int get hashCode =>
      secChUaPlatform.hashCode ^
      referer.hashCode ^
      xYoutubeBootstrapLoggedIn.hashCode ^
      xYoutubeClientName.hashCode ^
      xYoutubeClientVersion.hashCode ^
      xGoogVisitorId.hashCode ^
      userAgent.hashCode ^
      contentType.hashCode;
}

class QoeStatsRequest {
  final String secChUaPlatform;
  final String referer;
  final String xGoogVisitorId;
  final String userAgent;
  final String contentType;

  QoeStatsRequest({
    required this.secChUaPlatform,
    required this.referer,
    required this.xGoogVisitorId,
    required this.userAgent,
    required this.contentType,
  });

  factory QoeStatsRequest.fromJson(Map<String, dynamic> json) {
    return QoeStatsRequest(
      secChUaPlatform: json['sec-ch-ua-platform'],
      referer: json['referer'],
      xGoogVisitorId: json['x-goog-visitor-id'],
      userAgent: json['user-agent'],
      contentType: json['content-type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sec-ch-ua-platform': secChUaPlatform,
      'referer': referer,
      'x-goog-visitor-id': xGoogVisitorId,
      'user-agent': userAgent,
      'content-type': contentType,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QoeStatsRequest &&
          runtimeType == other.runtimeType &&
          secChUaPlatform == other.secChUaPlatform &&
          referer == other.referer &&
          xGoogVisitorId == other.xGoogVisitorId &&
          userAgent == other.userAgent &&
          contentType == other.contentType;

  @override
  int get hashCode =>
      secChUaPlatform.hashCode ^
      referer.hashCode ^
      xGoogVisitorId.hashCode ^
      userAgent.hashCode ^
      contentType.hashCode;
}

class NextVideoRequest {
  final String secChUaPlatform;
  final String referer;
  final String xYoutubeClientName;
  final String xYoutubeClientVersion;
  final String xGoogVisitorId;
  final String userAgent;
  final String contentType;

  NextVideoRequest({
    required this.secChUaPlatform,
    required this.referer,
    required this.xYoutubeClientName,
    required this.xYoutubeClientVersion,
    required this.xGoogVisitorId,
    required this.userAgent,
    required this.contentType,
  });

  factory NextVideoRequest.fromJson(Map<String, dynamic> json) {
    return NextVideoRequest(
      secChUaPlatform: json['sec-ch-ua-platform'],
      referer: json['referer'],
      xYoutubeClientName: json['x-youtube-client-name'],
      xYoutubeClientVersion: json['x-youtube-client-version'],
      xGoogVisitorId: json['x-goog-visitor-id'],
      userAgent: json['user-agent'],
      contentType: json['content-type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sec-ch-ua-platform': secChUaPlatform,
      'referer': referer,
      'x-youtube-client-name': xYoutubeClientName,
      'x-youtube-client-version': xYoutubeClientVersion,
      'x-goog-visitor-id': xGoogVisitorId,
      'user-agent': userAgent,
      'content-type': contentType,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NextVideoRequest &&
          runtimeType == other.runtimeType &&
          secChUaPlatform == other.secChUaPlatform &&
          referer == other.referer &&
          xYoutubeClientName == other.xYoutubeClientName &&
          xYoutubeClientVersion == other.xYoutubeClientVersion &&
          xGoogVisitorId == other.xGoogVisitorId &&
          userAgent == other.userAgent &&
          contentType == other.contentType;

  @override
  int get hashCode =>
      secChUaPlatform.hashCode ^
      referer.hashCode ^
      xYoutubeClientName.hashCode ^
      xYoutubeClientVersion.hashCode ^
      xGoogVisitorId.hashCode ^
      userAgent.hashCode ^
      contentType.hashCode;
}

class AnalyticsRequest {
  final String dh;
  final String ua;
  final String clientName;
  final String cv;
  final String vg;
  final String dp;
  final String traceId;
  final String cts;
  final String hitId;
  final String ht;
  final String ap;
  final String vci;
  final String z;

  AnalyticsRequest({
    required this.dh,
    required this.ua,
    required this.clientName,
    required this.cv,
    required this.vg,
    required this.dp,
    required this.traceId,
    required this.cts,
    required this.hitId,
    required this.ht,
    required this.ap,
    required this.vci,
    required this.z,
  });

  factory AnalyticsRequest.fromJson(Map<String, dynamic> json) {
    return AnalyticsRequest(
      dh: json['dh'],
      ua: json['ua'],
      clientName: json['client_name'],
      cv: json['cv'],
      vg: json['vg'],
      dp: json['dp'],
      traceId: json['trace_id'],
      cts: json['cts'],
      hitId: json['hit_id'],
      ht: json['ht'],
      ap: json['ap'],
      vci: json['vci'],
      z: json['z'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dh': dh,
      'ua': ua,
      'client_name': clientName,
      'cv': cv,
      'vg': vg,
      'dp': dp,
      'trace_id': traceId,
      'cts': cts,
      'hit_id': hitId,
      'ht': ht,
      'ap': ap,
      'vci': vci,
      'z': z,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalyticsRequest &&
          runtimeType == other.runtimeType &&
          dh == other.dh &&
          ua == other.ua &&
          clientName == other.clientName &&
          cv == other.cv &&
          vg == other.vg &&
          dp == other.dp &&
          traceId == other.traceId &&
          cts == other.cts &&
          hitId == other.hitId &&
          ht == other.ht &&
          ap == other.ap &&
          vci == other.vci &&
          z == other.z;

  @override
  int get hashCode =>
      dh.hashCode ^
      ua.hashCode ^
      clientName.hashCode ^
      cv.hashCode ^
      vg.hashCode ^
      dp.hashCode ^
      traceId.hashCode ^
      cts.hashCode ^
      hitId.hashCode ^
      ht.hashCode ^
      ap.hashCode ^
      vci.hashCode ^
      z.hashCode;
}

class EventBusRequest {
  final String secChUaPlatform;
  final String referer;
  final String userAgent;
  final String contentType;

  EventBusRequest({
    required this.secChUaPlatform,
    required this.referer,
    required this.userAgent,
    required this.contentType,
  });

  factory EventBusRequest.fromJson(Map<String, dynamic> json) {
    return EventBusRequest(
      secChUaPlatform: json['sec-ch-ua-platform'],
      referer: json['referer'],
      userAgent: json['user-agent'],
      contentType: json['content-type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sec-ch-ua-platform': secChUaPlatform,
      'referer': referer,
      'user-agent': userAgent,
      'content-type': contentType,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventBusRequest &&
          runtimeType == other.runtimeType &&
          secChUaPlatform == other.secChUaPlatform &&
          referer == other.referer &&
          userAgent == other.userAgent &&
          contentType == other.contentType;

  @override
  int get hashCode =>
      secChUaPlatform.hashCode ^
      referer.hashCode ^
      userAgent.hashCode ^
      contentType.hashCode;
}
