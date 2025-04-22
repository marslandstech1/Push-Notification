import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
 static Future<String> getServerKeyToken() async {
   dotenv.env['Private_Key'];
   log("Server DotNev Key: ${dotenv.env['Private_Key']}");
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        // "type": "service_account",
        // "project_id": "push-notification-14cd2",
        // "private_key_id": "f5152258d67b3e6efa5e76e054242b5243916246",
        // "private_key":"-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDfRsx9RToy7W8W\nEtQY88uPsdperAsikeiMGSWskO/8OBEyWOpdlgerKcBVWSia6q2w86N3UM2ZTPWn\nIDaaM0GbLibj9+gq8SjDhg/6SAhpV+M6XGWfBh7oImW8SN2UPfSQW9eGeX4VjBBa\nldArCc8c6XtjTff1P2tRcRGFtRIQmoYyKxOjLQmE0ghQRjtz4AzxssEVuSM2V7H3\nzyYthUqgKauraPgSfR18sfSCclHtPLdnbshND/L7vJ1w0kjOJXVKlxvPQSpvrk2j\nEKQ5zQ/3pcfgKGmrOoINJ7B5xlImEt5qeBQFxhjPX0Apu7+U2tDocCHWA0ODVjIu\nKEglnKkvAgMBAAECggEAEEmgR5y+zut2W9928w48OBJ67saq763bj1zGQsoDHhys\nJHmxnxVMU4NYMUgWJ9CDmytd+vY9PITaTR0seCAFFfm0tiyZFlWnts7kAeRluK/3\nA4R5/uYtAWiA9ptAjrypepGe+oOIwkmiNJMSyUQnhHrQmKeENX/K2sYRlFw0VSgA\n5I7EXx5lwZq8uSqJzCao03n9m8YSsrAG47p8FR8HYFiVm0nLlbDF4opDzq1/GhsV\nyALElnKTe608uW5f2oqtannlvPri5EOtuZoApZwV9oAmD2lNr3XikKCJ2TB3fqPw\nQ9IqQTCf+AW2X81mJILnBDsuRdranaBAhb1Z08P0AQKBgQD0nzmnJalKkKlRcD3T\nTczL7nDInYEZr9s2rQ3jxAaa2QVKJUbufFR51+KYWEm3zVQ7Qk9HjYFhloSxPhL5\nEZCSJ7zM/3Pf5ZK4vBYP6hBgDG4wXpN3/rZvfq/W57oqKYmJAwPwuueVT6+GTv1R\n8fsP/h981aQDojr3t8YDTLhD/wKBgQDpqWiMpXZ2TOSbFBPma3LF9Acjg1S8HoBA\nqOzLADQqKCEmMzsHjtB1X2eGAoGnFUC8wBTjz3Ol4T0gnhrUkjUwe5BxkhTsV2Df\nainWeWEUXS6F4WbVne5fqLCxH+OCVjoOZD08pO6PB8dJfrJ1PqmsqA4ye5l76Zsn\n+nBXzrra0QKBgQDa/3Ft4pmc18W90u6GrbAbImx2LgvWI0ntuSAmOOhw2LmTl6vY\n9hXqvwttuBzHIFu4cbToKhcadtZ0l04FDWSQdGLiZBAo8i5YlIpr1PC0DGzZgNIl\nKzPIvXJOw0Y3WNh4gOqWKb4KPjy10SGYqzpJJwipido8JpEEFNKBQb31oQKBgQCr\n8S+wH6o2j4rB21pxeqvwowwFxAS8ka1K54OoNjQsuW77T0Om4h7f4B6r7Hg/3VHQ\nE4DLysKNVFvI/s87kYN2c9bs29RtvjbY8KRs4NDhTViIyD8F/ruExPuQu6iNJqp+\nIKE3WR77PXwWxxbHVB9DoD8iQvXEyziTiKTW2JeDoQKBgQDqgcqB5bV42PM7uYzL\nwbVHGqnrWfyyt0OyjD8x26MYhgXNaOCCwwcH6/CH2w3vjcCUYpR/QCt0xaAmDQJR\nszGWkIrxP2j6yWoKqUQ3p5TjRkYU/jvxWcXVog8rOF3h5SmBkaqPGyvYDbKjHfBk\n6IoZcI/YDOWoPdEdil/qOgzxcA==\n-----END PRIVATE KEY-----\n",
         "private_key":dotenv.env['Private_Key'],
        // "client_email":"firebase-adminsdk-fbsvc@push-notification-14cd2.iam.gserviceaccount.com",
        // "client_id": "114299605697542825442",
        // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        // "token_uri": "https://oauth2.googleapis.com/token",
        // "auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs",
        // "client_x509_cert_url":"https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40push-notification-14cd2.iam.gserviceaccount.com",
        // "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
