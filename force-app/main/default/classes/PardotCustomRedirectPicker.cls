/**
 * @description Helps in the generation of Dynamic Picklist options that can be used in an LWC in the builder
 *
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class PardotCustomRedirectPicker extends VisualEditor.DynamicPickList {
  private static final VisualEditor.DataRow DEFAULT_ROW = new VisualEditor.DataRow(
    '-- Select a Custom Redirect --',
    'no-redirect-selected'
  );
  private static final VisualEditor.DataRow NO_CUSTOM_REDIRECTS_FOUND = new VisualEditor.DataRow(
    '-- No Custom Redirects Found --',
    ''
  );
  private asj__VideoComponentSetting__mdt settings = PardotCustomRedirectsHelper.getPardotSettings();
  private List<PardotCustomRedirect> customRedirects = PardotCustomRedirectsHelper.getPardotCustomRedirects(
    settings
  );

  /**
   * @description Get the default value for the dropdowns.
   * If Pardot Connection was successful, and there are Custom Redirects in the org,
   * we return '-- Select a Custom Redirect --'
   * Else, we return '-- No Custom Redirects Found --'.
   * @return VisualEditor.DataRow
   */
  global override VisualEditor.DataRow getDefaultValue() {
    if (this.customRedirects.size() > 0) {
      return DEFAULT_ROW;
    }
    return NO_CUSTOM_REDIRECTS_FOUND;
  }

  /**
   * @description Returning true always to avoid an error in the builder
   * @return Boolean
   */
  global override Boolean isValid(Object attributeValue) {
    return true;
  }

  /**
   * @description Get a list of dynamic picklist options
   * @return VisualEditor.DynamicPickListRows
   */
  global override VisualEditor.DynamicPickListRows getValues() {
    VisualEditor.DynamicPickListRows customRedirectRows = new VisualEditor.DynamicPickListRows();
    if (this.customRedirects.size() > 0) {
      // Our connection was successful, and we have custom redirects in the Pardot Org!
      customRedirectRows.addRow(DEFAULT_ROW);
      for (PardotCustomRedirect customRedirect : this.customRedirects) {
        VisualEditor.DataRow customRedirectRow = new VisualEditor.DataRow(
          customRedirect.name,
          customRedirect.trackedUrl
        );
        customRedirectRows.addRow(customRedirectRow);
      }
    } else {
      // Either the Pardot Org is not connected, or there are no redirects in the Org.
      // In the future, we may want to distinguish between these 2 conditions
      customRedirectRows.addRow(NO_CUSTOM_REDIRECTS_FOUND);
    }
    return customRedirectRows;
  }
}
