class TextConst {
  static const String baseUrl = 'https://youtube-to-mp315.p.rapidapi.com';

  static const String apiKey =
      '9621e3954amsh283d94076b12d61p129b7bjsn98fdb423a782';

  static String getApiUrl(String endpoint) => '$baseUrl/$endpoint';

  // Example usage of the API key and base URL in a request header
  static Map<String, String> get headers => {
        'X-RapidAPI-Host': 'youtube-to-mp315.p.rapidapi.com',
        'X-RapidAPI-Key': apiKey,
      };
}
