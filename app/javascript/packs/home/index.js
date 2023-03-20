// https://swiperjs.com/get-started

import Swiper, { Autoplay, Pagination } from 'swiper';

$(document).on('turbolinks:load', function () {
    new Swiper(".intro-swiper", {
        direction: 'horizontal',
        loop: true,
        autoplay: {
            delay: 1000 * 3
        },
        pagination: {
            el: '.swiper-pagination',
        },
        modules: [Autoplay, Pagination]
    });
});