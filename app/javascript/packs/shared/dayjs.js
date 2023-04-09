import dayjs from "dayjs"
import relativeTime from "dayjs/plugin/relativeTime"
import 'dayjs/locale/ja';
dayjs.extend(relativeTime)
dayjs.locale('ja');

$(document).on('turbolinks:load', function () {
  $("p[data-utc-time]").each(function () {
    var timestamp = $(this).attr("data-utc-time");
    var localeTimestamp = new Date(timestamp).toLocaleString();
    // var localeTimestamp = dayjs(new Date(timestamp)).fromNow()
    $(this).html(localeTimestamp);
  });
  $("span[data-utc-time]").each(function () {
    var timestamp = $(this).attr("data-utc-time");
    var localeTimestamp = new Date(timestamp).toLocaleString();
    // var localeTimestamp = dayjs(new Date(timestamp)).fromNow()
    $(this).html(localeTimestamp);
  });
});
