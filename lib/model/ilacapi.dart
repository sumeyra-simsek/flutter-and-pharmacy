class Ilac {
  Ilac({
    required this.ilacid,
    required this.ilacAdi,
    required this.ilacTuru,
    required this.BirimFiyat,
    required this.Miktar,
    required this.TETT,
    required this.FirmaAdi,
    required this.SeriNo
  });

  int? ilacid;
  String? ilacAdi;
  String? ilacTuru;
  int? BirimFiyat;
  int? Miktar;
  String? TETT;
  String? FirmaAdi;
  String? SeriNo;




  Ilac.fromJson(Map<String, dynamic> json){
    ilacid = json["ilacid"];
    ilacAdi = json["ilacAdi"] ?? 'Null';
    ilacTuru = json["ilacTuru"] ?? 'Null';
    BirimFiyat = json["BirimFiyat"] != null ? int.tryParse(json["BirimFiyat"].toString()) : null;
    Miktar = json["Miktar"] != null ? int.tryParse(json["Miktar"].toString()) : null;
    TETT = json["TETT"] ?? 'Null';
    FirmaAdi = json["FirmaAdi"] ?? 'Null';
    SeriNo = json["SeriNo"] ?? 'Null';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["ilacid"] = ilacid;
    data["ilacAdi"] = ilacAdi;
    data["ilacTuru"] = ilacTuru;
    data["BirimFiyat"] = BirimFiyat;
    data["Miktar"] = Miktar;
    data["TETT"] = TETT;
    data["FirmaAdi"] = FirmaAdi;
    data["SeriNo"] = SeriNo;
    return data;
  }

}