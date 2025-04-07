import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        // "type": "service_account",
        // "project_id": "swift-shop-1",
        // "private_key_id": "714e0dc506d8b4fcddfed7e52d52f3869b0c21f4",
        // "private_key":
        //     "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCH4BHS7RMj510y\nLUL/Wwy2oWpXKNdxuRFUlsJfQJwOIAXRwtxa8kDWY5/TTBoxAH8r1534ZEi4Jscr\nl9LxfVqbFRQ3UY5JZlA1UfJIlwccVl3dpyhzJ43HrKgywZW0iPxXkzIMutjxzF9N\nfh/BIwtzv+K1DPdITE9eD4hfufVmltpRG+EmFIg55IvUd/hwHytjt01u5yqtLhVM\nlmaYd7x1PGEgPNMCp35xcmQN+ueQipK51/Bgi3iDx6ugjwZlYScNyuL9gcyL7vPR\n2S71sEXYJVgtZ0jiQbXf5IpWzLFqOJSLl0OLG8bMIVVRlAUcn6r036PXcYf5iMCA\n3WBuQPRpAgMBAAECggEALdZ0jOC3rUwXD59fU8AGmPH5au/3RoE1jIDTj8i/HLDG\n5c3EAtZo8ypmt6SbzV4qiMLTowFJ2v4SAO3WFuvADkNdL5BO3QosEuDTSJPSrUeh\noO4MYlS8qtjfYUgXVfFEl9Krdsnt+ByHJiBfXAuTiHf6ZjO6lGRR/hxlWE3msLXD\njTfYjFLOFT4U/2j+xCai3dIpooN0k/5o8TcBLS3cH1pshoLERckIJZHJ3JBDEUSp\nYDQn0ZzbDD3/rz8OBrG7/hktd7H/uVUimYAn9DznDWn7f98I7Q0kO17BniDZpvje\n29la+yWLtBeQK2vvd+4l8AhpSzVmbCven6YBxb97tQKBgQC/fqn+VNwrB04Ks8Jt\n4bFAjOn6MMHmZxjtAkz0snyiAtXOEsqwa4/RBMY0utZBCHuIQrdu6yPCAZr6RPYk\nf7ktqSxLZdSePfpFOF4obpE12BmrYzKwN9WQRF/Jgr/zyG4CFbDQLPlhw135nMML\nMi5jGrGtPvFTYZrTmrQy7rc9MwKBgQC1pR69bT4347ixw/Msl1Q2Nolup2u2VU8l\nTqEvnjm1GuRS3vPqPYxw2QqJf3dULO9pQ54RbEXn/AIbKfAalEUppQgPBQvYi/CV\ndzuUNC7CoCvOw6sw1ftaRkBAhdb+XFKmgc0JZwtI48+7r02x4mk/EsMV2hCKuRaX\n21+eBpSv8wKBgDZE4k5GpGK5Xj+gNBDJ7l7Z0JFr8fem7iR1C3QphTKw1QDiyHh4\n8zgMP1PAQ2oIymGSbsPLdcXMiKw2kP9FByjOkdQIVtpFvECTufOBaju1M4kjwsC4\nAhkxl2fXWyjue2ax2PsWU9KF+IL+DzSEEytY7FOpy+CSf7tKU5k/l8SLAoGAWklD\nmUY2edM/12Qdd9mUKwo6j3y6JjwLBfEqXx/XcTR3rtVRCeoj52eKPEPWTUm0im7o\nn6JgsOlrJpNW2+883XFBKy4H8E/GepR0UbsKTwUMIU7SxYhm0j0+7JNaBL5g+pBk\nGLtWOZm6hICjLrrqM0ahHzhvpnRPTZXl1gdRWo8CgYA4iNsPuvCfVXt+SZXs4BBn\nSw0zeQKq5YrH0YuBA7JPx5+FQprIPVJ1ZDu+GBtKpFzW4H3FhhmtKVhlDKasaIy9\n/AxEbnzys+IbK4uMsoQIFTqs3vobAOWVpGjqGsM3zMnXFglZxbKKc5fvXLXrE+YP\nhJHWZAraSlk6dfBBHsa+7A==\n-----END PRIVATE KEY-----\n",
        // "client_email":
        //     "firebase-adminsdk-fbsvc@swift-shop-1.iam.gserviceaccount.com",
        // "client_id": "114293269525183735331",
        // "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        // "token_uri": "https://oauth2.googleapis.com/token",
        // "auth_provider_x509_cert_url":
        //     "https://www.googleapis.com/oauth2/v1/certs",
        // "client_x509_cert_url":
        //     "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40swift-shop-1.iam.gserviceaccount.com",
        // "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
