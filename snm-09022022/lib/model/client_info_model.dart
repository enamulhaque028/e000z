import 'package:intl/intl.dart';

class ClientInfo {
  String tKTPRIID;
  String tPRIORITY;
  String tICKETGDT;
  String uPDATEDAT;
  String tICKETDESC;
  String tKTSTUSID;
  String tICKSTATUS;
  String cTICKETID;
  String cSTTITLES;
  String pROJTNAME;
  String cREATEDAT;
  String cLINTNAME;
  String tICKETUDID;
  String tREQMODE;
  String tICKETATTACHMENT;

  ClientInfo({
    this.tKTPRIID,
    this.tPRIORITY,
    this.tICKETGDT,
    this.uPDATEDAT,
    this.tICKETDESC,
    this.tKTSTUSID,
    this.tICKSTATUS,
    this.cTICKETID,
    this.cSTTITLES,
    this.pROJTNAME,
    this.cREATEDAT,
    this.cLINTNAME,
    this.tICKETUDID,
    this.tREQMODE,
    this.tICKETATTACHMENT,
  });

  ClientInfo.fromJson(Map<String, dynamic> json) {
    tKTPRIID = json['TKT_PRI_ID'];
    tPRIORITY = json['T_PRIORITY'] ?? 'no priority!';
    tICKETGDT = json['TICKET_GDT'];
    uPDATEDAT = json['UPDATED_AT'] ?? '';
    tICKETDESC = json['TICKETDESC'] ?? 'Description';
    tKTSTUSID = json['TKTSTUS_ID'];
    tICKSTATUS = json['TICKSTATUS'] ?? 'no status found!';
    cTICKETID = json['CTICKET_ID'];
    cSTTITLES = json['CST_TITLES'] ?? 'Title';
    pROJTNAME = json['PROJT_NAME'] ?? 'Project Name!';
    cREATEDAT = json['CREATED_AT'];
    cLINTNAME = json['CLINT_NAME'] ?? 'Client Name';
    tICKETUDID = json['TICKETUDID'] ?? 'Ticket No';
    tREQMODE = json['T_REQ_MODE'] ?? 'mode not found!';
    tICKETATTACHMENT = json['TICKET_ATTACHMENT'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TKT_PRI_ID'] = this.tKTPRIID;
    data['T_PRIORITY'] = this.tPRIORITY;
    data['TICKET_GDT'] = convertDateFormat(this.tICKETGDT);
    data['UPDATED_AT'] = this.uPDATEDAT;
    data['TICKETDESC'] = this.tICKETDESC;
    data['TKTSTUS_ID'] = this.tKTSTUSID;
    data['TICKSTATUS'] = this.tICKSTATUS;
    data['CTICKET_ID'] = this.cTICKETID;
    data['CST_TITLES'] = this.cSTTITLES;
    data['PROJT_NAME'] = this.pROJTNAME;
    data['CREATED_AT'] = this.cREATEDAT;
    data['CLINT_NAME'] = this.cLINTNAME;
    data['TICKETUDID'] = this.tICKETUDID;
    data['T_REQ_MODE'] = this.tREQMODE;
    data['TICKET_ATTACHMENT'] = this.tICKETATTACHMENT;
    return data;
  }

  //converting time from "dd/MM/yyyy" to "yyyy-MM-dd"
  //getting data from server in the format of "dd/MM/yyyy"
  //sqlite doesn't support "dd/MM/yyyy" format. So convertion is needed.
  String convertDateFormat(String value) {
    if (value == null || value.isEmpty) {
      return "";
    }
    var dateTime = DateFormat("dd/MM/yyyy").parse(value);
    var formattedDate = DateFormat("MMMM dd, yyyy").format(dateTime);
    return formattedDate;
  }
}

class CountPriority {
  String tKTPRIID;
  String tPRIORITY;
  int count;

  CountPriority({this.tPRIORITY, this.count, this.tKTPRIID});

  CountPriority.fromMap(Map<String, dynamic> map) {
    tKTPRIID = map['TKT_PRI_ID'] ?? '0';
    tPRIORITY = map['T_PRIORITY'];
    count = map['count'];
  }
}

class CountStatus {
  String tKTSTUSID;
  String tICKSTATUS;
  int count;

  CountStatus({this.tICKSTATUS, this.count, this.tKTSTUSID});

  CountStatus.fromMap(Map<String, dynamic> map) {
    tKTSTUSID = map['TKTSTUS_ID'];
    tICKSTATUS = map['TICKSTATUS'];
    count = map['count'];
  }
}

class CountStatusByDate {
  String tKTSTUSID;
  String tICKSTATUS;
  int count;

  CountStatusByDate({this.tKTSTUSID, this.tICKSTATUS, this.count});

  CountStatusByDate.fromMap(Map<String, dynamic> map) {
    tKTSTUSID = map['TKTSTUS_ID'] ?? '0';
    tICKSTATUS = map['TICKSTATUS'];
    count = map['count'];
  }
}

class CountPriorityByDate {
  String tKTPRIID;
  String ticketPriority;
  int count;

  CountPriorityByDate({this.ticketPriority, this.count});

  CountPriorityByDate.fromMap(Map<String, dynamic> map) {
    tKTPRIID = map['TKT_PRI_ID'] ?? '0';
    ticketPriority = map['T_PRIORITY'];
    count = map['count'];
  }
}
