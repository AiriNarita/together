$(window).on("turbolinks:load", function () {
  if (window.sessionStorage.getItem("splash") === "true") {
    $("#splash").remove(); //ローディング画面を削除
  } else {
    $("#splash").delay(500).fadeOut("slow"); //ローディング画面を1.5秒（1000ms）待機してからフェードアウト
    $("#splash_logo").delay(1200).fadeOut("slow"); //ロゴを1.2秒（1200ms）待機してからフェードアウト
    window.sessionStorage.setItem("splash", "true");
  }
});
