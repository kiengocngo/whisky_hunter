class DistilleriesInfo {
  final String name;
  final String slug;
  final String country;
  final String whiskies;
  final String  votes;
  final String  rating;

  DistilleriesInfo(
      {required this.name,
      required this.slug,
      required this.country,
      required this.whiskies,
      required this.votes,
      required this.rating});

  factory DistilleriesInfo.fromJson(Map<String, dynamic> json) {
    return DistilleriesInfo(
        name: json['name'],
        slug: json['slug'],
        country: json['country'],
        whiskies: json['whiskybase_whiskies'],
        votes: json['whiskybase_votes'],
        rating: json['whiskybase_rating']);
  }
  Map<String, dynamic> toJson() =>{
    'name': name,
    'slug': slug,
    'country': country,
    'whiskybase_whiskyies': whiskies,
    'whiskybase_votes': votes,
    'whiskybase_rating': rating,
  };
}
