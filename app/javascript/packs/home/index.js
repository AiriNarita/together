import Swiper from 'swiper'

document.addEventListener('DOMContentLoaded', () => {
    new Swiper(".intro-swiper", {
        direction: 'horizontal',
        loop: true,
        autoplay: {
            delay: 1000 * 3
        },
        pagination: {
            el: '.swiper-pagination',
        },
    });
});