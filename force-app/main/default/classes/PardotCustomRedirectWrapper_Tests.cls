@isTest
private class PardotCustomRedirectWrapper_Tests {
  // Verify that Redirects are parsed correctly
  @isTest
  static void testOneCustomRedirect() {
    PardotCustomRedirectWrapper wrapper = PardotCustomRedirectWrapper.parse(
      '{\"values\":[{\"name\":\"Awesome Url\",\"trackedUrl\":\"https://www.example.com\"}]}'
    );
    List<PardotCustomRedirect> customRedirects = wrapper.values;
    System.assertEquals(
      1,
      customRedirects.size(),
      'Expected one custom redirect'
    );
    System.assertEquals(
      'Awesome Url',
      customRedirects[0].name,
      'Expected the name of the custom redirect to be Awesome Url'
    );
    System.assertEquals(
      'https://www.example.com',
      customRedirects[0].trackedUrl,
      'Expected the trackedUrl for the Custom Redirect to be https://example.com'
    );
  }

  // Verify that no exceptions are thrown in case the API returns null
  @isTest
  static void testEmptyCustomRedirect() {
    PardotCustomRedirectWrapper wrapper = PardotCustomRedirectWrapper.parse('');
    System.assertEquals(
      null,
      wrapper,
      'Expected the PardotCustomRedirectWrapper to be null'
    );
  }

  // Verify that no exceptions are thrown in case the API returns an empty response
  @isTest
  static void testNullCustomRedirect() {
    PardotCustomRedirectWrapper wrapper = PardotCustomRedirectWrapper.parse('');
    System.assertEquals(
      null,
      wrapper,
      'There should be no Custom Redirects in the List'
    );
  }
}
