<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

use craft\helpers\App;

return [
  // Craft config settings from .env variables
  'aliases' => [
    '@assetsUrl' => App::env('ASSETS_URL'),
    '@web' => App::env('SITE_URL'),
    '@webroot' => App::env('WEB_ROOT_PATH'),
  ],
  'allowUpdates' => (bool)App::env('ALLOW_UPDATES'),
  'allowAdminChanges' => (bool)App::env('ALLOW_ADMIN_CHANGES'),
  'backupOnUpdate' => (bool)App::env('BACKUP_ON_UPDATE'),
  'cpTrigger' => App::env('CP_TRIGGER') ?: 'admin',
  'devMode' => (bool)App::env('DEV_MODE'),
  'enableGraphQlCaching' => (bool)App::env('ENABLE_GQL_CACHING'),
  'enableTemplateCaching' => (bool)App::env('ENABLE_TEMPLATE_CACHING'),
  'isSystemLive' => (bool)App::env('IS_SYSTEM_LIVE'),
  'resourceBasePath' => dirname(__DIR__) . '/web/cpresources',
  'securityKey' => App::env('SECURITY_KEY'),
  // Craft config settings from constants
  'cacheDuration' => false,
  'defaultSearchTermOptions' => [
    'subLeft' => true,
    'subRight' => true,
  ],
  'enableCsrfProtection' => true,
  'errorTemplatePrefix' => 'errors/',
  'generateTransformsBeforePageLoad' => true,
  'loginPath' => 'login',
  'postLoginRedirect' => '/',
  'maxCachedCloudImageSize' => 3000,
  'maxRevisions' => 0,
  'maxUploadFileSize' => '100M',
  'omitScriptNameInUrls' => true,
  'useProjectConfigFile' => true,
  'useEmailAsUsername' => true,
];
