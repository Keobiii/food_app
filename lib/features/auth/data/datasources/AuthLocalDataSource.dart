abstract class AuthLocalDatasource {
  Future<void> cachedUserId(String uid);
  Future<String?> getCachedUserId();
  Future<void> clearUserId();
}