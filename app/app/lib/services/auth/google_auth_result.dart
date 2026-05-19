/// Google Sign-In payload passed to SAA backend for token exchange.
class GoogleAuthResult {
  const GoogleAuthResult({
    required this.idToken,
    this.accessToken,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  final String idToken;
  final String? accessToken;
  final String? email;
  final String? displayName;
  final String? photoUrl;
}

/// User dismissed the Google account picker.
class GoogleSignInCancelledException implements Exception {
  @override
  String toString() => 'Google sign-in was cancelled';
}
