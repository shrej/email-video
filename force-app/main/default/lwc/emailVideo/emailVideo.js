import { api, LightningElement } from "lwc";
import { getComputedImageUrl } from "./utils";

export default class EmailVideo extends LightningElement {
  @api
  destinationUrl = "";

  @api
  imageUrl = "";

  @api
  customRedirectUrl = "";

  @api
  playButtonType = "Light";

  aspectRatioAdjustmentImageUrl =
    "https://user-images.githubusercontent.com/12212922/125086855-dfcb2400-e080-11eb-9fb3-49abdcd28f94.gif";

  get computedImageUrl() {
    return this.imageUrl || getComputedImageUrl(this.destinationUrl);
  }

  get computedDestinationUrl() {
    return this.customRedirectUrl &&
      this.customRedirectUrl !== "no-redirect-selected"
      ? this.customRedirectUrl
      : this.destinationUrl;
  }

  get showLightPlayButton() {
    return this.playButtonType === "Light";
  }
}
