import { createApp } from 'vue';
import Collapse from '@/vue/Collapse';

const App = createApp({
  components: { Collapse }
});

export function initCollapse(element) {
  App.mount(element);
}
