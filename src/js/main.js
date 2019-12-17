// Import all modules here
import './modules/svgIconSprite';

const main = async () => {
  document.documentElement.classList.remove('no-js');
  const Lazysizes = await import(/* webpackChunkName: "lazysizes" */ 'lazysizes');
  // eslint-disable-next-line
  const LazySizesBgSet = await import(/* webpackChunkName: "lazysizes" */ 'lazysizes/plugins/bgset/ls.bgset.js');
  Lazysizes.init();
};

main().then((value) => {

});

/**
 * Accept hot reloading from dev server
 * Without this you may see this warning in your console:
 * "[HMR] Cannot apply update. Need to do a full reload!"
 */
if (module.hot) module.hot.accept();
