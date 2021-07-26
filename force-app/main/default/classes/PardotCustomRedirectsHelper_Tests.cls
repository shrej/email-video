@isTest
private class PardotCustomRedirectsHelper_Tests {
  @isTest
  private static void testGetPardotCustomRedirects() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('mockGetPardotCustomRedirects');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    // Get Pardot Settings
    asj__VideoComponentSetting__mdt settings = PardotCustomRedirectsHelper.getPardotSettings();
    // Call method to test
    List<PardotCustomRedirect> customRedirects = PardotCustomRedirectsHelper.getPardotCustomRedirects(
      settings
    );
    // Verify mock response is not null
    System.assertNotEquals(
      null,
      customRedirects,
      'Expected the response to not be null'
    );
    // Verify the List contains 2 items
    System.assertEquals(
      1,
      customRedirects.size(),
      'Expected the list to contain 1 item'
    );
    // Verify the item's properties
    System.assertEquals(
      'Youtube Video',
      customRedirects[0].name,
      'Expected the name of the redirect to be "Youtube Video".'
    );
    System.assertEquals(
      'http://www.example.com',
      customRedirects[0].trackedUrl,
      'Expected the trackedUrl of the redirect to be "http://www.example.com".'
    );
  }

  @isTest
  private static void testGetPardotCustomRedirectsWithProdSettings() {
    // Get Pardot Settings
    asj__VideoComponentSetting__mdt settings = PardotCustomRedirectsHelper.getPardotSettings();
    settings.PardotEnvironment__c = 'production';
    List<PardotCustomRedirect> customRedirects = PardotCustomRedirectsHelper.getPardotCustomRedirects(
      settings
    );
    // Verify mock response is not null
    System.assertNotEquals(
      null,
      customRedirects,
      'The getPardotCustomRedirects should not return a null response.'
    );
    // Verify the List contains 0 items
    System.assertEquals(
      0,
      customRedirects.size(),
      'Expected the list to contain 0 item'
    );
  }

  @isTest
  private static void testGetPardotCustomRedirectsWithNullSettings() {
    List<PardotCustomRedirect> customRedirects = PardotCustomRedirectsHelper.getPardotCustomRedirects(
      null
    );
    // Verify mock response is not null
    System.assertNotEquals(
      null,
      customRedirects,
      'The getPardotCustomRedirects should not return a null response.'
    );
    // Verify the List contains 0 items
    System.assertEquals(
      0,
      customRedirects.size(),
      'Expected the list to contain 0 items'
    );
  }

  @isTest
  private static void testGetPardotCustomRedirectsWithException() {
    try {
      List<PardotCustomRedirect> customRedirects = PardotCustomRedirectsHelper.getPardotCustomRedirects(
        null
      );
    } catch (Exception unexpectedException) {
      System.assert(false, 'Exceptions should be handled by the method');
    }
  }
}
