$(function () {
  $("p[data-utc-time]").each(function () {
    var timestamp = $(this).attr("data-utc-time");
    var localeTimestamp = new Date(timestamp).toLocaleString();
    $(this).html(localeTimestamp);
  });
  $("span[data-utc-time]").each(function () {
    var timestamp = $(this).attr("data-utc-time");
    var localeTimestamp = new Date(timestamp).toLocaleString();
    $(this).html(localeTimestamp);
  });
});
