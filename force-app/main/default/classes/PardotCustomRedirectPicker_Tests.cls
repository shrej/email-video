@isTest
private class PardotCustomRedirectPicker_Tests {
  @isTest
  private static void testGetDefaultValuesWhenNoResponse() {
    PardotCustomRedirectPicker customRedirectPicker = new PardotCustomRedirectPicker();
    VisualEditor.DataRow defaultRow = customRedirectPicker.getDefaultValue();
    System.assertNotEquals(
      null,
      defaultRow,
      'Expected the default row to be not null'
    );
    System.assertEquals(
      '-- No Custom Redirects Found --',
      defaultRow.getLabel(),
      'Expected the default label to be : "-- No Custom Redirects Found --"'
    );
    System.assertEquals(
      '',
      defaultRow.getValue(),
      'Expected the default value to be : Empty String'
    );
  }

  @isTest
  private static void testGetDefaultValuesWhenCustomRedirects() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('mockGetPardotCustomRedirects');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    PardotCustomRedirectPicker customRedirectPicker = new PardotCustomRedirectPicker();
    VisualEditor.DataRow defaultRow = customRedirectPicker.getDefaultValue();
    System.assertNotEquals(
      null,
      defaultRow,
      'Expected the default row to be not null'
    );
    System.assertEquals(
      '-- Select a Custom Redirect --',
      defaultRow.getLabel(),
      'Expected the default label to be : "-- Select a Custom Redirect --"'
    );
    System.assertEquals(
      'no-redirect-selected',
      defaultRow.getValue(),
      'Expected the default value to be : "no-redirect-selected"'
    );
  }

  @isTest
  private static void testGetPicklistValuesWhenValidResponse() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('mockGetPardotCustomRedirects');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    PardotCustomRedirectPicker customRedirectPicker = new PardotCustomRedirectPicker();
    VisualEditor.DynamicPickListRows picklistValues = customRedirectPicker.getValues();
    System.assertNotEquals(null, picklistValues, 'Rows should not be null');
    System.assertEquals(2, picklistValues.size(), 'Expected 2 picklist items');
    System.assertEquals(
      '-- Select a Custom Redirect --',
      picklistValues.get(0).getLabel(),
      'Expected the first picklist label to be : "-- Select a Custom Redirect --"'
    );
    System.assertEquals(
      'no-redirect-selected',
      picklistValues.get(0).getValue(),
      'Expected the first picklist value to be : "no-redirect-selected"'
    );
    System.assertEquals(
      'Youtube Video',
      picklistValues.get(1).getLabel(),
      'Expected the second picklist label to be : "Youtube Video"'
    );
    System.assertEquals(
      'http://www.example.com',
      picklistValues.get(1).getValue(),
      'Expected the second picklist value to be : "Youtube Video"'
    );
  }

  @isTest
  private static void testGetPicklistValuesWhenInValidResponse() {
    PardotCustomRedirectPicker customRedirectPicker = new PardotCustomRedirectPicker();
    VisualEditor.DynamicPickListRows picklistValues = customRedirectPicker.getValues();
    System.assertNotEquals(
      null,
      picklistValues,
      'Expected Picklist Values to be not null'
    );
    System.assertEquals(1, picklistValues.size(), 'Expected 1 picklist value');
    System.assertEquals(
      '-- No Custom Redirects Found --',
      picklistValues.get(0).getLabel(),
      'Expected the picklist label to be : "-- No Custom Redirects Found --"'
    );
    System.assertEquals(
      '',
      picklistValues.get(0).getValue(),
      'Expected the picklist value to be Empty String'
    );
  }

  @isTest
  private static void testIsValid() {
    PardotCustomRedirectPicker customRedirectPicker = new PardotCustomRedirectPicker();
    Boolean isValid = customRedirectPicker.isValid(null);
    System.assertEquals(
      true,
      isValid,
      'Expected isValid to always return true'
    );
  }
}
