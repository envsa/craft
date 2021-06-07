<?php

use craft\helpers\App;

$protocol = App::env('HMR_HTTPS') === 'true' ? 'https://' : 'http://';
$host = parse_url(App::env('SITE_URL'), PHP_URL_HOST);

return [

  'useDevServer' => App::env('DEV_MODE'),

  'useAbsoluteUrl' => true,

  'errorEntry' => ['/js/app.js'],

  'cacheKeySuffix' => '',

  'manifest' => [
    'legacy' => 'mix-manifest.json',
    'modern' => 'mix-manifest.json',
  ],

  'server' => [
    'manifestPath' => '@webroot/dist/',
    'publicPath' => '@assetsUrl',
  ],

  'devServer' => [
    'manifestPath' => $protocol . 'localhost:8080' . App::env('ASSETS_URL'),
    'publicPath' => $protocol . $host . ':' . App::env('HMR_PORT') . App::env('ASSETS_URL'),
  ],

  'devServerBuildType' => 'modern',

  'cspNonce' => '',

  'localFiles' => [
    'basePath' => '@webroot/dist/',
    'criticalPrefix' => 'css/critical/',
    'criticalSuffix' => '_critical.min.css',
  ]
];
