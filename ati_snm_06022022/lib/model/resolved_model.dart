class Resolved {
  String cTICKETID;
  String tKTSTUSID;
  String tICKETRTG;
  String tRTGFDBKS;

  Resolved({this.cTICKETID, this.tKTSTUSID});

  Resolved.fromJson(Map<String, dynamic> json) {
    cTICKETID = json['CTICKET_ID'];
    tKTSTUSID = json['TKTSTUS_ID'];
    tICKETRTG = json['TICKET_RTG'];
    tRTGFDBKS = json['TRTG_FDBKS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CTICKET_ID'] = this.cTICKETID;
    data['TKTSTUS_ID'] = this.tKTSTUSID;
    data['TICKET_RTG'] = this.tICKETRTG;
    data['TRTG_FDBKS'] = this.tRTGFDBKS;
    return data;
  }
}
