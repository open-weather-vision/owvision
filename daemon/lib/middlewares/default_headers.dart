import 'package:shelf/shelf.dart';

const _corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers':
      'Origin, Content-Type, Authorization', // 'Authorization' ist oft wichtig!
};

Middleware defaultHeaders() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: _corsHeaders);
      }

      final response = await innerHandler(request);

      return response.change(
        headers: {
          ...response.headers,
          'content-type':
              response.headers['content-type'] ??
              'application/json; charset=utf-8',
          ..._corsHeaders,
        },
      );
    };
  };
}
