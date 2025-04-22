import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
 static Future<String> getServerKeyToken() async {
   dotenv.env['Private_Key'];
   log("Server DotNev Key: ${dotenv.env['private_key']}");
   log("Server DotNev Key: ${dotenv.env['type']}");
   log("Server DotNev Key: ${dotenv.env['private_key_id']}");
   log("Server DotNev Key: ${dotenv.env['token_uri']}");
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": dotenv.env['type'],
        "project_id": dotenv.env['project_id'],
        "private_key_id": dotenv.env['private_key_id'],
        "private_key":dotenv.env['private_key'],
        "client_email":dotenv.env['client_email'],
        "client_id": dotenv.env['client_id'],
        "auth_uri": dotenv.env['auth_uri'],
        "token_uri": dotenv.env['token_uri'],
        "auth_provider_x509_cert_url":dotenv.env['auth_provider_x509_cert_url'],
        "client_x509_cert_url":dotenv.env['client_x509_cert_url'],
        "universe_domain": dotenv.env['universe_domain'],
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
