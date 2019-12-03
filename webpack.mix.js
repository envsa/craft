/**
 * ===========================
 * Agency Webpack-Mix Config
 * A capable website/webapp config built for the modern web agency.
 * https://github.com/ben-rogerson/agency-webpack-mix-config
 * ===========================
 *
 * Contents
 *
 * ⚙️ Settings
 * 🎭 Hashing
 * 🎨 Styles
 * 🎨 Styles: CriticalCSS
 * 🎨 Styles: PurgeCSS
 * 🎨 Styles: PostCSS
 * 🎨 Styles: Vendor
 * 🎨 Styles: Other
 * 📑 Scripts
 * 📑 Scripts: Polyfills
 * 📑 Scripts: Auto import libraries
 * 📑 Scripts: Linting
 * 🏞 Images
 * 🎆 Icons
 * 🗂️ Static
 * 🚧 Webpack-dev-server
 */

// ⚙️ Base config
const config = {
  // Dev domain to proxy
  devProxyDomain: process.env.SITE_URL || 'http://site.test',
  // Paths to observe for changes then trigger a full page reload
  devWatchPaths: ['templates'],
  // Port to use with webpack-dev-server
  devServerPort: process.env.DEVSERVER_PORT,
  // Folders where purgeCss can look for used selectors
  purgeCssGrabFolders: ['src', 'templates'],
  // Urls for CriticalCss to look for "above the fold" Css
  criticalCssUrls: [
    { urlPath: '/', label: 'homepage' }
  ],
  // Folder served to users
  publicFolder: 'web',
  // Foldername for built src assets (relative to publicFoler)
  publicBuildFolder: './dist/'
};

// ⚙️ Imports
const mix = require('laravel-mix');
const path = require('path');
const globby = require('globby');

// ⚙️ Source folders
const source = {
  favicons: path.resolve('src/favicons'),
  icons: path.resolve('src/icons'),
  images: path.resolve('src/images'),
  scripts: path.resolve('src/js'),
  styles: path.resolve('src/styles'),
  static: path.resolve('src/static'),
  templates: path.resolve('templates')
};

// Define local scripts that need to be inlined
let inlineScripts = globby.sync(`${source.scripts}/inline/*.{js,mjs}`);
// Add any node modules to the inline scripts
inlineScripts = [
  ...inlineScripts
  // eg. path.resolve('node_modules/module/module.js')
];

// ⚙️ Misc
mix.setPublicPath(config.publicFolder);
mix.disableNotifications();
mix.webpackConfig({ resolve: { alias: source } });
!mix.inProduction() && mix.sourceMaps();

/**
 * 🎭 Hashing (for non-static sites)
 * Mix has querystring hashing by default, eg: main.css?id=abcd1234
 * This script converts it to filename hashing, eg: main.abcd1234.css
 * https://github.com/JeffreyWay/laravel-mix/issues/1022#issuecomment-379168021
 */
const manifestPath = path.join(config.publicFolder, 'mix-manifest.json');

if (mix.inProduction()) {
  // Allow versioning in production
  mix.version();
  // Get the manifest filepath for filehash conversion
  // Run after mix finishes
  mix.then(() => {
    const laravelMixMakeFileHash = require('laravel-mix-make-file-hash');
    laravelMixMakeFileHash(config.publicFolder, manifestPath);
  });
} else {
  mix.then(() => {
    // Clean up the file paths from the manifest file
    const replace = require('replace');
    replace({
      regex: '/dist/',
      replacement: '',
      paths: [manifestPath],
      silent: false
    });
  });
}

/**
 * 🎨 Styles: Main
 * Uses dart-sass which has a replica API to Node-Sass
 * https://laravel-mix.com/docs/4.0/css-preprocessors
 * https://github.com/sass/node-sass#options
 */
// Get a list of style files within the base styles folder
const styleFiles = globby.sync(`${source.styles}/*.{scss,sass}`);
// Data to send to style files
const styleData = `$isDev: ${!mix.inProduction()}; $assetRoot: '/dist/';`;
// Create an asset for every style file
styleFiles.forEach(styleFile => {
  mix.sass(
    styleFile,
    path.join(config.publicFolder, config.publicBuildFolder),
    { prependData: styleData }
  );
});

/**
 * 🎨 Styles: CriticalCSS
 * https://github.com/addyosmani/critical#options
 */
const criticalDomain = config.devProxyDomain;
if (criticalDomain) {
  require('laravel-mix-critical');
  mix.critical({
    enabled: mix.inProduction() && config.criticalCssUrls.length,
    urls: config.criticalCssUrls.map(page => ({
      src: new URL(page.urlPath, criticalDomain).href,
      dest: path.join(
        config.publicFolder,
        config.publicBuildFolder,
        `${page.label}_critical.min.css`
      )
    })),
    options: {
      width: 1200,
      height: 1200
    }
  });
}

/**
 * 🎨 Styles: PurgeCSS
 * https://github.com/spatie/laravel-mix-purgecss#usage
 */
if (config.purgeCssGrabFolders.length) {
  require('laravel-mix-purgecss');
  mix.purgeCss({
    enabled: mix.inProduction(),
    folders: config.purgeCssGrabFolders, // Folders scanned for selectors
    whitelist: [],
    whitelistPatterns: [/icon-*/, /js-*/, /fonts-loaded/],
    extensions: ['php', 'twig', 'html', 'js']
  });
}

/**
 * 🎨 Styles: PostCSS
 * Extend CSS with plugins
 * https://laravel-mix.com/docs/4.0/css-preprocessors#postcss-plugins
 */
mix.options({
  postCss: [
    require('tailwindcss')('./tailwind.config.js'),
    require('postcss-preset-env')({ stage: 2 })
  ]
});

/**
 * 🎨 Styles: Other
 * https://laravel-mix.com/docs/4.0/options
 */
mix.options({
  // Disable processing css urls for speed
  // https://laravel-mix.com/docs/4.0/css-preprocessors#css-url-rewriting
  processCssUrls: false
});

/**
 * 📑 Scripts: Main
 * Script files are transpiled to vanilla JavaScript
 * https://laravel-mix.com/docs/4.0/mixjs
 */
const scriptFiles = globby.sync(`${source.scripts}/*.{js,mjs}`);
scriptFiles.forEach(scriptFile => {
  mix.js(scriptFile, path.join(config.publicFolder, config.publicBuildFolder));
});

inlineScripts.forEach(scriptFile => {
  const ext = path.extname(scriptFile);
  const name = path.basename(scriptFile, ext);

  mix.babel(scriptFile, path.join(config.publicFolder, config.publicBuildFolder, `/inlinejs/${name}.min.js`));
});

/**
 * 📑 Scripts: Polyfills
 * Automatically add polyfills for target browsers with core-js@3
 * See "browserslist" in package.json for your targets
 * https://github.com/zloirock/core-js/blob/master/docs/2019-03-19-core-js-3-babel-and-a-look-into-the-future.md
 * https://github.com/scottcharlesworth/laravel-mix-polyfill#options
 */
require('laravel-mix-polyfill');
mix.polyfill({
  enabled: mix.inProduction(),
  useBuiltIns: 'usage', // Only add a polyfill when a feature is used
  targets: false, // "false" makes the config use browserslist targets in package.json
  corejs: 3,
  debug: true // "true" to check which polyfills are being used
});

/**
 * 📑 Scripts: Auto import libraries
 * Make JavaScript libraries available without an import
 * https://laravel-mix.com/docs/4.0/autoloading
 */
mix.autoload({
  jquery: ['$', 'jQuery', 'window.jQuery']
});

/**
 * 📑 Scripts: Vendor
 * Separate the JavaScript code imported from node_modules
 * https://laravel-mix.com/docs/4.0/extract
 * Without mix.extract you'll see an annoying js error after
 * launching the dev server - this should be fixed in webpack 5
 */
mix.extract([]); // Empty params = separate all node_modules
// mix.extract(['jquery']) // Specify packages to add to the vendor file

/**
 * 📑 Scripts: Linting
 */
if (!mix.inProduction()) {
  require('laravel-mix-eslint');
  mix.eslint();
}

/**
 * 🏞 Images
 * Images are optimized and copied to the build directory
 * https://github.com/Klathmon/imagemin-webpack-plugin#api
 */
require('laravel-mix-imagemin');
mix.imagemin(
  {
    from: path.join(source.images, '**/*'),
    to: path.join(config.publicBuildFolder, '/img'),
    context: 'src/img',
    ignore: '**/favicon_src.*'
  },
  {},
  {
    gifsicle: { interlaced: true },
    mozjpeg: { progressive: true, arithmetic: false },
    optipng: { optimizationLevel: 3 }, // Lower number = speedier/reduced compression
    svgo: {
      plugins: [
        { convertPathData: false },
        { convertColors: { currentColor: false } },
        { removeDimensions: true },
        { removeViewBox: false },
        { cleanupIDs: false }
      ]
    }
  }
);

/**
 * 🎆 Icons
 * Individual SVG icons are optimised then combined into a single cacheable SVG
 * https://github.com/kisenka/svg-sprite-loader#configuration
 */
require('laravel-mix-svg-sprite');
mix.svgSprite(
  source.icons,
  path.join(config.publicBuildFolder, '/sprite.svg'),
  {
    symbolId: filePath => `icon-${path.parse(filePath).name}`,
    extract: true
  }
);

// Icon options
mix.options({
  imgLoaderOptions: {
    svgo: {
      plugins: [
        { convertColors: { currentColor: false } },
        { removeDimensions: false },
        { removeViewBox: false }
      ]
    }
  }
});

/**
 * 🗂️ Static
 * Additional folders with no transform requirements are copied to your build folders
 */
mix.copyDirectory(
  source.static,
  path.join(config.publicFolder, config.publicBuildFolder)
);

/**
 * 🗂️ Favicons
 * Separate the assets and markup to their appropriate folders templates/_partials
 * Due to the way that Laravel Mix versions files and includes them in the manifest,
 * we have to do this in two steps. The only file we want included/versioned is
 * the html_code (the actual markup to include in the template).
 */
mix.copyDirectory(
  source.favicons,
  path.join(config.publicFolder, config.publicBuildFolder, '/favicons')
);

mix.copy(
  `${source.favicons}/html_code.html`,
  path.join(config.publicFolder, config.publicBuildFolder, '/favicons')
);

/**
 * 🚧 Webpack-dev-server
 * https://webpack.js.org/configuration/dev-server/
 */
mix.webpackConfig({
  devServer: {
    clientLogLevel: 'none', // Hide console feedback so eslint can take over
    open: true, // open default browser
    overlay: true, // show compiler errors in browser as overlay
    port: config.devServerPort,
    public: `localhost:${config.devServerPort}`,
    host: '127.0.0.1', // Allows access from network
    hot: true,
    https: config.devProxyDomain.includes('https://'),
    cert: process.env.DEVSERVER_CERT,
    key: process.env.DEVSERVER_KEY,
    contentBase: config.devWatchPaths.length ? config.devWatchPaths : undefined,
    watchContentBase: config.devWatchPaths.length > 0,
    watchOptions: {
      aggregateTimeout: 200,
      poll: 200, // Lower for faster reloads (more cpu intensive)
      ignored: ['storage', 'node_modules', 'vendor']
    },
    disableHostCheck: true, // Fixes "Invalid Host header error" on assets
    headers: {
      'Access-Control-Allow-Origin': '*'
    },
    proxy: {
      '**': {
        target: config.devProxyDomain,
        changeOrigin: true,
        secure: false
      }
    }
  }
});
