$(document).on('turbolinks:load', function () {
    const mainContent = $('#main-content');
    const footer = $('#main-footer');

    // Check if the height of the main content exceeds 100vh
    function checkHeight() {
        if (mainContent.height() > $(window).height()) {
            footer.removeClass('fixed-bottom');
        } else {
            footer.addClass('fixed-bottom');
        }
    }

    // Call the checkHeight function on document ready and window resize
    checkHeight();
    $(window).resize(checkHeight);
});