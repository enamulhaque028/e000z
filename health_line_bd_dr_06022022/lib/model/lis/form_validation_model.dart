import 'dart:convert';

FormValidation formValidationFromJson(String str) =>
    FormValidation.fromJson(json.decode(str));

String formValidationToJson(FormValidation data) => json.encode(data.toJson());

class FormValidation {
  FormValidation({
    this.prcObjTest,
  });

  List<PrcObjTest> prcObjTest;

  factory FormValidation.fromJson(Map<String, dynamic> json) => FormValidation(
        prcObjTest: List<PrcObjTest>.from(
            json["prc_obj_test"].map((x) => PrcObjTest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "prc_obj_test": List<dynamic>.from(prcObjTest.map((x) => x.toJson())),
      };
}

class PrcObjTest {
  PrcObjTest({
    this.tcolmName,
    this.tblcolvFg,
    this.colcrudFg,
    this.colvchkFg,
    this.comentTxt,
  });

  String tcolmName;
  int tblcolvFg;
  int colcrudFg;
  int colvchkFg;
  String comentTxt;

  factory PrcObjTest.fromJson(Map<String, dynamic> json) => PrcObjTest(
        tcolmName: json["tcolm_name"],
        tblcolvFg: json["tblcolv_fg"],
        colcrudFg: json["colcrud_fg"],
        colvchkFg: json["colvchk_fg"],
        comentTxt: json["coment_txt"],
      );

  Map<String, dynamic> toJson() => {
        "tcolm_name": tcolmName,
        "tblcolv_fg": tblcolvFg,
        "colcrud_fg": colcrudFg,
        "colvchk_fg": colvchkFg,
        "coment_txt": comentTxt,
      };
}
