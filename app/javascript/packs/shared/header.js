$(document).scroll(function () {
    const header = $('#main-header');
    const scroll = $(window).scrollTop();
    const headerHeight = header.outerHeight();
    const toggler = $("#header-navbar-toggler");
    const isExpanded = toggler.attr("aria-expanded") === 'true';
    // header navにnavbar-expand-lgを設定したからlg !
    // https://getbootstrap.com/docs/4.6/layout/overview/#responsive-breakpoints
    const isSmallScreen = window.matchMedia("(max-width: 992px)").matches;
    const isScrollAtTop = scroll < headerHeight

    // 画面が小さい場合、またはスクロール位置がヘッダーの高さ以下の場合は、白の背景を追加します
    if (scroll >= headerHeight) {
        header.addClass('bg-white');
    } else {
        if (isSmallScreen && isExpanded && !isScrollAtTop) {
            return;
        }
        header.removeClass('bg-white');

    }
});


$(document).on("turbolinks:load", function () {
    const header = $('#main-header');
    const toggler = $("#header-navbar-toggler");

    toggler.click(function () {
        const isExpanded = toggler.attr("aria-expanded") === 'true';
        const isSmallScreen = window.matchMedia("(max-width: 992px)").matches;
        const isScrollAtTop = $(window).scrollTop() < header.outerHeight();
        if (isScrollAtTop) {
            header.addClass('bg-white');
        }

        // ナビゲーションが開いている場合は、白い背景を追加します
        if (!isExpanded) {
            header.addClass('bg-white');
            return;
        }

        // ナビゲーションが閉じていて画面が小さい場合は、白い背景を取り除きます
        console.log(isSmallScreen, isScrollAtTop)
        if (isSmallScreen && isScrollAtTop) {
            header.removeClass('bg-white');
            return;
        }
    });
});
