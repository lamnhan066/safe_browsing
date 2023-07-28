/// Result state of the Safe Browsing
enum SafeBrowsingStateType {
  /// Safe
  safe,

  /// Not safe. See `SafeBrowsingState.matches` for more information.
  notSafe,

  /// Empty threat entry
  empty,

  /// Error with the request
  requestError,

  /// Unknow error
  unknown;
}
