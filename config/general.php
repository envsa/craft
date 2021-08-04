<?php

/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * https://craftcms.com/docs/3.x/config/config-settings.html
 *
 * @see \craft\config\GeneralConfig
 */

use craft\helpers\App;

return [
  // System || https://craftcms.com/docs/3.x/config/config-settings.html#system
  'allowAdminChanges' => (bool)App::env('ALLOW_ADMIN_CHANGES'),
  'allowUpdates' => (bool)App::env('ALLOW_UPDATES'),
  'autoLoginAfterAccountActivation' => true,
  'backupOnUpdate' => (bool)App::env('BACKUP_ON_UPDATE'),
  'cacheDuration' => false,
  'defaultCpLanguage' => 'en-AU',
  'defaultCpLocale' => 'en-AU',
  'defaultSearchTermOptions' => [
    'subLeft' => true,
    'subRight' => true,
  ],
  'devMode' => (bool)App::env('DEV_MODE'),
  'enableTemplateCaching' => (bool)App::env('ENABLE_TEMPLATE_CACHING'),
  'errorTemplatePrefix' => 'errors/',
  'isSystemLive' => (bool)App::env('IS_SYSTEM_LIVE'),
  'maxBackups' => 5,
  'maxRevisions' => 0,
  'sendPoweredByHeader' => false,
  'useEmailAsUsername' => true,

  // Environment || https://craftcms.com/docs/3.x/config/config-settings.html#environment
  'aliases' => [
    '@assetsUrl' => App::env('ASSETS_URL'),
    '@bookeasyKey' => App::env('BOOKEASY_KEY'),
    '@web' => App::env('SITE_URL'),
    '@webroot' => App::env('WEB_ROOT_PATH'),
  ],

  // Routing ||https://craftcms.com/docs/3.x/config/config-settings.html#routing
  'cpTrigger' => App::env('CP_TRIGGER') ?: 'admin',
  'omitScriptNameInUrls' => true,

  // Session || https://craftcms.com/docs/3.x/config/config-settings.html#session

  // Security || https://craftcms.com/docs/3.x/config/config-settings.html#security
  'cooldownDuration' => 1800, // 30 mins
  'enableCsrfProtection' => true,
  'maxInvalidLogins' => 5,
  'preventUserEnumeration' => true,
  'securityKey' => App::env('SECURITY_KEY'),

  // Assets || https://craftcms.com/docs/3.x/config/config-settings.html#assets
  'maxUploadFileSize' => '2G',

  // Image handling || https://craftcms.com/docs/3.x/config/config-settings.html#image-handling
  'brokenImagePath' => null,
  'generateTransformsBeforePageLoad' => true,
  'maxCachedCloudImageSize' => 3000,

  // GraphQL || https://craftcms.com/docs/3.x/config/config-settings.html#graphql
  'enableGraphqlCaching' => (bool)App::env('ENABLE_GQL_CACHING'),

  // Garbage Collection
];
