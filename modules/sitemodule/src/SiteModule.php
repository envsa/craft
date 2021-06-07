<?php
/**
 * Site module for Craft CMS 3.x
 *
 * Custom site module for the parks.sa.gov.au website
 */

namespace modules\sitemodule;

use Craft;
use craft\i18n\PhpMessageSource;

use yii\base\Module;

class SiteModule extends Module
{
  // Static Properties
  // =========================================================================

  /**
   * @var SiteModule
   */
  public static $instance;

  // Public Methods
  // =========================================================================

  /**
   * @inheritdoc
   */
  public function __construct($id, $parent = null, array $config = [])
  {
    Craft::setAlias('@modules/sitemodule', $this->getBasePath());
    $this->controllerNamespace = 'modules\sitemodule\controllers';

    // Translation category
    $i18n = Craft::$app->getI18n();
    /** @noinspection UnSafeIsSetOverArrayInspection */
    if (!isset($i18n->translations[$id]) && !isset($i18n->translations[$id.'*'])) {
      $i18n->translations[$id] = [
        'class' => PhpMessageSource::class,
        'sourceLanguage' => 'en-US',
        'basePath' => '@modules/sitemodule/translations',
        'forceTranslation' => true,
        'allowOverrides' => true,
      ];
    }

    // set this as the global instance of this module class
    static::setInstance($this);

    parent::__construct($id, $parent, $config);
  }

  /**
   * @inheritdoc
   */
  public function init()
  {
    parent::init();
    self::$instance = $this;

    Craft::info(
      Craft::t(
        'site-module',
        '{name} module loaded',
        ['name' => 'Site']
      ),
      __METHOD__
    );
  }

  // Protected Methods
  // =========================================================================
}
