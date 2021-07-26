/**
 * @description A Wrapper Class to deserialize pardot custom redirects recived
 * from the Pardot API.
 */
public with sharing class PardotCustomRedirectWrapper {
  public List<PardotCustomRedirect> values;

  /**
   * @description A helper method to parse the JSON response recived from the API
   * Call.
   * @return PardotCustomRedirectWrapper - An object with a 'values' properties
   * which contains the list of redirects
   **/
  public static PardotCustomRedirectWrapper parse(String json) {
    try {
      return (PardotCustomRedirectWrapper) System.JSON.deserialize(
        json,
        PardotCustomRedirectWrapper.class
      );
    } catch (Exception e) {
      System.debug(e.getMessage());
      return null;
    }
  }
}
