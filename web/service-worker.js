/* global workbox, importScripts */
importScripts('https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js');

// Force development builds off or on
workbox.setConfig({ debug: true });

workbox.core.setCacheNameDetails({
  prefix: 'example',
  precache: 'precache',
  runtime: 'runtime'
});

// Caching rules

// Placeholder. At build-time, the Workbox plugin replaces the empty array with the list of resources to precache.
workbox.precaching.precacheAndRoute([
  {
    "url": "dist/fonts/Dewnrger67BoldCondensed.woff2",
    "revision": "6c3f17163eb127c3afc3ad0cd46236bd"
  },
  {
    "url": "dist/fonts/Dewnrger68BoldCondensedItalic.woff2",
    "revision": "1818c44751a82adb211754a863f79472"
  },
  {
    "url": "dist/fonts/ProximaNovaBold.woff2",
    "revision": "d0cad0875b54e7f49f6959d681fc21fd"
  },
  {
    "url": "dist/fonts/ProximaNovaBoldItalic.woff2",
    "revision": "f6b9bee44af469d4c70074a089e2eae2"
  },
  {
    "url": "dist/fonts/ProximaNovaItalic.woff2",
    "revision": "fdbf4e0ccea7d6ebd832a429e7d26cab"
  },
  {
    "url": "dist/fonts/ProximaNovaRegular.woff2",
    "revision": "ec615e3f7f8a645016bfe2544fc7741a"
  },
  {
    "url": "dist/main.abc82e831b57bf87d88b.js",
    "revision": "abc82e831b57bf87d88b39aa6f45982d"
  },
  {
    "url": "dist/main.c42f5707efc143a01c28.css",
    "revision": "c42f5707efc143a01c28f51349ed05d3"
  },
  {
    "url": "dist/manifest.5171d11a0f19b42fcd56.js",
    "revision": "5171d11a0f19b42fcd56d1a12d78eca4"
  },
  {
    "url": "dist/sprite.e7d4a712dfe2c4c23259.svg",
    "revision": "e7d4a712dfe2c4c232591bb2cff5b9ff"
  },
  {
    "url": "dist/vendor.1a6dd91bef82266bd9d0.js",
    "revision": "1a6dd91bef82266bd9d0b3f45aada64c"
  },
  {
    "url": "dist/images/site/offline.png",
    "revision": "463415cc4c57ea8a14495e818d22461d"
  }
],
{
  cleanUrls: true
});

// "Warm" the cache
self.addEventListener('install', (event) => {
  const urls = [
    '/',
    '/offline'
    // Any other useful urls
  ];

  const cacheName = 'all-cache'; // workbox.core.cacheNames.runtime
  event.waitUntil(
    caches.open(cacheName)
      .then((cache) => {
        return cache.addAll(urls);
      })
      // Make error a little more traceable
      .catch((error) => {
        console.error(`${cacheName}: ${error}`);
      })
  );
});

// cache dynamic routes e.g. API calls
// cache third-party files by specific domains. Must use StaleWhileRevalidate when headers are Opaque
workbox.routing.registerRoute(
  // e.g. https://instagram.fadl6-1.fna.fbcdn.net/vp/1b63cee59babc6909f2b58f34fd05956/5E59E6AC/t51.2885-15/e15/c135.0.810.810a/s640x640/68673853_395313984355023_9032710020976394898_n.jpg?_nc_ht=instagram.fadl6-1.fna.fbcdn.net&_nc_cat=103
  new RegExp(/^https:\/\/instagram\.([a-z-0-9]){1,9}\.fna\.fbcdn\.net\//),
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'insta-images',
    plugins: [
      new workbox.expiration.Plugin({
        maxAgeSeconds: 30 * 24 * 60 * 60, // 30 days
        maxEntries: 12
      })
    ]
  })
);

// cache third-party files by specific domains
workbox.routing.registerRoute(
  // e.g. https://s3.ap-southeast-2.amazonaws.com/env.images/adelaide-gaol/backgrounds/_1200x675_crop_center-center_82_line/homepage-bg.jpg
  new RegExp(/^https:\/\/s3\.ap-southeast-(\d){1,2}\.amazonaws\.com\/env\.images\/.*/),
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'image-cache',
    plugins: [
      new workbox.expiration.Plugin({
        maxAgeSeconds: 365 * 24 * 60 * 60, // 1 year
        maxEntries: 100
      })
    ]
  })
);

// cache third-party files by specific domains
workbox.routing.registerRoute(
  // e.g. https://d19ezedjtoh8s7.cloudfront.net/
  new RegExp(/^https:\/\/d19ezedjtoh8s7\.cloudfront\.net/),
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'image-cache'
  })
);

// cache third-party files by specific domains
workbox.routing.registerRoute(
  // e.g. https://cdn.polyfill.io/v3/polyfill.min.js?callback=polyfillsAreLoaded&flags=gated
  // e.g. https://au.openforms.com/Scripts/embed-iframe.js
  new RegExp(/^https:\/\/(?:cdn\.polyfill\.io|au\.openforms\.com)\/.*/),
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'all-cache'
  })
);

// cache third-party files by specific domains
workbox.routing.registerRoute(
  // e.g. https://maps.gstatic.com/mapfiles/embed/images/google4.png
  // https://www.google.com/maps/embed?pb=!1m14...
  // https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css
  // https://fonts.googleapis.com/css?family=Open+Sans...
  // https://maps.googleapis.com/maps/api/js?client
  // https://www.googletagmanager.com/gtag/js?id=UA-96647342-1
  // https://www.google-analytics.com/analytics.js
  // https://fonts.gstatic.com/s/roboto/v20/KFOmCnqEu92Fr1Mu4mxK.woff2
  new RegExp(/^https:\/\/(?:www|maps|ajax|fonts)\.(?:googleapis|gstatic|google|googletagmanager|google-analytics)\.com/),
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'google-cache'
  })
);

workbox.routing.registerRoute(
  new RegExp(/(\/\/){1}[a-zA-Z0-9._-]*(\/){1}(?!cpresources|admin|index.php).*\.(?:png|jpg|jpeg|webp|svg|gif)$/),
  // Use the cache if it's available.
  new workbox.strategies.CacheFirst({
    cacheName: 'image-cache'
  })
);

// cache files by broad wildcards
workbox.routing.registerRoute(
  // match all files except /cpresources or /admin or index.php
  new RegExp(/(\/\/){1}[a-zA-Z0-9._-]*(\/){1}(?!cpresources|admin|index.php).*/), // '/.*'
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'all-cache'
  })
);

// This "catch" handler is triggered when any of the other routes fail to
// generate a response.
workbox.routing.setCatchHandler(({ event }) => {
  // The FALLBACK_URL entries must be added to the cache ahead of time, either via runtime
  // or precaching.
  // If they are precached, then call workbox.precaching.getCacheKeyForURL(FALLBACK_URL)
  // to get the correct cache key to pass in to caches.match().
  //
  // Use event, request, and url to figure out how to respond.
  // One approach would be to use request.destination, see
  // https://medium.com/dev-channel/service-worker-caching-strategies-based-on-request-types-57411dd7652c
  switch (event.request.destination) {
    case 'image':
      console.log('offline image');
      return caches.match('dist/images/site/offline.png');

    case 'font':
      console.log('offline font');
      return caches.match('dist/fonts/ProximaNovaRegular.woff2');

    case 'document':
      return caches.match('offline');

    default:
      // If we don't have a fallback, just return an error response.
      return Response.error();
  }
});

workbox.googleAnalytics.initialize();
