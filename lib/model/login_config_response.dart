

  class LoginConfigResponse {
  String userName;
  String imageURL;
  int rating;
  int tournamentsPlayed;
  int tournamentWon;

  LoginConfigResponse(
  {this.userName,
  this.imageURL,
  this.rating,
  this.tournamentsPlayed,
  this.tournamentWon});

  LoginConfigResponse.fromJson(Map<String, dynamic> json) {
  userName = json['userName'];
  imageURL = json['imageURL'];
  rating = json['rating'];
  tournamentsPlayed = json['tournamentsPlayed'];
  tournamentWon = json['tournamentWon'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['userName'] = this.userName;
  data['imageURL'] = this.imageURL;
  data['rating'] = this.rating;
  data['tournamentsPlayed'] = this.tournamentsPlayed;
  data['tournamentWon'] = this.tournamentWon;
  return data;
  }
  }