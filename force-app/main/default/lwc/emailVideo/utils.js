export function getComputedImageUrl(videoUrl) {
  if (!videoUrl) {
    return "";
  }
  if (videoUrl.includes("youtu") && videoUrl.includes("?v=")) {
    const videoId = videoUrl.split("?v=")[1];
    return `https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`;
  }
  if (videoUrl.includes("dailymotion") && videoUrl.includes("/video/")) {
    const urlWithoutQueryParams = videoUrl.split("?")[0];
    const videoId = urlWithoutQueryParams.split("/video/")[1];
    return `https://www.dailymotion.com/thumbnail/video/${videoId}`;
  }
  return "";
}
