library opencmp;

class ConsentMetaData {
  final int dv;

  ConsentMetaData(this.dv);

  ConsentMetaData.fromJson(Map<String, dynamic> json) : dv = json['dv'];

  Map<String, dynamic> toJson() => {
        'dv': dv,
      };
}
