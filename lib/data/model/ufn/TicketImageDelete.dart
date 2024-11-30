class TicketImageDelete {
  TicketImageDelete({
    this.message,
    this.error,
    this.status,
    this.ticketimagepath,
  });

  TicketImageDelete.fromJson(dynamic json) {
    message = json['MESSAGE'];
    if (json['ERROR'] != null) {
      error = [];
      json['ERROR'].forEach((v) {
        error!.add(v);
      });
    }
    status = json['STATUS'];
    ticketimagepath = json['TICKETIMAGEPATH'];
  }

  String? message;
  List<dynamic>? error;
  int? status;
  String? ticketimagepath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MESSAGE'] = message;
    if (error != null) {
      map['ERROR'] = error!.map((v) => v.toJson()).toList();
    }
    map['STATUS'] = status;
    map['TICKETIMAGEPATH'] = ticketimagepath;
    return map;
  }
}
