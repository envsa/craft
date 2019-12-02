module.exports = {
  swSrc: './workbox-src-sw.js',
  swDest: 'web/service-worker.js',
  globDirectory: 'web/',
  globPatterns: [
    'dist/**/*.{html,css,js,ico,svg,woff2}',
    'dist/img/site/offline.png'
  ],
  globIgnores: [
    '**/*_critical.min.css',
    '**/inlinejs/**/*'
  ]
};
