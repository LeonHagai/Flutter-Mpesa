class Secret {
  final String apiKey;
  final String consumerKey;
  final String consumerSecret;

  Secret({
    this.apiKey = '',
    required this.consumerKey,
    required this.consumerSecret,
  });

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
      apiKey: jsonMap["api_key"],
      consumerKey: jsonMap["consumer_key"],
      consumerSecret: jsonMap["consumer_secret"],
    );
  }
}
