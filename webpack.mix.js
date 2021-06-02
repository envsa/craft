const mix = require('laravel-mix');
const replace = require('replace');
const path = require('path');
const globby = require('globby');
const webpack = require('webpack');
const { config, source, devServer } = require('./mix.config');

/**
 * Checklist
 * [✅] Hashing/cleanup mix-manifest
 * [✅] Scripts: Main
 * [✅] Styles: Main
 * [✅] Styles: CriticalCSS
 * [✅] Inline js processing
 * [✅] Devserver HMR
 * [ ] Images
 * [✅] Static
 */

mix.setPublicPath(config.publicPath);
mix.sourceMaps(!mix.inProduction(), 'source-map');
mix.disableNotifications();
mix.alias({
  '@': path.resolve('./src')
});

/**
 * Set devmode
 */
mix.before(() => {
  const status = mix.inProduction() ? 0 : 1;
  replace({
    regex: 'DEV_MODE=[1|0]',
    replacement: `DEV_MODE=${status}`,
    paths: ['.env'],
    silent: true
  });
});

/**
 * Scripts: Main
 * https://laravel-mix.com/docs/6.0/mixjs
 */
const scriptFiles = globby.sync(`${source.scripts}/[^_]*.js`);
scriptFiles.forEach((file) => {
  const scriptTask = mix.js(file, path.join(config.publicPath, '/js/'));

  switch (config.jsFramework) {
    case 'vue':
      scriptTask.vue();
      break;

    case 'react':
      scriptTask.react();
      break;

    default:
      scriptTask;
      break;
  }
});

/**
 * Scripts: Inline
 * Vanilla js that can be written in modern js but compiled
 * down to have support in the browser.
 * We handle these separately to the normal js because we don't
 * want it filled up with webopack nonsense
 */
const inlineScriptFiles = globby.sync(`${source.scripts}/inline/[^_]*.js`);
inlineScriptFiles.forEach((file) => {
  const ext = path.extname(file);
  const name = path.basename(file, ext);
  mix.babel(file, path.join(config.publicPath, `/js/inline/${name}.min.js`));
});

/**
 * Styles: Main
 * https://laravel-mix.com/docs/6.0/postcss
 */
// Get a list of style files within the base styles folder
// ignore files with a preceding underscore
const styleFiles = globby.sync(`${source.styles}/[^_]*.{css,pcss}`);
styleFiles.forEach((file) => {
  mix.postCss(file, path.join(config.publicPath, '/css/'));
});

/**
 * Styles: CriticalCSS
 * https://laravel-mix.com/extensions/criticalcss
 */
if (config.criticalDomain && config.criticalCssUrls.length) {
  require('laravel-mix-criticalcss');
  mix.criticalCss({
    enabled: mix.inProduction(),
    paths: {
      base: config.criticalDomain.href,
      templates: path.join(config.publicPath, '/css/critical/'),
      suffix: config.criticalCssSuffix
    },
    urls: config.criticalCssUrls,
    options: {
      minify: true,
      width: 1200,
      height: 1200
    }
  });
}

/**
 * Images
 * https://laravel-mix.com/docs/6.0/copying-files
 *
 * TODO: update this to handle basic image processing too
 */
mix.copyDirectory(source.images, path.join(config.publicPath, 'images'));

/**
 * Static
 * https://laravel-mix.com/docs/6.0/copying-files
 */
mix.copyDirectory(source.static, path.join(config.publicPath, 'static'));

mix.webpackConfig({
  target: 'web',
  output: {
    publicPath: devServer.outputPath()
  },
  devServer: {
    host: devServer.host,
    port: devServer.port,
    dev: {
      publicPath: devServer.path
    },
    client: {
      port: devServer.port,
      host: devServer.clientHost,
      overlay: true,
      progress: false
    },
    firewall: false,
    static: {
      directory: './templates',
      publicPath: '/',
      watch: true
    },
    liveReload: true
  },
  infrastructureLogging: {
    level: 'log'
  },
  plugins: [
    new webpack.DefinePlugin({
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false
    })
  ]
});

if (mix.inProduction()) {
  mix.webpackConfig({
    output: {
      publicPath: '/dist/',
      chunkFilename: 'js/modules/[name].[chunkhash:20].js',
      clean: true
    },
    optimization: {
      chunkIds: 'named',
      moduleIds: 'named'
    }
  });
  mix.version();
  mix.then(() => {
    const convertToFileHash = require('laravel-mix-make-file-hash');
    convertToFileHash({
      publicPath: config.publicPath,
      manifestFilePath: path.resolve(config.publicPath, 'mix-manifest.json'),
      blacklist: ['js/modules/**/*.js', 'images/**/*', 'static/**/*'],
      keepBlacklistedEntries: false
    });
  });
}
