class TodayCollectionModel {
  String? todayCollection;
  String? yesterdayCollection;

  TodayCollectionModel({this.todayCollection, this.yesterdayCollection});

  factory TodayCollectionModel.fromJson(Map<String, dynamic> json) {
    return TodayCollectionModel(
      todayCollection: json['today_collection'],
      yesterdayCollection: json['yesterday_collection'],
    );
  }
}

class TodayCollectionResponse {
  String? status;
  int? responseCode;
  List<TodayCollectionModel>? data;
  String? message;

  TodayCollectionResponse({this.status, this.responseCode, this.data, this.message});

  factory TodayCollectionResponse.fromJson(Map<String, dynamic> json) {
    return TodayCollectionResponse(
      status: json['status'],
      responseCode: json['response_code'],
      data: (json['data'] as List?)
          ?.map((item) => TodayCollectionModel.fromJson(item))
          .toList(),
      message: json['message'],
    );
  }
}
