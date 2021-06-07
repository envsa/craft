<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\elements\User;

/**
 * m210130_211013_add_users migration.
 */
class m210130_211013_add_users extends Migration
{
  /**
   * @inheritdoc
   */
  public function safeUp()
  {
    $users = [
      // ['dew.internet@sa.gov.au', 'Admin', '', true],
      ['liam.rella@sa.gov.au', 'Liam', 'Rella', true],
      ['yofamb@gmail.com', 'Ben', 'Kannenberg', true],
      ['adam@adamth.com', 'Adam', 'Thompson', true],
      ['tusha.bhatia@sa.gov.au', 'Tusha', 'Bhatia', false],
      ['elly.siklic@sa.gov.au', 'Elly', 'Siklic', false],
      ['michelle.read@sa.gov.au', 'Michelle', 'Read', false],
      ['Renee.Pearson2@sa.gov.au', 'Renee', 'Pearson',  false],
      ['emma.acella@sa.gov.au', 'Emma', 'Acella', false],
      ['deb.blair@sa.gov.au', 'Deb', 'Blair', false],
      ['daniel.sunstrom@sa.gov.au', 'Daniel', 'Sunstrom', false]
    ];
    foreach ($users as $userData) {
      [$email, $firstName, $lastName, $admin] = $userData;
      $this->createUser($email, $firstName, $lastName, $admin);
    }
  }
  /**
   * @inheritdoc
   */
  public function safeDown()
  {
    echo "m210130_211013_add_users cannot be reverted.\n";
    return false;
  }
  protected function createUser($email, $firstName, $lastName, $admin)
  {
    $user = new User;
    $user->username = $email;
    $user->email = $email;
    $user->firstName = $firstName;
    $user->lastName = $lastName;
    $user->admin = $admin;
    $user->newPassword = CRAFT_ENVIRONMENT === 'local'
      ? $email
      : md5(uniqid() . rand());
    $user->passwordResetRequired = CRAFT_ENVIRONMENT !== 'local';
    Craft::$app->getElements()->saveElement($user, false);
  }
}
