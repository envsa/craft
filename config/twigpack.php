<?php
/**
 * Twigpack plugin for Craft CMS 3.x
 *
 * Twigpack is the conduit between Twig and webpack, with manifest.json &
 * webpack-dev-server HMR support
 *
 * @link      https://nystudio107.com/
 * @copyright Copyright (c) 2018 nystudio107
 */

return [
  '*' => [
    // If `devMode` is on, use webpack-dev-server to all for HMR (hot module reloading)
    'useDevServer' => getenv('DEV_MODE'),
    // Manifest file names
    'manifest' => [
      'legacy' => 'mix-manifest.json',
      'modern' => 'mix-manifest.json',
    ],
    // Public server config
    'server' => [
      'manifestPath' => '@webroot/',
      'publicPath' => '/dist/',
    ],
    // webpack-dev-server config
    'devServer' => [
      'manifestPath' => '@webroot/',
      'publicPath' => getenv('TWIGPACK_DEV_SERVER_PUBLIC_PATH'),
    ],
    // Local files config
    'localFiles' => [
      'basePath' => '@webroot/dist/',
      'criticalPrefix' => '',
      'criticalSuffix' => '_critical.min.css',
    ],
  ],
];
