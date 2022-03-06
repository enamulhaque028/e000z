// class Ticket {
//   Clients clients;
//   Projects projects;
//   String ticketDescString;
//   TicketMode ticketMode;
//   TicketPriority ticketPriority;
//   TicketTitle ticketTitle;
//   String ticketTitleString;
//   TicketType ticketType;
//   String userCode;
//   bool success;
//   String ticketId;

//   Ticket(
//       {this.clients,
//       this.projects,
//       this.ticketDescString,
//       this.ticketMode,
//       this.ticketPriority,
//       this.ticketTitle,
//       this.ticketTitleString,
//       this.ticketType,
//       this.userCode,
//       this.success,
//       this.ticketId});

//   Ticket.fromJson(Map<String, dynamic> json) {
//     clients =
//         json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
//     projects = json['projects'] != null
//         ? new Projects.fromJson(json['projects'])
//         : null;
//     ticketDescString = json['ticketDescString'];
//     ticketMode = json['ticketMode'] != null
//         ? new TicketMode.fromJson(json['ticketMode'])
//         : null;
//     ticketPriority = json['ticketPriority'] != null
//         ? new TicketPriority.fromJson(json['ticketPriority'])
//         : null;
//     ticketTitle = json['ticketTitle'] != null
//         ? new TicketTitle.fromJson(json['ticketTitle'])
//         : null;
//     ticketTitleString = json['ticketTitleString'];
//     ticketType = json['ticketType'] != null
//         ? new TicketType.fromJson(json['ticketType'])
//         : null;
//     userCode = json['userCode'];
//     success = json['success'];
//     ticketId = json['ticketId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.clients != null) {
//       data['clients'] = this.clients.toJson();
//     }
//     if (this.projects != null) {
//       data['projects'] = this.projects.toJson();
//     }
//     data['ticketDescString'] = this.ticketDescString;
//     if (this.ticketMode != null) {
//       data['ticketMode'] = this.ticketMode.toJson();
//     }
//     if (this.ticketPriority != null) {
//       data['ticketPriority'] = this.ticketPriority.toJson();
//     }
//     if (this.ticketTitle != null) {
//       data['ticketTitle'] = this.ticketTitle.toJson();
//     }
//     data['ticketTitleString'] = this.ticketTitleString;
//     if (this.ticketType != null) {
//       data['ticketType'] = this.ticketType.toJson();
//     }
//     data['userCode'] = this.userCode;
//     data['success'] = this.success;
//     data['ticketId'] = this.ticketId;
//     return data;
//   }
// }

// class Clients {
//   String cLIENTSID;
//   String cOMPANYID;

//   Clients({this.cLIENTSID, this.cOMPANYID});

//   Clients.fromJson(Map<String, dynamic> json) {
//     cLIENTSID = json['CLIENTS_ID'];
//     cOMPANYID = json['COMPANY_ID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['CLIENTS_ID'] = this.cLIENTSID;
//     data['COMPANY_ID'] = this.cOMPANYID;
//     return data;
//   }
// }

// class Projects {
//   String pROJECTID;
//   String pROJTNAME;

//   Projects({this.pROJECTID, this.pROJTNAME});

//   Projects.fromJson(Map<String, dynamic> json) {
//     pROJECTID = json['PROJECT_ID'];
//     pROJTNAME = json['PROJT_NAME'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['PROJECT_ID'] = this.pROJECTID;
//     data['PROJT_NAME'] = this.pROJTNAME;
//     return data;
//   }
// }

// class TicketMode {
//   String tRMODEID;

//   TicketMode({this.tRMODEID});

//   TicketMode.fromJson(Map<String, dynamic> json) {
//     tRMODEID = json['TR_MODE_ID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TR_MODE_ID'] = this.tRMODEID;
//     return data;
//   }
// }

// class TicketPriority {
//   String tKTPRIID;

//   TicketPriority({this.tKTPRIID});

//   TicketPriority.fromJson(Map<String, dynamic> json) {
//     tKTPRIID = json['TKT_PRI_ID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TKT_PRI_ID'] = this.tKTPRIID;
//     return data;
//   }
// }

// class TicketTitle {
//   String refctktId;

//   TicketTitle({this.refctktId});

//   TicketTitle.fromJson(Map<String, dynamic> json) {
//     refctktId = json['refctkt_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['refctkt_id'] = this.refctktId;
//     return data;
//   }
// }

// class TicketType {
//   String tRTYPEID;

//   TicketType({this.tRTYPEID});

//   TicketType.fromJson(Map<String, dynamic> json) {
//     tRTYPEID = json['TR_TYPE_ID'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['TR_TYPE_ID'] = this.tRTYPEID;
//     return data;
//   }
// }

class Ticket {
  Clients clients;
  Projects projects;
  String ticketDescString;
  TicketMode ticketMode;
  TicketPriority ticketPriority;
  TicketTitle ticketTitle;
  String ticketTitleString;
  TicketType ticketType;
  String userCode;
  List<Attatchments> attatchments;
  String ticketPriorityString;
  bool status;
  String title;

  Ticket(
      {this.clients,
      this.projects,
      this.ticketDescString,
      this.ticketMode,
      this.ticketPriority,
      this.ticketTitle,
      this.ticketTitleString,
      this.ticketType,
      this.userCode,
      this.attatchments,
      this.status,
      this.title});

  Ticket.fromJson(Map<String, dynamic> json) {
    clients =
        json['clients'] != null ? new Clients.fromJson(json['clients']) : null;
    projects = json['projects'] != null
        ? new Projects.fromJson(json['projects'])
        : null;
    ticketDescString = json['ticketDescString'];
    ticketMode = json['ticketMode'] != null
        ? new TicketMode.fromJson(json['ticketMode'])
        : null;
    ticketPriority = json['ticketPriority'] != null
        ? new TicketPriority.fromJson(json['ticketPriority'])
        : null;
    ticketTitle = json['ticketTitle'] != null
        ? new TicketTitle.fromJson(json['ticketTitle'])
        : null;
    ticketTitleString = json['ticketTitleString'];
    ticketType = json['ticketType'] != null
        ? new TicketType.fromJson(json['ticketType'])
        : null;
    userCode = json['userCode'];
    if (json['attatchments'] != null) {
      // ignore: deprecated_member_use
      attatchments = new List<Attatchments>();
      json['attatchments'].forEach((v) {
        attatchments.add(new Attatchments.fromJson(v));
      });
    }
    status = json['status'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clients != null) {
      data['clients'] = this.clients.toJson();
    }
    if (this.projects != null) {
      data['projects'] = this.projects.toJson();
    }
    data['ticketDescString'] = this.ticketDescString;
    if (this.ticketMode != null) {
      data['ticketMode'] = this.ticketMode.toJson();
    }
    if (this.ticketPriority != null) {
      data['ticketPriority'] = this.ticketPriority.toJson();
    }
    if (this.ticketTitle != null) {
      data['ticketTitle'] = this.ticketTitle.toJson();
    }
    data['ticketTitleString'] = this.ticketTitleString;
    if (this.ticketType != null) {
      data['ticketType'] = this.ticketType.toJson();
    }
    data['userCode'] = this.userCode;
    if (this.attatchments != null) {
      data['attatchments'] = this.attatchments.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['Title'] = this.title;
    return data;
  }
}

class Clients {
  String cLIENTSID;
  String cOMPANYID;

  Clients({this.cLIENTSID, this.cOMPANYID});

  Clients.fromJson(Map<String, dynamic> json) {
    cLIENTSID = json['CLIENTS_ID'];
    cOMPANYID = json['COMPANY_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLIENTS_ID'] = this.cLIENTSID;
    data['COMPANY_ID'] = this.cOMPANYID;
    return data;
  }
}

class Projects {
  String pROJECTID;
  String pROJTNAME;

  Projects({this.pROJECTID, this.pROJTNAME});

  Projects.fromJson(Map<String, dynamic> json) {
    pROJECTID = json['PROJECT_ID'];
    pROJTNAME = json['PROJT_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PROJECT_ID'] = this.pROJECTID;
    data['PROJT_NAME'] = this.pROJTNAME;
    return data;
  }
}

class TicketMode {
  String tRMODEID;

  TicketMode({this.tRMODEID});

  TicketMode.fromJson(Map<String, dynamic> json) {
    tRMODEID = json['TR_MODE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TR_MODE_ID'] = this.tRMODEID;
    return data;
  }
}

class TicketPriority {
  String tKTPRIID;

  TicketPriority({this.tKTPRIID});

  TicketPriority.fromJson(Map<String, dynamic> json) {
    tKTPRIID = json['TKT_PRI_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TKT_PRI_ID'] = this.tKTPRIID;
    return data;
  }
}

class TicketTitle {
  String refctktId;

  TicketTitle({this.refctktId});

  TicketTitle.fromJson(Map<String, dynamic> json) {
    refctktId = json['refctkt_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refctkt_id'] = this.refctktId;
    return data;
  }
}

class TicketType {
  String tRTYPEID;

  TicketType({this.tRTYPEID});

  TicketType.fromJson(Map<String, dynamic> json) {
    tRTYPEID = json['TR_TYPE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TR_TYPE_ID'] = this.tRTYPEID;
    return data;
  }
}

class Attatchments {
  String userCode;
  String attachment;

  Attatchments({this.userCode, this.attachment});

  Attatchments.fromJson(Map<String, dynamic> json) {
    userCode = json['UserCode'];
    attachment = json['Attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserCode'] = this.userCode;
    data['Attachment'] = this.attachment;
    return data;
  }
}
