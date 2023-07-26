class Notes{
  int id;
  String icerik;
  String user_id;

  Notes(this.id, {required this.icerik, required this.user_id});

  Map<String, dynamic> toMap() {
    return {
      'Not': icerik,
      'UserId': user_id,
    };
  }

}