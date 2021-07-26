/**
 * @description A helper class to retrieve Pardot Business Unit Id and Custom Redirects
 */
public with sharing class PardotCustomRedirectsHelper {
  private static final String CUSTOM_REDIRECT_URL_PART = '/v5/objects/custom-redirects?fields=name,trackedUrl';
  private static final String NAMESPACE_PREFIX_PART = 'asj__';
  /**
   * @description Get Pardot Named Credentials
   * @param  pardotBuisnessUnitId The Pardot Buisness Unit ID
   * @return List<PardotCustomRedirect>
   */
  public static List<PardotCustomRedirect> getPardotCustomRedirects(
    asj__VideoComponentSetting__mdt pardotSettings
  ) {
    List<PardotCustomRedirect> customRedirects = new List<PardotCustomRedirect>();
    String calloutUrl;
    String pardotBuisnessUnitId;
    String pardotEnvironment;
    if (pardotSettings != null) {
      pardotBuisnessUnitId = pardotSettings.PardotBuisnessUnitId__c;
      pardotEnvironment = pardotSettings.PardotEnvironment__c;
    }
    // If no pardotBuisnessUnitId or environment was provided, return an empty list of redirects
    if (pardotBuisnessUnitId == null || pardotEnvironment == null) {
      return customRedirects;
    }
    calloutUrl = getCallOutUrl(pardotEnvironment);
    try {
      HttpRequest request = new HttpRequest();
      request.setEndpoint(calloutUrl);
      request.setHeader('Pardot-Business-Unit-Id', pardotBuisnessUnitId);
      request.setMethod('GET');
      Http http = new Http();
      HTTPResponse response = http.send(request);
      if (response.getStatusCode() == 200) {
        // Our request was successful! Let's add to the list of redirects
        PardotCustomRedirectWrapper wrapper = PardotCustomRedirectWrapper.parse(
          response.getBody()
        );
        if (wrapper != null && wrapper.values != null) {
          customRedirects.addAll(wrapper.values);
        }
      } else {
        // Something went wrong.
        System.debug(
          'The status code returned was not expected: ' +
          response.getStatusCode() +
          ' ' +
          response.getStatus()
        );
      }
    } catch (Exception e) {
      System.debug(
        ' There was an error in executing the callout' + e.getMessage()
      );
    }
    return customRedirects;
  }

  /**
   * @description Get Pardot Buisness Unit ID stored in a Custom Metadata Type
   * @param  pardotBuisnessUnitId The Pardot Buisness Unit ID
   * @return String
   */
  public static asj__VideoComponentSetting__mdt getPardotSettings() {
    List<asj__VideoComponentSetting__mdt> settings = [
      SELECT PardotBuisnessUnitId__c, PardotEnvironment__c
      FROM asj__VideoComponentSetting__mdt WITH_SECURITY_ENFORCED
      WHERE DeveloperName = 'Default'
    ];
    if (settings != null && settings.size() > 0) {
      return settings[0];
    } else {
      return null;
    }
  }

  /**
   * @description Get Callout URL based on the Environment
   * @param  environment Either 'demo' or 'production'
   * @return String
   */
  private static String getCallOutUrl(String environment) {
    if (environment == 'demo') {
      return 'callout:' +
        NAMESPACE_PREFIX_PART +
        'VideoComponentNamedCredentialDemoOrg' +
        CUSTOM_REDIRECT_URL_PART;
    } else {
      return 'callout:' +
        NAMESPACE_PREFIX_PART +
        'VideoComponentNamedCredentialProductionOrg' +
        CUSTOM_REDIRECT_URL_PART;
    }
  }
}
