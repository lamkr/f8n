import 'package:http/http.dart' as http;

abstract class IHttpClientBuilder
{
  http.BaseClient buildClient();
}