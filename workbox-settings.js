module.exports = {
  swSrc: './workbox-src-sw.js',
  swDest: 'web/service-worker.js',
  globDirectory: 'web/',
  globPatterns: [
    'dist/**/*.{html,css,js,ico,svg,woff2}',
    'dist/images/site/offline.svg'
  ],
  globIgnores: [
    '**/*_critical.min.css',
    '**/inlinejs/**/*',
    '**/favicons/*'
  ]
};
