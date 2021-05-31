import { createApp } from 'vue';
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/swiper.min.css';

import SwiperCore, { Navigation, Autoplay } from 'swiper';
SwiperCore.use([Navigation, Autoplay]);

const App = createApp({
  components: { Swiper, SwiperSlide }
});

export function initHeroSlider(element) {
  App.mount(element);
}
