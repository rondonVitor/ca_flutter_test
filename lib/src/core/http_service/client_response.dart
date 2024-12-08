class ClientResponse {
  final dynamic data;
  final int statusCode;

  const ClientResponse({
    required this.data,
    this.statusCode = 500,
  });
}
