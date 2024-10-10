class Tur{
  Tur({
    required this.turid,
    required this.turadi
});

  int? turid;
  String? turadi;

  Tur.fromJson(Map<String,dynamic>json){
    turid=json["turid"];
    turadi=json["turadi"] ?? "Null";
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = {};
    data["turid"] = turid;
    data["turadi"] = turadi;
    return data;
  }
}