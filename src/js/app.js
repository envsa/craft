// * Load a JS library
// 1.) In terminal, npm install <package-name>
// 2.) Here, type import PackageName from 'package-name'
// most JS packages will have instructions for instlaling via NPM/Yarn
// * Load a local component file.
import './modules/example-local.js';
import App from '../vue/App.vue';
import { createApp } from 'vue';

// ! This is just an example of how to dynamically import a module for pages that require it.
// ! In this case, pages that have an element with an ID of "slider-example" will load this JS file.
// ! This is a huge win for performance. No need to load heavy JS libraries on every page if it doesn't need it.

const main = async () => {
  const app = createApp(App);
  const root = app.mount('#component-container');

  if (document.querySelector('#example-slider')) {
    import(
      './modules/example-slider' /* webpackChunkName: "example-slider" */
    ).then((instance) => {
      instance.initSliderExample();
    });
  }

  if (document.querySelector('.alert-banner')) {
    import(
      './modules/alert-banner' /* webpackChunkName: "alert-banner" */
    ).then((instance) => {
      instance.initAlertBanners();
    });
  }

  return root;
};

main().then(() => {});

// For local development / webpack dev server.
if (module.hot) {
  module.hot.accept();
}
