$(window).on('turbolinks:load', function() {
    $("#splash").delay(500).fadeOut('slow'); //ローディング画面を1.5秒（1000ms）待機してからフェードアウト
    $("#splash_logo").delay(1200).fadeOut('slow');//ロゴを1.2秒（1200ms）待機してからフェードアウト
});
