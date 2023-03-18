$(document).scroll(function () {
    const scroll = $(window).scrollTop();
    const headerHeight = $('#main-header').outerHeight();

    if (scroll >= headerHeight) {
        $('#main-header').addClass('bg-white');
    } else {
        $('#main-header').removeClass('bg-white');
    }
});