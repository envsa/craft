-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql-5.7-3306.database.nitro    Database: newapp
-- ------------------------------------------------------
-- Server version	5.7.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mwfcyddbruvkqfpcajvbzwodafxpymbkvwss` (`sessionId`,`volumeId`),
  KEY `idx_hbawsfghjjvgmsftndbrtbofdkohfvufzcnn` (`volumeId`),
  CONSTRAINT `fk_hrchqjlswaairfaltlokbigjogwjkldoeeds` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rpnhbomfuldvszsjcsjmhlfhpizewoeonjui` (`filename`,`folderId`),
  KEY `idx_eeykjswdnfwwedkwktbjwttkttxmxoievyuw` (`folderId`),
  KEY `idx_tuggggweduhpmaxqoekiayuvnlngxjobbgaa` (`volumeId`),
  KEY `fk_pssvzflzobngpphqlbocvaqxoqjaqzxsjtql` (`uploaderId`),
  CONSTRAINT `fk_csxhhmqeszogfpxulwovdizzdjtiagxvxukz` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jibmwssoiszxhxuclhlwhneoliczoiwrkdwz` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pssvzflzobngpphqlbocvaqxoqjaqzxsjtql` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qajexlubtfnwtdsibpxqrzthudggpatvpazh` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lkjpnliucjtyfzduacsswozukdzzsocamqrr` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_cksilpyqokdgiatvqybthblfcgaejlkatdqp` (`name`),
  KEY `idx_pkzmegzxlguwuexlkbxprgojnqocvnyjwjup` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dfhdfhggxvmrqkxpsmzeicvyualcwznmjucj` (`groupId`),
  KEY `fk_waywbowuhngiuaatvicuoktofoxoicdlqbsl` (`parentId`),
  CONSTRAINT `fk_gzjmzhhfzujkqcffyafdaadpxzqkjeuwtttk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lhjcssmwmjstewckgzcaeuoxjkavnilweoaw` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_waywbowuhngiuaatvicuoktofoxoicdlqbsl` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bjnyqnwyufckvdyzxeziwvzmxfzhhfdplcug` (`name`),
  KEY `idx_qalvmkvbtprqkeeqsqdhhaahkyxdcdcyegiu` (`handle`),
  KEY `idx_qnlqafbtbtlxvxjpabhjdnzenhtgtxkclpzk` (`structureId`),
  KEY `idx_xcvfzlsltwflwjhaajtzthvokzbqraakeult` (`fieldLayoutId`),
  KEY `idx_qlysitqbthwqashsemwkzcfuwjymgexdipnk` (`dateDeleted`),
  CONSTRAINT `fk_acnhjnmnojdgauvylvttvjpqtykluhvkqzuv` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ryshioqegondjiuaqquxlwduigezjgzdbzom` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fuyjqzpjstdabuuevstcmzmiawdytsulozoy` (`groupId`,`siteId`),
  KEY `idx_qpzjednvxpzmlgwtmlqofowuqrnjgonsisxj` (`siteId`),
  CONSTRAINT `fk_jrdelqydrhmomqfttqudledhyxmyxljdkhbs` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_vvwirdxkrggbalowjhntlumlxugymbdyuzgo` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_zdudycebcfcwwgqkfioygpqcmjnrmeifxktj` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_cookncqgigwqnwjlmzhgowkdocdosqapqlej` (`siteId`),
  KEY `fk_ucqjlzixknqxljxllhndwfqcppmkpsmodhxo` (`userId`),
  CONSTRAINT `fk_cookncqgigwqnwjlmzhgowkdocdosqapqlej` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ucqjlzixknqxljxllhndwfqcppmkpsmodhxo` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_ywnckzzeykvftnsmqoxzcflxgwrxqczrmaoq` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_qohshnvmawzuheqpwcjwqgypuoiqarawmiud` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_qgzydybgfocawxzagibmnzxtoskfltizqqhf` (`siteId`),
  KEY `fk_bzikxxykpnftdisvemhztntktxowqvfyqmxv` (`fieldId`),
  KEY `fk_pqnqfyagzzjougshyxywoebaurfjsnbasxup` (`userId`),
  CONSTRAINT `fk_bzikxxykpnftdisvemhztntktxowqvfyqmxv` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gbjmshrthrzrrrjvsbhmprerzwcimijeicos` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pqnqfyagzzjougshyxywoebaurfjsnbasxup` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_qgzydybgfocawxzagibmnzxtoskfltizqqhf` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_footerLinks` text,
  `field_optimizedGeneral` text,
  `field_teaserTitle` text,
  `field_teaserText` text,
  `field_caption` text,
  `field_alertText` text,
  `field_errorHeadline` text,
  `field_seo` text,
  `field_dismiss` tinyint(1) DEFAULT NULL,
  `field_hideNav` tinyint(1) DEFAULT NULL,
  `field_endDate` datetime DEFAULT NULL,
  `field_showCaption` tinyint(1) DEFAULT NULL,
  `field_altText` text,
  `field_richText` text,
  `field_hideSearch` text,
  `field_errorText` text,
  `field_redirectUrl` varchar(255) DEFAULT NULL,
  `field_acknowledgementText` text,
  `field_startDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wlnxfkntwduvtbyhqczoronnwmzxryshcgwt` (`elementId`,`siteId`),
  KEY `idx_ehbpyrisnyxrmhfvnzzflsccmefjzbbjdpvc` (`siteId`),
  KEY `idx_njbxmghztqnxmhduqywfcvdugiidxlzmronq` (`title`),
  CONSTRAINT `fk_cwnapjeuykokizblunezevolbtedhtigbkpt` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_zcfdznpqokaafuwplbcgvfgijyykmalhiief` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_bxaptlrsqgeherooiliqrxofzwkzljndrdsi` (`userId`),
  CONSTRAINT `fk_bxaptlrsqgeherooiliqrxofzwkzljndrdsi` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sfgdlnqfhbspkcevnulwewpfwyweskrligva` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_raavrkririmlbziveajtoarfnfqgdueqfgwg` (`saved`),
  KEY `fk_jvnmatoqmelzrykrzwjsfhivbtxcphwyppau` (`creatorId`),
  KEY `fk_hfwzfjibzrlufrigekkweufmrcwleinuxozu` (`sourceId`),
  CONSTRAINT `fk_hfwzfjibzrlufrigekkweufmrcwleinuxozu` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jvnmatoqmelzrykrzwjsfhivbtxcphwyppau` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dzjxcwjspyuqcxhlspbbfyaqkiqbonrqgbqo` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ypfmieskimbygiggrcvdxeikxymdgnmciqrq` (`dateDeleted`),
  KEY `idx_pybwgmgokfbuadukypolwnpouuuultapbpeg` (`fieldLayoutId`),
  KEY `idx_dsnenabcmcbkujxmcckjytadaqrykfsguxdf` (`type`),
  KEY `idx_zuvzupprqhtkmicmjhgkmohlopybugespbds` (`enabled`),
  KEY `idx_ncftfdgcbopgzdpgpgxepspftjaidnzkkzea` (`archived`,`dateCreated`),
  KEY `idx_ngsmhcgbxvnzjmhprratnkdyagydlzlzchte` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `fk_flibauaebzzaiijhzvikwqsavhspaasycwer` (`draftId`),
  KEY `fk_echamgjzdmsnzosykgpbnvvbktnkapfqehez` (`revisionId`),
  CONSTRAINT `fk_echamgjzdmsnzosykgpbnvvbktnkapfqehez` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_flibauaebzzaiijhzvikwqsavhspaasycwer` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_goieglcxumepieyzuajnoojsluxnadknzvei` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_djwqxlwgamzjczhuomylrhslwijwhmyggmgl` (`elementId`,`siteId`),
  KEY `idx_qyyuhnzdpegpyzmjlgnvzpelzxufbdxuuraq` (`siteId`),
  KEY `idx_ycxjrfbhtzirrqpgmxlbcimmpbeyzhbjxpko` (`slug`,`siteId`),
  KEY `idx_qsssnyltvxggnirxaybxuriluuamafgzsmpz` (`enabled`),
  KEY `idx_csyunxrtprajjmxtrmdhwfafijxtesspcosx` (`uri`,`siteId`),
  CONSTRAINT `fk_lpavmsfmbwnnrwrneqdncodkylliesniaujs` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_speltdynoslxnlfcngbhtubbfdvafebnkido` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_vmpvtclxpllolzuwyfnudpfzmpzmuhytfgvd` (`postDate`),
  KEY `idx_fqnqxkrmaqjqypfwoigmvihpgkzrspxvioeh` (`expiryDate`),
  KEY `idx_pzpqzjfwjegkdwsswmfvktfdwoyggmcauzwb` (`authorId`),
  KEY `idx_asktcgooxskbfhrszjyhctaimfxljqcyqcpi` (`sectionId`),
  KEY `idx_xuwwaruukzsldutflojnopwekorvfdnjsorg` (`typeId`),
  KEY `fk_uzhyowcmgawsfnivuvhxwxeyvmgkqvqdiiav` (`parentId`),
  CONSTRAINT `fk_cxslxkgyasyebgwrlesevbhuaiwjredluidt` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hgtnabjhojiohftilmohiftltngmosmfhlpi` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ozctkvawjerolktkbirmcbouuerdgevoufhh` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uzhyowcmgawsfnivuvhxwxeyvmgkqvqdiiav` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ykhlqltmzpntoybdukaaxicfktzdcxskwpek` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrypublishes`
--

DROP TABLE IF EXISTS `entrypublishes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrypublishes` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `publishDraftId` int(11) DEFAULT NULL,
  `publishAt` datetime NOT NULL,
  `expire` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `sourceSiteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ocdwuwudquyvfixywpngvnhuhyqvhjosslry` (`sourceId`),
  KEY `fk_mtewhfvwkdqyodyflbghvzehxqgshvagkjuu` (`publishDraftId`),
  CONSTRAINT `fk_mtewhfvwkdqyodyflbghvzehxqgshvagkjuu` FOREIGN KEY (`publishDraftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ocdwuwudquyvfixywpngvnhuhyqvhjosslry` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rylidvwovejrufunjvlpdphfcjykpdcrpanb` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fifpkzuumuisakeodjaqsnxxaqtijzqrfbce` (`name`,`sectionId`),
  KEY `idx_ixnyszkpktvzkdswlifvpjlxtnvwagefmjwa` (`handle`,`sectionId`),
  KEY `idx_bpxwiamaaucshbrlylxhxpqyvskqlpqvbsmi` (`sectionId`),
  KEY `idx_xomwlorvzfwkugwazhqbrihalhggfxnwqlba` (`fieldLayoutId`),
  KEY `idx_dgwizbxxgeiugohavmfkdjarlytpmbwejfib` (`dateDeleted`),
  CONSTRAINT `fk_imiffujitftbfdrazvfompjncwdzspqvdgck` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vllistjokdebuetluhxeqzumqduvlulcoroq` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedme_feeds`
--

DROP TABLE IF EXISTS `feedme_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedme_feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feedUrl` text NOT NULL,
  `feedType` varchar(255) DEFAULT NULL,
  `primaryElement` varchar(255) DEFAULT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementGroup` text,
  `siteId` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `singleton` tinyint(1) NOT NULL DEFAULT '0',
  `duplicateHandle` text,
  `paginationNode` text,
  `fieldMapping` text,
  `fieldUnique` text,
  `passkey` varchar(255) NOT NULL,
  `backup` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lpjmyzfhuayqrejljmzyewxafpehmgfuvxqm` (`name`),
  KEY `idx_tumqgxjgptsjiaafvgjpilquenzihtphtgnv` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_oimutyevhghckzwnowidhffsrrbujlhxkxfu` (`layoutId`,`fieldId`),
  KEY `idx_ockifuezulpiuixjcduczqqzgeahmsgkwtvm` (`sortOrder`),
  KEY `idx_yxzdmjjukxbgesyfpjizhthgrqndhbnbdhva` (`tabId`),
  KEY `idx_mqrfhnwkraxwywrrclgtwlgvrztalaunsstu` (`fieldId`),
  CONSTRAINT `fk_clelmnnoxrgjnztjudnidayrgkfvxuuruhzg` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_hkvrwaliyduhyqwbnnagifswrwrehsyzgddc` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pxlfjtoklgjkgvkjgrklbphjtafhgtfgyhnt` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xpznbbirevbbbcwmhuhjjqefndyaccgxiggy` (`dateDeleted`),
  KEY `idx_bwdqfcphnrjgooxxvyhmosahppszdfdhurrz` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_iyinzbhjuizhnwrjjrvpkinvbipmcqziajoy` (`sortOrder`),
  KEY `idx_rjodvuxddxyuchkuozvbkympskzrvnurlseu` (`layoutId`),
  CONSTRAINT `fk_iujhmgtegqbnlnufplrhwjrxzuulfbsoznhk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lypasllqjzlysowoqmcmqnzeqkvrelqigtfn` (`handle`,`context`),
  KEY `idx_efdtnaenolgufcvozbafxvvrolnvtbssgbqi` (`groupId`),
  KEY `idx_fnihibnahmseenpmjmtezeclunmggatbzuty` (`context`),
  CONSTRAINT `fk_zmuffardnxgcqsmfizgtfpgdcqfavsatjuff` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gvjlxanrmctjzvwpgbudmjouvteqcqzawpqj` (`name`),
  KEY `idx_iywvzldhwsirmvpxdnwhydwrdyxvsjopikig` (`handle`),
  KEY `idx_bngcfohthpwqtdaawrsndzfuofnoavgqqnwn` (`fieldLayoutId`),
  CONSTRAINT `fk_lviclcsislvccwsmdfilbumwmglsnythxzbb` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_rogzrjpptitnqvfclltzxrlpapxkzspuffew` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mvdwqglvddlhhvzuxvdkcsdqoviqpciwoiiu` (`accessToken`),
  UNIQUE KEY `idx_ovkxuxferyqdyuktwwjznzdaqyqfmnfxkkjj` (`name`),
  KEY `fk_ueykfknaqbyndgzjcqatwhsmutzfqwmdmmvs` (`schemaId`),
  CONSTRAINT `fk_ueykfknaqbyndgzjcqatwhsmutzfqwmdmmvs` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lockout`
--

DROP TABLE IF EXISTS `lockout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lockout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `environment` varchar(255) NOT NULL DEFAULT '',
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ijccslozccoqzpcscufmttsqxdarimbrghfu` (`ownerId`),
  KEY `idx_ckgofonacjbsbgdjyaceuxdutnbrkgoxedkd` (`fieldId`),
  KEY `idx_bcedphtudxbdrhzxuzafwnfzkqgoskzscfbt` (`typeId`),
  KEY `idx_trctfgonfmpziehhapyngxjvyzyytioxlqfz` (`sortOrder`),
  CONSTRAINT `fk_cvgqszterqwfayftzyprphqgmguolgqovvop` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ecymlkyleauigjnogdmsaekcuahtybdqnezw` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kyzqwwadvztknzhtixqpigoegtfmnbhfevmh` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_onqwelcohqhfjvomgfktvwcllatpofpoxcod` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_umxosmijaudydjklmemurvktxbmhysvawqzm` (`name`,`fieldId`),
  KEY `idx_jwondczwotuhssddlsedrdiwcucaekqurchg` (`handle`,`fieldId`),
  KEY `idx_xaownplatatnpistxorfcgpaglkdaxjtfyvi` (`fieldId`),
  KEY `idx_dwtgtmeusgnksbyhnhptckuqxnyxnevqfycf` (`fieldLayoutId`),
  CONSTRAINT `fk_iabnzcspmvipncizygsqqpfiefvdelherqna` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_utswydkbzqfqsbnqaiimnmhfrzkjqjzalyzp` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ljvrfznfeksnfmfjqlkhwkkbctyciiqwokkj` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `neoblocks`
--

DROP TABLE IF EXISTS `neoblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neoblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tyayarmyviemrdsdmlupxkchgslpemusodus` (`ownerId`),
  KEY `idx_kmumaeeeobtzbmcrzwfedmvbbojofjothgih` (`ownerSiteId`),
  KEY `idx_eihrkvbiwtlabthgtcujdzjxmiecijivzcvi` (`fieldId`),
  KEY `idx_nrjurkocqiighkwtervqezkekauiuhocchim` (`typeId`),
  CONSTRAINT `fk_ariygmzqcijcsmpfrlsucwqqxyxurueypbmr` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gvcimmaketfsxxkkynhepcartxhrqtfliela` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jepnqbomgyxvanrlkrhcpfnljvbjenwyjvfk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mnpkazsczgniknnqpjmnsuhhaokrdusdiarx` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ojfvcyisffwqktffhyrkgvdukykdnmjbatib` FOREIGN KEY (`typeId`) REFERENCES `neoblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `neoblockstructures`
--

DROP TABLE IF EXISTS `neoblockstructures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neoblockstructures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ljswfnpftzrtwfctkhbtwtzdozhmvpfoavzh` (`structureId`),
  KEY `idx_kjovrmjazqwqumuymizjsmpcnjzwhhulpmnn` (`ownerId`),
  KEY `idx_vptzlhllsatylwqmadyqpjdxzqmcbmyoyrhq` (`ownerSiteId`),
  KEY `idx_uotyrcrqvruwqyhdlybsqdshxcdglhzlnrxn` (`fieldId`),
  CONSTRAINT `fk_fzmytfbhgimnneytlmkrdbbhhesygvgcyzmx` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gvutjqulgmnharumndsrgnpvniupihltfahw` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mluuafsssrmywafyoufzylvdozjexkytsesr` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wfzgeadbienwyblexryckymnyvvlrwoicbno` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `neoblocktypegroups`
--

DROP TABLE IF EXISTS `neoblocktypegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neoblocktypegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ufayxrprkmzqtpsuokfblyexsxwyuqeeasfn` (`name`,`fieldId`),
  KEY `idx_rvqndqbhtapletqydkjachuoxtpxykeadxcj` (`fieldId`),
  CONSTRAINT `fk_qmjrclzjpymwurwenbnewonxpsqwaadiktgj` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `neoblocktypes`
--

DROP TABLE IF EXISTS `neoblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neoblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `maxBlocks` smallint(6) unsigned DEFAULT NULL,
  `maxSiblingBlocks` smallint(6) unsigned DEFAULT '0',
  `maxChildBlocks` smallint(6) unsigned DEFAULT NULL,
  `childBlocks` text,
  `topLevel` tinyint(1) NOT NULL DEFAULT '1',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_koosbacwtpmgqgtvxuahjjfbmlkcwchbthqt` (`handle`,`fieldId`),
  KEY `idx_ljcfjmllwaewrwhiekfxczgyyrnoauvivwin` (`name`,`fieldId`),
  KEY `idx_puzukxtzsklcomqilvrdrruwwgncvcvezatk` (`fieldId`),
  KEY `idx_mgnkagxvahnlpttfghhegmuufsvmofzrnshc` (`fieldLayoutId`),
  CONSTRAINT `fk_gkzdckaeefoteaqcinxklzzfbelaisfvxhyc` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_pldfkariiqlvfzxtwjsypqxjlxcipolxmvae` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sfygcjglolreoflnlmdefukorbfugetrsujo` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfignames`
--

DROP TABLE IF EXISTS `projectconfignames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfignames` (
  `uid` char(36) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_maxzffyfazfxosoefbinpuoflnzcdgvymfjz` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_mqfdlgulbuztvscqlkofautamlurkmpobmuh` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vburhifyrjnsichlxwiqgkkjyvdtjwygdjvb` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_hapouifqotnguonmnnrsixwyyfxymorzebsa` (`sourceId`),
  KEY `idx_pekoehzqmboirqgvpgyohlgswnowprcaubyl` (`targetId`),
  KEY `idx_pexkwwftgyrrksvimxtqcsnhzyaohwdcfabi` (`sourceSiteId`),
  CONSTRAINT `fk_cmraebsdabfwefaunpgjgwiegoupbkqqspme` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ffstwsvjbmzasjzierfmgwfaksyzjbtmqfsq` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_mpfdpazigtgeyupkrdemhbfdbxisgjvlqizy` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wlsnsnwgckqszjnzacigyecgjromarvrssqe` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_redirects`
--

DROP TABLE IF EXISTS `retour_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT '301',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bkmqrqessmzvhrrdhbmwjllijvledbghxbvq` (`redirectSrcUrlParsed`),
  KEY `idx_ihwximeivgwtyucavbqmfpmzrhiformihqzx` (`redirectSrcUrl`),
  KEY `idx_nqpdpuevxxjtfgmjrumyfqgliujtejktgboz` (`siteId`),
  KEY `fk_fqamltdwtfkztqdznggxktchzxkgkvrfwimw` (`associatedElementId`),
  CONSTRAINT `fk_fqamltdwtfkztqdznggxktchzxkgkvrfwimw` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_static_redirects`
--

DROP TABLE IF EXISTS `retour_static_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_static_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT '301',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_lzzgodlbltabnjfgwvktpmnxcbcitksrblyg` (`redirectSrcUrlParsed`),
  KEY `idx_qexxhtvzebdsahuekjvgbhxxrayrtrlprier` (`redirectSrcUrl`),
  KEY `idx_ocihevmlsjmyzwgiwzmfrdpygyrpfjmikkit` (`siteId`),
  CONSTRAINT `fk_zzoqrbrvgcxlfgmludrdczghvultbersfoei` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_stats`
--

DROP TABLE IF EXISTS `retour_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int(11) DEFAULT '0',
  `hitCount` int(11) DEFAULT '1',
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bpvuumgravmsegcoyfhrpybiejohdybofbzd` (`redirectSrcUrl`),
  KEY `idx_arujjkjtgflqusvsqocsyxnvomkpiloeczep` (`siteId`),
  CONSTRAINT `fk_wlcpnoctckztslxqbxddherohdagmbvamdcv` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_emdeotpiteooxcyxvddfhhqtgsumncomzowr` (`sourceId`,`num`),
  KEY `fk_kktjtwlcztojjerbolbduqomwjnyusgtaulv` (`creatorId`),
  CONSTRAINT `fk_jzpuibdbgkiseqdbeupfgqvqgxjxmigmcpzh` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kktjtwlcztojjerbolbduqomwjnyusgtaulv` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_vltzkespdzfsdtnrdzjcnyzhipfygyaaitdw` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gbustrkjdiuykirprugbdzehamjygsfsxktx` (`handle`),
  KEY `idx_xkijpamqqniasyxosgamiluforasmebfzxah` (`name`),
  KEY `idx_wurexyblmmvdxcuhmcgzkoafrcwxujeutsek` (`structureId`),
  KEY `idx_emjafnrnfbciihdeoicxggaolvkmlkkniryy` (`dateDeleted`),
  CONSTRAINT `fk_cmrzbdqakdiyjluqbffmuvkomtliizryojtf` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_gzqcrwsoyrcsmwrylxjjkxbzlnwmoxyaajfz` (`sectionId`,`siteId`),
  KEY `idx_zabvdggqvssqwzdkjwubtqllyipkdwqpjcgb` (`siteId`),
  CONSTRAINT `fk_muorsdwxppriyrxshknqsvmearlzirbddmym` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wqcomkfmacyvlfzacrfxkwkkvpcvxyiuivdf` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int(11) DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `idx_jwojnwgnlktpgbyrdkrnobqorywuydytrtjg` (`sourceBundleType`),
  KEY `idx_viznadjpryfvdeojbogihmeavriliqkcxkla` (`sourceId`),
  KEY `idx_pdbcbdhkwskdtumzvzewrjgfffbjaqofgfiv` (`sourceSiteId`),
  KEY `idx_gyizmmhsqngstrszewslnmjysgwtwurlbbpw` (`sourceHandle`),
  CONSTRAINT `fk_esimyfpneossuahxhcrhnzjshxbbrxkzhafe` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wjqscqvdjfxbftbuelamqhlfcykmgrlpzfhb` (`uid`),
  KEY `idx_urbwcfmrbgqwlzgfzoowevhqjokowzolzgdj` (`token`),
  KEY `idx_wjoqklrjombuaqebkkrjmmrnbjuqiykruwdv` (`dateUpdated`),
  KEY `idx_yyjsujnbxvqrjnvqnnrzotoqwgzjkdmusnfw` (`userId`),
  CONSTRAINT `fk_aegygbpogumudglzmpozzisqariwdznmcfts` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nvoxzhbhlnsejdqmvxvjlnstwhznbwgtxbak` (`userId`,`message`),
  CONSTRAINT `fk_tufvplpjhziwvsbkhebrnowqlydkghshcvuj` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tbqmlqplyeguuhmzyeeejddhryzaxufcalmn` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rrjjqfczetmlcrkgfdaeuekorweziullkvsl` (`dateDeleted`),
  KEY `idx_ixslcgttlffyandethxrdugwctelhmzjdhjr` (`handle`),
  KEY `idx_zucwgwngduebbjihvpygixjzinlcsrbyhtej` (`sortOrder`),
  KEY `fk_achfjpfctwikseogksxpgzxdafvniqnsfhgq` (`groupId`),
  CONSTRAINT `fk_achfjpfctwikseogksxpgzxdafvniqnsfhgq` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_erywqivscqialnyucecypbetsmsutgrkmfnt` (`structureId`,`elementId`),
  KEY `idx_qqhgjerfvrjljlkuajsdbiimkggpooacrrby` (`root`),
  KEY `idx_ndlmzjsfqdjjpspmlpvzdvrtgqinqwgmwsbv` (`lft`),
  KEY `idx_ajabgqpimrdxlqvzwhobojiiqydeaxnmiybd` (`rgt`),
  KEY `idx_puqgwgqeqxqgjnaopcascyblbfhzaxfpoahk` (`level`),
  KEY `idx_tbtagqeirwgvylkvtttgvvluldbmlirrqouf` (`elementId`),
  CONSTRAINT `fk_artzpsbrqftusniuzfjuhtorfvvukwgrwmom` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_scqvjuvrvtselzwhdrlznwkirjefndrrvbyg` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_kzewashxzehqmenhxwyvaxvpblnhiagejvjm` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_qlhhpyrzoqdcyrgjangyvmukdjunbnirqcko` (`key`,`language`),
  KEY `idx_juqudymrzqfhbcfygkwudsildmformjnzfri` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_muxcqmdqpjejduzngwdorwyqggcjssegvwjm` (`name`),
  KEY `idx_qytvqkfhztbfijqrwmfuetnekelwvvhxwduq` (`handle`),
  KEY `idx_ldvsbgsjznabcqkjgcygqvlmzbaofwxpdeps` (`dateDeleted`),
  KEY `fk_rpfmhkhroczxzzenqbzcrolgyhevihlunpph` (`fieldLayoutId`),
  CONSTRAINT `fk_rpfmhkhroczxzzenqbzcrolgyhevihlunpph` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_esdisahryblsuukzmvkniirmxmagktkgyzim` (`groupId`),
  CONSTRAINT `fk_ekbzigjjscidxmzefnitdrnjmnvapsjkoxts` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wnrdenxfgrvxbdzlzyvmezeunayewlnilxqy` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ziigojuylijefyoexuavuyokdaylbygreacr` (`cacheId`),
  KEY `idx_okdykwfbggimoyaxykeonaidordnuqyqglbr` (`elementId`),
  CONSTRAINT `fk_styasidvmqqnpqldiyzrrcmiyolprspzwkox` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wfwjjoeanbamcvfmxnrehcgghsrzevjaerhg` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_aymnucvcyfwbrtcxvswhazbxoylyueyapyvp` (`cacheId`),
  KEY `idx_uuldtkshtcnzwcnmxkbesvxovhsosdkpzaob` (`type`),
  CONSTRAINT `fk_ipwnxmvrilzbstoedpczlwpgycvzcgzuvcrj` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_hkvoankckwyibspegezeergwvltpcjrosdvk` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `idx_igabizwtkstnfcifqntuwvspiewpdqdklriw` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `idx_iwuqwwzbeegulrzjgzjxthvzgolnuuuiixhk` (`siteId`),
  CONSTRAINT `fk_lsvydnmojyxvusprjydxyxivsxnmxilgheun` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ewzafypazbwubotrtpkqabmnahezblqsgley` (`token`),
  KEY `idx_eggbsafmljhlqfznidigqjvpkjxhfbryxnsl` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_nvmkgkpaytwycltgaelqkpwmxnielcfuhphu` (`handle`),
  KEY `idx_mfcodumydgmxlujqtrqioynmtebmitgosuov` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xsyjnnedbjkqzzzxlupyxcvkaaitcwrgpqkn` (`groupId`,`userId`),
  KEY `idx_vrooeqveisszmbxqaczuarxhimbttfyfigvt` (`userId`),
  CONSTRAINT `fk_snsjcfhcvcnzxnojeckdyegixieyugafsvse` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ssthzrypubmdlttpxdhqvekgfpckgzxaxyoo` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bqyuayvgohrftiblyldufljmcoqqbeyuhshv` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_navisuhwaoolmdkxxifdzhabgproshlwlwax` (`permissionId`,`groupId`),
  KEY `idx_usvvmqhgyjznbphmmsvjjrspypkdpgteebuz` (`groupId`),
  CONSTRAINT `fk_hlmxsugjkvuygwfpsrimderirvhvqpdxrvcf` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mjpcirohazgdlezxgbwxfebjyobstycypvgx` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wziccaowjbpaprsiixvgeyiqdzadzhlapjgc` (`permissionId`,`userId`),
  KEY `idx_wohfpyzusoqwjxcmeklxqnqaznbhnlcdyfpg` (`userId`),
  CONSTRAINT `fk_xlsjnhidgeksmbadvebvwojcrhhvrdptkfia` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zsthqoqkysryivkyoxjdvwibieflmkprnpwy` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_zyesgzwmedpzbdhcdvtpgsycbuqsitadaglm` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lsoxgzhqidlubnkqkztikqenufhvlfgtwqpr` (`uid`),
  KEY `idx_tapylusdzsjwkjxnqgarcbhqgblenpyjeyeq` (`verificationCode`),
  KEY `idx_iwupgjqyopyamxtitisfgbzvwngykwxlachz` (`email`),
  KEY `idx_ckvusfosmnylmciykrwnnyrodiuxewrpahfd` (`username`),
  KEY `fk_qplslicrotlpvnldycrsxhastwahviossjjt` (`photoId`),
  CONSTRAINT `fk_qflenrilfuzsgljxwjzykwizushvsqaduvic` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qplslicrotlpvnldycrsxhastwahviossjjt` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vtvozbojwqoxatgbfzjyonckopmgemtgrwry` (`name`,`parentId`,`volumeId`),
  KEY `idx_dojtncaanaxovxeszehxgmonbtfbqoyfebfr` (`parentId`),
  KEY `idx_igzeoqtejjydkhuuxlrmsedkbarxkylfmycu` (`volumeId`),
  CONSTRAINT `fk_hxhsxidcopntoxprutbhcpatyllhczhntcav` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vozfvtgwwhvfyotcujaxkyfsggeyrskdgmxo` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_vwkrntogyufxcjhullyrstkicjsujkkqbcec` (`name`),
  KEY `idx_tyiygkbjzrplpyalbcxvbvaojlabgstbnejc` (`handle`),
  KEY `idx_sbolxyukhpboojzrguwlboihhsgzpiczhzvw` (`fieldLayoutId`),
  KEY `idx_gsyvnxswmmnkjajbryuqzulrjyyobstawbfg` (`dateDeleted`),
  CONSTRAINT `fk_aovfqozpdvmxbgkjfadqcygnwzetqzexilbs` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zvoehsgvuqxocxkrivvjsasoptsuytpkeitq` (`userId`),
  CONSTRAINT `fk_dcfrqhwdjseyktzlhvrkwwprdkkkqxeyuycd` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'newapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-25  7:40:55
-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql-5.7-3306.database.nitro    Database: newapp
-- ------------------------------------------------------
-- Server version	5.7.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assets` VALUES (22,1,8,NULL,'dcmb_logo_white.svg','image',183,106,6153,NULL,1,1,'2021-05-25 06:18:51','2021-05-25 05:23:37','2021-05-25 06:19:04','96834b25-f46f-4127-a8f8-3980b3b29ab3'),(23,1,8,NULL,'npwssa-logotype.svg','image',560,180,83446,NULL,1,1,'2021-05-25 06:18:52','2021-05-25 05:23:37','2021-05-25 06:19:07','69b60418-51ce-406a-b7c4-7286a15417e8'),(24,1,8,NULL,'npwssa-logotype-black.svg','image',560,180,97455,NULL,1,1,'2021-05-25 06:18:52','2021-05-25 05:23:38','2021-05-25 06:19:09','dc874c4e-64d9-413c-aa6b-4cd8713dd9f4'),(25,1,8,NULL,'lbsa-logotype-color.svg','image',831,259,14032,NULL,1,1,'2021-05-25 06:18:52','2021-05-25 05:23:38','2021-05-25 06:19:11','4e916bbc-4843-4e09-831d-1cd4b742e7b0'),(26,1,8,NULL,'gosa-logotype-white.svg','image',146,61,20886,NULL,1,1,'2021-05-25 06:18:52','2021-05-25 05:23:38','2021-05-25 06:19:14','5ffcd4c4-1b27-4f9f-b1d8-f30ef932a6b8'),(27,1,8,NULL,'gosa-logotype-color.svg','image',146,40,31931,NULL,1,1,'2021-05-25 06:18:51','2021-05-25 05:23:38','2021-05-25 06:19:16','296935f4-da28-40ca-80fe-2e9e7b785393'),(28,1,8,NULL,'good-living-logotype.svg','image',560,317,18619,NULL,1,1,'2021-05-25 06:18:51','2021-05-25 05:23:39','2021-05-25 06:19:18','d4ec0ff0-45cc-418a-a6d2-72bfb7d72453'),(29,1,8,NULL,'DCMB-rev-Horiz.svg','image',395,83,86362,NULL,1,1,'2021-05-25 06:18:46','2021-05-25 05:23:39','2021-05-25 06:19:20','8d53d895-17d6-4cbf-87b1-858c0f153bb9'),(30,1,8,NULL,'dcmb_logo.svg','image',80,46,4364,NULL,1,1,'2021-05-25 06:18:51','2021-05-25 05:23:40','2021-05-25 06:19:22','618335a2-120f-4cb0-ba93-c27e96fd37f7'),(31,1,5,NULL,'ack-banner.png','image',326,190,122239,NULL,1,1,'2021-02-04 03:53:09','2021-05-25 05:23:40','2021-05-25 05:23:40','8cdc6272-f7eb-4cd0-9c18-bf5528ef5691'),(32,1,8,NULL,'craftcms.svg','image',104,26,5747,NULL,1,1,'2021-05-25 06:18:50','2021-05-25 05:23:41','2021-05-25 06:19:26','f9cf2f94-41fc-485e-b0c1-82d21c3a439a'),(33,1,8,NULL,'bsa-logotype-white.svg','image',123,55,2891,NULL,1,1,'2021-05-25 06:18:50','2021-05-25 05:23:41','2021-05-25 06:19:28','a78bcd28-a8f9-4af7-bc3b-5308b0ab45ad'),(34,1,5,NULL,'desert-parks-2010-176.jpg','image',3769,2512,3995340,NULL,1,1,'2020-09-11 01:37:06','2021-05-25 05:23:42','2021-05-25 05:23:42','2305a54b-c794-4df8-a0b6-1bef07edafe0'),(35,1,5,NULL,'connect-with-sa.png','image',375,484,28447,NULL,1,1,'2021-04-09 05:14:21','2021-05-25 05:23:42','2021-05-25 05:23:42','c181a7e1-0e27-45e5-a44a-169a51cf4714'),(36,1,5,NULL,'apy-final.jpg','image',4006,965,424480,NULL,1,1,'2020-02-03 03:34:51','2021-05-25 05:23:42','2021-05-25 05:23:42','f77f4cf7-de7f-4a74-9fe8-14128f0f94ff'),(37,1,5,NULL,'aoc-bg.png','image',1330,545,124992,NULL,1,1,'2021-04-12 03:47:10','2021-05-25 05:23:43','2021-05-25 05:23:43','d8e7714d-eb18-4705-97f6-9825a9259bcc'),(38,1,8,NULL,'sagovau-logotype-white.svg','image',120,55,2902,NULL,1,1,'2021-05-25 06:18:53','2021-05-25 05:23:43','2021-05-25 06:19:45','359c6dae-baa1-49f1-aa83-299261b35ab4'),(39,5,10,NULL,'dcmb_logo_white.svg','image',183,106,6153,NULL,NULL,NULL,'2021-05-25 06:22:31','2021-05-25 06:35:05','2021-05-25 06:35:05','bbeb796d-ffab-45e4-a022-34a8be16a0ce'),(40,5,10,NULL,'npwssa-logotype.svg','image',560,180,83446,NULL,NULL,NULL,'2021-05-25 06:22:32','2021-05-25 06:35:07','2021-05-25 06:35:07','fa51b48a-00b5-4ead-bff2-a80211a2ee78'),(41,5,10,NULL,'npwssa-logotype-black.svg','image',560,180,97455,NULL,NULL,NULL,'2021-05-25 06:22:32','2021-05-25 06:35:09','2021-05-25 06:35:09','73be62d9-6f53-4539-990f-9914cf64291d'),(42,5,10,NULL,'lbsa-logotype-color.svg','image',831,259,14032,NULL,NULL,NULL,'2021-05-25 06:22:32','2021-05-25 06:35:11','2021-05-25 06:35:11','a3011bcb-8afe-4b25-b4e1-43659ab6e677'),(43,5,10,NULL,'gosa-logotype-white.svg','image',146,61,20886,NULL,NULL,NULL,'2021-05-25 06:22:31','2021-05-25 06:35:13','2021-05-25 06:35:13','4880cbda-38be-4eb0-9014-28cb4b63e2ed'),(44,5,10,NULL,'gosa-logotype-color.svg','image',146,40,31931,NULL,NULL,NULL,'2021-05-25 06:22:31','2021-05-25 06:35:15','2021-05-25 06:35:15','79002220-d5b8-4146-8e6e-a76e65444054'),(45,5,10,NULL,'good-living-logotype.svg','image',560,317,18619,NULL,NULL,NULL,'2021-05-25 06:22:31','2021-05-25 06:35:17','2021-05-25 06:35:17','c82f4fa7-567d-4f9d-8109-6acecb355842'),(46,5,10,NULL,'DCMB-rev-Horiz.svg','image',395,83,86362,NULL,NULL,NULL,'2021-05-25 06:22:26','2021-05-25 06:35:19','2021-05-25 06:35:19','0c3aea4a-474e-4fcf-a99c-eb57c336cdbe'),(47,5,10,NULL,'dcmb_logo.svg','image',80,46,4364,NULL,NULL,NULL,'2021-05-25 06:22:30','2021-05-25 06:35:21','2021-05-25 06:35:21','cf969a12-57f0-487a-9ce7-b902b5d77649'),(48,5,11,NULL,'ack-banner.png','image',326,190,122239,NULL,NULL,NULL,'2021-02-04 03:53:09','2021-05-25 06:35:23','2021-05-25 06:35:23','e9c08bfe-1c3a-4e7b-b0c1-b9e547691cbc'),(49,5,10,NULL,'craftcms.svg','image',104,26,5747,NULL,NULL,NULL,'2021-05-25 06:22:30','2021-05-25 06:35:24','2021-05-25 06:35:24','74df1985-5c1e-4973-a9ed-bb289885f892'),(50,5,10,NULL,'bsa-logotype-white.svg','image',123,55,2891,NULL,NULL,NULL,'2021-05-25 06:22:30','2021-05-25 06:35:26','2021-05-25 06:35:26','fcec1a83-19a9-4910-9679-6b4cdad486e2'),(51,5,11,NULL,'desert-parks-2010-176.jpg','image',3769,2512,3995340,NULL,NULL,NULL,'2020-09-11 01:37:06','2021-05-25 06:35:28','2021-05-25 06:35:28','887ec4fa-f6bc-4d14-ab4a-0fa51b617c05'),(52,5,11,NULL,'connect-with-sa.png','image',375,484,28447,NULL,NULL,NULL,'2021-04-09 05:14:21','2021-05-25 06:35:30','2021-05-25 06:35:30','e9391b08-19f7-49df-b8eb-050514853ce6'),(53,5,11,NULL,'apy-final.jpg','image',4006,965,424480,NULL,NULL,NULL,'2020-02-03 03:34:51','2021-05-25 06:35:31','2021-05-25 06:35:31','5d459754-60b8-420c-b764-e703f74248ed'),(54,5,11,NULL,'aoc-bg.png','image',1330,545,124992,NULL,NULL,NULL,'2021-04-12 03:47:10','2021-05-25 06:35:34','2021-05-25 06:35:34','1cc11ec0-a0b5-4a03-b558-43c18d75a0fd'),(55,5,10,NULL,'sagovau-logotype-white.svg','image',120,55,2902,NULL,NULL,NULL,'2021-05-25 06:22:33','2021-05-25 06:35:35','2021-05-25 06:35:35','a6b7129b-7023-4794-82c2-71f195ebe2f6');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedattributes` VALUES (10,1,'firstName','2021-05-25 03:31:36',0,10),(10,1,'lastName','2021-05-25 03:31:36',0,10),(12,1,'fieldLayoutId','2021-05-24 22:36:20',0,10),(12,1,'title','2021-05-24 22:42:13',0,10),(18,1,'slug','2021-05-24 23:02:38',0,10);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (12,1,11,'2021-05-24 22:42:13',0,10),(12,1,16,'2021-05-24 22:36:58',0,10),(12,1,25,'2021-05-24 22:42:13',0,10);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2021-05-24 00:08:00','2021-05-25 05:21:19','34716d5d-8493-4f28-847e-25d21d0b2c54',NULL,NULL,NULL,NULL,NULL,'This is a test *banner*',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2021-05-24 14:30:00'),(2,2,1,NULL,'2021-05-24 00:08:00','2021-05-24 00:08:01','a95e9edd-47cf-4888-ad77-5eb60f5f28b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,1,NULL,'2021-05-24 00:08:00','2021-05-25 07:40:41','a88eb03a-a854-4702-9ca4-743977e55c80','[{\"col1\":\"Disclaimer\",\"col2\":\"\"},{\"col1\":\"Privacy\",\"col2\":\"\"},{\"col1\":\"Accessibility\",\"col2\":\"\"}]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'The state government acknowledges Aboriginal people as the First Peoples and Nations of the lands and waters we live and work upon and we pay our respects to their Elders past, present and emerging. We acknowledge and respect the deep spiritual connection and the relationship that Aboriginal and Torres Strait Islander people have to Country.\n\nWe work in partnership with the First Peoples of South Australia and supports their Nations to take a leading role in caring for their Country.',NULL),(4,4,1,'404 Not Found','2021-05-24 00:08:01','2021-05-24 00:08:01','ffe08676-ae2e-4ad7-91dd-102dc55f1655',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'Generic Error','2021-05-24 00:08:01','2021-05-24 00:08:01','e08ce320-3a2f-4869-b490-abe357ae284a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'Site Offline','2021-05-24 00:08:01','2021-05-24 00:08:01','3ca8b603-70eb-4876-8875-a2dd0acb25cb',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,7,1,'503 Service Unavailable','2021-05-24 00:08:01','2021-05-24 00:08:01','8a7d4062-cf04-42f5-917e-3f6130cab547',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Home','2021-05-24 00:08:01','2021-05-24 00:08:01','dace35f1-e3bb-48dc-9c66-6ea45dc5c24d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,1,'Home','2021-05-24 00:08:01','2021-05-24 00:08:01','616b7fab-6058-4838-b968-c1d2cc658eb3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,10,1,NULL,'2021-05-24 00:08:02','2021-05-25 03:34:50','d2ceb115-270b-4f7b-aabc-eb22031eee11',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,12,1,'404 Error','2021-05-24 14:42:06','2021-05-24 22:42:13','78dcb1c3-7112-44be-b231-5b9a46329552',NULL,NULL,NULL,NULL,NULL,NULL,'404 Error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Not found',NULL,NULL,NULL),(14,14,1,'403 Error','2021-05-24 22:58:50','2021-05-24 22:58:50','178ecfdb-7a29-4ccf-9121-ca90c679c777',NULL,NULL,NULL,NULL,NULL,NULL,'403 Error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Forbidden.',NULL,NULL,NULL),(16,16,1,'503 Error','2021-05-24 23:01:11','2021-05-24 23:01:25','2a1328bb-7787-4324-9034-cdfd8ed63357',NULL,NULL,NULL,NULL,NULL,NULL,'503 Error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Service unavailable.',NULL,NULL,NULL),(18,18,1,'Error','2021-05-24 23:01:58','2021-05-24 23:02:38','3a9ea210-1283-478b-bb03-579fc22c837d',NULL,NULL,NULL,NULL,NULL,NULL,'Error',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Generic error.',NULL,NULL,NULL),(20,20,1,'Offline','2021-05-24 23:03:30','2021-05-24 23:03:30','a793a5d0-7e6f-444f-92bd-69c1bc317b1e',NULL,NULL,NULL,NULL,NULL,NULL,'Offline',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Site offline.',NULL,NULL,NULL),(21,21,1,NULL,'2021-05-25 02:04:00','2021-05-25 02:04:00','b6092a54-7de1-4e85-867a-ccfce4d4ffab',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,22,1,'Dcmb logo white','2021-05-25 05:23:37','2021-05-25 06:19:04','a0a04172-0bc2-40a0-9577-b639bfeaa25a',NULL,'{\"optimizedImageUrls\":{\"183\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2RjbWJfbG9nb193aGl0ZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxODMsImhlaWdodCI6MTA2LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"183\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2RjbWJfbG9nb193aGl0ZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTgzLCJoZWlnaHQiOjEwNiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[183],\"variantHeights\":{\"183\":106},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":183,\"originalImageHeight\":106,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAQQG/8QAHxAAAQMEAwEAAAAAAAAAAAAAAQACAwQREiExMkFC/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAL/xAAYEQACAwAAAAAAAAAAAAAAAAAAASEiMf/aAAwDAQACEQMRAD8A20cNLC7NjcSPdpmjppyDIA42uNnhTnog/KqQq4f/2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#0e8ecc\",\"#f1f0f5\",\"#8f8daa\",\"#b7248b\",\"#bc8eb4\"],\"lightness\":61,\"placeholderWidth\":183,\"placeholderHeight\":106,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,23,1,'Npwssa logotype','2021-05-25 05:23:37','2021-05-25 06:19:07','7bafdb23-8367-4548-829d-9bbe01fd7766',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL25wd3NzYS1sb2dvdHlwZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MTgwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL25wd3NzYS1sb2dvdHlwZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTYwLCJoZWlnaHQiOjE4MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[560],\"variantHeights\":{\"560\":180},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":560,\"originalImageHeight\":180,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAFABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAIRAAAQMCBwEAAAAAAAAAAAAAAgABAwQRBQYTISIxoXH/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAv/EABcRAAMBAAAAAAAAAAAAAAAAAAABAhH/2gAMAwEAAhEDEQA/AKWX4DfE64NY+GxO3ZPfvz1aKGnITu08j/XuiITL1H//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e7cfcd\",\"#254137\",\"#9db0a4\",\"#88575e\",\"#9c9c9c\"],\"lightness\":56,\"placeholderWidth\":560,\"placeholderHeight\":180,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,24,1,'Npwssa logotype black','2021-05-25 05:23:38','2021-05-25 06:19:09','69586be3-61c6-4a9c-9122-5e39ad09f9a1',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL25wd3NzYS1sb2dvdHlwZS1ibGFjay5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MTgwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL25wd3NzYS1sb2dvdHlwZS1ibGFjay5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTYwLCJoZWlnaHQiOjE4MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[560],\"variantHeights\":{\"560\":180},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":560,\"originalImageHeight\":180,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAFABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAIRAAAQMCBwEAAAAAAAAAAAAAAgABAwQRBQYTISIxoXH/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAv/EABcRAAMBAAAAAAAAAAAAAAAAAAABAhH/2gAMAwEAAhEDEQA/AKWX4DfE64NY+GxO3ZPfvz1aKGnITu08j/XuiITL1H//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e7cfce\",\"#254238\",\"#9fb0a5\",\"#88575e\",\"#9c9c9c\"],\"lightness\":57,\"placeholderWidth\":560,\"placeholderHeight\":180,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,25,1,'Lbsa logotype color','2021-05-25 05:23:38','2021-05-25 06:19:11','243db774-4e28-409a-8ed4-2409f516a0ea',NULL,'{\"optimizedImageUrls\":{\"831\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2xic2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6ODMxLCJoZWlnaHQiOjI1OSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"831\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2xic2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjgzMSwiaGVpZ2h0IjoyNTksImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[831],\"variantHeights\":{\"831\":259},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":831,\"originalImageHeight\":259,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAMF/8QAHxAAAgEDBQEAAAAAAAAAAAAAAQIAAzFBBBESFCJR/8QAFQEBAQAAAAAAAAAAAAAAAAAAAgP/xAAVEQEBAAAAAAAAAAAAAAAAAAAAEf/aAAwDAQACEQMRAD8A1epRZC7JyYC5J+bSb6el5BpggjOLxEaEf//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#144d57\",\"#e9f5f7\",\"#8fb6bb\",\"#81a1ad\",\"#a4acb4\"],\"lightness\":57,\"placeholderWidth\":831,\"placeholderHeight\":259,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,26,1,'Gosa logotype white','2021-05-25 05:23:38','2021-05-25 06:19:14','0f7182d1-f890-4d74-891f-b6a589828928',NULL,'{\"optimizedImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvc2EtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTQ2LCJoZWlnaHQiOjYxLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvc2EtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjE0NiwiaGVpZ2h0Ijo2MSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[146],\"variantHeights\":{\"146\":61},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":146,\"originalImageHeight\":61,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAGABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":146,\"placeholderHeight\":61,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,27,1,'Gosa logotype color','2021-05-25 05:23:38','2021-05-25 06:19:16','d3c1bc01-da7c-4a11-b5b9-b757cf740bf1',NULL,'{\"optimizedImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvc2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTQ2LCJoZWlnaHQiOjQwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvc2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjE0NiwiaGVpZ2h0Ijo0MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[146],\"variantHeights\":{\"146\":40},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":146,\"originalImageHeight\":40,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIG/8QAHhAAAgIABwAAAAAAAAAAAAAAAAECAxESISIxQ1L/xAAUAQEAAAAAAAAAAAAAAAAAAAAC/8QAFREBAQAAAAAAAAAAAAAAAAAAAAH/2gAMAwEAAhEDEQA/ANZTHMrN0lg1qmW6mu2zj0AOBX//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e8eff1\",\"#275479\",\"#7b7d81\",\"#66a4d4\",\"#919494\"],\"lightness\":61,\"placeholderWidth\":146,\"placeholderHeight\":40,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,28,1,'Good living logotype','2021-05-25 05:23:39','2021-05-25 06:19:18','96cb8992-3f75-4fca-a164-725a6fa8153f',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvb2QtbGl2aW5nLWxvZ290eXBlLnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjU2MCwiaGVpZ2h0IjozMTcsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2dvb2QtbGl2aW5nLWxvZ290eXBlLnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MzE3LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[560],\"variantHeights\":{\"560\":317},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":560,\"originalImageHeight\":317,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAABAX/xAAiEAABAwIGAwAAAAAAAAAAAAACAQMRAAQFEhQhMUE0UfD/xAAUAQEAAAAAAAAAAAAAAAAAAAAC/8QAFREBAQAAAAAAAAAAAAAAAAAAEQD/2gAMAwEAAhEDEQA/ALhWmJMNIbt2/JFlygqksRzz73+ilWt9oLQkdB5zdSUySJ7pvdBxfwHKaxC//9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#eef3f5\",\"#234066\",\"#84909e\",\"#98acbf\",\"#8ea1bd\"],\"lightness\":63,\"placeholderWidth\":560,\"placeholderHeight\":317,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,29,1,'DCMB rev Horiz','2021-05-25 05:23:39','2021-05-25 06:19:20','268f93ca-e91f-46e7-b5ca-c5131b7f7e81',NULL,'{\"optimizedImageUrls\":{\"395\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL0RDTUItcmV2LUhvcml6LnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjM5NSwiaGVpZ2h0Ijo4MywiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"395\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL0RDTUItcmV2LUhvcml6LnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjozOTUsImhlaWdodCI6ODMsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[395],\"variantHeights\":{\"395\":83},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":395,\"originalImageHeight\":83,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAADABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAABAb/xAAdEAACAQQDAAAAAAAAAAAAAAABAgMABBExEiIy/9oACAEBAAA/AK6xiR435LnudmkC2hz4G6//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#d6d6d6\",\"#232323\",\"#7b7b7b\",\"#575757\",\"#646464\"],\"lightness\":48,\"placeholderWidth\":395,\"placeholderHeight\":83,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,30,1,'Dcmb logo','2021-05-25 05:23:40','2021-05-25 06:19:22','e17a247a-850a-4703-bc64-f0460450b21f',NULL,'{\"optimizedImageUrls\":{\"80\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2RjbWJfbG9nby5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo4MCwiaGVpZ2h0Ijo0NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"80\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2RjbWJfbG9nby5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6ODAsImhlaWdodCI6NDYsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[80],\"variantHeights\":{\"80\":46},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":80,\"originalImageHeight\":46,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAQIG/8QAIhAAAgIABAcAAAAAAAAAAAAAAQIAEQMEEiExMkFCcYHh/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAL/xAAYEQACAwAAAAAAAAAAAAAAAAAAARESMf/aAAwDAQACEQMRAD8A1eHl0RbOHTdDe3uLZZWI1KDtYo8fks8kD2+JcsJVw//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#30558a\",\"#f2f1f5\",\"#a2378c\",\"#918faf\",\"#89859a\"],\"lightness\":57,\"placeholderWidth\":80,\"placeholderHeight\":46,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,31,1,'Ack banner','2021-05-25 05:23:40','2021-05-25 06:19:24','789641f7-420b-4970-b8a3-3b8bc7ccc318',NULL,'{\"optimizedImageUrls\":{\"326\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hY2stYmFubmVyLnBuZyIsImVkaXRzIjp7InBuZyI6eyJxdWFsaXR5IjoxMDAsInByb2dyZXNzaXZlIjp0cnVlfSwicmVzaXplIjp7IndpZHRoIjozMjYsImhlaWdodCI6MTkwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"326\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hY2stYmFubmVyLnBuZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjozMjYsImhlaWdodCI6MTkwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[326],\"variantHeights\":{\"326\":190},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":326,\"originalImageHeight\":190,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAwIE/8QAIBAAAAYBBQEAAAAAAAAAAAAAAAECAwQRcQUSMTQ1Yf/EABQBAQAAAAAAAAAAAAAAAAAAAAP/xAAYEQACAwAAAAAAAAAAAAAAAAAAAgEDFP/aAAwDAQACEQMRAD8AWPpkVLVracT9oFJiREIOm3DKudhmNkvptZEL89OAOhxYoQ//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#afa495\",\"#285379\",\"#866337\",\"#577696\",\"#583e1c\"],\"lightness\":44,\"placeholderWidth\":326,\"placeholderHeight\":190,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,32,1,'Craftcms','2021-05-25 05:23:41','2021-05-25 06:19:26','2dfd1fda-9dda-4786-bd7a-8c5de7716f21',NULL,'{\"optimizedImageUrls\":{\"104\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2NyYWZ0Y21zLnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjEwNCwiaGVpZ2h0IjoyNiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"104\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2NyYWZ0Y21zLnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxMDQsImhlaWdodCI6MjYsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[104],\"variantHeights\":{\"104\":26},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":104,\"originalImageHeight\":26,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAHxAAAQIGAwAAAAAAAAAAAAAAAAECAwUREiExE1GR/8QAFAEBAAAAAAAAAAAAAAAAAAAAAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwDVyhtzYuVTWsdlDiSlL3+gDRH/2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#a4abb3\",\"#f0f3f5\",\"#c2c6cb\",\"#ccd4d8\",\"#ccccdc\"],\"lightness\":79,\"placeholderWidth\":104,\"placeholderHeight\":26,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,33,1,'Bsa logotype white','2021-05-25 05:23:41','2021-05-25 06:19:28','0f56502b-d1b8-444e-906e-d9a75e6ed78d',NULL,'{\"optimizedImageUrls\":{\"123\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2JzYS1sb2dvdHlwZS13aGl0ZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxMjMsImhlaWdodCI6NTUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"123\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL2JzYS1sb2dvdHlwZS13aGl0ZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIzLCJoZWlnaHQiOjU1LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[123],\"variantHeights\":{\"123\":55},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":123,\"originalImageHeight\":55,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAHABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":123,\"placeholderHeight\":55,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,34,1,'Desert parks 2010 176','2021-05-25 05:23:42','2021-05-25 06:19:32','ac00e9ae-1304-4b34-bb6b-8551bfeec6e7',NULL,'{\"optimizedImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn19fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"optimizedWebPImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn19fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"variantSourceWidths\":[\"1200\",\"992\",\"768\",\"576\"],\"variantHeights\":{\"1200\":675,\"992\":558,\"768\":576,\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":3769,\"originalImageHeight\":2512,\"placeholder\":\"/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADAREAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAwT/xAAgEAAABgICAwAAAAAAAAAAAAAAAQIDBBESMQVxITQ1/8QAFwEAAwEAAAAAAAAAAAAAAAAAAAEEAv/EABgRAQEBAQEAAAAAAAAAAAAAAAABFAIx/9oADAMBAAIRAxEAPwBo/GxktWtlwvG8Q9ULPQyosRCDptyq3gZg0wZ6ul+m32IVfQz+eXRhNTx//9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#969999\",\"#2b577c\",\"#8d6839\",\"#e0b890\",\"#5d4422\"],\"lightness\":47,\"placeholderWidth\":1200,\"placeholderHeight\":675,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,35,1,'Connect with sa','2021-05-25 05:23:42','2021-05-25 06:19:37','af0fae67-f682-4afe-aaa0-da3715c992c4',NULL,'{\"optimizedImageUrls\":{\"375\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9jb25uZWN0LXdpdGgtc2EucG5nIiwiZWRpdHMiOnsicG5nIjp7InF1YWxpdHkiOjEwMCwicHJvZ3Jlc3NpdmUiOnRydWV9LCJyZXNpemUiOnsid2lkdGgiOjM3NSwiaGVpZ2h0Ijo0ODQsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"375\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9jb25uZWN0LXdpdGgtc2EucG5nIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjM3NSwiaGVpZ2h0Ijo0ODQsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[375],\"variantHeights\":{\"375\":484},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":375,\"originalImageHeight\":484,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAUABADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAAIDBf/EABkQAQEAAwEAAAAAAAAAAAAAAAABAhESMf/EABYBAQEBAAAAAAAAAAAAAAAAAAAEBf/EABYRAQEBAAAAAAAAAAAAAAAAAAACAf/aAAwDAQACEQMRAD8AzOSXFfRbFFYyp1SkvgBRL//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#1f7779\",\"#1c828e\",\"#1b6962\",\"#0c7375\",\"#16646c\"],\"lightness\":29,\"placeholderWidth\":375,\"placeholderHeight\":484,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,36,1,'Apy final','2021-05-25 05:23:42','2021-05-25 06:19:39','75a2f3ed-47d4-43c8-bca8-3a82c54c0b9d',NULL,'{\"optimizedImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"optimizedWebPImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"variantSourceWidths\":[\"1200\",\"992\",\"768\",\"576\"],\"variantHeights\":{\"1200\":675,\"992\":558,\"768\":576,\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":4006,\"originalImageHeight\":965,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADAREAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAgAF/8QAIBAAAQMDBQEAAAAAAAAAAAAAAQACAwQREhMUMkJRYf/EABcBAAMBAAAAAAAAAAAAAAAAAAABAgT/xAAZEQEBAAMBAAAAAAAAAAAAAAAAAQIDERP/2gAMAwEAAhEDEQA/AM91TUS21MyfAVc3RFxPeT42JfYfU/aFyn2asilFwKDf/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#4f5949\",\"#939ec5\",\"#4f6387\",\"#849269\",\"#7e7d5e\"],\"lightness\":46,\"placeholderWidth\":1200,\"placeholderHeight\":675,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,37,1,'Aoc bg','2021-05-25 05:23:43','2021-05-25 06:19:43','6491bce8-8162-45db-879e-5d6f564615be',NULL,'{\"optimizedImageUrls\":{\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hb2MtYmcucG5nIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hb2MtYmcucG5nIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"576\"],\"variantHeights\":{\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":1330,\"originalImageHeight\":545,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAMABADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAgMEBf/EABgQAAMBAQAAAAAAAAAAAAAAAAABAhFB/8QAFQEBAQAAAAAAAAAAAAAAAAAABAX/xAAVEQEBAAAAAAAAAAAAAAAAAAAAAv/aAAwDAQACEQMRAD8AzVCwCoKOCrEWlQ//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#1c7576\",\"#158395\",\"#1c655a\",\"#1e848a\",\"#046a6d\"],\"lightness\":29,\"placeholderWidth\":576,\"placeholderHeight\":432,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,38,1,'Sagovau logotype white','2021-05-25 05:23:43','2021-05-25 06:19:45','3293c6ee-c57f-46ee-9414-3f29d2b8db9b',NULL,'{\"optimizedImageUrls\":{\"120\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL3NhZ292YXUtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwLCJoZWlnaHQiOjU1LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"120\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL2xvZ29zL3NhZ292YXUtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjEyMCwiaGVpZ2h0Ijo1NSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[120],\"variantHeights\":{\"120\":55},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":120,\"originalImageHeight\":55,\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAHABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":120,\"placeholderHeight\":55,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,39,1,'Dcmb logo white','2021-05-25 06:35:05','2021-05-25 06:35:05','05408826-4986-4e6e-ac19-b3d8c769ead3',NULL,'{\"optimizedImageUrls\":{\"183\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2RjbWJfbG9nb193aGl0ZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxODMsImhlaWdodCI6MTA2LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"183\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2RjbWJfbG9nb193aGl0ZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTgzLCJoZWlnaHQiOjEwNiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"183\"],\"variantHeights\":{\"183\":106},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"183\",\"originalImageHeight\":\"106\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAQQG/8QAHxAAAQMEAwEAAAAAAAAAAAAAAQACAwQREiExMkFC/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAL/xAAYEQACAwAAAAAAAAAAAAAAAAAAASEiMf/aAAwDAQACEQMRAD8A20cNLC7NjcSPdpmjppyDIA42uNnhTnog/KqQq4f/2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#0e8ecc\",\"#f1f0f5\",\"#8f8daa\",\"#b7248b\",\"#bc8eb4\"],\"lightness\":61,\"placeholderWidth\":183,\"placeholderHeight\":106,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,40,1,'Npwssa logotype','2021-05-25 06:35:07','2021-05-25 06:35:07','4ae5ad21-d049-44a3-aa7b-ace9e98c0990',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL25wd3NzYS1sb2dvdHlwZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MTgwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL25wd3NzYS1sb2dvdHlwZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTYwLCJoZWlnaHQiOjE4MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"560\"],\"variantHeights\":{\"560\":180},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"560\",\"originalImageHeight\":\"180\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAFABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAIRAAAQMCBwEAAAAAAAAAAAAAAgABAwQRBQYTISIxoXH/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAv/EABcRAAMBAAAAAAAAAAAAAAAAAAABAhH/2gAMAwEAAhEDEQA/AKWX4DfE64NY+GxO3ZPfvz1aKGnITu08j/XuiITL1H//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e7cfcd\",\"#254137\",\"#9db0a4\",\"#88575e\",\"#9c9c9c\"],\"lightness\":56,\"placeholderWidth\":560,\"placeholderHeight\":180,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,41,1,'Npwssa logotype black','2021-05-25 06:35:09','2021-05-25 06:35:09','870e818b-89f1-4847-bd8a-842e7d34d051',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL25wd3NzYS1sb2dvdHlwZS1ibGFjay5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MTgwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL25wd3NzYS1sb2dvdHlwZS1ibGFjay5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTYwLCJoZWlnaHQiOjE4MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"560\"],\"variantHeights\":{\"560\":180},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"560\",\"originalImageHeight\":\"180\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAFABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAIRAAAQMCBwEAAAAAAAAAAAAAAgABAwQRBQYTISIxoXH/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAv/EABcRAAMBAAAAAAAAAAAAAAAAAAABAhH/2gAMAwEAAhEDEQA/AKWX4DfE64NY+GxO3ZPfvz1aKGnITu08j/XuiITL1H//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e7cfce\",\"#254238\",\"#9fb0a5\",\"#88575e\",\"#9c9c9c\"],\"lightness\":57,\"placeholderWidth\":560,\"placeholderHeight\":180,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(42,42,1,'Lbsa logotype color','2021-05-25 06:35:10','2021-05-25 06:35:10','60702b1f-facc-4f35-87ef-16d8997c6f3c',NULL,'{\"optimizedImageUrls\":{\"831\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2xic2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6ODMxLCJoZWlnaHQiOjI1OSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"831\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2xic2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjgzMSwiaGVpZ2h0IjoyNTksImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[\"831\"],\"variantHeights\":{\"831\":259},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"831\",\"originalImageHeight\":\"259\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAMF/8QAHxAAAgEDBQEAAAAAAAAAAAAAAQIAAzFBBBESFCJR/8QAFQEBAQAAAAAAAAAAAAAAAAAAAgP/xAAVEQEBAAAAAAAAAAAAAAAAAAAAEf/aAAwDAQACEQMRAD8A1epRZC7JyYC5J+bSb6el5BpggjOLxEaEf//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#144d57\",\"#e9f5f7\",\"#8fb6bb\",\"#81a1ad\",\"#a4acb4\"],\"lightness\":57,\"placeholderWidth\":831,\"placeholderHeight\":259,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(43,43,1,'Gosa logotype white','2021-05-25 06:35:13','2021-05-25 06:35:13','e5ef9915-d095-4407-96dd-dbca33b3f354',NULL,'{\"optimizedImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvc2EtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTQ2LCJoZWlnaHQiOjYxLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvc2EtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjE0NiwiaGVpZ2h0Ijo2MSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"146\"],\"variantHeights\":{\"146\":61},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"146\",\"originalImageHeight\":\"61\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAGABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":146,\"placeholderHeight\":61,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(44,44,1,'Gosa logotype color','2021-05-25 06:35:15','2021-05-25 06:35:15','e98f76d3-1b54-4c22-a5ba-6d8eecb3b1a8',NULL,'{\"optimizedImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvc2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTQ2LCJoZWlnaHQiOjQwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"146\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvc2EtbG9nb3R5cGUtY29sb3Iuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjE0NiwiaGVpZ2h0Ijo0MCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"146\"],\"variantHeights\":{\"146\":40},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"146\",\"originalImageHeight\":\"40\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAIG/8QAHhAAAgIABwAAAAAAAAAAAAAAAAECAxESISIxQ1L/xAAUAQEAAAAAAAAAAAAAAAAAAAAC/8QAFREBAQAAAAAAAAAAAAAAAAAAAAH/2gAMAwEAAhEDEQA/ANZTHMrN0lg1qmW6mu2zj0AOBX//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#e8eff1\",\"#275479\",\"#7b7d81\",\"#66a4d4\",\"#919494\"],\"lightness\":61,\"placeholderWidth\":146,\"placeholderHeight\":40,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,45,1,'Good living logotype','2021-05-25 06:35:17','2021-05-25 06:35:17','e1af5bce-03a5-4a2d-b558-0a86ed2ae826',NULL,'{\"optimizedImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvb2QtbGl2aW5nLWxvZ290eXBlLnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjU2MCwiaGVpZ2h0IjozMTcsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"560\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2dvb2QtbGl2aW5nLWxvZ290eXBlLnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo1NjAsImhlaWdodCI6MzE3LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[\"560\"],\"variantHeights\":{\"560\":317},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"560\",\"originalImageHeight\":\"317\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAABAX/xAAiEAABAwIGAwAAAAAAAAAAAAACAQMRAAQFEhQhMUE0UfD/xAAUAQEAAAAAAAAAAAAAAAAAAAAC/8QAFREBAQAAAAAAAAAAAAAAAAAAEQD/2gAMAwEAAhEDEQA/ALhWmJMNIbt2/JFlygqksRzz73+ilWt9oLQkdB5zdSUySJ7pvdBxfwHKaxC//9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#eef3f5\",\"#234066\",\"#84909e\",\"#98acbf\",\"#8ea1bd\"],\"lightness\":63,\"placeholderWidth\":560,\"placeholderHeight\":317,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,46,1,'DCMB rev Horiz','2021-05-25 06:35:19','2021-05-25 06:35:19','250904d1-2bf3-4c46-905d-2fe968c17539',NULL,'{\"optimizedImageUrls\":{\"395\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL0RDTUItcmV2LUhvcml6LnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjM5NSwiaGVpZ2h0Ijo4MywiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"395\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL0RDTUItcmV2LUhvcml6LnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjozOTUsImhlaWdodCI6ODMsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[\"395\"],\"variantHeights\":{\"395\":83},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"395\",\"originalImageHeight\":\"83\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAADABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAABAb/xAAdEAACAQQDAAAAAAAAAAAAAAABAgMABBExEiIy/9oACAEBAAA/AK6xiR435LnudmkC2hz4G6//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#d6d6d6\",\"#232323\",\"#7b7b7b\",\"#575757\",\"#646464\"],\"lightness\":48,\"placeholderWidth\":395,\"placeholderHeight\":83,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,47,1,'Dcmb logo','2021-05-25 06:35:21','2021-05-25 06:35:21','384e4c39-8b49-4192-af15-1b0307e60db1',NULL,'{\"optimizedImageUrls\":{\"80\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2RjbWJfbG9nby5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjo4MCwiaGVpZ2h0Ijo0NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"80\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2RjbWJfbG9nby5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6ODAsImhlaWdodCI6NDYsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[\"80\"],\"variantHeights\":{\"80\":46},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"80\",\"originalImageHeight\":\"46\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAQIG/8QAIhAAAgIABAcAAAAAAAAAAAAAAQIAEQMEEiExMkFCcYHh/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAL/xAAYEQACAwAAAAAAAAAAAAAAAAAAARESMf/aAAwDAQACEQMRAD8A1eHl0RbOHTdDe3uLZZWI1KDtYo8fks8kD2+JcsJVw//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#30558a\",\"#f2f1f5\",\"#a2378c\",\"#918faf\",\"#89859a\"],\"lightness\":57,\"placeholderWidth\":80,\"placeholderHeight\":46,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,48,1,'Ack banner','2021-05-25 06:35:23','2021-05-25 06:35:23','9eb3f34c-4e68-48b4-bdbc-1419da39eae3',NULL,'{\"optimizedImageUrls\":{\"326\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hY2stYmFubmVyLnBuZyIsImVkaXRzIjp7InBuZyI6eyJxdWFsaXR5IjoxMDAsInByb2dyZXNzaXZlIjp0cnVlfSwicmVzaXplIjp7IndpZHRoIjozMjYsImhlaWdodCI6MTkwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"326\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hY2stYmFubmVyLnBuZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjozMjYsImhlaWdodCI6MTkwLCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[\"326\"],\"variantHeights\":{\"326\":190},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"326\",\"originalImageHeight\":\"190\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAwIE/8QAIBAAAAYBBQEAAAAAAAAAAAAAAAECAwQRcQUSMTQ1Yf/EABQBAQAAAAAAAAAAAAAAAAAAAAP/xAAYEQACAwAAAAAAAAAAAAAAAAAAAgEDFP/aAAwDAQACEQMRAD8AWPpkVLVracT9oFJiREIOm3DKudhmNkvptZEL89OAOhxYoQ//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#afa495\",\"#285379\",\"#866337\",\"#577696\",\"#583e1c\"],\"lightness\":44,\"placeholderWidth\":326,\"placeholderHeight\":190,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,49,1,'Craftcms','2021-05-25 06:35:24','2021-05-25 06:35:24','6d1a290a-ad30-463f-a450-1dd1cf75663a',NULL,'{\"optimizedImageUrls\":{\"104\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2NyYWZ0Y21zLnN2ZyIsImVkaXRzIjp7InN2ZyI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjEwNCwiaGVpZ2h0IjoyNiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"104\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2NyYWZ0Y21zLnN2ZyIsImVkaXRzIjp7IndlYnAiOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxMDQsImhlaWdodCI6MjYsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[\"104\"],\"variantHeights\":{\"104\":26},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"104\",\"originalImageHeight\":\"26\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAEABADASIAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAAUG/8QAHxAAAQIGAwAAAAAAAAAAAAAAAAECAwUREiExE1GR/8QAFAEBAAAAAAAAAAAAAAAAAAAAAf/EABURAQEAAAAAAAAAAAAAAAAAAAAB/9oADAMBAAIRAxEAPwDVyhtzYuVTWsdlDiSlL3+gDRH/2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#a4abb3\",\"#f0f3f5\",\"#c2c6cb\",\"#ccd4d8\",\"#ccccdc\"],\"lightness\":79,\"placeholderWidth\":104,\"placeholderHeight\":26,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,50,1,'Bsa logotype white','2021-05-25 06:35:26','2021-05-25 06:35:26','c89ffe8a-3aa9-4878-b3fb-f82bd4a1d351',NULL,'{\"optimizedImageUrls\":{\"123\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2JzYS1sb2dvdHlwZS13aGl0ZS5zdmciLCJlZGl0cyI6eyJzdmciOnsicXVhbGl0eSI6MTAwfSwicmVzaXplIjp7IndpZHRoIjoxMjMsImhlaWdodCI6NTUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"123\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL2JzYS1sb2dvdHlwZS13aGl0ZS5zdmciLCJlZGl0cyI6eyJ3ZWJwIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIzLCJoZWlnaHQiOjU1LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"variantSourceWidths\":[\"123\"],\"variantHeights\":{\"123\":55},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"123\",\"originalImageHeight\":\"55\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAHABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":123,\"placeholderHeight\":55,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,51,1,'Desert parks 2010 176','2021-05-25 06:35:28','2021-05-25 06:35:28','548dcfdd-359d-4fec-91b1-679033b1b1dd',NULL,'{\"optimizedImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn19fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"optimizedWebPImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn19fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9kZXNlcnQtcGFya3MtMjAxMC0xNzYuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"variantSourceWidths\":[\"1200\",\"992\",\"768\",\"576\"],\"variantHeights\":{\"1200\":675,\"992\":558,\"768\":576,\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"3769\",\"originalImageHeight\":\"2512\",\"placeholder\":\"/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADAREAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAwT/xAAgEAAABgICAwAAAAAAAAAAAAAAAQIDBBESMQVxITQ1/8QAFwEAAwEAAAAAAAAAAAAAAAAAAAEEAv/EABgRAQEBAQEAAAAAAAAAAAAAAAABFAIx/9oADAMBAAIRAxEAPwBo/GxktWtlwvG8Q9ULPQyosRCDptyq3gZg0wZ6ul+m32IVfQz+eXRhNTx//9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#969999\",\"#2b577c\",\"#8d6839\",\"#e0b890\",\"#5d4422\"],\"lightness\":47,\"placeholderWidth\":1200,\"placeholderHeight\":675,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,52,1,'Connect with sa','2021-05-25 06:35:30','2021-05-25 06:35:30','8583fe80-f96d-4795-93be-7221201fc2f1',NULL,'{\"optimizedImageUrls\":{\"375\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9jb25uZWN0LXdpdGgtc2EucG5nIiwiZWRpdHMiOnsicG5nIjp7InF1YWxpdHkiOjEwMCwicHJvZ3Jlc3NpdmUiOnRydWV9LCJyZXNpemUiOnsid2lkdGgiOjM3NSwiaGVpZ2h0Ijo0ODQsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"optimizedWebPImageUrls\":{\"375\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9jb25uZWN0LXdpdGgtc2EucG5nIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjM3NSwiaGVpZ2h0Ijo0ODQsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\"},\"variantSourceWidths\":[\"375\"],\"variantHeights\":{\"375\":484},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"375\",\"originalImageHeight\":\"484\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAUABADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAAIDBf/EABkQAQEAAwEAAAAAAAAAAAAAAAABAhESMf/EABYBAQEBAAAAAAAAAAAAAAAAAAAEBf/EABYRAQEBAAAAAAAAAAAAAAAAAAACAf/aAAwDAQACEQMRAD8AzOSXFfRbFFYyp1SkvgBRL//Z\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#1f7779\",\"#1c828e\",\"#1b6962\",\"#0c7375\",\"#16646c\"],\"lightness\":29,\"placeholderWidth\":375,\"placeholderHeight\":484,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,53,1,'Apy final','2021-05-25 06:35:31','2021-05-25 06:35:31','331819fd-41a2-4290-890d-27670240a1c7',NULL,'{\"optimizedImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo4MiwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"optimizedWebPImageUrls\":{\"1200\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwMCwiaGVpZ2h0Ijo2NzUsImZpdCI6ImNvdmVyIn0sInNoYXJwZW4iOnRydWV9fQ==\",\"992\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo4Mn0sInJlc2l6ZSI6eyJ3aWR0aCI6OTkyLCJoZWlnaHQiOjU1OCwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"768\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NzY4LCJoZWlnaHQiOjU3NiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\",\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hcHktZmluYWwuanBnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifX19\"},\"variantSourceWidths\":[\"1200\",\"992\",\"768\",\"576\"],\"variantHeights\":{\"1200\":675,\"992\":558,\"768\":576,\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"4006\",\"originalImageHeight\":\"965\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAJABADAREAAhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAAAgAF/8QAIBAAAQMDBQEAAAAAAAAAAAAAAQACAwQREhMUMkJRYf/EABcBAAMBAAAAAAAAAAAAAAAAAAABAgT/xAAZEQEBAAMBAAAAAAAAAAAAAAAAAQIDERP/2gAMAwEAAhEDEQA/AM91TUS21MyfAVc3RFxPeT42JfYfU/aFyn2asilFwKDf/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#4f5949\",\"#939ec5\",\"#4f6387\",\"#849269\",\"#7e7d5e\"],\"lightness\":46,\"placeholderWidth\":1200,\"placeholderHeight\":675,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,54,1,'Aoc bg','2021-05-25 06:35:34','2021-05-25 06:35:34','eb4de50b-a601-42d2-9db5-888b7fe9d516',NULL,'{\"optimizedImageUrls\":{\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hb2MtYmcucG5nIiwiZWRpdHMiOnsianBlZyI6eyJxdWFsaXR5Ijo2MCwicHJvZ3Jlc3NpdmUiOnRydWUsInRyZWxsaXNRdWFudGlzYXRpb24iOnRydWUsIm92ZXJzaG9vdERlcmluZ2luZyI6dHJ1ZSwib3B0aW1pemVTY2FucyI6dHJ1ZX0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"optimizedWebPImageUrls\":{\"576\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0FPQy9hb2MtYmcucG5nIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5Ijo2MH0sInJlc2l6ZSI6eyJ3aWR0aCI6NTc2LCJoZWlnaHQiOjQzMiwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"576\"],\"variantHeights\":{\"576\":432},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"1330\",\"originalImageHeight\":\"545\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAAMABADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAgMEBf/EABgQAAMBAQAAAAAAAAAAAAAAAAABAhFB/8QAFQEBAQAAAAAAAAAAAAAAAAAABAX/xAAVEQEBAAAAAAAAAAAAAAAAAAAAAv/aAAwDAQACEQMRAD8AzVCwCoKOCrEWlQ//2Q==\",\"placeholderSvg\":\"\",\"colorPalette\":[\"#1c7576\",\"#158395\",\"#1c655a\",\"#1e848a\",\"#046a6d\"],\"lightness\":29,\"placeholderWidth\":576,\"placeholderHeight\":432,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,55,1,'Sagovau logotype white','2021-05-25 06:35:35','2021-05-25 06:35:35','8add8f3e-84c4-4c57-8a50-f841fa614e58',NULL,'{\"optimizedImageUrls\":{\"120\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL3NhZ292YXUtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsic3ZnIjp7InF1YWxpdHkiOjEwMH0sInJlc2l6ZSI6eyJ3aWR0aCI6MTIwLCJoZWlnaHQiOjU1LCJmaXQiOiJjb3ZlciJ9LCJzaGFycGVuIjp0cnVlfX0=\"},\"optimizedWebPImageUrls\":{\"120\":\"https://cdn.envsa.dev/img/eyJidWNrZXQiOiJlbnZzYS1idWNrZXQiLCJrZXkiOiJzaGFyZWQvaW1hZ2VzL0xvZ29zL3NhZ292YXUtbG9nb3R5cGUtd2hpdGUuc3ZnIiwiZWRpdHMiOnsid2VicCI6eyJxdWFsaXR5IjoxMDB9LCJyZXNpemUiOnsid2lkdGgiOjEyMCwiaGVpZ2h0Ijo1NSwiZml0IjoiY292ZXIifSwic2hhcnBlbiI6dHJ1ZX19\"},\"variantSourceWidths\":[\"120\"],\"variantHeights\":{\"120\":55},\"focalPoint\":{\"x\":0.5,\"y\":0.5},\"originalImageWidth\":\"120\",\"originalImageHeight\":\"55\",\"placeholder\":\"/9j/4AAQSkZJRgABAQAAYABgAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkzODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/wAALCAAHABABAREA/8QAFQABAQAAAAAAAAAAAAAAAAAAAAf/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/9oACAEBAAA/AKAP/9k=\",\"placeholderSvg\":\"\",\"colorPalette\":[],\"lightness\":null,\"placeholderWidth\":120,\"placeholderHeight\":55,\"stickyErrors\":[]}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `drafts` VALUES (5,NULL,10,'First draft',NULL,0,NULL,0);
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sourceOrder\":[[\"key\",\"*\"],[\"heading\",\"Singles\"],[\"key\",\"single:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"],[\"heading\",\"Channels\"],[\"key\",\"section:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"],[\"heading\",\"\"],[\"key\",\"section:a8c0d162-4d98-41f6-b67b-215123a3f69d\"]],\"sources\":{\"section:a8c0d162-4d98-41f6-b67b-215123a3f69d\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}}}}','2021-05-24 22:43:51','2021-05-24 22:43:51','a9cbee3c-5b6d-4fa1-9330-c3532ee58e58');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,2,'craft\\elements\\GlobalSet',1,0,'2021-05-24 00:08:00','2021-05-25 05:21:19',NULL,'6a16e864-cae2-42df-95cc-3834afcfe89b'),(2,NULL,NULL,4,'craft\\elements\\GlobalSet',1,0,'2021-05-24 00:08:00','2021-05-24 00:08:01',NULL,'c17bf7df-73d2-4012-9f9e-a6078d9996ff'),(3,NULL,NULL,8,'craft\\elements\\GlobalSet',1,0,'2021-05-24 00:08:00','2021-05-25 07:40:41',NULL,'a2c771d3-8007-42be-a397-7945f01f2c44'),(4,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:24','9925adfa-3b15-4cbc-9831-507bc3a05371'),(5,NULL,NULL,11,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:31','b8b623f3-bcb0-427b-bd16-62a23dfb69c1'),(6,NULL,NULL,12,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:34','f026bd66-93cc-4156-872f-49ead579354b'),(7,NULL,NULL,15,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:27','ab88661d-09c9-446e-b8bb-97c63cf661db'),(8,NULL,NULL,16,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'f9b8cbb0-50f2-4ad9-80f3-3c45bbf15f5a'),(9,NULL,1,16,'craft\\elements\\Entry',1,0,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'91a75bf3-1618-4e0d-a0cf-1eff02fc56fa'),(10,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2021-05-24 00:08:02','2021-05-25 03:34:50',NULL,'f25901a6-dd64-4146-89b6-0aafaa4551d3'),(12,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2021-05-24 14:42:06','2021-05-24 22:42:13',NULL,'1045fb96-ceaa-47e9-a601-d8631f2783c7'),(14,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2021-05-24 22:58:50','2021-05-24 22:58:50',NULL,'bd7ae7e7-7db8-430b-9d60-8fdc9d227dd9'),(16,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2021-05-24 23:01:11','2021-05-24 23:01:25',NULL,'cc05a081-feb6-4f7f-9b9e-34dfd7086d58'),(18,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2021-05-24 23:01:58','2021-05-24 23:02:38',NULL,'189a74c5-5435-41ac-8549-d69e1b4afb93'),(20,NULL,NULL,20,'craft\\elements\\Entry',1,0,'2021-05-24 23:03:30','2021-05-24 23:03:30',NULL,'544d6cdf-f7b7-4780-a605-d93c5b9f6ef4'),(21,5,NULL,17,'craft\\elements\\Entry',1,0,'2021-05-25 02:04:00','2021-05-25 02:04:00',NULL,'652bd931-9bd7-479c-b33d-b300a3c914d4'),(22,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:37','2021-05-25 06:19:04','2021-05-25 06:26:29','bb2755e3-c5b5-479e-b3d6-88ce54bb4171'),(23,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:37','2021-05-25 06:19:07','2021-05-25 06:26:29','13c57eaa-9f00-4d3e-a4f5-9c964d27e6a9'),(24,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:38','2021-05-25 06:19:09','2021-05-25 06:26:29','cd8490ce-2443-4f20-b8ce-5ea27f186c22'),(25,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:38','2021-05-25 06:19:11','2021-05-25 06:26:29','69ff658c-b489-4055-b815-a1fbf46db92c'),(26,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:38','2021-05-25 06:19:14','2021-05-25 06:26:29','030dbb1a-cfeb-420f-83f5-657f7712e83d'),(27,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:38','2021-05-25 06:19:16','2021-05-25 06:26:29','98b6492a-2077-4f1b-bab9-f32620344740'),(28,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:39','2021-05-25 06:19:18','2021-05-25 06:26:29','1d627295-384d-4509-9228-991d83652ce9'),(29,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:39','2021-05-25 06:19:20','2021-05-25 06:26:29','23baaebe-e54c-4bdd-af19-ac430d2b2cf4'),(30,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:40','2021-05-25 06:19:22','2021-05-25 06:26:29','9d141b9a-0453-45bb-8d8a-44dd65aeb18f'),(31,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:40','2021-05-25 06:19:24','2021-05-25 06:26:29','f03b8a26-d765-4a9e-867e-f3e197e5c6b2'),(32,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:41','2021-05-25 06:19:26','2021-05-25 06:26:29','e4292ca1-506f-4b47-8819-f4851838e02a'),(33,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:41','2021-05-25 06:19:28','2021-05-25 06:26:29','04247b50-a2f4-4a52-8da0-f0bd9b1e81ca'),(34,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:42','2021-05-25 06:19:32','2021-05-25 06:26:29','31334b54-11e4-4854-ba8c-8a0398ec030b'),(35,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:42','2021-05-25 06:19:37','2021-05-25 06:26:29','f27acf10-8ac2-4ed0-bacb-732cb4b9a0b1'),(36,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:42','2021-05-25 06:19:39','2021-05-25 06:26:29','7490d2e8-13ce-47c7-8876-a0b2ce6d840e'),(37,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:43','2021-05-25 06:19:43','2021-05-25 06:26:29','56c8cb92-1784-4e0b-be1e-7ad447388fdb'),(38,NULL,NULL,1,'craft\\elements\\Asset',1,0,'2021-05-25 05:23:43','2021-05-25 06:19:45','2021-05-25 06:26:29','77e8841d-df3e-4eb6-9eb5-841b631bdb94'),(39,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:05','2021-05-25 06:35:05',NULL,'8bcbe88f-0b4c-4497-ae3b-746ada20f11a'),(40,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:07','2021-05-25 06:35:07',NULL,'a4d415f5-297e-4e1d-8bfa-ed6dfcce666d'),(41,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:09','2021-05-25 06:35:09',NULL,'fd8ca3bd-f8d1-479e-ab19-0a723b624c12'),(42,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:10','2021-05-25 06:35:10',NULL,'a0d874a2-8f6c-40fd-9cb7-c40f8d1d15d5'),(43,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:13','2021-05-25 06:35:13',NULL,'4942e47a-3cc4-49a4-a4b5-7593ee4639b4'),(44,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:15','2021-05-25 06:35:15',NULL,'dfb0892b-d123-4331-810d-9d09f24d61bb'),(45,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:17','2021-05-25 06:35:17',NULL,'8336d0f4-2572-49f7-ade4-40b4da1c7bf6'),(46,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:19','2021-05-25 06:35:19',NULL,'5a56a7f4-5e81-452a-899d-211ef690c2f3'),(47,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:21','2021-05-25 06:35:21',NULL,'7cd1869e-0d2f-468c-95cb-f7b98d568273'),(48,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:23','2021-05-25 06:35:23',NULL,'ce979342-6b2a-453a-a58d-a6eef63871dd'),(49,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:24','2021-05-25 06:35:24',NULL,'4c3a21ca-42cf-4e43-87c2-4acfc9f62e47'),(50,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:26','2021-05-25 06:35:26',NULL,'374d114a-cd3e-4a17-a902-094b20c522da'),(51,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:28','2021-05-25 06:35:28',NULL,'7427a8e5-8641-4b0d-ac41-42c43df5d7d0'),(52,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:30','2021-05-25 06:35:30',NULL,'9dbbf09e-5466-47c7-b607-eb844f28db1f'),(53,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:31','2021-05-25 06:35:31',NULL,'71af196f-b574-41b8-abad-2df1a0c5cadb'),(54,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:34','2021-05-25 06:35:34',NULL,'62834a81-c174-4d48-b27d-684456ffa3df'),(55,NULL,NULL,21,'craft\\elements\\Asset',1,0,'2021-05-25 06:35:35','2021-05-25 06:35:35',NULL,'18687e3f-24a6-44c5-aa43-aa4090a13d3a');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','3fbab1ca-2f4c-495d-9d6b-40313009a878'),(2,2,1,NULL,NULL,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','38c382fc-8898-4744-8278-69f3eaaed6f3'),(3,3,1,NULL,NULL,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','75207832-e8ed-44aa-b774-0317422ecaa8'),(4,4,1,'404-not-found','404',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','08b4385d-7c03-43af-aaca-ddf75841d889'),(5,5,1,'generic-error','error',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2299b400-09c6-486e-86f8-1df6858155c0'),(6,6,1,'site-offline','offline',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','e45d4dbb-eab7-41ce-9575-f781cfde6b45'),(7,7,1,'503-service-unavailable','503',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','fb9eaade-4724-4aef-b666-45ddc52c7496'),(8,8,1,'homepage','__home__',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','675da6f8-6d4c-4cbb-b14d-6dd357ee52a1'),(9,9,1,'homepage','__home__',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','91288895-95d5-41da-9cb7-4870e602488d'),(10,10,1,NULL,NULL,1,'2021-05-24 00:08:02','2021-05-24 00:08:02','405dfdd8-a218-4be4-bd76-02a19f2be4f0'),(12,12,1,'error404',NULL,1,'2021-05-24 14:42:06','2021-05-24 14:42:06','b7fa1ec0-c0c8-486a-9ed2-90ceef739a0c'),(14,14,1,'error403',NULL,1,'2021-05-24 22:58:50','2021-05-24 22:58:50','58b32337-7ba3-4c24-98f5-39f77263b412'),(16,16,1,'error503',NULL,1,'2021-05-24 23:01:11','2021-05-24 23:01:11','fd76a9d3-c4f9-4068-800e-5a401bb9a894'),(18,18,1,'error',NULL,1,'2021-05-24 23:01:58','2021-05-24 23:02:38','ca83162f-e415-4163-bb23-0c981b53588f'),(20,20,1,'offline',NULL,1,'2021-05-24 23:03:30','2021-05-24 23:03:30','5ac14e27-fe24-4bc5-a14f-f4e5d5f3cc80'),(21,21,1,'__temp_hvbwflbxvethqkklhdxrdqkqpvsejsxvtcyn','__temp_hvbwflbxvethqkklhdxrdqkqpvsejsxvtcyn',1,'2021-05-25 02:04:00','2021-05-25 02:04:00','70c90d3f-91c3-4514-9602-3fe82d40ba8d'),(22,22,1,NULL,NULL,1,'2021-05-25 05:23:37','2021-05-25 05:23:37','eb928707-58f3-4906-a8f9-ef79b0df7a8f'),(23,23,1,NULL,NULL,1,'2021-05-25 05:23:37','2021-05-25 05:23:37','95eadcf7-018e-4a51-b0ca-a5ac4f2703ac'),(24,24,1,NULL,NULL,1,'2021-05-25 05:23:38','2021-05-25 05:23:38','775b5778-f248-45fb-a2ec-019bd20bd5d6'),(25,25,1,NULL,NULL,1,'2021-05-25 05:23:38','2021-05-25 05:23:38','2c73dd48-b195-41e1-88b6-289e42e2a189'),(26,26,1,NULL,NULL,1,'2021-05-25 05:23:38','2021-05-25 05:23:38','cb7ef61e-635e-4e27-bf54-86302b55ae68'),(27,27,1,NULL,NULL,1,'2021-05-25 05:23:38','2021-05-25 05:23:38','302e7c32-441d-41a8-8ed1-2fa3bea08663'),(28,28,1,NULL,NULL,1,'2021-05-25 05:23:39','2021-05-25 05:23:39','8698233f-9898-48b9-a848-ac0cda24b356'),(29,29,1,NULL,NULL,1,'2021-05-25 05:23:39','2021-05-25 05:23:39','88ded248-1689-4ee3-9065-6ecf533b42f7'),(30,30,1,NULL,NULL,1,'2021-05-25 05:23:40','2021-05-25 05:23:40','72852028-2a75-445f-9835-bbe87cc47cf2'),(31,31,1,NULL,NULL,1,'2021-05-25 05:23:40','2021-05-25 05:23:40','eb4dc8d5-91ae-4441-be2c-ec34ed3e55e0'),(32,32,1,NULL,NULL,1,'2021-05-25 05:23:41','2021-05-25 05:23:41','4e6176cc-6495-4eff-bb62-13b25e9b4fde'),(33,33,1,NULL,NULL,1,'2021-05-25 05:23:41','2021-05-25 05:23:41','6f37bbf6-6db6-4741-8b71-281762eb9375'),(34,34,1,NULL,NULL,1,'2021-05-25 05:23:42','2021-05-25 05:23:42','ec45a918-3f78-4b49-80e5-f7ba08aab9b6'),(35,35,1,NULL,NULL,1,'2021-05-25 05:23:42','2021-05-25 05:23:42','0236ef7a-f561-404f-8a28-63232155e47c'),(36,36,1,NULL,NULL,1,'2021-05-25 05:23:42','2021-05-25 05:23:42','16e79ae9-4e60-4b97-9afa-1b3222d0fa6c'),(37,37,1,NULL,NULL,1,'2021-05-25 05:23:43','2021-05-25 05:23:43','c53aaf93-0083-491c-8a6a-1653d103f961'),(38,38,1,NULL,NULL,1,'2021-05-25 05:23:43','2021-05-25 05:23:43','51c7e526-975a-4517-9457-db42e0a64073'),(39,39,1,NULL,NULL,1,'2021-05-25 06:35:05','2021-05-25 06:35:05','eb08e1f6-eb57-4bde-9b51-224e9d8c6f03'),(40,40,1,NULL,NULL,1,'2021-05-25 06:35:07','2021-05-25 06:35:07','ee16be2d-4911-48d4-997b-6f5db26d7d5f'),(41,41,1,NULL,NULL,1,'2021-05-25 06:35:09','2021-05-25 06:35:09','9385a01e-d917-4437-adcf-a851792f8865'),(42,42,1,NULL,NULL,1,'2021-05-25 06:35:10','2021-05-25 06:35:10','d12c549d-4307-441f-bb70-4dcdd32ca1d1'),(43,43,1,NULL,NULL,1,'2021-05-25 06:35:13','2021-05-25 06:35:13','dc98f954-9f68-4c6f-8a10-4e4afb4029c2'),(44,44,1,NULL,NULL,1,'2021-05-25 06:35:15','2021-05-25 06:35:15','4cf31623-4a9a-4c80-a25e-68d3cd933c0a'),(45,45,1,NULL,NULL,1,'2021-05-25 06:35:17','2021-05-25 06:35:17','a861a2a3-9740-415f-90f9-837ad573956c'),(46,46,1,NULL,NULL,1,'2021-05-25 06:35:19','2021-05-25 06:35:19','bbe809e5-6dd7-426d-b26c-fd4ce77c2241'),(47,47,1,NULL,NULL,1,'2021-05-25 06:35:21','2021-05-25 06:35:21','9bc3844c-9121-43fa-8be2-5cbdbb0263cb'),(48,48,1,NULL,NULL,1,'2021-05-25 06:35:23','2021-05-25 06:35:23','67b26ca6-1395-4c96-b0cd-8729a2c71d44'),(49,49,1,NULL,NULL,1,'2021-05-25 06:35:24','2021-05-25 06:35:24','0a300415-17b9-4a49-8d8e-c958fd4a231b'),(50,50,1,NULL,NULL,1,'2021-05-25 06:35:26','2021-05-25 06:35:26','d6cf85b3-9edd-4ffc-b818-3e93edef641d'),(51,51,1,NULL,NULL,1,'2021-05-25 06:35:28','2021-05-25 06:35:28','ed7921b0-2551-411f-a721-e9c37f0cffa1'),(52,52,1,NULL,NULL,1,'2021-05-25 06:35:30','2021-05-25 06:35:30','24e4d560-725b-4a74-b2bd-fd55dc4c3137'),(53,53,1,NULL,NULL,1,'2021-05-25 06:35:31','2021-05-25 06:35:31','468b9710-a6a7-4d59-b74f-d1a9018941ef'),(54,54,1,NULL,NULL,1,'2021-05-25 06:35:34','2021-05-25 06:35:34','64995424-f067-44ea-9334-5992e09daf06'),(55,55,1,NULL,NULL,1,'2021-05-25 06:35:35','2021-05-25 06:35:35','bdf509a5-fc23-45a2-a6f1-04b5de125321');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (4,1,NULL,1,NULL,'2021-05-24 00:08:00',NULL,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','ce4613d3-9f8e-46c1-8642-a2f7b3723f79'),(5,2,NULL,2,NULL,'2021-05-24 00:08:00',NULL,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','000a3838-90d1-4456-a7d6-28f7112e3f45'),(6,3,NULL,3,NULL,'2021-05-24 00:08:00',NULL,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','72bd4bee-8a94-45c5-bff6-60d0793a37f6'),(7,6,NULL,6,NULL,'2021-05-24 00:08:00',NULL,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','33d9add5-6f01-42ea-8afc-d27c038a3bfc'),(8,5,NULL,7,NULL,'2021-05-24 00:08:00',NULL,NULL,'2021-05-24 00:08:01','2021-05-24 00:08:01','c426d68a-586e-4160-8f5b-b35bf9b3f263'),(9,5,NULL,7,NULL,'2021-05-24 00:08:00',NULL,NULL,'2021-05-24 00:08:01','2021-05-24 00:08:01','f8f3c41e-1f0f-43c5-bb64-b164aea014df'),(12,7,NULL,10,10,'2021-05-24 14:41:00',NULL,NULL,'2021-05-24 14:42:06','2021-05-24 14:42:06','99ced2ee-8d61-456e-84fb-4a779164f700'),(14,7,NULL,10,10,'2021-05-24 22:57:00',NULL,NULL,'2021-05-24 22:58:50','2021-05-24 22:58:50','bcc416ab-f789-4172-82ec-91d54a65ed25'),(16,7,NULL,10,10,'2021-05-24 23:00:00',NULL,NULL,'2021-05-24 23:01:11','2021-05-24 23:01:11','28ffde08-00f4-4f68-b6d5-908bfb9fc75e'),(18,7,NULL,10,10,'2021-05-24 23:01:00',NULL,NULL,'2021-05-24 23:01:58','2021-05-24 23:01:58','203c2d22-aa64-4ea0-9031-66671278586f'),(20,7,NULL,10,10,'2021-05-24 23:02:00',NULL,NULL,'2021-05-24 23:03:30','2021-05-24 23:03:30','f33f1228-9ed9-46ba-b378-93af1677be67'),(21,4,NULL,8,10,'2021-05-25 02:04:00',NULL,NULL,'2021-05-25 02:04:00','2021-05-25 02:04:00','5bfcb92f-0702-44cd-bf98-ab67cdc3a7bf');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrypublishes`
--

LOCK TABLES `entrypublishes` WRITE;
/*!40000 ALTER TABLE `entrypublishes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrypublishes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,10,'404 Not Found','notFound',1,'site',NULL,'{section.name|raw}',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:24','cb4a3853-3a01-4e33-9ccb-1ad67e772c0e'),(2,2,11,'Generic Error','genericError',1,'site',NULL,'{section.name|raw}',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:31','dcdcc836-ef51-4775-b5e1-82552debe9a8'),(3,3,12,'Site Offline','siteOffline',1,'site',NULL,'{section.name|raw}',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:34','3e4817fe-7473-4944-a7a6-dd146f71e1c5'),(4,4,13,'Redirect','redirect',1,'site',NULL,NULL,4,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'d059edc7-b38e-4922-aee9-1cbc88b92ecd'),(5,4,14,'Full width','fullWidth',1,'site',NULL,NULL,2,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'98ad4db6-2be2-4ca8-9b2f-55b134195713'),(6,6,15,'503 Service Unavailable','serviceUnavailable',1,'site',NULL,'{section.name|raw}',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:27','d1353fee-b94b-4c06-af15-b08c5d633b88'),(7,5,16,'Homepage','homepage',0,'site',NULL,'Home',1,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'ecbd874f-2167-4018-a697-0ae3677231a7'),(8,4,17,'General','general',1,'site',NULL,NULL,1,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada'),(9,4,18,'Landing','landing',1,'site',NULL,NULL,3,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'aaa783ac-8136-45ae-954f-aeb3a10f9ab5'),(10,7,20,'Errors','errors',1,'',NULL,NULL,1,'2021-05-24 14:37:00','2021-05-24 22:36:50',NULL,'0e0fc1dc-2333-4642-823a-faeb5caffa84');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `feedme_feeds`
--

LOCK TABLES `feedme_feeds` WRITE;
/*!40000 ALTER TABLE `feedme_feeds` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `feedme_feeds` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Globals','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'820d67ae-c658-4d30-8347-14058c97e1c1'),(2,'Settings','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b'),(3,'Assets','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'c070a16a-3c83-4536-ad01-e4a85fade10d'),(4,'Optimized images','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'3004f128-4dcc-4b0f-9369-4c7f87cb3839'),(5,'Blocks','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'e122630f-ef1f-4011-b0d4-3e3487d928b3'),(6,'Common','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'5530f693-5e22-48f0-ba53-d8e8999ec908'),(7,'Errors','2021-05-24 00:07:59','2021-05-24 00:07:59',NULL,'7cc23e51-bc00-4d62-832b-6cc9c0b4d923');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (25,10,16,11,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','ac9deab6-3a81-45d1-9caf-2477af9d91df'),(26,10,16,16,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','baf77cd4-dece-4fdf-a9c1-aa1af520db39'),(27,10,16,25,0,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','69bc4833-66ec-4768-a8f9-460c79ecd856'),(28,11,17,11,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','3c33022d-fce4-42ff-b64b-339d50159911'),(29,11,17,16,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','726c6419-694c-45af-8413-9e3476409afa'),(30,11,17,25,0,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','a7609ab3-0cba-43b5-b5d5-27b7e2c35ba9'),(31,12,18,11,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','19b0809d-b8ff-44f2-aca5-581c5cabbbb5'),(32,12,18,16,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','242108be-5d44-4c38-a85f-c84c9dc29f44'),(33,12,18,25,0,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','8c49f957-769f-499d-8162-4a154e35d7cd'),(34,8,19,19,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','32c18b48-4777-4c5d-8ba5-9768c5a9251d'),(35,8,19,27,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','2f6ddbb0-84a5-49e4-a1cc-e9f972eace83'),(36,8,19,1,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','11fb5f23-0e38-4c87-88b9-e1d723f22e1d'),(37,13,20,26,1,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','1ae66a3d-4d84-4757-8177-dd17e7600555'),(38,13,21,14,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','1ae652ae-4b47-40e9-962e-654e7af798d6'),(39,13,21,24,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','09969f2a-6212-4483-9ef1-d3a68ec1bbb8'),(40,13,21,7,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','e68fccde-5408-4eb2-a1df-f00f91955e25'),(41,13,21,8,0,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','0f37fd3f-e4fc-4475-b008-154747142f31'),(42,13,21,3,0,4,'2021-05-24 00:08:01','2021-05-24 00:08:01','f21301bf-9939-4e74-acd1-81ce9cc1009f'),(43,4,22,15,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','5ae314c8-f09a-4fef-a7c5-6098a9d4c5b9'),(44,4,22,6,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','cd11b3c2-0b62-4331-b705-44a78bd711b1'),(45,15,24,11,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','ae71f65a-fdd5-4f24-b4a0-283373ce77f9'),(46,15,24,16,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','9d029d0c-68ef-4021-a2e5-014e35ed3fcb'),(47,15,24,25,0,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','391b9af6-5e71-4d4b-8a62-3c9372d241ec'),(48,17,26,23,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','bfeca56f-7b28-406a-91db-c4952f559afb'),(49,1,29,21,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','11143268-991e-4163-87d4-0c287e973356'),(50,1,29,9,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','6f7de753-c636-4741-acc6-a71ee57492de'),(51,1,30,2,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','13329cb9-7d96-4afa-93bf-8cf8c6499eff'),(52,3,31,21,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','545bf753-187f-4ab2-aace-74543eb6afd4'),(53,3,31,9,0,2,'2021-05-24 00:08:01','2021-05-24 00:08:01','a8a39f14-b358-47b2-ac41-9aa7ad098dd4'),(54,3,32,2,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','4e4f0a0e-a66a-4f45-92b8-408a6ab152dc'),(58,5,35,4,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','fcab6f1c-3d66-425e-b53c-cf9530720e4f'),(59,5,36,20,0,0,'2021-05-24 00:08:01','2021-05-24 00:08:01','6ec3d72b-3505-47d5-82a2-2f821dd88778'),(60,5,36,9,0,1,'2021-05-24 00:08:01','2021-05-24 00:08:01','935e3da6-efab-4ad7-89d2-21c32a24042e'),(62,6,39,22,0,0,'2021-05-24 00:08:02','2021-05-24 00:08:02','235ac8e8-b901-4113-bf59-fe883938490b'),(63,2,40,10,0,0,'2021-05-24 00:08:02','2021-05-24 00:08:02','57ebd1e5-6b74-47b1-9a67-60abce3dccba'),(64,2,40,13,0,1,'2021-05-24 00:08:02','2021-05-24 00:08:02','ef6af0b1-7fc2-4a2c-ae42-624b2b036b37'),(65,2,40,28,0,2,'2021-05-24 00:08:02','2021-05-24 00:08:02','fc53df4d-afbd-4351-b785-31db9793b77a'),(66,2,40,18,0,3,'2021-05-24 00:08:02','2021-05-24 00:08:02','4f812329-cf26-4c00-8f0d-4657bdd631b6'),(67,2,40,17,0,4,'2021-05-24 00:08:02','2021-05-24 00:08:02','bd253c6d-f1b9-485b-9c75-3dfc131c4bcb'),(71,20,43,11,1,1,'2021-05-24 22:36:50','2021-05-24 22:36:50','4f6437a1-957e-49e0-ab3e-05bca405f33e'),(72,20,43,25,1,2,'2021-05-24 22:36:50','2021-05-24 22:36:50','d1cfac44-0007-4df4-a62b-2e44c7276a10'),(73,20,43,16,0,3,'2021-05-24 22:36:50','2021-05-24 22:36:50','f35d4efd-8c76-4487-ad91-739cf2cfc3c4'),(74,21,44,21,0,1,'2021-05-25 06:34:28','2021-05-25 06:34:28','85a14452-3bb8-4130-9c6a-763b0f5165c7'),(75,21,44,9,0,2,'2021-05-25 06:34:28','2021-05-25 06:34:28','2cf27647-591b-4c03-835d-e336fa466137'),(76,21,45,2,0,0,'2021-05-25 06:34:28','2021-05-25 06:34:28','2f65328f-6ca1-48bd-8d9a-1d1ae3f652bd');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Asset','2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 06:26:29','d6d46ea7-ef0c-4649-9b1b-32d807dbdb5f'),(2,'craft\\elements\\GlobalSet','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'f94f935f-88f7-4e0a-987f-cf140e155cad'),(3,'craft\\elements\\Asset','2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 00:48:05','670a5f66-a801-4bbd-8783-d94703d45a6b'),(4,'craft\\elements\\GlobalSet','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'f17eb96b-6f58-4b4e-9d9c-29b22a3c382f'),(5,'benf\\neo\\elements\\Block','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'7a07039d-10df-4e6a-a9e7-362c6abdb517'),(6,'benf\\neo\\elements\\Block','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'2977a957-31c1-4ef4-91e6-858edec1167c'),(7,'craft\\elements\\Asset','2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 00:48:12','882f9caa-8282-439f-b951-4d1a0623bc66'),(8,'craft\\elements\\GlobalSet','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'0c6b2725-c24b-427c-95b2-d64c3f434029'),(9,'craft\\elements\\Asset','2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'f5363b55-b061-491a-9d18-f7acdb6b2de4'),(10,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:24','1185d871-3aba-4d32-ac0b-fb25a52f9610'),(11,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:31','93ed6f94-2cd7-4c1a-8fae-19822226b9a4'),(12,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:34','55f0a27d-fc43-4711-b52f-d33370307ff3'),(13,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'ca8c8850-a918-40e5-8764-6c41ff22005c'),(14,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'e44c8a74-10a2-48a6-8d49-238fb5a745f5'),(15,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:27','2162008d-26bc-4208-a40b-c8715c174e77'),(16,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'36b70137-d270-4462-84e0-3f23d9d26df4'),(17,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'cc7b76f2-aea2-4851-8e97-1d3b4f565a6d'),(18,'craft\\elements\\Entry','2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'a047e99f-b0d0-4e0e-9671-98e8043e5c5c'),(19,'craft\\elements\\Entry','2021-05-24 14:37:00','2021-05-24 14:37:00','2021-05-24 14:41:29','941a9ac2-70b4-4dd8-b234-3569a332470a'),(20,'craft\\elements\\Entry','2021-05-24 22:36:17','2021-05-24 22:36:17',NULL,'ab9d869d-fefc-4661-97e2-b93f79b4d294'),(21,'craft\\elements\\Asset','2021-05-25 06:34:28','2021-05-25 06:34:28',NULL,'e2a2a2db-1a22-43fe-bd08-f11492d09a4a');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (16,10,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21f58d98-8320-49d6-8066-b096dee14310\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','a2eefc49-a1e1-4ed3-9879-62acd1bc6647'),(17,11,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21f58d98-8320-49d6-8066-b096dee14310\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','0a391c39-0c4b-4b05-9766-8a5456618aad'),(18,12,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21f58d98-8320-49d6-8066-b096dee14310\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','be5edadb-a6c4-4eba-850d-54ab0d5bc164'),(19,8,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b7232602-e058-4dc6-b639-3e5dfb6ee3f0\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"434cb523-f553-43e1-b517-b4350f11580e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"906dff7a-94e7-43bb-a515-3feda5b3bbec\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','3f05d358-01d4-49ca-be94-4d855423b121'),(20,13,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"1\",\"width\":100,\"fieldUid\":\"1b30d64f-2b47-47ab-b74c-56ca223018fd\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','ce9875fb-bf28-495c-9a9c-e2af8e385495'),(21,13,'Settings','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"ad29506d-5bf0-4507-ace0-445d37ad4df3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"06536257-6591-4559-b58a-811c65d68b07\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b8cad5cb-060a-4f09-b35c-c4ddd40c147b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"8faa7537-f8f6-4808-88f5-909c50cf87b8\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"6535d548-8ab4-4b6f-acef-a044ef5e2f97\"}]',2,'2021-05-24 00:08:01','2021-05-24 00:08:01','4369ec69-d2cc-4377-9233-78516f56ccd6'),(22,4,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"38aeb4dd-0882-41f8-98a5-bf78e31d659a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"eba7d0a3-19f3-4d50-8ea8-850b84c5af55\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','676e703c-4e0c-41b8-8156-c21c58d687a1'),(23,14,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','9a5e9e2e-e80c-4994-ac5a-3c99fb1bf657'),(24,15,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"21f58d98-8320-49d6-8066-b096dee14310\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','fbb0a21a-393e-46c8-8721-720e8857d33e'),(25,16,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','fca6e014-8ca6-47eb-96a3-5c35649de133'),(26,17,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"e449bc51-6949-4b4c-8fbf-008e590c9935\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','b40340cd-f255-44ea-a39e-d65843a54da5'),(27,7,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','8c594a5f-cf66-48cc-86a8-55249818acbd'),(28,18,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','e3c9d977-f72b-4622-aef3-735434c4240d'),(29,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a920bb04-faca-4f59-9a0a-a2e2a090fe23\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','8464c9fd-ae8c-4a9e-a04b-569713e2225e'),(30,1,'Optimized images','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"da2fde99-98d1-4e82-b00c-5c792200f49f\"}]',2,'2021-05-24 00:08:01','2021-05-24 00:08:01','2efbdfa8-bac0-4ff8-8f7c-52ae8f959e40'),(31,3,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a920bb04-faca-4f59-9a0a-a2e2a090fe23\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','5339c23f-ac68-4e04-8871-51f3ddb42eb0'),(32,3,'Optimized images','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"da2fde99-98d1-4e82-b00c-5c792200f49f\"}]',2,'2021-05-24 00:08:01','2021-05-24 00:08:01','bd894d9c-2e11-446d-b071-c38f30cd8778'),(35,5,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"c1fbbe64-a078-4af6-9266-3321a7dc4724\"}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','c4872ff3-e9d4-4575-b57f-a7e4ede6de1c'),(36,5,'Settings','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"886db157-8715-44d2-a1f6-36b4ac508beb\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"Custom caption\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"}]',2,'2021-05-24 00:08:01','2021-05-24 00:08:01','c39f2023-ff4b-4c51-a01c-bd0226f2be46'),(37,9,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','182aa562-0dcc-49a0-a74d-c3805196b6c5'),(39,6,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"fb00c1dd-4f98-427b-a2ba-4b53503d8cb5\"}]',1,'2021-05-24 00:08:02','2021-05-24 00:08:02','44a5ccdf-9987-42e9-97c8-5b3a7033f854'),(40,2,'Main','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a7fa6737-974c-401e-ac92-6239739c2ccc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b5e6b714-38fe-4661-91c0-28454e56d45a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a93a6824-982b-40e8-ab4b-3ed360a152c3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9\"}]',1,'2021-05-24 00:08:02','2021-05-24 00:08:02','2982d855-d084-4f0f-90d5-58c5b4e1e18e'),(41,19,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-24 14:37:00','2021-05-24 14:37:00','d434febd-f13f-41c7-b852-6331b4c148c3'),(43,20,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"1\",\"width\":100,\"fieldUid\":\"21f58d98-8320-49d6-8066-b096dee14310\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"1\",\"width\":100,\"fieldUid\":\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"}]',1,'2021-05-24 22:36:50','2021-05-24 22:36:50','873f4473-fe2f-4610-9c22-568d87a5082b'),(44,21,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a920bb04-faca-4f59-9a0a-a2e2a090fe23\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"}]',1,'2021-05-25 06:34:28','2021-05-25 06:34:28','db6e2479-fd81-4a9e-840f-73d351f46e83'),(45,21,'Optimized images','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"da2fde99-98d1-4e82-b00c-5c792200f49f\"}]',2,'2021-05-25 06:34:28','2021-05-25 06:34:28','4438ec98-0d40-4d6d-a8e1-fd8993521d51');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,1,'Footer links','footerLinks','global','',0,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a link\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Text\",\"handle\":\"text\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Link\",\"handle\":\"link\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[{\"col1\":\"Disclaimer\",\"col2\":\"\"},{\"col1\":\"Privacy\",\"col2\":\"\"},{\"col1\":\"Accessibility\",\"col2\":\"\"}],\"maxRows\":\"\",\"minRows\":\"\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','906dff7a-94e7-43bb-a515-3feda5b3bbec'),(2,4,'Optimized general','optimizedGeneral','global','',0,'none',NULL,'nystudio107\\imageoptimize\\fields\\OptimizedImages','{\"displayDominantColorPalette\":\"1\",\"displayLazyLoadPlaceholderImages\":\"1\",\"displayOptimizedImageVariants\":\"1\",\"variants\":[{\"width\":\"1200\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"992\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"16\",\"aspectRatioY\":\"9\",\"retinaSizes\":[\"1\"],\"quality\":\"82\",\"format\":\"jpg\"},{\"width\":\"768\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"},{\"width\":\"576\",\"useAspectRatio\":\"1\",\"aspectRatioX\":\"4\",\"aspectRatioY\":\"3\",\"retinaSizes\":[\"1\"],\"quality\":\"60\",\"format\":\"jpg\"}]}','2021-05-24 00:07:59','2021-05-24 00:07:59','da2fde99-98d1-4e82-b00c-5c792200f49f'),(3,2,'Teaser image','teaserImage','global','Alternate image for navigation menus etc.',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:e06bad3e-e63c-49ac-b605-164d334f58f8\"],\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','6535d548-8ab4-4b6f-acef-a044ef5e2f97'),(4,6,'Image','image','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:16:13','c1fbbe64-a078-4af6-9266-3321a7dc4724'),(5,6,'Content builder','contentBuilder','global','',0,'site',NULL,'benf\\neo\\Field','{\"maxBlocks\":\"\",\"maxLevels\":\"\",\"maxTopBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\",\"wasModified\":true}','2021-05-24 00:07:59','2021-05-24 00:07:59','9ccb3478-824d-4f4b-a1ca-7589415a1339'),(6,1,'Favicon','favicon','global','It\'s best to try and make sure this is cropped square before uploading',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\",\"defaultUploadLocationSubpath\":\"favicons\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Select favicon source\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\",\"singleUploadLocationSubpath\":\"Favicons\",\"source\":null,\"sources\":[\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"],\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:02:28','eba7d0a3-19f3-4d50-8ea8-850b84c5af55'),(7,2,'Teaser title','teaserTitle','global','Alternate title for navigation menus etc.',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','b8cad5cb-060a-4f09-b35c-c4ddd40c147b'),(8,2,'Teaser text','teaserText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"2\",\"multiline\":\"1\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','8faa7537-f8f6-4808-88f5-909c50cf87b8'),(9,3,'Caption','caption','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','112c70eb-196d-49cf-8c69-cb6cd11432ac'),(10,6,'Alert text','alertText','global','This field accepts [Markdown](https://devhints.io/markdown)',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','a7fa6737-974c-401e-ac92-6239739c2ccc'),(11,7,'Error headline','errorHeadline','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','21f58d98-8320-49d6-8066-b096dee14310'),(12,6,'SEO','seo','global','',0,'none',NULL,'nystudio107\\seomatic\\fields\\SeoSettings','{\"elementDisplayPreviewType\":\"google\",\"facebookEnabledFields\":[\"seoPreview\",\"ogTitle\",\"ogDescription\",\"ogImage\"],\"facebookTabEnabled\":\"1\",\"generalEnabledFields\":[\"seoPreview\",\"seoTitle\",\"seoDescription\",\"seoImage\",\"robots\",\"canonicalUrl\"],\"generalTabEnabled\":\"1\",\"sitemapEnabledFields\":[\"sitemapUrls\"],\"sitemapTabEnabled\":\"1\",\"twitterTabEnabled\":\"\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','56f7afac-4e92-4e6b-bc02-0902467b5843'),(13,6,'Dismiss','dismiss','global','Allow the user to close this?',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":true,\"offLabel\":\"No\",\"onLabel\":\"Yes\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a'),(14,2,'Hide from navigation','hideNav','global','Hide this page from navigation menus',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2021-05-24 00:07:59','2021-05-24 00:07:59','ad29506d-5bf0-4507-ace0-445d37ad4df3'),(15,1,'Site logo','siteLogo','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add a logo\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\",\"singleUploadLocationSubpath\":\"Logos\",\"source\":null,\"sources\":[\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"],\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:02:02','38aeb4dd-0882-41f8-98a5-bf78e31d659a'),(16,7,'Error image','errorImage','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:02:55','07c3c9d2-dac1-46ee-9c0b-0198c2b71d77'),(17,6,'Excluded pages','excludedPages','global','',0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"limit\":\"\",\"localizeRelations\":false,\"selectionLabel\":\"\",\"showSiteMenu\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2021-05-24 00:07:59','2021-05-24 00:07:59','bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9'),(18,6,'End date','endDate','global','',0,'none',NULL,'craft\\fields\\Date','{\"max\":null,\"min\":null,\"minuteIncrement\":\"15\",\"showDate\":true,\"showTime\":true}','2021-05-24 00:07:59','2021-05-24 00:07:59','a93a6824-982b-40e8-ab4b-3ed360a152c3'),(19,1,'Acknowledgement image','acknowledgementImage','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\",\"singleUploadLocationSubpath\":\"AOC\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:39:51','b7232602-e058-4dc6-b639-3e5dfb6ee3f0'),(20,2,'Show caption','showCaption','global','Show image caption',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":\"Hide\",\"onLabel\":\"Show\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','886db157-8715-44d2-a1f6-36b4ac508beb'),(21,3,'Alt text','altText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','a920bb04-faca-4f59-9a0a-a2e2a090fe23'),(22,6,'Rich text','richText','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2021-05-24 00:07:59','2021-05-24 00:07:59','fb00c1dd-4f98-427b-a2ba-4b53503d8cb5'),(23,6,'Hero image','heroImage','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add an image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2021-05-24 00:07:59','2021-05-25 07:15:48','e449bc51-6949-4b4c-8fbf-008e590c9935'),(24,2,'Hide from search','hideSearch','global','Hide this page from site search results',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:08:00','2021-05-24 00:08:00','06536257-6591-4559-b58a-811c65d68b07'),(25,7,'Error text','errorText','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:08:00','2021-05-24 00:08:00','bc3e6fff-c84a-486c-94ff-f77de96ab75f'),(26,6,'Redirect URL','redirectUrl','global','',1,'none',NULL,'craft\\fields\\Url','{\"maxLength\":\"255\",\"placeholder\":null,\"types\":[\"url\"]}','2021-05-24 00:08:00','2021-05-24 00:08:00','1b30d64f-2b47-47ab-b74c-56ca223018fd'),(27,1,'Acknowledgement text','acknowledgementText','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":null,\"uiMode\":\"normal\"}','2021-05-24 00:08:00','2021-05-24 00:08:00','434cb523-f553-43e1-b517-b4350f11580e'),(28,6,'Start date','startDate','global','',0,'none',NULL,'craft\\fields\\Date','{\"max\":null,\"min\":null,\"minuteIncrement\":\"15\",\"showDate\":true,\"showTime\":true}','2021-05-24 00:08:00','2021-05-24 00:08:00','b5e6b714-38fe-4661-91c0-28454e56d45a');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `globalsets` VALUES (1,'Sitewide alert','sitewideAlert',2,'2021-05-24 00:08:00','2021-05-24 00:08:00','6a16e864-cae2-42df-95cc-3834afcfe89b'),(2,'Site','site',4,'2021-05-24 00:08:00','2021-05-24 00:08:00','c17bf7df-73d2-4012-9f9e-a6078d9996ff'),(3,'Footer','footer',8,'2021-05-24 00:08:00','2021-05-24 00:08:00','a2c771d3-8007-42be-a397-7945f01f2c44');
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.6.15','3.6.8',0,'bfipkraccpyx','fgemtrklbllx','2021-05-24 00:07:57','2021-05-25 07:39:51','6688e05e-4b79-4f05-b82b-c9cf485d153a');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `lockout`
--

LOCK TABLES `lockout` WRITE;
/*!40000 ALTER TABLE `lockout` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `lockout` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'plugin:aws-s3','Install','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','566246f5-24da-40bc-9b02-7899f1d4eac9'),(2,'plugin:aws-s3','m180929_165000_remove_storageclass_setting','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','e016d86a-af05-4a62-94bc-3821442c37da'),(3,'plugin:aws-s3','m190131_214300_cleanup_config','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','7b65053f-b409-4082-86e3-039087a10e03'),(4,'plugin:aws-s3','m190305_133000_cleanup_expires_config','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','b0899fb3-6c94-4f8c-a89c-fbbf0534cb0a'),(5,'plugin:feed-me','Install','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','48a210c1-89d5-4869-bbe6-cb7d81731e85'),(6,'plugin:feed-me','m180305_000000_migrate_feeds','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','2831c56c-f622-42a1-8b79-abd30fc03989'),(7,'plugin:feed-me','m181113_000000_add_paginationNode','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','4094d2aa-00d2-47cd-8f93-58f140d02251'),(8,'plugin:feed-me','m190201_000000_update_asset_feeds','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','43f579d7-2e24-4496-810f-b27f31176808'),(9,'plugin:feed-me','m190320_000000_renameLocale','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','0381f421-04b5-4bf4-a693-472f49ccfb6d'),(10,'plugin:feed-me','m190406_000000_sortOrder','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','fd5c621d-769b-486f-b7e5-5acaa1c59539'),(11,'plugin:feed-me','m201106_202042_singleton_feeds','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','adcaf03e-604b-4aa2-a087-bd40f520c76c'),(12,'plugin:incognito-field','m190226_225231_craft3','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','aa059e04-dd15-4c10-998f-6be7366dd639'),(13,'plugin:lockout','Install','2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-24 00:07:57','1309d578-5f22-49b7-94c5-7c6862c856a7'),(14,'plugin:neo','Install','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','8cfabd82-0215-48c0-9270-ffc14e6c682f'),(15,'plugin:neo','m181022_123749_craft3_upgrade','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','608ef4fb-78bc-4fd5-aeae-40716a1cd974'),(16,'plugin:neo','m190127_023247_soft_delete_compatibility','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','a27c1b7b-5087-4b91-964e-de4fba6a2b13'),(17,'plugin:neo','m200313_015120_structure_update','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','f25791dc-618d-432c-9473-ab3fc4fea0cc'),(18,'plugin:neo','m200722_061114_add_max_sibling_blocks','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','6879a470-69f0-40da-839b-14eef0caf549'),(19,'plugin:neo','m201108_123758_block_propagation_method_fix','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','afd31ac8-8517-4d5e-89d6-06ea4fbb0cee'),(20,'plugin:neo','m201208_110049_delete_blocks_without_sort_order','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','27cf8668-a81d-4dfe-9c15-ba95178b3e5c'),(21,'plugin:neo','m201223_024137_delete_blocks_with_invalid_owner','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','ecf74f9f-b1b1-4340-9b50-0ee44b285af1'),(22,'plugin:publisher','Install','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','120a501e-1c2e-4256-aa7b-bfdc30e83e77'),(23,'plugin:publisher','m190726_074724_craft32_upgrade','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','96189cc1-4340-4b8a-9543-3d6b0dda66ea'),(24,'plugin:redactor','m180430_204710_remove_old_plugins','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','0d67002a-bc48-4347-a648-8b19a36a2624'),(25,'plugin:redactor','Install','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','0853ab6b-bb2d-402f-8d1f-b080a598ea2a'),(26,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','87be1e32-39e3-462d-80a1-b3e8b7c7bf65'),(27,'plugin:retour','Install','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','3cb86554-2a3d-4ff7-b405-c36999683b37'),(28,'plugin:retour','m181013_122446_add_remote_ip','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','3ea506c4-734a-4857-bbc2-f27005efd550'),(29,'plugin:retour','m181013_171315_truncate_match_type','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','cc730666-736a-4a89-8f0f-f7cd6eabf8df'),(30,'plugin:retour','m181013_202455_add_redirect_src_match','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','5100fe84-eaae-42d1-bc15-af0d360fc1ad'),(31,'plugin:retour','m181018_123901_add_stats_info','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','365a35fd-7f19-4af8-ad1d-61b017ce552f'),(32,'plugin:retour','m181018_135656_add_redirect_status','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','8436cac4-0a52-4197-a4a4-a7bb807ff66d'),(33,'plugin:retour','m181213_233502_add_site_id','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','f4dec9a8-a747-421d-bb07-e533feb27e1b'),(34,'plugin:retour','m181216_043222_rebuild_indexes','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','55819328-4477-4b22-b09f-00ea2d5e871c'),(35,'plugin:retour','m190416_212500_widget_type_update','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','310f921b-0b9c-4424-b6c7-a9badd81716d'),(36,'plugin:retour','m200109_144310_add_redirectSrcUrl_index','2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-24 00:07:58','03f89080-d40a-4d52-a09e-0350700189af'),(37,'plugin:seomatic','Install','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','328476ec-caeb-49b7-a6eb-5cd641475c1d'),(38,'plugin:seomatic','m180314_002755_field_type','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','05d86310-6221-4387-b6a4-0483a58c19f2'),(39,'plugin:seomatic','m180314_002756_base_install','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','6b79a731-673f-438b-87d6-1f36807c669a'),(40,'plugin:seomatic','m180502_202319_remove_field_metabundles','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','4ba8360d-a955-4ea6-9d08-c85608290fc5'),(41,'plugin:seomatic','m180711_024947_commerce_products','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','cc75d881-9ba2-41c5-be16-64ede97d2f83'),(42,'plugin:seomatic','m190401_220828_longer_handles','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','79d1c865-f30f-4f11-83de-655ee7824b19'),(43,'plugin:seomatic','m190518_030221_calendar_events','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','374d2956-29b8-41d1-a10c-e1d307ea91c1'),(44,'plugin:seomatic','m200419_203444_add_type_id','2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-24 00:07:59','cbc88ce5-9b23-450a-a901-825bde075c13'),(45,'craft','Install','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','dc32a5c9-1e08-4878-90d0-6025c1c0abfb'),(46,'craft','m150403_183908_migrations_table_changes','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','f121f81c-845a-46b7-bd35-f7b8450acd6b'),(47,'craft','m150403_184247_plugins_table_changes','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','af4fce4c-f2ad-4751-9c22-5612bcf1b87c'),(48,'craft','m150403_184533_field_version','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','04e5fa76-5d7b-4623-bf58-6f4bdfbf0056'),(49,'craft','m150403_184729_type_columns','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','2fe665f0-3d00-4da6-86d9-97fb77603395'),(50,'craft','m150403_185142_volumes','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','992a1467-c22d-4938-999b-e39c9b4b09d9'),(51,'craft','m150428_231346_userpreferences','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','93cba527-7b4d-4602-9901-9137a358a0aa'),(52,'craft','m150519_150900_fieldversion_conversion','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','f4827262-494a-4046-b254-94943d0da4b6'),(53,'craft','m150617_213829_update_email_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','e766e136-dbae-4cf9-8eb3-227724c56d62'),(54,'craft','m150721_124739_templatecachequeries','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','ff5b1fbf-3e5c-4d8f-827b-fc6e5d7e54cf'),(55,'craft','m150724_140822_adjust_quality_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','f1f07afa-fa4e-4598-b09d-3df16008947a'),(56,'craft','m150815_133521_last_login_attempt_ip','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','c28f4b25-13ec-4ba2-9ac9-29210b4ed39b'),(57,'craft','m151002_095935_volume_cache_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','56c3eea2-3c70-4560-8c08-e5b6e1a557ca'),(58,'craft','m151005_142750_volume_s3_storage_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','f786c7d4-76b3-490e-9fb2-fe44f912cf96'),(59,'craft','m151016_133600_delete_asset_thumbnails','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','e1a45c2b-0d44-4881-bf92-7006bc25d922'),(60,'craft','m151209_000000_move_logo','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','3789d23c-d6c9-43fa-ba7f-01ed226e0501'),(61,'craft','m151211_000000_rename_fileId_to_assetId','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','300388f4-08a0-432e-8b6f-d5e534a2ac40'),(62,'craft','m151215_000000_rename_asset_permissions','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','b21ce1e2-47ae-4c77-8654-949e7af52aaf'),(63,'craft','m160707_000001_rename_richtext_assetsource_setting','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','d967f67d-1575-4cfa-b7e2-a356720fefef'),(64,'craft','m160708_185142_volume_hasUrls_setting','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','6ae40ea1-ad22-49b4-a44d-7860298936dc'),(65,'craft','m160714_000000_increase_max_asset_filesize','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','5ea1557f-363f-4185-a63c-ef343f8e44b5'),(66,'craft','m160727_194637_column_cleanup','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','91c7b40d-a1ec-467a-a3e1-e7e1b221f1c9'),(67,'craft','m160804_110002_userphotos_to_assets','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','6ccf42c5-c927-4cc7-8d40-c1e2ac496d31'),(68,'craft','m160807_144858_sites','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','73b77cb1-9991-46b4-9dd5-757c2b25e9db'),(69,'craft','m160829_000000_pending_user_content_cleanup','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','4d69c671-34cd-4d62-95a0-0408025fd419'),(70,'craft','m160830_000000_asset_index_uri_increase','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','7485ef94-33ee-4431-8075-3dd5ea28b45b'),(71,'craft','m160912_230520_require_entry_type_id','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','d49e933a-fabe-4407-b43e-01697c2a6af7'),(72,'craft','m160913_134730_require_matrix_block_type_id','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','b4c29466-bde6-43c4-86e9-11d690c4abcc'),(73,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','0bfee324-d38a-4694-a935-8286c7599d69'),(74,'craft','m160920_231045_usergroup_handle_title_unique','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','3d429647-cd59-4727-8f79-ead1c01b1ea8'),(75,'craft','m160925_113941_route_uri_parts','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','916fb4b6-c57f-45b1-95a4-85c28316966a'),(76,'craft','m161006_205918_schemaVersion_not_null','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','95bba774-177b-43cd-96ed-d7df3122fe3b'),(77,'craft','m161007_130653_update_email_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','b1ba78b2-e6fd-468e-b74d-9671f047fd76'),(78,'craft','m161013_175052_newParentId','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','5ecb4118-7046-499f-8299-18efe9b42d3a'),(79,'craft','m161021_102916_fix_recent_entries_widgets','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','07122954-5f5a-4cd1-b0da-478cadeb113f'),(80,'craft','m161021_182140_rename_get_help_widget','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','7712dc25-cb99-420b-b5a0-9cd32ada1b04'),(81,'craft','m161025_000000_fix_char_columns','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','3334bae1-b675-4983-a52e-b4b76cb083ab'),(82,'craft','m161029_124145_email_message_languages','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','0c46ea24-2628-496f-96a1-f0e4934cff32'),(83,'craft','m161108_000000_new_version_format','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','a1df495c-66fb-42cf-8502-7839777478fa'),(84,'craft','m161109_000000_index_shuffle','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','dca74573-2fd3-40e5-9ae2-83c46bb2a3cc'),(85,'craft','m161122_185500_no_craft_app','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','00a9dd26-1e11-4aed-b8cf-ed1fcf273ac5'),(86,'craft','m161125_150752_clear_urlmanager_cache','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','ee46a8bf-dc69-48de-8dce-6a3a407fc7b5'),(87,'craft','m161220_000000_volumes_hasurl_notnull','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','40b50c04-8801-410a-a0aa-00e643c9eaac'),(88,'craft','m170114_161144_udates_permission','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','374af551-38d8-45c1-8168-48bfd6c67724'),(89,'craft','m170120_000000_schema_cleanup','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','743a292d-7edc-4c47-a896-13896e59ed7d'),(90,'craft','m170126_000000_assets_focal_point','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','fb12bb57-30be-4711-b2ad-311adcaf1803'),(91,'craft','m170206_142126_system_name','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','5f6768a1-7794-48d1-8690-c6be159a6cd2'),(92,'craft','m170217_044740_category_branch_limits','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','299cf161-92a6-48fd-94e0-4735d82f544f'),(93,'craft','m170217_120224_asset_indexing_columns','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','fffeb811-fabd-4fdb-b149-c1ec026b7704'),(94,'craft','m170223_224012_plain_text_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','dfc6441d-2362-4ef0-93dd-acd6d4f41100'),(95,'craft','m170227_120814_focal_point_percentage','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','1d95e9fb-64f3-4b0d-893f-79e1f00cfe31'),(96,'craft','m170228_171113_system_messages','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','f45a37f8-a34e-4b38-83c0-0e86edf4864e'),(97,'craft','m170303_140500_asset_field_source_settings','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','dcf8aff5-da39-4fb6-871d-c8cec00769ba'),(98,'craft','m170306_150500_asset_temporary_uploads','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','496e16c9-95c0-41f2-8548-086878e8feba'),(99,'craft','m170523_190652_element_field_layout_ids','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','323cd593-a1f6-4df1-9515-e55a3e2658bb'),(100,'craft','m170621_195237_format_plugin_handles','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','0a08b10f-f452-4a01-b4de-d727e0f69e97'),(101,'craft','m170630_161027_deprecation_line_nullable','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','48298767-eea7-40fa-aece-d98b0337a5da'),(102,'craft','m170630_161028_deprecation_changes','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','26c7d8b0-fbad-4400-ae74-2690881af2bd'),(103,'craft','m170703_181539_plugins_table_tweaks','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','fb9c0f5c-1a27-4837-a7b2-052356188612'),(104,'craft','m170704_134916_sites_tables','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','95c2f459-fc4e-4ad2-aabd-fae5c0b78b07'),(105,'craft','m170706_183216_rename_sequences','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','9bdc2094-8f2a-4f7f-b026-749083aea413'),(106,'craft','m170707_094758_delete_compiled_traits','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','fea9e8d4-8f38-4e39-8442-8934746cc536'),(107,'craft','m170731_190138_drop_asset_packagist','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','32d25831-3d2a-416e-b994-9ef3eac1b13a'),(108,'craft','m170810_201318_create_queue_table','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','11ec70d3-4085-4534-a660-32cbbc3d1cd0'),(109,'craft','m170903_192801_longblob_for_queue_jobs','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','98afc203-94a3-4829-81de-e86dcb36cf4a'),(110,'craft','m170914_204621_asset_cache_shuffle','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','ec2ca7b5-f4c4-420d-aad8-c12011a3620a'),(111,'craft','m171011_214115_site_groups','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','7b356a22-6d50-4734-9455-615dc578efda'),(112,'craft','m171012_151440_primary_site','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','2327d052-4689-407f-9ecc-e6c0c2545beb'),(113,'craft','m171013_142500_transform_interlace','2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-24 00:08:02','3568dbd0-91cf-4981-8f35-8e1f1d384fe9'),(114,'craft','m171016_092553_drop_position_select','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','48d9f8cd-54e0-40e7-bb1a-90ab570e9407'),(115,'craft','m171016_221244_less_strict_translation_method','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','9054a6f9-facf-4a63-a584-ec0dc646161b'),(116,'craft','m171107_000000_assign_group_permissions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','71394594-d4ad-4bf9-a4eb-ddbaccefd651'),(117,'craft','m171117_000001_templatecache_index_tune','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','fd281197-88e4-4cac-85b4-67ab97c0257c'),(118,'craft','m171126_105927_disabled_plugins','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','468342a3-81cf-409e-8d4e-aa925d076902'),(119,'craft','m171130_214407_craftidtokens_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','ff9f4813-d320-4921-92e2-c25a182c9ccd'),(120,'craft','m171202_004225_update_email_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','7f4a0645-d1e0-4702-9016-0518d2dcb635'),(121,'craft','m171204_000001_templatecache_index_tune_deux','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','130ada9a-ced5-49e4-86ef-c3e902760150'),(122,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b808b863-cf43-4217-95c0-67763ab29b29'),(123,'craft','m171218_143135_longtext_query_column','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b9f13896-a8b2-4bc9-8963-5a3667f04f34'),(124,'craft','m171231_055546_environment_variables_to_aliases','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','7d22092f-ceaa-4f08-b7c1-2f3a86b67099'),(125,'craft','m180113_153740_drop_users_archived_column','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','38a00920-a8c7-499c-b11b-9b62949eea63'),(126,'craft','m180122_213433_propagate_entries_setting','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','6a64846b-4ca2-4bb7-8efc-43a61a489fc7'),(127,'craft','m180124_230459_fix_propagate_entries_values','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','5c4551ee-14bc-45c7-b2cb-b5e945908971'),(128,'craft','m180128_235202_set_tag_slugs','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','245af1a0-2d28-4f32-b819-13cf3107c15c'),(129,'craft','m180202_185551_fix_focal_points','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','df66f0dd-ed5f-4df4-8617-b8371723222e'),(130,'craft','m180217_172123_tiny_ints','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','62b13217-fc82-4273-8ae6-70afe5c64172'),(131,'craft','m180321_233505_small_ints','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b7b3ac4f-71a2-49af-8d0a-382bb76650a5'),(132,'craft','m180404_182320_edition_changes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','fd625ffd-8559-48dc-b0fc-6689582b16a1'),(133,'craft','m180411_102218_fix_db_routes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','55102eb3-1523-4a67-bd17-386e02b5b263'),(134,'craft','m180416_205628_resourcepaths_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b5cb751d-2c5b-4960-b801-ca663879d9c6'),(135,'craft','m180418_205713_widget_cleanup','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','4be0d2fb-1efc-4018-a75e-eb78d5229d57'),(136,'craft','m180425_203349_searchable_fields','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','a7bb778d-6344-4784-8dfa-e0ce4d692f2d'),(137,'craft','m180516_153000_uids_in_field_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d92e32c7-2c2e-4990-90bf-a696a9628c83'),(138,'craft','m180517_173000_user_photo_volume_to_uid','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','2ebb22bc-309a-4a7e-b8eb-765b37a31988'),(139,'craft','m180518_173000_permissions_to_uid','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','0b11d834-3b5f-4d6d-b35b-80f2ae09c66f'),(140,'craft','m180520_173000_matrix_context_to_uids','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','bd7b4466-2145-4243-a3cc-2734ede81184'),(141,'craft','m180521_172900_project_config_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','82ab6276-074d-4db1-a285-83bdffb34c5e'),(142,'craft','m180521_173000_initial_yml_and_snapshot','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','adbb1e7b-28af-403d-8010-1575dd7b27d2'),(143,'craft','m180731_162030_soft_delete_sites','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','811aaaf2-efdb-44ce-97c9-907c901cfd84'),(144,'craft','m180810_214427_soft_delete_field_layouts','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','c3d7c729-23a9-4b3c-a2ed-c6cf9cc5d355'),(145,'craft','m180810_214439_soft_delete_elements','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','0461dc87-8aef-444b-ba01-342c65505bc8'),(146,'craft','m180824_193422_case_sensitivity_fixes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','2630ff05-ad25-4b78-a61c-ad5e7192cae9'),(147,'craft','m180901_151639_fix_matrixcontent_tables','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','bc753ec5-24fa-4f31-ba62-bc1c6b67d7cd'),(148,'craft','m180904_112109_permission_changes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','dfc61486-e247-41dd-896f-abd52991c7f5'),(149,'craft','m180910_142030_soft_delete_sitegroups','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','1404916e-e21f-4db7-a58d-c6a4e81a43b9'),(150,'craft','m181011_160000_soft_delete_asset_support','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b2950555-235e-4d7f-93a1-e11cd93a90b2'),(151,'craft','m181016_183648_set_default_user_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','e8baf42d-865d-42e1-86ba-dee505428505'),(152,'craft','m181017_225222_system_config_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d7781844-100b-4274-86b6-40344d17cf42'),(153,'craft','m181018_222343_drop_userpermissions_from_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','f9d99e25-273d-4f86-a0fc-cf2c297a16cd'),(154,'craft','m181029_130000_add_transforms_routes_to_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','cbfed556-c030-4444-9f62-b62c05dacb03'),(155,'craft','m181112_203955_sequences_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','6af74ec8-e8c7-43c7-936d-5f565db5ca1a'),(156,'craft','m181121_001712_cleanup_field_configs','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','ed007edf-aad3-48df-95a2-ea3bc5145eba'),(157,'craft','m181128_193942_fix_project_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','52cbaf2d-49d3-4a9b-ad68-f45c1f286c28'),(158,'craft','m181130_143040_fix_schema_version','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','351b5f3e-c685-4a9c-9bb1-7341375c5161'),(159,'craft','m181211_143040_fix_entry_type_uids','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','4bbb4f1a-483f-4f0d-bfa8-b062585653b3'),(160,'craft','m181217_153000_fix_structure_uids','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','a191ca1a-ae63-45f5-81c1-c55097e58744'),(161,'craft','m190104_152725_store_licensed_plugin_editions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','7c7b3a28-df93-4f01-aa57-cf128b9ab21b'),(162,'craft','m190108_110000_cleanup_project_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','7f8f8a80-5752-42b6-b23a-99518b22f5de'),(163,'craft','m190108_113000_asset_field_setting_change','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d78eb4c5-c359-4897-8755-9712aa117ba4'),(164,'craft','m190109_172845_fix_colspan','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','28f544b4-de7f-4d7e-9cfb-30b0a4d4d98e'),(165,'craft','m190110_150000_prune_nonexisting_sites','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','28c3a3a4-e0c0-46e5-b5d9-2c73762af106'),(166,'craft','m190110_214819_soft_delete_volumes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','c67b240a-6b9b-4446-b38b-16938fb3d279'),(167,'craft','m190112_124737_fix_user_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','9487e36f-8a8b-4c07-8f08-1da8c195d926'),(168,'craft','m190112_131225_fix_field_layouts','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','940f81dd-f926-4510-bd8d-a6b13faba5ff'),(169,'craft','m190112_201010_more_soft_deletes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','a176c419-8dc8-4f63-bbe9-0b1e37734023'),(170,'craft','m190114_143000_more_asset_field_setting_changes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','12c6c2b4-2a5e-402c-9676-19be28af3e9b'),(171,'craft','m190121_120000_rich_text_config_setting','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','66a74693-bbfe-483a-8403-20b9021e2f8f'),(172,'craft','m190125_191628_fix_email_transport_password','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','6ab1a337-976f-4823-a494-4d3133083d0e'),(173,'craft','m190128_181422_cleanup_volume_folders','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','1f2018b3-b5ae-483d-94cd-1cf0bdeb3f36'),(174,'craft','m190205_140000_fix_asset_soft_delete_index','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','3ed971c7-7841-4717-9e7a-a5f1c33ef951'),(175,'craft','m190218_143000_element_index_settings_uid','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','4d33c4db-2d48-4c69-ba26-353221b23a0a'),(176,'craft','m190312_152740_element_revisions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','3e470a04-929c-4386-a40d-f63a8bae7489'),(177,'craft','m190327_235137_propagation_method','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','9e2700f7-b6f2-4e11-a812-97be1175fa6b'),(178,'craft','m190401_223843_drop_old_indexes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','bccdf32b-1a79-46ad-b37d-079d491de429'),(179,'craft','m190416_014525_drop_unique_global_indexes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','75b1070f-48bb-4818-b850-56b35c21785c'),(180,'craft','m190417_085010_add_image_editor_permissions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','414706d1-9f31-405d-880c-10eabc7145f7'),(181,'craft','m190502_122019_store_default_user_group_uid','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b0fc8dbb-577d-406d-a124-b91b9b208ce5'),(182,'craft','m190504_150349_preview_targets','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','725aad04-4051-4c1b-9c35-825a80d4b731'),(183,'craft','m190516_184711_job_progress_label','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','ba513674-62df-48bc-8e14-a21ce02b0a8b'),(184,'craft','m190523_190303_optional_revision_creators','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','4dbd1f69-0f1e-4478-b9d3-1830b3bd9cf7'),(185,'craft','m190529_204501_fix_duplicate_uids','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','279c1cd2-4f0f-4f13-99b9-eae394767705'),(186,'craft','m190605_223807_unsaved_drafts','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','98a7d9ea-8588-46cf-9c67-563908f3ad6c'),(187,'craft','m190607_230042_entry_revision_error_tables','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','39648adc-2e21-456d-b259-6c9768d3454e'),(188,'craft','m190608_033429_drop_elements_uid_idx','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','12cd5676-5793-49db-b2f7-5b44e09287b1'),(189,'craft','m190617_164400_add_gqlschemas_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','12540fde-dc3f-426f-a397-b91612ad31a3'),(190,'craft','m190624_234204_matrix_propagation_method','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','8d7179d6-aa87-43b2-9db8-dc4da9242c9e'),(191,'craft','m190711_153020_drop_snapshots','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b6a1568b-73bd-4e01-8dbf-d421052cff28'),(192,'craft','m190712_195914_no_draft_revisions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','e0d32085-84df-4c4e-b10e-357db1842ebd'),(193,'craft','m190723_140314_fix_preview_targets_column','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','de5e16ab-2f84-4fad-8e7d-a54dbfee57a7'),(194,'craft','m190820_003519_flush_compiled_templates','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','22aa36df-9533-4c0c-a7f0-8668891f6360'),(195,'craft','m190823_020339_optional_draft_creators','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','8ba341c6-4d32-4253-be42-8680ad7623ac'),(196,'craft','m190913_152146_update_preview_targets','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','1dd4c0b6-6753-4e82-8799-b9cceb05f970'),(197,'craft','m191107_122000_add_gql_project_config_support','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','cc2b2970-27b7-4457-92d7-57d9a2636d49'),(198,'craft','m191204_085100_pack_savable_component_settings','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','4c2e85d6-0cde-444d-9b4f-81ee49a13353'),(199,'craft','m191206_001148_change_tracking','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','25fd8b13-92a0-44fb-bada-aee8d68ed029'),(200,'craft','m191216_191635_asset_upload_tracking','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d971ae12-1e84-4153-a7d4-93f064838c2c'),(201,'craft','m191222_002848_peer_asset_permissions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','5218868b-49c9-49b6-9ae1-f9a8a35d04e8'),(202,'craft','m200127_172522_queue_channels','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','51a427be-d699-4a65-8685-b3c614c92f5e'),(203,'craft','m200211_175048_truncate_element_query_cache','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','f90d06fb-19d0-452c-af90-74b0b268d320'),(204,'craft','m200213_172522_new_elements_index','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','774eb8e5-6e6c-4cde-ad00-f079ba60e501'),(205,'craft','m200228_195211_long_deprecation_messages','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d613aecd-78a8-4f3a-bfaf-fb6a57ec1bff'),(206,'craft','m200306_054652_disabled_sites','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','aac17cd6-66f6-45f6-a281-409ceb42d68b'),(207,'craft','m200522_191453_clear_template_caches','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','e22199e8-9fef-4000-97fe-076ac3d23099'),(208,'craft','m200606_231117_migration_tracks','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','61cf9dc3-7c20-4ffd-8c23-dcab42942adb'),(209,'craft','m200619_215137_title_translation_method','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','38b58f4f-ce7d-4950-886d-fec2bf509777'),(210,'craft','m200620_005028_user_group_descriptions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','324e3625-af19-4a50-bf3e-c7062d866bad'),(211,'craft','m200620_230205_field_layout_changes','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','bec6cd86-05a6-407c-bd2d-cd00f0443740'),(212,'craft','m200625_131100_move_entrytypes_to_top_project_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','e018b993-98c1-4bce-ace0-751bfce57d68'),(213,'craft','m200629_112700_remove_project_config_legacy_files','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','8ec92f3c-96d2-43b8-83f0-62b31a87a79c'),(214,'craft','m200630_183000_drop_configmap','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','43e836cc-a49b-483a-b1fc-40e59d51874a'),(215,'craft','m200715_113400_transform_index_error_flag','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','12756d17-d850-46f5-aa9d-22b9dacc2586'),(216,'craft','m200716_110900_replace_file_asset_permissions','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','2d8f04f3-e839-4562-8a97-9e373542e73b'),(217,'craft','m200716_153800_public_token_settings_in_project_config','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','98610aaf-347f-493b-9773-aa39edd204f8'),(218,'craft','m200720_175543_drop_unique_constraints','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','7ab2e2a0-b3eb-4b44-8106-04357299130e'),(219,'craft','m200825_051217_project_config_version','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','b644f57f-6779-4c7b-a094-8910e90bf837'),(220,'craft','m201116_190500_asset_title_translation_method','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','9ee4f2c3-54e1-4bd8-a0e0-ff51ea393796'),(221,'craft','m201124_003555_plugin_trials','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','3fe8ca84-1902-4895-8c57-118bc881404c'),(222,'craft','m210209_135503_soft_delete_field_groups','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','53b1c3e4-befa-4a61-b5c3-67862d4ba4f3'),(223,'craft','m210212_223539_delete_invalid_drafts','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','a60202f0-b5ee-49b9-bec5-532fffefa054'),(224,'craft','m210214_202731_track_saved_drafts','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','462e9db1-c2f9-4aba-828b-47eaa89913df'),(225,'craft','m210223_150900_add_new_element_gql_schema_components','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','d7c78916-15f7-42ee-99f0-38af16c104c9'),(226,'craft','m210224_162000_add_projectconfignames_table','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','3c9b16d0-f073-41e8-8fd0-d53da55e73b8'),(227,'craft','m210326_132000_invalidate_projectconfig_cache','2021-05-24 00:08:03','2021-05-24 00:08:03','2021-05-24 00:08:03','cc691019-7ddc-4c24-b3be-4418b97c5fd5'),(228,'craft','m210331_220322_null_author','2021-05-24 23:29:09','2021-05-24 23:29:09','2021-05-24 23:29:09','a300aad3-8d9f-4812-918d-2fb2be27db20'),(229,'plugin:publisher','m210430_124740_AddSourceSiteIdToEntryPublishTable','2021-05-24 23:29:09','2021-05-24 23:29:09','2021-05-24 23:29:09','be35d2a5-6e2b-48a5-878e-35c421a14caa');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `neoblocks`
--

LOCK TABLES `neoblocks` WRITE;
/*!40000 ALTER TABLE `neoblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `neoblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `neoblockstructures`
--

LOCK TABLES `neoblockstructures` WRITE;
/*!40000 ALTER TABLE `neoblockstructures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `neoblockstructures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `neoblocktypegroups`
--

LOCK TABLES `neoblocktypegroups` WRITE;
/*!40000 ALTER TABLE `neoblocktypegroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `neoblocktypegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `neoblocktypes`
--

LOCK TABLES `neoblocktypes` WRITE;
/*!40000 ALTER TABLE `neoblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `neoblocktypes` VALUES (1,5,5,'Image','image',0,0,0,'',1,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','c0b32c55-a7e9-4d6e-9696-236594d7a98d'),(2,5,6,'Text','text',0,0,0,'',1,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','4e95ad26-266a-497f-9524-fb54eeeafedc'),(3,5,NULL,'Video','video',0,0,0,'',1,3,'2021-05-24 00:08:01','2021-05-24 00:08:01','fd5bb1fc-eeb9-4b53-9d04-293fb24e9648');
/*!40000 ALTER TABLE `neoblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'activeusers','1.1.1','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','00503283-0e12-4c04-8cca-42b0e2c16a1b'),(2,'aws-s3','1.2.11','1.2','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','29278ef8-4b24-496f-9604-cf62d36e0ef1'),(3,'dumper','2.0.0','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','0737e71d-2be0-487e-b5d8-cdd2e6658f54'),(4,'expanded-singles','1.1.3','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','35b6ab73-844c-40f2-b606-c80414a55450'),(5,'feed-me','4.3.6','4.3.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','f4d6556f-0e05-4aa3-89e9-f453540da2b5'),(6,'hide-admin','1.1.0','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','1b9f14bf-bc20-46c6-ab9e-ce331013815c'),(7,'image-optimize','1.6.33','1.0.0','trial',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','36b42628-c9a4-4c6e-83ad-30f422a57f95'),(8,'incognito-field','1.2.0','1.1.1','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','e72c72b8-6b52-4bd1-aabd-35c98ede3838'),(9,'lockout','1.0.1','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','71cf2e52-6ccc-4617-99ca-abe48baa9f52'),(10,'minify','1.2.10','1.0.0','unknown',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','ea3c97fe-8ea6-43bb-a4fa-886d3894cfb0'),(11,'neo','2.9.8','2.8.16','trial',NULL,'2021-05-24 00:07:57','2021-05-24 00:07:57','2021-05-25 03:17:04','0b5b8eb3-bde3-4aec-ac3e-a25cff3f92d5'),(12,'publisher','2.0.6','2.0.6','unknown',NULL,'2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-25 03:17:04','42b62a1e-e677-4bdc-8bd4-194bed700f7b'),(13,'redactor','2.8.7','2.3.0','unknown',NULL,'2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-25 03:17:04','6fda6695-ebdb-451f-b1d6-0f5480f7778f'),(14,'redactor-anchors','1.1.0','2.0','unknown',NULL,'2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-25 03:17:04','eab50f9c-8501-4ee5-b886-c7eb810ee793'),(15,'retour','3.1.53','3.0.9','trial',NULL,'2021-05-24 00:07:58','2021-05-24 00:07:58','2021-05-25 03:17:04','4fb05611-4e14-485e-b947-38c5ae77b182'),(16,'seomatic','3.3.42','3.0.9','trial',NULL,'2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-25 03:17:04','117981d9-9af7-40ea-a3c8-a2af9eba1282'),(17,'wordsmith','3.3.0.1','0.0.0.0','unknown',NULL,'2021-05-24 00:07:59','2021-05-24 00:07:59','2021-05-25 03:17:04','1d60a9be-9525-4b4a-8a61-ea224c917d69'),(18,'twigpack','1.2.14','1.0.0','unknown',NULL,'2021-05-24 06:12:58','2021-05-24 06:12:58','2021-05-25 03:17:04','fec8deb8-ce3c-492e-8f6e-aa1da55a70c9'),(19,'cookies','1.1.14','1.0.0','unknown',NULL,'2021-05-24 13:24:33','2021-05-24 13:24:33','2021-05-25 03:17:04','4ee609e4-66f8-4528-949d-efe75052c162');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1621928391'),('email.fromEmail','\"dew.internet@sa.gov.au\"'),('email.fromName','base64:IkNyYWZ0IEJvdCDwn6SWICI='),('email.replyToEmail','\"dew.internet@sa.gov.au\"'),('email.template','\"mail/_entry\"'),('email.transportSettings.encryptionMethod','\"tls\"'),('email.transportSettings.host','\"$EMAIL_SMTP_HOST_NAME\"'),('email.transportSettings.password','\"$EMAIL_SMTP_PASSWORD\"'),('email.transportSettings.port','\"$EMAIL_SMTP_PORT\"'),('email.transportSettings.timeout','\"10\"'),('email.transportSettings.useAuthentication','\"1\"'),('email.transportSettings.username','\"$EMAIL_SMTP_USERNAME\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Smtp\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.autocapitalize','true'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.autocomplete','false'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.autocorrect','true'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.class','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.disabled','false'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.id','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.instructions','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.label','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.max','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.min','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.name','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.orientation','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.placeholder','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.readonly','false'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.requirable','false'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.size','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.step','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.tip','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.title','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.warning','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.0.width','100'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.fieldUid','\"21f58d98-8320-49d6-8066-b096dee14310\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.instructions','\"\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.label','\"\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.required','\"1\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.tip','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.warning','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.1.width','100'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.fieldUid','\"bc3e6fff-c84a-486c-94ff-f77de96ab75f\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.instructions','\"\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.label','\"\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.required','\"1\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.tip','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.warning','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.2.width','100'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.fieldUid','\"07c3c9d2-dac1-46ee-9c0b-0198c2b71d77\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.instructions','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.label','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.required','false'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.tip','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.warning','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.elements.3.width','100'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.name','\"Content\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.fieldLayouts.ab9d869d-fefc-4661-97e2-b93f79b4d294.tabs.0.sortOrder','1'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.handle','\"errors\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.hasTitleField','true'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.name','\"Errors\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.section','\"a8c0d162-4d98-41f6-b67b-215123a3f69d\"'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.sortOrder','1'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.titleFormat','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.titleTranslationKeyFormat','null'),('entryTypes.0e0fc1dc-2333-4642-823a-faeb5caffa84.titleTranslationMethod','\"\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.autocapitalize','true'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.autocomplete','false'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.autocorrect','true'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.class','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.disabled','false'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.id','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.instructions','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.label','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.max','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.min','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.name','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.orientation','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.placeholder','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.readonly','false'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.requirable','false'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.size','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.step','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.tip','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.title','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.warning','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.elements.0.width','100'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.name','\"Content\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.fieldLayouts.e44c8a74-10a2-48a6-8d49-238fb5a745f5.tabs.0.sortOrder','1'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.handle','\"fullWidth\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.hasTitleField','true'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.name','\"Full width\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.section','\"ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.sortOrder','2'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.titleFormat','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.titleTranslationKeyFormat','null'),('entryTypes.98ad4db6-2be2-4ca8-9b2f-55b134195713.titleTranslationMethod','\"site\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.autocapitalize','true'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.autocomplete','false'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.autocorrect','true'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.class','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.disabled','false'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.id','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.instructions','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.label','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.max','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.min','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.name','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.orientation','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.placeholder','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.readonly','false'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.requirable','false'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.size','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.step','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.tip','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.title','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.warning','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.elements.0.width','100'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.name','\"Content\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.fieldLayouts.a047e99f-b0d0-4e0e-9671-98e8043e5c5c.tabs.0.sortOrder','1'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.handle','\"landing\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.hasTitleField','true'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.name','\"Landing\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.section','\"ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.sortOrder','3'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.titleFormat','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.titleTranslationKeyFormat','null'),('entryTypes.aaa783ac-8136-45ae-954f-aeb3a10f9ab5.titleTranslationMethod','\"site\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.autocapitalize','true'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.autocomplete','false'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.autocorrect','true'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.class','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.disabled','false'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.id','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.instructions','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.label','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.max','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.min','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.name','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.orientation','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.placeholder','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.readonly','false'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.requirable','false'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.size','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.step','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.tip','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.title','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.warning','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.0.width','100'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.fieldUid','\"e449bc51-6949-4b4c-8fbf-008e590c9935\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.instructions','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.label','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.required','false'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.tip','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.warning','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.elements.1.width','100'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.name','\"Content\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.fieldLayouts.cc7b76f2-aea2-4851-8e97-1d3b4f565a6d.tabs.0.sortOrder','1'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.handle','\"general\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.hasTitleField','true'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.name','\"General\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.section','\"ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.sortOrder','1'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.titleFormat','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.titleTranslationKeyFormat','null'),('entryTypes.cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada.titleTranslationMethod','\"site\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.autocapitalize','true'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.autocomplete','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.autocorrect','true'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.class','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.disabled','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.id','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.max','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.min','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.name','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.orientation','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.placeholder','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.readonly','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.requirable','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.size','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.step','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.title','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.0.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.fieldUid','\"1b30d64f-2b47-47ab-b74c-56ca223018fd\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.instructions','\"\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.label','\"\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.required','\"1\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.elements.1.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.name','\"Main\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.0.sortOrder','1'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.fieldUid','\"ad29506d-5bf0-4507-ace0-445d37ad4df3\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.required','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.0.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.fieldUid','\"06536257-6591-4559-b58a-811c65d68b07\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.required','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.1.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.fieldUid','\"b8cad5cb-060a-4f09-b35c-c4ddd40c147b\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.required','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.2.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.fieldUid','\"8faa7537-f8f6-4808-88f5-909c50cf87b8\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.required','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.3.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.fieldUid','\"6535d548-8ab4-4b6f-acef-a044ef5e2f97\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.instructions','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.label','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.required','false'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.tip','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.warning','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.elements.4.width','100'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.name','\"Settings\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.fieldLayouts.ca8c8850-a918-40e5-8764-6c41ff22005c.tabs.1.sortOrder','2'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.handle','\"redirect\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.hasTitleField','true'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.name','\"Redirect\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.section','\"ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.sortOrder','4'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.titleFormat','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.titleTranslationKeyFormat','null'),('entryTypes.d059edc7-b38e-4922-aee9-1cbc88b92ecd.titleTranslationMethod','\"site\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.autocapitalize','true'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.autocomplete','false'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.autocorrect','true'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.class','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.disabled','false'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.id','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.instructions','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.label','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.max','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.min','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.name','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.orientation','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.placeholder','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.readonly','false'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.requirable','false'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.size','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.step','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.tip','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.title','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.warning','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.elements.0.width','100'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.name','\"Content\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.fieldLayouts.36b70137-d270-4462-84e0-3f23d9d26df4.tabs.0.sortOrder','1'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.handle','\"homepage\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.hasTitleField','false'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.name','\"Homepage\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.section','\"5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.sortOrder','1'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.titleFormat','\"Home\"'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.titleTranslationKeyFormat','null'),('entryTypes.ecbd874f-2167-4018-a697-0ae3677231a7.titleTranslationMethod','\"site\"'),('fieldGroups.3004f128-4dcc-4b0f-9369-4c7f87cb3839.name','\"Optimized images\"'),('fieldGroups.5530f693-5e22-48f0-ba53-d8e8999ec908.name','\"Common\"'),('fieldGroups.7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b.name','\"Settings\"'),('fieldGroups.7cc23e51-bc00-4d62-832b-6cc9c0b4d923.name','\"Errors\"'),('fieldGroups.820d67ae-c658-4d30-8347-14058c97e1c1.name','\"Globals\"'),('fieldGroups.c070a16a-3c83-4536-ad01-e4a85fade10d.name','\"Assets\"'),('fieldGroups.e122630f-ef1f-4011-b0d4-3e3487d928b3.name','\"Blocks\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.contentColumnType','\"text\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.handle','\"hideSearch\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.instructions','\"Hide this page from site search results\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.name','\"Hide from search\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.searchable','false'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.byteLimit','null'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.charLimit','null'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.code','\"\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.columnType','null'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.initialRows','\"4\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.multiline','\"\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.placeholder','null'),('fields.06536257-6591-4559-b58a-811c65d68b07.settings.uiMode','\"normal\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.translationKeyFormat','null'),('fields.06536257-6591-4559-b58a-811c65d68b07.translationMethod','\"none\"'),('fields.06536257-6591-4559-b58a-811c65d68b07.type','\"craft\\\\fields\\\\PlainText\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.contentColumnType','\"string\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.fieldGroup','\"7cc23e51-bc00-4d62-832b-6cc9c0b4d923\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.handle','\"errorImage\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.instructions','\"\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.name','\"Error image\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.searchable','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.allowedKinds.0','\"image\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.allowSelfRelations','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.allowUploads','true'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.defaultUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.defaultUploadLocationSubpath','\"\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.limit','\"1\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.localizeRelations','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.previewMode','\"full\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.restrictFiles','\"1\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.selectionLabel','\"Add an image\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.showSiteMenu','true'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.showUnpermittedFiles','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.showUnpermittedVolumes','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.singleUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.singleUploadLocationSubpath','\"\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.source','null'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.sources','\"*\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.targetSiteId','null'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.useSingleFolder','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.validateRelatedElements','false'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.settings.viewMode','\"list\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.translationKeyFormat','null'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.translationMethod','\"site\"'),('fields.07c3c9d2-dac1-46ee-9c0b-0198c2b71d77.type','\"craft\\\\fields\\\\Assets\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.contentColumnType','\"text\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.fieldGroup','\"c070a16a-3c83-4536-ad01-e4a85fade10d\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.handle','\"caption\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.instructions','\"\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.name','\"Caption\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.searchable','true'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.byteLimit','null'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.charLimit','null'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.code','\"\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.columnType','null'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.initialRows','\"4\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.multiline','\"\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.placeholder','null'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.settings.uiMode','\"normal\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.translationKeyFormat','null'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.translationMethod','\"none\"'),('fields.112c70eb-196d-49cf-8c69-cb6cd11432ac.type','\"craft\\\\fields\\\\PlainText\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.contentColumnType','\"string(255)\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.handle','\"redirectUrl\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.instructions','\"\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.name','\"Redirect URL\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.searchable','true'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.settings.maxLength','\"255\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.settings.placeholder','null'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.settings.types.0','\"url\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.translationKeyFormat','null'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.translationMethod','\"none\"'),('fields.1b30d64f-2b47-47ab-b74c-56ca223018fd.type','\"craft\\\\fields\\\\Url\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.contentColumnType','\"text\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.fieldGroup','\"7cc23e51-bc00-4d62-832b-6cc9c0b4d923\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.handle','\"errorHeadline\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.instructions','\"\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.name','\"Error headline\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.searchable','false'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.byteLimit','null'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.charLimit','null'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.code','\"\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.columnType','null'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.initialRows','\"4\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.multiline','\"\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.placeholder','null'),('fields.21f58d98-8320-49d6-8066-b096dee14310.settings.uiMode','\"normal\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.translationKeyFormat','null'),('fields.21f58d98-8320-49d6-8066-b096dee14310.translationMethod','\"none\"'),('fields.21f58d98-8320-49d6-8066-b096dee14310.type','\"craft\\\\fields\\\\PlainText\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.contentColumnType','\"string\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.fieldGroup','\"820d67ae-c658-4d30-8347-14058c97e1c1\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.handle','\"siteLogo\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.instructions','\"\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.name','\"Site logo\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.searchable','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.allowedKinds.0','\"image\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.allowSelfRelations','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.allowUploads','true'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.defaultUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.defaultUploadLocationSubpath','\"\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.limit','\"1\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.localizeRelations','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.previewMode','\"full\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.restrictFiles','\"1\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.selectionLabel','\"Add a logo\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.showSiteMenu','true'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.showUnpermittedFiles','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.showUnpermittedVolumes','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.singleUploadLocationSource','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.singleUploadLocationSubpath','\"Logos\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.source','null'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.sources.0','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.targetSiteId','null'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.useSingleFolder','true'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.validateRelatedElements','false'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.settings.viewMode','\"list\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.translationKeyFormat','null'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.translationMethod','\"site\"'),('fields.38aeb4dd-0882-41f8-98a5-bf78e31d659a.type','\"craft\\\\fields\\\\Assets\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.contentColumnType','\"text\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.fieldGroup','\"820d67ae-c658-4d30-8347-14058c97e1c1\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.handle','\"acknowledgementText\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.instructions','\"\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.name','\"Acknowledgement text\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.searchable','false'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.byteLimit','null'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.charLimit','null'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.code','\"\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.columnType','null'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.initialRows','\"4\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.multiline','\"1\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.placeholder','null'),('fields.434cb523-f553-43e1-b517-b4350f11580e.settings.uiMode','\"normal\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.translationKeyFormat','null'),('fields.434cb523-f553-43e1-b517-b4350f11580e.translationMethod','\"none\"'),('fields.434cb523-f553-43e1-b517-b4350f11580e.type','\"craft\\\\fields\\\\PlainText\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.contentColumnType','\"text\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.handle','\"seo\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.instructions','\"\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.name','\"SEO\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.searchable','false'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.elementDisplayPreviewType','\"google\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.facebookEnabledFields.0','\"seoPreview\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.facebookEnabledFields.1','\"ogTitle\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.facebookEnabledFields.2','\"ogDescription\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.facebookEnabledFields.3','\"ogImage\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.facebookTabEnabled','\"1\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.0','\"seoPreview\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.1','\"seoTitle\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.2','\"seoDescription\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.3','\"seoImage\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.4','\"robots\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalEnabledFields.5','\"canonicalUrl\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.generalTabEnabled','\"1\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.sitemapEnabledFields.0','\"sitemapUrls\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.sitemapTabEnabled','\"1\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.settings.twitterTabEnabled','\"\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.translationKeyFormat','null'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.translationMethod','\"none\"'),('fields.56f7afac-4e92-4e6b-bc02-0902467b5843.type','\"nystudio107\\\\seomatic\\\\fields\\\\SeoSettings\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.contentColumnType','\"string\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.handle','\"teaserImage\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.instructions','\"Alternate image for navigation menus etc.\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.name','\"Teaser image\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.searchable','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.allowedKinds.0','\"image\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.allowSelfRelations','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.allowUploads','true'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.defaultUploadLocationSource','\"volume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.defaultUploadLocationSubpath','\"\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.limit','\"1\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.localizeRelations','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.previewMode','\"full\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.restrictFiles','\"1\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.selectionLabel','\"Add an image\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.showSiteMenu','true'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.showUnpermittedFiles','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.showUnpermittedVolumes','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.singleUploadLocationSource','\"volume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.singleUploadLocationSubpath','\"\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.source','null'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.sources.0','\"volume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.targetSiteId','null'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.useSingleFolder','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.validateRelatedElements','false'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.settings.viewMode','\"list\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.translationKeyFormat','null'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.translationMethod','\"site\"'),('fields.6535d548-8ab4-4b6f-acef-a044ef5e2f97.type','\"craft\\\\fields\\\\Assets\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.contentColumnType','\"boolean\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.handle','\"dismiss\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.instructions','\"Allow the user to close this?\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.name','\"Dismiss\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.searchable','false'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.settings.default','true'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.settings.offLabel','\"No\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.settings.onLabel','\"Yes\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.translationKeyFormat','null'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.translationMethod','\"none\"'),('fields.65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a.type','\"craft\\\\fields\\\\Lightswitch\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.contentColumnType','\"boolean\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.handle','\"showCaption\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.instructions','\"Show image caption\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.name','\"Show caption\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.searchable','false'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.settings.default','false'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.settings.offLabel','\"Hide\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.settings.onLabel','\"Show\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.translationKeyFormat','null'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.translationMethod','\"none\"'),('fields.886db157-8715-44d2-a1f6-36b4ac508beb.type','\"craft\\\\fields\\\\Lightswitch\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.contentColumnType','\"text\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.handle','\"teaserText\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.instructions','\"\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.name','\"Teaser text\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.searchable','true'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.byteLimit','null'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.charLimit','null'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.code','\"\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.columnType','null'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.initialRows','\"2\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.multiline','\"1\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.placeholder','null'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.settings.uiMode','\"normal\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.translationKeyFormat','null'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.translationMethod','\"none\"'),('fields.8faa7537-f8f6-4808-88f5-909c50cf87b8.type','\"craft\\\\fields\\\\PlainText\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.contentColumnType','\"text\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.fieldGroup','\"820d67ae-c658-4d30-8347-14058c97e1c1\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.handle','\"footerLinks\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.instructions','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.name','\"Footer links\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.searchable','false'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.addRowLabel','\"Add a link\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.0','\"col1\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Text\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.1.1','\"text\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.0.1.__assoc__.3.1','\"singleline\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.0','\"col2\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.0.0','\"heading\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.0.1','\"Link\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.1.0','\"handle\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.1.1','\"link\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.2.0','\"width\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.2.1','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.3.0','\"type\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columns.__assoc__.1.1.__assoc__.3.1','\"singleline\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.columnType','\"text\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.0.__assoc__.0.0','\"col1\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.0.__assoc__.0.1','\"Disclaimer\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.0.__assoc__.1.0','\"col2\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.0.__assoc__.1.1','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.1.__assoc__.0.0','\"col1\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.1.__assoc__.0.1','\"Privacy\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.1.__assoc__.1.0','\"col2\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.1.__assoc__.1.1','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.2.__assoc__.0.0','\"col1\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.2.__assoc__.0.1','\"Accessibility\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.2.__assoc__.1.0','\"col2\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.defaults.2.__assoc__.1.1','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.maxRows','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.settings.minRows','\"\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.translationKeyFormat','null'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.translationMethod','\"none\"'),('fields.906dff7a-94e7-43bb-a515-3feda5b3bbec.type','\"craft\\\\fields\\\\Table\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.contentColumnType','\"string\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.handle','\"contentBuilder\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.instructions','\"\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.name','\"Content builder\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.searchable','false'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.maxBlocks','\"\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.maxLevels','\"\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.maxTopBlocks','\"\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.minBlocks','\"\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.propagationMethod','\"all\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.settings.wasModified','true'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.translationKeyFormat','null'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.translationMethod','\"site\"'),('fields.9ccb3478-824d-4f4b-a1ca-7589415a1339.type','\"benf\\\\neo\\\\Field\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.contentColumnType','\"text\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.handle','\"alertText\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.instructions','\"This field accepts [Markdown](https://devhints.io/markdown)\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.name','\"Alert text\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.searchable','false'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.byteLimit','null'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.charLimit','null'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.code','\"\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.columnType','null'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.initialRows','\"4\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.multiline','\"\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.placeholder','null'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.settings.uiMode','\"normal\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.translationKeyFormat','null'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.translationMethod','\"none\"'),('fields.a7fa6737-974c-401e-ac92-6239739c2ccc.type','\"craft\\\\fields\\\\PlainText\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.contentColumnType','\"text\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.fieldGroup','\"c070a16a-3c83-4536-ad01-e4a85fade10d\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.handle','\"altText\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.instructions','\"\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.name','\"Alt text\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.searchable','true'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.byteLimit','null'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.charLimit','null'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.code','\"\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.columnType','null'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.initialRows','\"4\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.multiline','\"\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.placeholder','null'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.settings.uiMode','\"normal\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.translationKeyFormat','null'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.translationMethod','\"none\"'),('fields.a920bb04-faca-4f59-9a0a-a2e2a090fe23.type','\"craft\\\\fields\\\\PlainText\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.contentColumnType','\"datetime\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.handle','\"endDate\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.instructions','\"\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.name','\"End date\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.searchable','false'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.settings.max','null'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.settings.min','null'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.settings.minuteIncrement','\"15\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.settings.showDate','true'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.settings.showTime','true'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.translationKeyFormat','null'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.translationMethod','\"none\"'),('fields.a93a6824-982b-40e8-ab4b-3ed360a152c3.type','\"craft\\\\fields\\\\Date\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.contentColumnType','\"boolean\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.handle','\"hideNav\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.instructions','\"Hide this page from navigation menus\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.name','\"Hide from navigation\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.searchable','false'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.settings.default','false'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.settings.offLabel','null'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.settings.onLabel','null'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.translationKeyFormat','null'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.translationMethod','\"none\"'),('fields.ad29506d-5bf0-4507-ace0-445d37ad4df3.type','\"craft\\\\fields\\\\Lightswitch\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.contentColumnType','\"datetime\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.handle','\"startDate\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.instructions','\"\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.name','\"Start date\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.searchable','false'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.settings.max','null'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.settings.min','null'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.settings.minuteIncrement','\"15\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.settings.showDate','true'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.settings.showTime','true'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.translationKeyFormat','null'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.translationMethod','\"none\"'),('fields.b5e6b714-38fe-4661-91c0-28454e56d45a.type','\"craft\\\\fields\\\\Date\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.contentColumnType','\"string\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.fieldGroup','\"820d67ae-c658-4d30-8347-14058c97e1c1\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.handle','\"acknowledgementImage\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.instructions','\"\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.name','\"Acknowledgement image\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.searchable','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.allowedKinds.0','\"image\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.allowSelfRelations','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.allowUploads','true'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.defaultUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.defaultUploadLocationSubpath','\"\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.limit','\"1\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.localizeRelations','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.previewMode','\"full\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.restrictFiles','\"1\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.selectionLabel','\"Add an image\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.showSiteMenu','true'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.showUnpermittedFiles','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.showUnpermittedVolumes','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.singleUploadLocationSource','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.singleUploadLocationSubpath','\"AOC\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.source','null'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.sources','\"*\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.targetSiteId','null'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.useSingleFolder','true'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.validateRelatedElements','false'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.settings.viewMode','\"list\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.translationKeyFormat','null'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.translationMethod','\"site\"'),('fields.b7232602-e058-4dc6-b639-3e5dfb6ee3f0.type','\"craft\\\\fields\\\\Assets\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.contentColumnType','\"text\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.fieldGroup','\"7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.handle','\"teaserTitle\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.instructions','\"Alternate title for navigation menus etc.\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.name','\"Teaser title\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.searchable','true'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.byteLimit','null'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.charLimit','null'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.code','\"\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.columnType','null'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.initialRows','\"4\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.multiline','\"\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.placeholder','null'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.settings.uiMode','\"normal\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.translationKeyFormat','null'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.translationMethod','\"none\"'),('fields.b8cad5cb-060a-4f09-b35c-c4ddd40c147b.type','\"craft\\\\fields\\\\PlainText\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.contentColumnType','\"string\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.handle','\"excludedPages\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.instructions','\"\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.name','\"Excluded pages\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.searchable','false'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.allowSelfRelations','false'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.limit','\"\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.localizeRelations','false'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.selectionLabel','\"\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.showSiteMenu','false'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.source','null'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.sources','\"*\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.targetSiteId','null'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.validateRelatedElements','false'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.settings.viewMode','null'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.translationKeyFormat','null'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.translationMethod','\"site\"'),('fields.bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9.type','\"craft\\\\fields\\\\Entries\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.contentColumnType','\"text\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.fieldGroup','\"7cc23e51-bc00-4d62-832b-6cc9c0b4d923\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.handle','\"errorText\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.instructions','\"\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.name','\"Error text\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.searchable','false'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.byteLimit','null'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.charLimit','null'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.code','\"\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.columnType','null'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.initialRows','\"4\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.multiline','\"1\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.placeholder','null'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.settings.uiMode','\"normal\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.translationKeyFormat','null'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.translationMethod','\"none\"'),('fields.bc3e6fff-c84a-486c-94ff-f77de96ab75f.type','\"craft\\\\fields\\\\PlainText\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.contentColumnType','\"string\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.handle','\"image\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.instructions','\"\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.name','\"Image\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.searchable','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.allowedKinds.0','\"image\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.allowSelfRelations','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.allowUploads','true'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.defaultUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.defaultUploadLocationSubpath','\"\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.limit','\"1\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.localizeRelations','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.previewMode','\"full\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.restrictFiles','\"1\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.selectionLabel','\"Add an image\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.showSiteMenu','true'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.showUnpermittedFiles','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.showUnpermittedVolumes','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.singleUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.singleUploadLocationSubpath','\"\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.source','null'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.sources','\"*\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.targetSiteId','null'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.useSingleFolder','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.validateRelatedElements','false'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.settings.viewMode','\"list\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.translationKeyFormat','null'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.translationMethod','\"site\"'),('fields.c1fbbe64-a078-4af6-9266-3321a7dc4724.type','\"craft\\\\fields\\\\Assets\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.contentColumnType','\"text\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.fieldGroup','\"3004f128-4dcc-4b0f-9369-4c7f87cb3839\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.handle','\"optimizedGeneral\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.instructions','\"\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.name','\"Optimized general\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.searchable','false'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.displayDominantColorPalette','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.displayLazyLoadPlaceholderImages','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.displayOptimizedImageVariants','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.0.0','\"width\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.0.1','\"1200\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.1.0','\"useAspectRatio\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.1.1','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.2.0','\"aspectRatioX\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.2.1','\"16\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.3.0','\"aspectRatioY\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.3.1','\"9\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.4.0','\"retinaSizes\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.4.1.0','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.5.0','\"quality\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.5.1','\"82\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.6.0','\"format\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.0.__assoc__.6.1','\"jpg\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.0.0','\"width\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.0.1','\"992\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.1.0','\"useAspectRatio\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.1.1','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.2.0','\"aspectRatioX\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.2.1','\"16\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.3.0','\"aspectRatioY\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.3.1','\"9\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.4.0','\"retinaSizes\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.4.1.0','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.5.0','\"quality\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.5.1','\"82\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.6.0','\"format\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.1.__assoc__.6.1','\"jpg\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.0.0','\"width\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.0.1','\"768\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.1.0','\"useAspectRatio\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.1.1','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.2.0','\"aspectRatioX\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.2.1','\"4\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.3.0','\"aspectRatioY\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.3.1','\"3\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.4.0','\"retinaSizes\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.4.1.0','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.5.0','\"quality\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.5.1','\"60\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.6.0','\"format\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.2.__assoc__.6.1','\"jpg\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.0.0','\"width\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.0.1','\"576\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.1.0','\"useAspectRatio\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.1.1','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.2.0','\"aspectRatioX\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.2.1','\"4\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.3.0','\"aspectRatioY\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.3.1','\"3\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.4.0','\"retinaSizes\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.4.1.0','\"1\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.5.0','\"quality\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.5.1','\"60\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.6.0','\"format\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.settings.variants.3.__assoc__.6.1','\"jpg\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.translationKeyFormat','null'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.translationMethod','\"none\"'),('fields.da2fde99-98d1-4e82-b00c-5c792200f49f.type','\"nystudio107\\\\imageoptimize\\\\fields\\\\OptimizedImages\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.contentColumnType','\"string\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.handle','\"heroImage\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.instructions','\"\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.name','\"Hero image\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.searchable','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.allowedKinds.0','\"image\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.allowSelfRelations','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.allowUploads','true'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.defaultUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.defaultUploadLocationSubpath','\"\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.limit','\"1\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.localizeRelations','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.previewMode','\"full\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.restrictFiles','\"1\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.selectionLabel','\"Add an image\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.showSiteMenu','true'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.showUnpermittedFiles','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.showUnpermittedVolumes','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.singleUploadLocationSource','\"volume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.singleUploadLocationSubpath','\"\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.source','null'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.sources','\"*\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.targetSiteId','null'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.useSingleFolder','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.validateRelatedElements','false'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.settings.viewMode','\"list\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.translationKeyFormat','null'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.translationMethod','\"site\"'),('fields.e449bc51-6949-4b4c-8fbf-008e590c9935.type','\"craft\\\\fields\\\\Assets\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.contentColumnType','\"string\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.fieldGroup','\"820d67ae-c658-4d30-8347-14058c97e1c1\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.handle','\"favicon\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.instructions','\"It\'s best to try and make sure this is cropped square before uploading\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.name','\"Favicon\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.searchable','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.allowedKinds.0','\"image\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.allowSelfRelations','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.allowUploads','true'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.defaultUploadLocationSource','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.defaultUploadLocationSubpath','\"favicons\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.limit','\"1\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.localizeRelations','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.previewMode','\"full\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.restrictFiles','\"1\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.selectionLabel','\"Select favicon source\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.showSiteMenu','true'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.showUnpermittedFiles','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.showUnpermittedVolumes','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.singleUploadLocationSource','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.singleUploadLocationSubpath','\"Favicons\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.source','null'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.sources.0','\"volume:37e0968a-18b5-4f97-b792-d34a431b19fd\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.targetSiteId','null'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.useSingleFolder','true'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.validateRelatedElements','false'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.settings.viewMode','\"list\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.translationKeyFormat','null'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.translationMethod','\"site\"'),('fields.eba7d0a3-19f3-4d50-8ea8-850b84c5af55.type','\"craft\\\\fields\\\\Assets\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.contentColumnType','\"text\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.fieldGroup','\"5530f693-5e22-48f0-ba53-d8e8999ec908\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.handle','\"richText\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.instructions','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.name','\"Rich text\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.searchable','true'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.availableTransforms','\"*\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.availableVolumes','\"*\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.cleanupHtml','true'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.columnType','\"text\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.configSelectionMode','\"choose\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.defaultTransform','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.manualConfig','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.purifierConfig','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.purifyHtml','\"1\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.redactorConfig','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.removeEmptyTags','\"1\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.removeInlineStyles','\"1\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.removeNbsp','\"1\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.showHtmlButtonForNonAdmins','\"\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.showUnpermittedFiles','false'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.showUnpermittedVolumes','false'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.settings.uiMode','\"enlarged\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.translationKeyFormat','null'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.translationMethod','\"none\"'),('fields.fb00c1dd-4f98-427b-a2ba-4b53503d8cb5.type','\"craft\\\\redactor\\\\Field\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.fieldUid','\"a7fa6737-974c-401e-ac92-6239739c2ccc\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.instructions','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.label','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.required','false'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.tip','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.warning','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.0.width','100'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.fieldUid','\"65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.instructions','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.label','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.required','false'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.tip','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.warning','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.1.width','100'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.fieldUid','\"b5e6b714-38fe-4661-91c0-28454e56d45a\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.instructions','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.label','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.required','false'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.tip','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.warning','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.2.width','100'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.fieldUid','\"a93a6824-982b-40e8-ab4b-3ed360a152c3\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.instructions','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.label','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.required','false'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.tip','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.warning','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.3.width','100'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.fieldUid','\"bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.instructions','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.label','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.required','false'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.tip','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.warning','null'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.elements.4.width','100'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.name','\"Main\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.fieldLayouts.f94f935f-88f7-4e0a-987f-cf140e155cad.tabs.0.sortOrder','1'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.handle','\"sitewideAlert\"'),('globalSets.6a16e864-cae2-42df-95cc-3834afcfe89b.name','\"Sitewide alert\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.fieldUid','\"b7232602-e058-4dc6-b639-3e5dfb6ee3f0\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.instructions','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.label','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.required','false'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.tip','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.warning','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.0.width','100'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.fieldUid','\"434cb523-f553-43e1-b517-b4350f11580e\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.instructions','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.label','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.required','false'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.tip','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.warning','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.1.width','100'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.fieldUid','\"906dff7a-94e7-43bb-a515-3feda5b3bbec\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.instructions','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.label','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.required','false'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.tip','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.warning','null'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.elements.2.width','100'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.name','\"Main\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.fieldLayouts.0c6b2725-c24b-427c-95b2-d64c3f434029.tabs.0.sortOrder','1'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.handle','\"footer\"'),('globalSets.a2c771d3-8007-42be-a397-7945f01f2c44.name','\"Footer\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.fieldUid','\"38aeb4dd-0882-41f8-98a5-bf78e31d659a\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.instructions','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.label','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.required','false'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.tip','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.warning','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.0.width','100'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.fieldUid','\"eba7d0a3-19f3-4d50-8ea8-850b84c5af55\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.instructions','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.label','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.required','false'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.tip','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.warning','null'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.elements.1.width','100'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.name','\"Main\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.fieldLayouts.f17eb96b-6f58-4b4e-9d9c-29b22a3c382f.tabs.0.sortOrder','1'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.handle','\"site\"'),('globalSets.c17bf7df-73d2-4012-9f9e-a6078d9996ff.name','\"Site\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.childBlocks','\"\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.field','\"9ccb3478-824d-4f4b-a1ca-7589415a1339\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.fieldUid','\"fb00c1dd-4f98-427b-a2ba-4b53503d8cb5\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.instructions','null'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.label','null'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.required','false'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.tip','null'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.warning','null'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.elements.0.width','100'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.name','\"Main\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.fieldLayouts.2977a957-31c1-4ef4-91e6-858edec1167c.tabs.0.sortOrder','1'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.handle','\"text\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.maxBlocks','0'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.maxChildBlocks','0'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.maxSiblingBlocks','0'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.name','\"Text\"'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.sortOrder','1'),('neoBlockTypes.4e95ad26-266a-497f-9524-fb54eeeafedc.topLevel','true'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.childBlocks','\"\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.field','\"9ccb3478-824d-4f4b-a1ca-7589415a1339\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.fieldUid','\"c1fbbe64-a078-4af6-9266-3321a7dc4724\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.instructions','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.label','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.required','false'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.tip','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.warning','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.elements.0.width','100'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.name','\"Main\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.0.sortOrder','1'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.fieldUid','\"886db157-8715-44d2-a1f6-36b4ac508beb\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.instructions','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.label','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.required','false'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.tip','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.warning','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.0.width','100'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.fieldUid','\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.instructions','\"\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.label','\"Custom caption\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.required','false'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.tip','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.warning','null'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.elements.1.width','100'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.name','\"Settings\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.fieldLayouts.7a07039d-10df-4e6a-a9e7-362c6abdb517.tabs.1.sortOrder','2'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.handle','\"image\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.maxBlocks','0'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.maxChildBlocks','0'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.maxSiblingBlocks','0'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.name','\"Image\"'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.sortOrder','2'),('neoBlockTypes.c0b32c55-a7e9-4d6e-9696-236594d7a98d.topLevel','true'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.childBlocks','\"\"'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.field','\"9ccb3478-824d-4f4b-a1ca-7589415a1339\"'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.handle','\"video\"'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.maxBlocks','0'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.maxChildBlocks','0'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.maxSiblingBlocks','0'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.name','\"Video\"'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.sortOrder','3'),('neoBlockTypes.fd5bb1fc-eeb9-4b53-9d04-293fb24e9648.topLevel','true'),('plugins.activeusers.edition','\"standard\"'),('plugins.activeusers.enabled','true'),('plugins.activeusers.schemaVersion','\"1.0.0\"'),('plugins.aws-s3.edition','\"standard\"'),('plugins.aws-s3.enabled','true'),('plugins.aws-s3.schemaVersion','\"1.2\"'),('plugins.cookies.edition','\"standard\"'),('plugins.cookies.enabled','true'),('plugins.cookies.schemaVersion','\"1.0.0\"'),('plugins.dumper.edition','\"standard\"'),('plugins.dumper.enabled','true'),('plugins.dumper.schemaVersion','\"1.0.0\"'),('plugins.expanded-singles.edition','\"standard\"'),('plugins.expanded-singles.enabled','true'),('plugins.expanded-singles.schemaVersion','\"1.0.0\"'),('plugins.expanded-singles.settings.expandSingles','\"1\"'),('plugins.expanded-singles.settings.redirectToEntry','\"1\"'),('plugins.feed-me.edition','\"standard\"'),('plugins.feed-me.enabled','true'),('plugins.feed-me.schemaVersion','\"4.3.0\"'),('plugins.hide-admin.edition','\"standard\"'),('plugins.hide-admin.enabled','true'),('plugins.hide-admin.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.edition','\"standard\"'),('plugins.image-optimize.enabled','true'),('plugins.image-optimize.licenseKey','\"98VD4QK7Z71771L8U1NE7WVO\"'),('plugins.image-optimize.schemaVersion','\"1.0.0\"'),('plugins.image-optimize.settings.allowUpScaledImageVariants','false'),('plugins.image-optimize.settings.assetVolumeSubFolders','true'),('plugins.image-optimize.settings.autoSharpenScaledImages','true'),('plugins.image-optimize.settings.createColorPalette','true'),('plugins.image-optimize.settings.createPlaceholderSilhouettes','false'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.0','\"nystudio107\\\\imageoptimizeimgix\\\\imagetransforms\\\\ImgixImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.0','\"domain\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.0','\"apiKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.0','\"securityToken\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.2.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.3.0','\"unsharpMask\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.0.1.__assoc__.3.1','\"20\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.0','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.1.1.__assoc__.0.1','\"$IMAGE_HANDLER_URL\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.0','\"nystudio107\\\\imageoptimizethumbor\\\\imagetransforms\\\\ThumborImageTransform\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.0','\"baseUrl\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.0.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.0','\"securityKey\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.1.1','\"\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.0','\"includeBucketPrefix\"'),('plugins.image-optimize.settings.imageTransformTypeSettings.__assoc__.2.1.__assoc__.2.1','\"\"'),('plugins.image-optimize.settings.lowerQualityRetinaImageVariants','true'),('plugins.image-optimize.settings.transformClass','\"nystudio107\\\\imageoptimizesharp\\\\imagetransforms\\\\SharpImageTransform\"'),('plugins.incognito-field.edition','\"standard\"'),('plugins.incognito-field.enabled','true'),('plugins.incognito-field.schemaVersion','\"1.1.1\"'),('plugins.lockout.edition','\"standard\"'),('plugins.lockout.enabled','true'),('plugins.lockout.schemaVersion','\"1.0.0\"'),('plugins.minify.edition','\"standard\"'),('plugins.minify.enabled','true'),('plugins.minify.schemaVersion','\"1.0.0\"'),('plugins.neo.edition','\"standard\"'),('plugins.neo.enabled','true'),('plugins.neo.licenseKey','\"OAL9GD6HGCZSLCZGB3V1DA1Y\"'),('plugins.neo.schemaVersion','\"2.8.16\"'),('plugins.publisher.edition','\"standard\"'),('plugins.publisher.enabled','true'),('plugins.publisher.schemaVersion','\"2.0.6\"'),('plugins.redactor-anchors.edition','\"standard\"'),('plugins.redactor-anchors.enabled','true'),('plugins.redactor-anchors.schemaVersion','\"2.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.retour.edition','\"standard\"'),('plugins.retour.enabled','true'),('plugins.retour.licenseKey','\"KUH6PJFJKHHVLO280GSIAUF8\"'),('plugins.retour.schemaVersion','\"3.0.9\"'),('plugins.seomatic.edition','\"standard\"'),('plugins.seomatic.enabled','true'),('plugins.seomatic.licenseKey','\"ZPLAAH9FG7R6D3CT6YSIHSKW\"'),('plugins.seomatic.schemaVersion','\"3.0.9\"'),('plugins.seomatic.settings.addHrefLang','true'),('plugins.seomatic.settings.addPaginatedHreflang','true'),('plugins.seomatic.settings.addXDefaultHrefLang','true'),('plugins.seomatic.settings.cpTitlePrefix','\"⚙ \"'),('plugins.seomatic.settings.cspNonce','\"\"'),('plugins.seomatic.settings.cspScriptSrcPolicies.0.__assoc__.0.0','\"policy\"'),('plugins.seomatic.settings.cspScriptSrcPolicies.0.__assoc__.0.1','\"\'self\'\"'),('plugins.seomatic.settings.devModeCpTitlePrefix','\"&#x1f6a7;⚙ \"'),('plugins.seomatic.settings.devModeTitlePrefix','\"&#x1f6a7; \"'),('plugins.seomatic.settings.displayAnalysisSidebar','true'),('plugins.seomatic.settings.displayPreviewSidebar','true'),('plugins.seomatic.settings.enableJsonLdEndpoint','false'),('plugins.seomatic.settings.enableMetaContainerEndpoint','false'),('plugins.seomatic.settings.enableSeoFileLinkEndpoint','false'),('plugins.seomatic.settings.environment','\"live\"'),('plugins.seomatic.settings.generatorEnabled','true'),('plugins.seomatic.settings.headersEnabled','true'),('plugins.seomatic.settings.lowercaseCanonicalUrl','\"1\"'),('plugins.seomatic.settings.manuallySetEnvironment','false'),('plugins.seomatic.settings.maxDescriptionLength','155'),('plugins.seomatic.settings.maxTitleLength','70'),('plugins.seomatic.settings.metaCacheDuration','\"null\"'),('plugins.seomatic.settings.pluginName','\"SEOmatic\"'),('plugins.seomatic.settings.regenerateSitemapsAutomatically','true'),('plugins.seomatic.settings.renderEnabled','true'),('plugins.seomatic.settings.separatorChar','\"|\"'),('plugins.seomatic.settings.sidebarDisplayPreviewTypes.0','\"google\"'),('plugins.seomatic.settings.sidebarDisplayPreviewTypes.1','\"facebook\"'),('plugins.seomatic.settings.siteGroupsSeparate','\"1\"'),('plugins.seomatic.settings.sitemapsEnabled','true'),('plugins.seomatic.settings.siteUrlOverride','\"\"'),('plugins.seomatic.settings.socialMediaPreviewTarget','true'),('plugins.seomatic.settings.submitSitemaps','true'),('plugins.twigpack.edition','\"standard\"'),('plugins.twigpack.enabled','true'),('plugins.twigpack.schemaVersion','\"1.0.0\"'),('plugins.wordsmith.edition','\"standard\"'),('plugins.wordsmith.enabled','true'),('plugins.wordsmith.schemaVersion','\"0.0.0.0\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.enableVersioning','true'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.handle','\"homepage\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.name','\"Homepage\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.propagationMethod','\"all\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.enabledByDefault','true'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.hasUrls','true'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.template','\"index\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.uriFormat','\"__home__\"'),('sections.5bca25b9-aa51-4b88-bbe5-9e338aecfb97.type','\"single\"'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.enableVersioning','false'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.handle','\"errors\"'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.name','\"Errors\"'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.propagationMethod','\"all\"'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.enabledByDefault','true'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.hasUrls','true'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.template','null'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.uriFormat','null'),('sections.a8c0d162-4d98-41f6-b67b-215123a3f69d.type','\"channel\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.enableVersioning','true'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.handle','\"pages\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.name','\"Pages\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.propagationMethod','\"all\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.enabledByDefault','true'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.hasUrls','true'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.template','\"_pages/entry\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.siteSettings.7aa2b387-b891-449b-bbbb-b709fb95595e.uriFormat','\"{% if object.level == 1 %}{slug}{% else %}{parent.uri}/{slug}{% endif %}\"'),('sections.ed9d3647-71e9-4ce1-a143-0a5692fd03d0.type','\"channel\"'),('siteGroups.0cf7cbe9-74ce-44c2-bbce-d1bf108b3eb2.name','\"craft3\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.baseUrl','\"$SITE_URL\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.enabled','true'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.handle','\"default\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.hasUrls','true'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.language','\"en-AU\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.name','\"craft3\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.primary','true'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.siteGroup','\"0cf7cbe9-74ce-44c2-bbce-d1bf108b3eb2\"'),('sites.7aa2b387-b891-449b-bbbb-b709fb95595e.sortOrder','1'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"craft3\"'),('system.retryDuration','null'),('system.schemaVersion','\"3.6.8\"'),('system.timeZone','\"Australia/Adelaide\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.description','\"\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.handle','\"contentAuthors\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.name','\"Content Authors\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.0','\"accesssitewhensystemisoff\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.1','\"accesscp\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.10','\"publishpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.11','\"deletepeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.12','\"editpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.13','\"publishpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.14','\"deletepeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.15','\"editpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.16','\"editentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.17','\"saveassetinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.18','\"createfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.19','\"deletefilesandfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.2','\"publishentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.20','\"replacefilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.21','\"editimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.22','\"editpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.23','\"replacepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.24','\"deletepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.25','\"editpeerimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.26','\"viewpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.27','\"viewvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.28','\"saveassetinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.29','\"createfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.3','\"publishpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.30','\"deletefilesandfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.31','\"replacefilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.32','\"editimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.33','\"editpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.34','\"replacepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.35','\"deletepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.36','\"editpeerimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.37','\"viewpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.38','\"viewvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.39','\"saveassetinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.4','\"deletepeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.40','\"editimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.41','\"editpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.42','\"editpeerimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.43','\"viewpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.44','\"viewvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.45','\"saveassetinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.46','\"editimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.47','\"editpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.48','\"editpeerimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.49','\"viewpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.5','\"editpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.50','\"viewvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.6','\"editentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.7','\"createentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.8','\"publishentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.b0524ca9-95e0-4a63-90b4-a497793fe0a1.permissions.9','\"deleteentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.description','\"Access to everything except development related things\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.handle','\"cmsAdmin\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.name','\"CMS Admin\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.0','\"accesssitewhensystemisoff\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.1','\"accesscp\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.10','\"deleteusers\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.11','\"publishentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.12','\"publishpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.13','\"deletepeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.14','\"editpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.15','\"editentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.16','\"createentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.17','\"publishentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.18','\"deleteentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.19','\"publishpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.2','\"registerusers\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.20','\"deletepeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.21','\"editpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.22','\"publishpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.23','\"deletepeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.24','\"editpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.25','\"editentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.26','\"editglobalset:a2c771d3-8007-42be-a397-7945f01f2c44\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.27','\"editglobalset:c17bf7df-73d2-4012-9f9e-a6078d9996ff\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.28','\"editglobalset:6a16e864-cae2-42df-95cc-3834afcfe89b\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.29','\"saveassetinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.3','\"moderateusers\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.30','\"createfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.31','\"deletefilesandfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.32','\"replacefilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.33','\"editimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.34','\"editpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.35','\"replacepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.36','\"deletepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.37','\"editpeerimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.38','\"viewpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.39','\"viewvolume:e06bad3e-e63c-49ac-b605-164d334f58f8\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.4','\"assignuserpermissions\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.40','\"saveassetinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.41','\"createfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.42','\"deletefilesandfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.43','\"replacefilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.44','\"editimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.45','\"editpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.46','\"replacepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.47','\"deletepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.48','\"editpeerimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.49','\"viewpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.5','\"assignusergroup:fc194dfa-7273-44e9-8a76-201a431bd85a\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.50','\"viewvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.51','\"saveassetinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.52','\"createfoldersinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.53','\"deletefilesandfoldersinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.54','\"replacefilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.55','\"editimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.56','\"editpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.57','\"replacepeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.58','\"deletepeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.59','\"editpeerimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.6','\"assignusergroups\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.60','\"viewpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.61','\"viewvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.62','\"saveassetinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.63','\"createfoldersinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.64','\"deletefilesandfoldersinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.65','\"replacefilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.66','\"editimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.67','\"editpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.68','\"replacepeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.69','\"deletepeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.7','\"administrateusers\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.70','\"editpeerimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.71','\"viewpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.72','\"viewvolume:007cf408-5171-4608-bb10-37e9d01c33e7\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.73','\"retour:dashboard\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.74','\"retour:redirects\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.75','\"seomatic:dashboard\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.8','\"impersonateusers\"'),('users.groups.fc194dfa-7273-44e9-8a76-201a431bd85a.permissions.9','\"editusers\"'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.autocapitalize','true'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.autocomplete','false'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.autocorrect','true'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.class','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.disabled','false'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.id','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.instructions','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.label','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.max','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.min','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.name','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.orientation','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.placeholder','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.readonly','false'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.requirable','false'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.size','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.step','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.tip','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.title','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.warning','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.elements.0.width','100'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.name','\"Content\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.fieldLayouts.f5363b55-b061-491a-9d18-f7acdb6b2de4.tabs.0.sortOrder','1'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.handle','\"sharedDocuments\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.hasUrls','true'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.name','\"Shared documents\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.addSubfolderToRootUrl','\"1\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.autoFocalPoint','\"\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.bucket','\"$S3_BUCKET\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.bucketSelectionMode','\"manual\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.expires','\"12 months\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.keyId','\"$S3_KEY_ID\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.makeUploadsPublic','\"\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.region','\"$S3_REGION\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.secret','\"$S3_SECRET\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.storageClass','\"\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.settings.subfolder','\"shared/docs/\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.sortOrder','1'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.titleTranslationKeyFormat','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.titleTranslationMethod','null'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.type','\"craft\\\\awss3\\\\Volume\"'),('volumes.007cf408-5171-4608-bb10-37e9d01c33e7.url','\"$CLOUDFRONT_URL\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.autocapitalize','true'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.autocomplete','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.autocorrect','true'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.class','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.disabled','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.id','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.instructions','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.label','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.max','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.min','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.name','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.orientation','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.placeholder','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.readonly','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.requirable','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.size','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.step','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.tip','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.title','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.warning','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.0.width','100'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.fieldUid','\"a920bb04-faca-4f59-9a0a-a2e2a090fe23\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.instructions','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.label','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.required','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.tip','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.warning','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.1.width','100'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.fieldUid','\"112c70eb-196d-49cf-8c69-cb6cd11432ac\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.instructions','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.label','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.required','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.tip','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.warning','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.elements.2.width','100'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.name','\"Content\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.0.sortOrder','1'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.fieldUid','\"da2fde99-98d1-4e82-b00c-5c792200f49f\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.instructions','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.label','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.required','false'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.tip','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.warning','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.elements.0.width','100'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.name','\"Optimized images\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.fieldLayouts.e2a2a2db-1a22-43fe-bd08-f11492d09a4a.tabs.1.sortOrder','2'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.handle','\"sharedImages\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.hasUrls','true'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.name','\"Shared images\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.addSubfolderToRootUrl','\"1\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.autoFocalPoint','\"\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.bucket','\"$S3_BUCKET\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.bucketSelectionMode','\"manual\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.cfDistributionId','\"$CLOUDFRONT_DISTRIBUTION_ID\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.cfPrefix','\"$CLOUDFRONT_PATH_PREFIX\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.expires','\"6 months\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.keyId','\"$S3_KEY_ID\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.makeUploadsPublic','\"\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.region','\"$S3_REGION\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.secret','\"$S3_SECRET\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.storageClass','\"\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.settings.subfolder','\"shared/images/\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.sortOrder','2'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.titleTranslationKeyFormat','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.titleTranslationMethod','null'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.type','\"craft\\\\awss3\\\\Volume\"'),('volumes.37e0968a-18b5-4f97-b792-d34a431b19fd.url','\"@cloudfrontUrl\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfignames`
--

LOCK TABLES `projectconfignames` WRITE;
/*!40000 ALTER TABLE `projectconfignames` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfignames` VALUES ('007cf408-5171-4608-bb10-37e9d01c33e7','Shared documents'),('06536257-6591-4559-b58a-811c65d68b07','Hide from search'),('07c3c9d2-dac1-46ee-9c0b-0198c2b71d77','Error image'),('0cf7cbe9-74ce-44c2-bbce-d1bf108b3eb2','craft3'),('0e0fc1dc-2333-4642-823a-faeb5caffa84','Errors'),('112c70eb-196d-49cf-8c69-cb6cd11432ac','Caption'),('1b30d64f-2b47-47ab-b74c-56ca223018fd','Redirect URL'),('21f58d98-8320-49d6-8066-b096dee14310','Error headline'),('3004f128-4dcc-4b0f-9369-4c7f87cb3839','Optimized images'),('37e0968a-18b5-4f97-b792-d34a431b19fd','Shared images'),('38aeb4dd-0882-41f8-98a5-bf78e31d659a','Site logo'),('434cb523-f553-43e1-b517-b4350f11580e','Acknowledgement text'),('4e95ad26-266a-497f-9524-fb54eeeafedc','Text'),('5530f693-5e22-48f0-ba53-d8e8999ec908','Common'),('56f7afac-4e92-4e6b-bc02-0902467b5843','SEO'),('5bca25b9-aa51-4b88-bbe5-9e338aecfb97','Homepage'),('6535d548-8ab4-4b6f-acef-a044ef5e2f97','Teaser image'),('65d8ebe8-6a97-403c-8f4d-27b32c5b4d5a','Dismiss'),('6a16e864-cae2-42df-95cc-3834afcfe89b','Sitewide alert'),('7aa2b387-b891-449b-bbbb-b709fb95595e','craft3'),('7bfcbb3d-29bf-40e4-a9a8-838a0ebf268b','Settings'),('7cc23e51-bc00-4d62-832b-6cc9c0b4d923','Errors'),('820d67ae-c658-4d30-8347-14058c97e1c1','Globals'),('886db157-8715-44d2-a1f6-36b4ac508beb','Show caption'),('8faa7537-f8f6-4808-88f5-909c50cf87b8','Teaser text'),('906dff7a-94e7-43bb-a515-3feda5b3bbec','Footer links'),('98ad4db6-2be2-4ca8-9b2f-55b134195713','Full width'),('9ccb3478-824d-4f4b-a1ca-7589415a1339','Content builder'),('a2c771d3-8007-42be-a397-7945f01f2c44','Footer'),('a7fa6737-974c-401e-ac92-6239739c2ccc','Alert text'),('a8c0d162-4d98-41f6-b67b-215123a3f69d','Errors'),('a920bb04-faca-4f59-9a0a-a2e2a090fe23','Alt text'),('a93a6824-982b-40e8-ab4b-3ed360a152c3','End date'),('aaa783ac-8136-45ae-954f-aeb3a10f9ab5','Landing'),('ad29506d-5bf0-4507-ace0-445d37ad4df3','Hide from navigation'),('b0524ca9-95e0-4a63-90b4-a497793fe0a1','Content Authors'),('b5e6b714-38fe-4661-91c0-28454e56d45a','Start date'),('b7232602-e058-4dc6-b639-3e5dfb6ee3f0','Acknowledgement image'),('b8cad5cb-060a-4f09-b35c-c4ddd40c147b','Teaser title'),('bc35f3c3-ef3c-46da-9dba-1a19b48ad7f9','Excluded pages'),('bc3e6fff-c84a-486c-94ff-f77de96ab75f','Error text'),('c070a16a-3c83-4536-ad01-e4a85fade10d','Assets'),('c0b32c55-a7e9-4d6e-9696-236594d7a98d','Image'),('c17bf7df-73d2-4012-9f9e-a6078d9996ff','Site'),('c1fbbe64-a078-4af6-9266-3321a7dc4724','Image'),('cc2dbcd9-ed1a-4fb6-b83f-675c2b8d0ada','General'),('d059edc7-b38e-4922-aee9-1cbc88b92ecd','Redirect'),('da2fde99-98d1-4e82-b00c-5c792200f49f','Optimized general'),('e122630f-ef1f-4011-b0d4-3e3487d928b3','Blocks'),('e449bc51-6949-4b4c-8fbf-008e590c9935','Hero image'),('eba7d0a3-19f3-4d50-8ea8-850b84c5af55','Favicon'),('ecbd874f-2167-4018-a697-0ae3677231a7','Homepage'),('ed9d3647-71e9-4ce1-a143-0a5692fd03d0','Pages'),('fb00c1dd-4f98-427b-a2ba-4b53503d8cb5','Rich text'),('fc194dfa-7273-44e9-8a76-201a431bd85a','CMS Admin'),('fd5bb1fc-eeb9-4b53-9d04-293fb24e9648','Video');
/*!40000 ALTER TABLE `projectconfignames` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `relations` VALUES (1,19,3,NULL,51,1,'2021-05-25 07:40:41','2021-05-25 07:40:41','bbd8b3b1-a502-4432-8e80-10547f1098fd');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('1420ae24','@lib/garnishjs'),('14c4b8ab','@app/web/assets/cp/dist'),('1667a1a','@lib/fabric'),('1747a17d','@app/web/assets/plugins/dist'),('1d786a45','@app/web/assets/editsection/dist'),('209853c6','@nystudio107/retour/assetbundles/retour/dist'),('221e4cb3','@craft/awss3/resources'),('25be5edd','@lib/axios'),('293899f3','@lib/picturefill'),('2c1aafb8','@lib/prismjs'),('2d19fe2b','@vardump/activeusers/assetbundles/activeuserswidgetwidget/dist'),('2e9ca531','@lib/jquery-touch-events'),('2f691e94','@lib/jquery-ui'),('30ee4ed7','@verbb/expandedsingles/resources/dist'),('31d0980d','@lib/fileupload'),('35ea6dce','@craft/web/assets/cp/dist'),('397f4abc','@app/web/assets/admintable/dist'),('3a70fe11','@app/web/assets/fieldsettings/dist'),('3d73a71a','@lib/iframe-resizer'),('3e8688e3','@lib/d3'),('42c57d10','@nystudio107/retour/assetbundles/retour/dist'),('43ca5361','@verbb/base/resources/dist'),('48d5a888','@lib/timepicker'),('4c97dd2f','@app/web/assets/dashboard/dist'),('530b5d8','@app/web/assets/updates/dist'),('5741c00','@nystudio107/seomatic/assetbundles/seomatic/dist'),('5fdfd9b9','@lib/element-resize-detector'),('612c633','@app/web/assets/assetindexes/dist'),('61c08531','@lib/velocity'),('685bd213','@app/web/assets/userpermissions/dist'),('704f724c','@bower/jquery/dist'),('752a2e6e','@app/web/assets/editentry/dist'),('76bffa3a','@app/web/assets/utilities/dist'),('772af0fd','@lib/xregexp'),('7d46b477','@lib/selectize'),('7de72ad9','@lib/jquery.payment'),('81c2800','@nystudio107/seomatic/assetbundles/seomatic/dist'),('855fda8','@lib/vue'),('890c32b7','@app/web/assets/admintable/dist'),('8a020e81','@lib/element-resize-detector'),('8db9ef09','@app/web/assets/pluginstore/dist'),('8f9a9363','@app/web/assets/cp/dist'),('92bfb75c','@app/web/assets/login/dist'),('9bc4db0a','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),('9d087fb0','@lib/timepicker'),('a2f727c5','@lib/xregexp'),('a2ff5a41','@app/web/assets/craftsupport/dist'),('a592a574','@bower/jquery/dist'),('a83afde1','@lib/jquery.payment'),('a89b634f','@lib/selectize'),('affb169a','@nystudio107/imageoptimize/assetbundles/imageoptimize/dist'),('b138c453','@lib/datepicker-i18n'),('b392b5ac','@craft/web/assets/plugins/dist'),('b41d5209','@lib/velocity'),('bbbb7674','@app/web/assets/utilities/dist'),('bf474634','@app/web/assets/edituser/dist'),('c1fd791c','@lib/garnishjs'),('c48d1368','@app/web/assets/recententries/dist'),('c8343996','@app/web/assets/updates/dist'),('d0aed8a9','@app/web/assets/fields/dist'),('d4bbad22','@lib/fabric'),('dd882a90','@lib/vue'),('e40d4f35','@lib/fileupload'),('e88179c4','@app/web/assets/dbbackup/dist'),('e8ae7022','@lib/iframe-resizer'),('e978b8a4','@lib/axios'),('ef9ae99c','@app/web/assets/feed/dist'),('f2406e9a','@lib/d3'),('f76f34e7','@app/web/assets/editentry/dist'),('f9c77880','@lib/prismjs'),('fa375106','@app/web/assets/updateswidget/dist'),('fab4c9ac','@lib/jquery-ui'),('fb417209','@lib/jquery-touch-events'),('fce54ecb','@lib/picturefill'),('ffcf580','@app/web/assets/pluginstore/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_redirects`
--

LOCK TABLES `retour_redirects` WRITE;
/*!40000 ALTER TABLE `retour_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_static_redirects`
--

LOCK TABLES `retour_static_redirects` WRITE;
/*!40000 ALTER TABLE `retour_static_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_static_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_stats`
--

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `retour_stats` VALUES (1,'2021-05-24 06:59:38','2021-05-24 07:02:10','d6669dea-daa4-47f3-91ab-42defa84c241',1,'/js/app.js','https://newapp.test/','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: js/app.js','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,2,'2021-05-24 07:02:10',0),(2,'2021-05-24 06:59:39','2021-05-24 07:02:09','d3ba854f-45b4-497f-b927-7b1f18624c53',1,'/css/app.css','https://newapp.test/','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: css/app.css','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,2,'2021-05-24 07:02:09',0),(3,'2021-05-24 10:07:39','2021-05-24 10:07:45','1d33fdfd-e910-46bb-8341-6f7fe5642e36',1,'/dist/mix-manifest.json','','127.0.0.1','User-Agent:Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13','Template not found: dist/mix-manifest.json','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,6,'2021-05-24 10:07:45',0),(4,'2021-05-24 10:28:04','2021-05-24 10:28:04','d74bccbd-af56-47fb-a24a-81fe2961e5af',1,'/wsnewapp.test:3000/ws/js/app.js','http://newapp.test/','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: wsnewapp.test:3000/ws/js/app.js','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2021-05-24 10:28:04',0),(5,'2021-05-24 10:28:04','2021-05-24 10:28:04','a4363482-c084-4ac3-958b-689ef0a76095',1,'/wsnewapp.test:3000/ws/css/app.css','http://newapp.test/','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: wsnewapp.test:3000/ws/css/app.css','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2021-05-24 10:28:04',0),(6,'2021-05-24 10:51:04','2021-05-24 10:59:05','c3558b06-fc01-4479-8449-555f54d818e7',1,'/dist/js/inline/tab-handler.min.js','','127.0.0.1','User-Agent:Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13','Template not found: dist/js/inline/tab-handler.min.js','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,5,'2021-05-24 10:59:05',0),(7,'2021-05-24 13:02:20','2021-05-24 13:02:20','2bbfdf32-d87d-4579-afd5-8a064b59aa18',1,'/js/app.57e988f71aedffa977e6.js','http://newapp.test/','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: js/app.57e988f71aedffa977e6.js','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2021-05-24 13:02:20',0),(8,'2021-05-24 13:40:16','2021-05-24 13:40:16','dc672aad-40c1-4796-ae46-dc6679afcfdd',1,'/dist/css/app.1c7d9e117e0083a4fbe8.css','http://newapp.test//','172.18.0.1','Penthouse Critical Path CSS Generator','Template not found: dist/css/app.1c7d9e117e0083a4fbe8.css','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2021-05-24 13:40:16',0),(9,'2021-05-24 22:32:32','2021-05-25 01:33:35','04d8d357-d894-45aa-be35-3526e83bffc9',1,'/fakepage','','172.18.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36','Template not found: fakepage','/app/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,4,'2021-05-25 01:33:35',0);
/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,8,NULL,1,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'slug',0,1,''),(2,'slug',0,1,''),(3,'slug',0,1,''),(4,'slug',0,1,' 404 not found '),(4,'title',0,1,' 404 not found '),(5,'slug',0,1,' generic error '),(5,'title',0,1,' generic error '),(6,'slug',0,1,' site offline '),(6,'title',0,1,' site offline '),(7,'slug',0,1,' 503 service unavailable '),(7,'title',0,1,' 503 service unavailable '),(8,'slug',0,1,' homepage '),(8,'title',0,1,' home '),(10,'email',0,1,' dew internet sa gov au '),(10,'firstname',0,1,''),(10,'fullname',0,1,''),(10,'lastname',0,1,''),(10,'slug',0,1,''),(10,'username',0,1,' dew internet sa gov au '),(12,'slug',0,1,' error404 '),(12,'title',0,1,' 404 error '),(14,'slug',0,1,' error403 '),(14,'title',0,1,' 403 error '),(16,'slug',0,1,' error503 '),(16,'title',0,1,' 503 error '),(18,'slug',0,1,' error '),(18,'title',0,1,' error '),(20,'slug',0,1,' offline '),(20,'title',0,1,' offline '),(21,'slug',0,1,' temp hvbwflbxvethqkklhdxrdqkqpvsejsxvtcyn '),(21,'title',0,1,''),(22,'extension',0,1,' svg '),(22,'field',9,1,''),(22,'field',21,1,''),(22,'filename',0,1,' dcmb logo white svg '),(22,'kind',0,1,' image '),(22,'slug',0,1,''),(22,'title',0,1,' dcmb logo white '),(23,'extension',0,1,' svg '),(23,'field',9,1,''),(23,'field',21,1,''),(23,'filename',0,1,' npwssa logotype svg '),(23,'kind',0,1,' image '),(23,'slug',0,1,''),(23,'title',0,1,' npwssa logotype '),(24,'extension',0,1,' svg '),(24,'field',9,1,''),(24,'field',21,1,''),(24,'filename',0,1,' npwssa logotype black svg '),(24,'kind',0,1,' image '),(24,'slug',0,1,''),(24,'title',0,1,' npwssa logotype black '),(25,'extension',0,1,' svg '),(25,'field',9,1,''),(25,'field',21,1,''),(25,'filename',0,1,' lbsa logotype color svg '),(25,'kind',0,1,' image '),(25,'slug',0,1,''),(25,'title',0,1,' lbsa logotype color '),(26,'extension',0,1,' svg '),(26,'field',9,1,''),(26,'field',21,1,''),(26,'filename',0,1,' gosa logotype white svg '),(26,'kind',0,1,' image '),(26,'slug',0,1,''),(26,'title',0,1,' gosa logotype white '),(27,'extension',0,1,' svg '),(27,'field',9,1,''),(27,'field',21,1,''),(27,'filename',0,1,' gosa logotype color svg '),(27,'kind',0,1,' image '),(27,'slug',0,1,''),(27,'title',0,1,' gosa logotype color '),(28,'extension',0,1,' svg '),(28,'field',9,1,''),(28,'field',21,1,''),(28,'filename',0,1,' good living logotype svg '),(28,'kind',0,1,' image '),(28,'slug',0,1,''),(28,'title',0,1,' good living logotype '),(29,'extension',0,1,' svg '),(29,'field',9,1,''),(29,'field',21,1,''),(29,'filename',0,1,' dcmb rev horiz svg '),(29,'kind',0,1,' image '),(29,'slug',0,1,''),(29,'title',0,1,' dcmb rev horiz '),(30,'extension',0,1,' svg '),(30,'field',9,1,''),(30,'field',21,1,''),(30,'filename',0,1,' dcmb logo svg '),(30,'kind',0,1,' image '),(30,'slug',0,1,''),(30,'title',0,1,' dcmb logo '),(31,'extension',0,1,' png '),(31,'field',9,1,''),(31,'field',21,1,''),(31,'filename',0,1,' ack banner png '),(31,'kind',0,1,' image '),(31,'slug',0,1,''),(31,'title',0,1,' ack banner '),(32,'extension',0,1,' svg '),(32,'field',9,1,''),(32,'field',21,1,''),(32,'filename',0,1,' craftcms svg '),(32,'kind',0,1,' image '),(32,'slug',0,1,''),(32,'title',0,1,' craftcms '),(33,'extension',0,1,' svg '),(33,'field',9,1,''),(33,'field',21,1,''),(33,'filename',0,1,' bsa logotype white svg '),(33,'kind',0,1,' image '),(33,'slug',0,1,''),(33,'title',0,1,' bsa logotype white '),(34,'extension',0,1,' jpg '),(34,'field',9,1,''),(34,'field',21,1,''),(34,'filename',0,1,' desert parks 2010 176 jpg '),(34,'kind',0,1,' image '),(34,'slug',0,1,''),(34,'title',0,1,' desert parks 2010 176 '),(35,'extension',0,1,' png '),(35,'field',9,1,''),(35,'field',21,1,''),(35,'filename',0,1,' connect with sa png '),(35,'kind',0,1,' image '),(35,'slug',0,1,''),(35,'title',0,1,' connect with sa '),(36,'extension',0,1,' jpg '),(36,'field',9,1,''),(36,'field',21,1,''),(36,'filename',0,1,' apy final jpg '),(36,'kind',0,1,' image '),(36,'slug',0,1,''),(36,'title',0,1,' apy final '),(37,'extension',0,1,' png '),(37,'field',9,1,''),(37,'field',21,1,''),(37,'filename',0,1,' aoc bg png '),(37,'kind',0,1,' image '),(37,'slug',0,1,''),(37,'title',0,1,' aoc bg '),(38,'extension',0,1,' svg '),(38,'field',9,1,''),(38,'field',21,1,''),(38,'filename',0,1,' sagovau logotype white svg '),(38,'kind',0,1,' image '),(38,'slug',0,1,''),(38,'title',0,1,' sagovau logotype white '),(39,'extension',0,1,' svg '),(39,'filename',0,1,' dcmb logo white svg '),(39,'kind',0,1,' image '),(39,'slug',0,1,''),(39,'title',0,1,' dcmb logo white '),(40,'extension',0,1,' svg '),(40,'filename',0,1,' npwssa logotype svg '),(40,'kind',0,1,' image '),(40,'slug',0,1,''),(40,'title',0,1,' npwssa logotype '),(41,'extension',0,1,' svg '),(41,'filename',0,1,' npwssa logotype black svg '),(41,'kind',0,1,' image '),(41,'slug',0,1,''),(41,'title',0,1,' npwssa logotype black '),(42,'extension',0,1,' svg '),(42,'filename',0,1,' lbsa logotype color svg '),(42,'kind',0,1,' image '),(42,'slug',0,1,''),(42,'title',0,1,' lbsa logotype color '),(43,'extension',0,1,' svg '),(43,'filename',0,1,' gosa logotype white svg '),(43,'kind',0,1,' image '),(43,'slug',0,1,''),(43,'title',0,1,' gosa logotype white '),(44,'extension',0,1,' svg '),(44,'filename',0,1,' gosa logotype color svg '),(44,'kind',0,1,' image '),(44,'slug',0,1,''),(44,'title',0,1,' gosa logotype color '),(45,'extension',0,1,' svg '),(45,'filename',0,1,' good living logotype svg '),(45,'kind',0,1,' image '),(45,'slug',0,1,''),(45,'title',0,1,' good living logotype '),(46,'extension',0,1,' svg '),(46,'filename',0,1,' dcmb rev horiz svg '),(46,'kind',0,1,' image '),(46,'slug',0,1,''),(46,'title',0,1,' dcmb rev horiz '),(47,'extension',0,1,' svg '),(47,'filename',0,1,' dcmb logo svg '),(47,'kind',0,1,' image '),(47,'slug',0,1,''),(47,'title',0,1,' dcmb logo '),(48,'extension',0,1,' png '),(48,'filename',0,1,' ack banner png '),(48,'kind',0,1,' image '),(48,'slug',0,1,''),(48,'title',0,1,' ack banner '),(49,'extension',0,1,' svg '),(49,'filename',0,1,' craftcms svg '),(49,'kind',0,1,' image '),(49,'slug',0,1,''),(49,'title',0,1,' craftcms '),(50,'extension',0,1,' svg '),(50,'filename',0,1,' bsa logotype white svg '),(50,'kind',0,1,' image '),(50,'slug',0,1,''),(50,'title',0,1,' bsa logotype white '),(51,'extension',0,1,' jpg '),(51,'filename',0,1,' desert parks 2010 176 jpg '),(51,'kind',0,1,' image '),(51,'slug',0,1,''),(51,'title',0,1,' desert parks 2010 176 '),(52,'extension',0,1,' png '),(52,'filename',0,1,' connect with sa png '),(52,'kind',0,1,' image '),(52,'slug',0,1,''),(52,'title',0,1,' connect with sa '),(53,'extension',0,1,' jpg '),(53,'filename',0,1,' apy final jpg '),(53,'kind',0,1,' image '),(53,'slug',0,1,''),(53,'title',0,1,' apy final '),(54,'extension',0,1,' png '),(54,'filename',0,1,' aoc bg png '),(54,'kind',0,1,' image '),(54,'slug',0,1,''),(54,'title',0,1,' aoc bg '),(55,'extension',0,1,' svg '),(55,'filename',0,1,' sagovau logotype white svg '),(55,'kind',0,1,' image '),(55,'slug',0,1,''),(55,'title',0,1,' sagovau logotype white ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'404 Not Found','notFound','single',0,'all',NULL,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-24 14:35:24','b314117c-3a79-475d-8c5d-fb9ec1936d23'),(2,NULL,'Generic Error','genericError','single',0,'all',NULL,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-24 14:35:31','30c63261-6db1-4736-860e-386bfac1ac03'),(3,NULL,'Site Offline','siteOffline','single',0,'all',NULL,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-24 14:35:34','1c7d3aa7-8a5c-4b5f-ab7f-66304a00b055'),(4,NULL,'Pages','pages','channel',1,'all',NULL,'2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'ed9d3647-71e9-4ce1-a143-0a5692fd03d0'),(5,NULL,'Homepage','homepage','single',1,'all',NULL,'2021-05-24 00:08:01','2021-05-24 00:08:01',NULL,'5bca25b9-aa51-4b88-bbe5-9e338aecfb97'),(6,NULL,'503 Service Unavailable','serviceUnavailable','single',0,'all',NULL,'2021-05-24 00:08:01','2021-05-24 00:08:01','2021-05-24 14:35:27','77dd2c77-6400-4791-bc4b-b2bf9e9ccfca'),(7,NULL,'Errors','errors','channel',0,'all',NULL,'2021-05-24 14:37:00','2021-05-24 14:38:48',NULL,'a8c0d162-4d98-41f6-b67b-215123a3f69d');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'404','404.twig',1,'2021-05-24 00:08:00','2021-05-24 00:08:00','8e8526fd-44c2-4f30-b5ba-248b02a9ea5d'),(2,2,1,1,'error','error.twig',1,'2021-05-24 00:08:00','2021-05-24 00:08:00','d512249a-f99b-44d4-908a-229ad51c1f35'),(3,3,1,1,'offline','offline.twig',1,'2021-05-24 00:08:00','2021-05-24 00:08:00','c4cf4f0c-16a4-4287-84e7-b3b9a73453b4'),(4,4,1,1,'{% if object.level == 1 %}{slug}{% else %}{parent.uri}/{slug}{% endif %}','_pages/entry',1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7b066e55-3a00-4d00-9d31-19b4cebb1b9a'),(5,5,1,1,'__home__','index',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','617407a6-0bd8-448d-88ce-0af1e9c6becf'),(6,6,1,1,'503','503.twig',1,'2021-05-24 00:08:01','2021-05-24 00:08:01','a6097a83-797b-4be0-b6ee-3c41d1900b78'),(7,7,1,1,NULL,NULL,1,'2021-05-24 14:37:00','2021-05-24 14:38:48','faf3cf03-47b1-4c9a-977f-4f99d69d23d8');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2021-05-24 00:07:59','2021-05-25 00:28:59','c90111ac-836d-4033-9440-75649f14261c','1.0.56','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2021-05-25 00:28:59','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"craft3\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"GovernmentOrganization\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"Department for Environment and Water\",\"genericAlternateName\":\"DEW\",\"genericDescription\":\"The Department for Environment and Water aims to help South Australians conserve, sustain and prosper.\",\"genericUrl\":\"https://environment.sa.gov.au/\",\"genericImage\":\"https://d3u55zae1ecw4x.cloudfront.net/shared/images/Logos/gosa-logotype-color.svg\",\"genericImageWidth\":\"146\",\"genericImageHeight\":\"40.75\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"dew.internet@sa.gov.au\",\"genericStreetAddress\":\"81 Waymouth Street\",\"genericAddressLocality\":\"Adelaide\",\"genericAddressRegion\":\"SA\",\"genericPostalCode\":\"5000\",\"genericAddressCountry\":\"AU\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"Adelaide, South Australia\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{seomatic.meta.robots}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"//{{ scriptUrl.value }}/\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2021-05-24 00:08:10','2021-05-24 00:08:10','136b474e-c64f-497f-a390-86a2c3577f68','1.0.29','section',5,'Homepage','homepage','single',NULL,'index',1,'{\"1\":{\"id\":5,\"sectionId\":5,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-au\"}}','2021-05-24 00:08:01','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"craft3\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(7,'2021-05-24 14:37:00','2021-05-24 23:03:30','8ad611c1-d133-4d9f-959a-8fa56b893972','1.0.29','section',7,'Errors','errorsSection','channel',NULL,'errors/_entry',1,'{\"1\":{\"id\":7,\"sectionId\":7,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"errors/{slug}\",\"template\":\"errors/_entry\",\"language\":\"en-au\"}}','2021-05-24 23:03:30','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"craft3\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'craft3','2021-05-24 00:07:57','2021-05-24 00:07:57',NULL,'0cf7cbe9-74ce-44c2-bbce-d1bf108b3eb2');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,1,'craft3','default','en-AU',1,'$SITE_URL',1,'2021-05-24 00:07:57','2021-05-24 00:07:57',NULL,'7aa2b387-b891-449b-bbbb-b709fb95595e');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `usergroups` VALUES (1,'Content Authors','contentAuthors','','2021-05-24 00:08:00','2021-05-24 00:08:00','b0524ca9-95e0-4a63-90b4-a497793fe0a1'),(2,'CMS Admin','cmsAdmin','Access to everything except development related things','2021-05-24 00:08:00','2021-05-24 00:08:00','fc194dfa-7273-44e9-8a76-201a431bd85a');
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpermissions` VALUES (1,'accesssitewhensystemisoff','2021-05-24 00:08:00','2021-05-24 00:08:00','7928a9b9-9f74-4968-8ad7-1a1da6e554f8'),(2,'accesscp','2021-05-24 00:08:00','2021-05-24 00:08:00','d5c3e3ac-f47b-4b38-aa41-dab661489aeb'),(3,'publishentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97','2021-05-24 00:08:00','2021-05-24 00:08:00','10b6e1d0-7277-42d6-bec5-f912532f9545'),(4,'publishpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97','2021-05-24 00:08:00','2021-05-24 00:08:00','4aa259d6-425b-49fc-9fb5-f4a84180c67d'),(5,'deletepeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97','2021-05-24 00:08:00','2021-05-24 00:08:00','cf9e9cb4-f2a3-4470-b24e-eec201962b15'),(6,'editpeerentrydrafts:5bca25b9-aa51-4b88-bbe5-9e338aecfb97','2021-05-24 00:08:00','2021-05-24 00:08:00','2ae6fad0-750a-4d47-829b-6929680e89fa'),(7,'editentries:5bca25b9-aa51-4b88-bbe5-9e338aecfb97','2021-05-24 00:08:00','2021-05-24 00:08:00','2fbf0af1-f60a-4306-9fca-57717d11f102'),(8,'createentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','d816a7b7-cd1d-4024-8d0b-2f7922482b39'),(9,'publishentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','8c788d59-918b-4981-b856-103e6c6c3660'),(10,'deleteentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','6252d6d4-e29a-42a1-9f4e-194594d5aeee'),(11,'publishpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','b4458c20-da5e-4741-8704-0f2759f77e8b'),(12,'deletepeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','a2db8905-d4a8-465f-9189-b9ed72075d2f'),(13,'editpeerentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','f1c4178c-ac3e-4a2b-bb7d-6e78abed0468'),(14,'publishpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','cc658c09-7d25-40f4-a741-eb5c50088363'),(15,'deletepeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','325ced47-e664-4f21-b25f-1c93c7ab0bdc'),(16,'editpeerentrydrafts:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','024ab22b-f72e-4f80-8758-ccdfcf66168a'),(17,'editentries:ed9d3647-71e9-4ce1-a143-0a5692fd03d0','2021-05-24 00:08:00','2021-05-24 00:08:00','ccb7b9dc-98cf-4a7a-a3e6-7a43627057ef'),(18,'saveassetinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','349e40d9-299b-4f78-bee3-aa159530b771'),(19,'createfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','2e76ca58-3c7d-407e-b56d-35630a8f5959'),(20,'deletefilesandfoldersinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','7213281d-1d10-415d-bf8c-daef2f42e8e4'),(21,'replacefilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','082ad26a-b638-4724-92cd-89adf4a383a3'),(22,'editimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','e62b9f36-b2ba-4036-9bc0-6691b0d2ed42'),(23,'editpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','d2c310d1-4202-4c22-bce5-724a182afe78'),(24,'replacepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','66548b71-78e7-48b1-b83f-21bce909a7cb'),(25,'deletepeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','f4031950-5ead-4d53-a869-3490910b66a8'),(26,'editpeerimagesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','81748b9d-515a-4c39-bbb7-1a7266ea14bc'),(27,'viewpeerfilesinvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','614935f0-a9e6-4b3e-97f3-13dd868237ea'),(28,'viewvolume:e06bad3e-e63c-49ac-b605-164d334f58f8','2021-05-24 00:08:00','2021-05-24 00:08:00','194a14b6-be87-4b98-b06f-ea814cfd1079'),(29,'saveassetinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','7373ed66-1ff0-431e-a08b-5e40e1b0bd4e'),(30,'createfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','ad043755-a95d-4795-9e9c-d7421116a23a'),(31,'deletefilesandfoldersinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','02594a30-79aa-4456-85e0-a2cff2f58ef5'),(32,'replacefilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','0de14be1-9815-4f48-bb1a-8db1fe27f715'),(33,'editimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','d0b9c524-d1a2-4ef5-9a2b-fb7d80b14039'),(34,'editpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','60aaad19-f5a8-4100-8fc6-d64efbb83465'),(35,'replacepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','b74954b3-d33e-4cda-919e-adabe3766fff'),(36,'deletepeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','880d3076-cc0c-4d34-a506-588e50cce94f'),(37,'editpeerimagesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','481eb71e-308c-40f2-bf92-6a8cdb5cb2e4'),(38,'viewpeerfilesinvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','aee0f512-0239-43c7-978f-05574df67291'),(39,'viewvolume:6b51a275-7999-4ae0-bbde-0f0c7a4aad5c','2021-05-24 00:08:00','2021-05-24 00:08:00','13c3084a-7d63-4fcd-8172-a4937a30409a'),(40,'saveassetinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','95f46e85-7b8a-414b-bb44-a45d89ec1256'),(41,'editimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','35a92ed2-e2bf-4231-9d52-b71e0b1b6be0'),(42,'editpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','5fe24d5d-e0a8-4909-b09b-5f238e88055c'),(43,'editpeerimagesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','f7650826-7880-4589-9778-857f124f2e47'),(44,'viewpeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','e52fda84-cabf-4468-932e-503ef7f73c06'),(45,'viewvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','9ef4f90a-b347-4257-bc05-bf8db19b1091'),(46,'saveassetinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','7af6a180-7fc3-4d7a-a1a2-77fe4adccec7'),(47,'editimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','16cffa4c-d3f7-4326-92f8-39f4fc7a5cc6'),(48,'editpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','d7d4afb1-2f3a-47f6-b322-6314175ea44d'),(49,'editpeerimagesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','32fde28a-b983-4ea2-a28c-4bd1fed235c7'),(50,'viewpeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','eb4b75a0-3d98-48dd-bb45-e6e312c794b6'),(51,'viewvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','5043732c-7d23-4239-a3a9-9ddbc7ed88cc'),(52,'registerusers','2021-05-24 00:08:00','2021-05-24 00:08:00','9a0f9fb5-8e6c-45a1-8a84-c4bc1daf2f3a'),(53,'moderateusers','2021-05-24 00:08:00','2021-05-24 00:08:00','59b57917-328e-4d55-bcbc-85631a9aa65f'),(54,'assignuserpermissions','2021-05-24 00:08:00','2021-05-24 00:08:00','929240a3-56c3-45bf-98ac-c6e9f244eae6'),(55,'assignusergroup:fc194dfa-7273-44e9-8a76-201a431bd85a','2021-05-24 00:08:00','2021-05-24 00:08:00','e474c801-9a0c-43e1-a959-ff5d3c276011'),(56,'assignusergroups','2021-05-24 00:08:00','2021-05-24 00:08:00','a6d38299-7667-44ff-8ffb-6d73f0df5a22'),(57,'administrateusers','2021-05-24 00:08:00','2021-05-24 00:08:00','a2999cd2-4f57-48bd-9403-d5f2af4961e0'),(58,'impersonateusers','2021-05-24 00:08:00','2021-05-24 00:08:00','b4cae57b-1a1b-4e0a-9239-55ffde6ff20e'),(59,'editusers','2021-05-24 00:08:00','2021-05-24 00:08:00','126596a0-84c2-49f9-9fee-739439a5646f'),(60,'deleteusers','2021-05-24 00:08:00','2021-05-24 00:08:00','a5aa922d-8246-4ea7-8788-2c3bbe7e0bf9'),(61,'editglobalset:a2c771d3-8007-42be-a397-7945f01f2c44','2021-05-24 00:08:00','2021-05-24 00:08:00','f1d3c843-e631-4fa0-a56e-647866f297bc'),(62,'editglobalset:c17bf7df-73d2-4012-9f9e-a6078d9996ff','2021-05-24 00:08:00','2021-05-24 00:08:00','4ecbbfe2-0f73-4fe5-a0b8-2c71b8100f7c'),(63,'editglobalset:6a16e864-cae2-42df-95cc-3834afcfe89b','2021-05-24 00:08:00','2021-05-24 00:08:00','0d8d74de-a045-433e-81d3-e2766080ab71'),(64,'createfoldersinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','8d01c4cf-b77e-409c-ba42-f6a9d3317850'),(65,'deletefilesandfoldersinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','812321b7-841a-4bc0-bdc4-34601d72716d'),(66,'replacefilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','fe02e4b0-fee8-4856-ae43-b90a21aa2662'),(67,'replacepeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','1418ce7e-152c-44ec-b514-0a96a0e6d292'),(68,'deletepeerfilesinvolume:35b5ffbd-9878-4e66-8a46-11adf9162b06','2021-05-24 00:08:00','2021-05-24 00:08:00','c2dd3040-1651-4e2d-b291-ec705b3943d0'),(69,'createfoldersinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','8e48ee4d-8bf2-4bb9-8113-1ee78e70469c'),(70,'deletefilesandfoldersinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','67a1bedf-0c34-4b7d-a4cb-fde913e0c4d1'),(71,'replacefilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','e3bb316b-41a7-41c4-80ac-fdae3fb94e07'),(72,'replacepeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','3da2f2f3-d511-43fd-a344-88ee78ec013e'),(73,'deletepeerfilesinvolume:007cf408-5171-4608-bb10-37e9d01c33e7','2021-05-24 00:08:00','2021-05-24 00:08:00','ff026c2a-9eee-4db7-a512-28a2c5ee2f14'),(74,'retour:dashboard','2021-05-24 00:08:00','2021-05-24 00:08:00','f6a9d044-4a9e-4395-861a-3d87345c339e'),(75,'retour:redirects','2021-05-24 00:08:00','2021-05-24 00:08:00','29689d52-9037-4946-8353-15500c99f6fe'),(76,'seomatic:dashboard','2021-05-24 00:08:00','2021-05-24 00:08:00','3021c4de-b08f-4036-b5e8-1856203583e1');
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpermissions_usergroups` VALUES (1,1,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','57f07548-d511-43c8-8582-cf0b69707f1e'),(2,2,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','0d047b52-4168-4444-95ae-b4a8ddbfdb99'),(3,3,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7b350e7b-b891-47a7-9115-60aad8995d9c'),(4,4,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','1ada2abe-55f3-4774-aa54-2430bdde019d'),(5,5,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','ab6140d2-c709-40ca-b489-cd3e6808ae69'),(6,6,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','e2989a6b-e6cf-4e43-87af-39438b860873'),(7,7,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','c8a50f60-e423-4273-9c19-8bf7a0d805fb'),(8,8,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','edc3be29-4659-4877-8bc0-fd65d69a055a'),(9,9,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','8e3ffcc3-910f-4342-800e-a620fb7fcbeb'),(10,10,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','addd6bdb-f277-431a-a4b7-60f31dc6bcb1'),(11,11,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','870ad1b2-abde-4bbc-b583-4befa5012d57'),(12,12,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','23670cd5-6cca-47b2-a4a5-37845b43da9f'),(13,13,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','ce9a4ad6-af85-4de0-a372-931be85e005a'),(14,14,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','d1471110-02d3-485f-83d6-53869a4077c6'),(15,15,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','930a95ee-9e59-41f5-8293-c5cb57b27d2f'),(16,16,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','f467c8cb-5dfd-45b8-a069-0378d0b804a6'),(17,17,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','98dfb7bc-4f3b-46f6-a0d5-4ff0f31ec79e'),(18,18,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','edac2f41-3a55-4fb8-b721-358e41590ace'),(19,19,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','4e4387ad-59a0-4248-bf43-2dcb9e13854e'),(20,20,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','a30f930d-b73f-46a0-be72-6d473d4d8a4d'),(21,21,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','5d6dded6-72b9-4317-9e11-d16781004dd0'),(22,22,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','626687ae-07f0-4cfe-b563-44a406b78c97'),(23,23,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','1c2c86bd-abaf-4db8-8f92-779cc034e111'),(24,24,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','d2683865-16de-4f2d-84ab-64ff4ed65393'),(25,25,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','5f9ac8a8-1045-4045-b65b-8c92c76da82f'),(26,26,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','5578d022-c29e-4059-8417-ba66b031f547'),(27,27,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','b84f0ca2-74af-489b-84ef-1eb466a789d3'),(28,28,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','0eb27c8c-0e0b-4498-95f8-0d0e0a140bc5'),(29,29,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','b0752205-0446-4726-8b0c-da0a8ea7f6e9'),(30,30,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','5c329cee-e14b-48ab-aecc-8d8012daf758'),(31,31,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','5e66ed25-71bb-418f-b12c-db2c927c7d90'),(32,32,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','f86e8141-25eb-459b-a0d9-21229afe6df3'),(33,33,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','49b309c1-45bf-494d-bca0-c68489409de4'),(34,34,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','e16b22bc-78d8-431b-bbaa-0b9ad952ca2b'),(35,35,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','ecfb78f2-1265-4547-9e93-96bbc2ea6daa'),(36,36,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','794dbf6e-0e09-4476-9641-1ad190cbbf98'),(37,37,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','3578ef7b-2c72-4df1-ad48-e9770ba3dd1f'),(38,38,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','d99e6ca0-e33b-4423-ab9a-fe3781cefa70'),(39,39,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','2e713f46-3d8b-45d2-9ad9-f8f735fc2347'),(40,40,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','ae0a006d-d6d5-4f3b-bce7-48b81b9c2eaa'),(41,41,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','6b6ceb07-b58e-4307-9700-5f8dff4a20e6'),(42,42,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7bf6bfe7-b354-4c1e-9f59-be353009c1ca'),(43,43,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7347a0b3-0cfc-4592-aa82-6e21bb85b4a4'),(44,44,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','8d63aca8-a6f7-4312-bf55-ab4f37ce639a'),(45,45,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','34d6e951-12ba-4d99-8b8c-c6d631a20607'),(46,46,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','8c677cd7-6262-4d3a-a07f-2febffcbf845'),(47,47,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7bbed0bf-0c2a-4b22-947b-e7717c17a424'),(48,48,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','7e89dbcb-261c-4167-b781-a421730b7523'),(49,49,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','06cec13e-5ae6-46ca-9065-8a253f0305c1'),(50,50,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','0c57bb20-d406-47b6-a1a6-4f6e8e1a1e03'),(51,51,1,'2021-05-24 00:08:00','2021-05-24 00:08:00','bfef9686-e50c-42e7-80d8-11d5cab432f1'),(52,1,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','d0b7dc76-ea27-4467-b8db-7245f3b85fe4'),(53,2,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','7e52d322-91a9-45d3-9a57-2e060da0b412'),(54,52,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','81afdb65-77aa-4776-a7c0-a09f10d81d12'),(55,53,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','f7d98938-0d08-4ea9-b956-16b330522674'),(56,54,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','60d64e67-146a-44cb-8861-c8a7df021c4c'),(57,55,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5d0862ae-a77b-42af-821d-0d0e059acf51'),(58,56,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','cfa3f571-8371-42df-b09b-4b6d188fbcca'),(59,57,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','60fa2a0e-6e9c-4df3-8d33-3195401c4dcc'),(60,58,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','16f50b98-a220-4790-ae18-d19f6eba329c'),(61,59,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','ffe8eb29-a7c5-4af6-996e-cfa65421bac3'),(62,60,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','35726086-b941-4e3f-bc45-14f6c417e11f'),(63,3,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','c1e0e86f-1d6c-4cea-8042-28233b454433'),(64,4,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5e0cad2e-c4bf-4762-abbf-a4c160a5361d'),(65,5,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','c8e87fed-8286-4b6c-827e-a4b4114475fd'),(66,6,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','c3f19094-328a-4b5b-9501-c392fae81cf2'),(67,7,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','1c87082d-dd62-4283-9042-b4fbf3b7d61b'),(68,8,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','9d1ae033-9083-42d4-9a32-b82e50a3aba0'),(69,9,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','142be494-ce20-4fba-94e1-f48a773c46ff'),(70,10,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','005da5e8-acbe-4e3c-9556-3048c3977b8d'),(71,11,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','8eb537aa-b2b2-4828-a006-41454e87bfd6'),(72,12,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','947715cb-ef80-47ea-a3b0-295f7d211e5f'),(73,13,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','397ac97d-1470-462d-9dec-938f3277eda7'),(74,14,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','92802d38-fa85-4f3a-9941-493c3d01d829'),(75,15,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','694e0a80-96fb-4dc0-892e-798308fc41b2'),(76,16,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5017ff39-8bbd-48a3-8304-99e581f7ffc1'),(77,17,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','e5280e5b-ae76-415b-8fb9-d61c694f520d'),(78,61,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','d6cef7ce-7a9c-4b32-8abb-b7663e7b0e89'),(79,62,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','8f9c9ed6-31e9-478e-8c92-4b340e43aa01'),(80,63,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5ffb3ecb-ea9c-4a72-a3da-b0077d4e5862'),(81,18,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','4f4ed858-d9b9-49f9-924c-a15a15073f1f'),(82,19,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','a1837144-81a6-423e-ace3-8bf095b05c40'),(83,20,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','7d0f580a-3235-438c-89a0-a5bf0b2d8a1c'),(84,21,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','9e48950c-27af-479e-957c-61186a745990'),(85,22,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','dcd6c987-85ae-4628-a695-f6cc6e3b1b49'),(86,23,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','284abed0-ecba-440f-8385-0255ebe6bc43'),(87,24,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','a1526a58-151a-41c8-94db-a4c799b6cf97'),(88,25,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','2b30f765-1054-449f-bb13-8e2adee3ccd4'),(89,26,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','b5a03901-2382-4c9f-aa5e-d8f85452c9f7'),(90,27,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','e8658b28-916e-4572-853e-a4ac07fba61b'),(91,28,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','bfc83701-386f-4db0-9f1b-17a20eee5b21'),(92,29,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','0eadaa60-debe-4d6d-8fc5-9df66ad2f7df'),(93,30,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','f3ef7951-decf-4962-9480-2d65c1d53cd5'),(94,31,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','a35a1583-eaed-4b87-bb6a-ddcbac6faacf'),(95,32,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5244fbce-ae3c-4631-8585-c208c5b42c5f'),(96,33,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','c311d542-e42e-4d3d-b4e5-a0c9406a5165'),(97,34,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','7bb2275a-5d6b-4872-97ef-77c64acf1a36'),(98,35,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','8c562f78-1ed6-41cd-81f4-26fbd07a4092'),(99,36,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','fe9ae53e-9651-4b15-a6ba-449ee773350e'),(100,37,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','cf241681-4475-4686-bbb4-9666cfe912b3'),(101,38,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','a1242d94-9237-4194-aa41-3b4ae60fe3e9'),(102,39,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','1788619f-86e7-4d54-9cfb-df548719246d'),(103,40,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','2d3c7d5a-f39d-4e90-bf1a-17a9f87e4b28'),(104,64,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','f0f04ac4-9030-48f8-a9e3-1f69b337fa00'),(105,65,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','3881b145-85ea-4251-9b27-da37275b2c9d'),(106,66,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','f91001eb-90ef-4954-9771-d9a330647a2e'),(107,41,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','5e46cb33-d02f-461f-b8c1-fc3027942e80'),(108,42,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','a8c10e3a-5abb-442c-a749-8630612410f2'),(109,67,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','cfbf921d-84ea-41f7-8ea0-0fbc782917f7'),(110,68,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','77847302-51d3-4978-901a-6217c9395281'),(111,43,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','e22347d9-22d6-458c-b77c-e83d79122cf3'),(112,44,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','ba14b518-da50-48ad-aa8c-83d99dfb35dd'),(113,45,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','441f55d4-fc98-4eab-8efd-f5bac5dc016c'),(114,46,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','76d3649b-dfbc-4a89-8835-6fd81d58905c'),(115,69,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','6bd9581e-dee5-4b2c-a364-9d10d420bd05'),(116,70,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','3ba9ffc4-27f3-4c2f-ab16-7216a9cd53fe'),(117,71,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','df76b250-3202-4e9b-be0c-ac124ad179d2'),(118,47,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','e1e37d5c-8288-4d13-ad97-a54f8c716d16'),(119,48,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','809b6f9c-8dc0-435d-877b-d5e47ba0957d'),(120,72,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','da9c191a-07f2-44b0-9625-86725d0fff06'),(121,73,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','126c2443-a945-4ebe-b54a-fd0a758453b4'),(122,49,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','56171c62-370c-48d6-ae34-104da3013999'),(123,50,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','b0e3dfe3-690b-4ba0-96ee-82e8e21b8e57'),(124,51,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','4cb1ba6f-ebfb-4bf1-9ffb-59655513abb0'),(125,74,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','65663842-ae56-4f30-beaf-02a648be74ce'),(126,75,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','92c31a9e-a26f-4b7b-88bc-df32fd4f4ff8'),(127,76,2,'2021-05-24 00:08:00','2021-05-24 00:08:00','63b714f7-2047-4784-b4cb-46919b040618');
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (10,'{\"language\":\"en-GB\",\"locale\":null,\"weekStartDay\":\"1\",\"useShapes\":false,\"underlineLinks\":false,\"showFieldHandles\":true,\"enableDebugToolbarForSite\":true,\"enableDebugToolbarForCp\":true,\"showExceptionView\":false,\"profileTemplates\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (10,'dew.internet@sa.gov.au',NULL,'','','dew.internet@sa.gov.au','$2y$13$vNhOtoo7cIt351UVouxMVedY9XbaIgI9wD0BID96NNmG63T0AUP8a',1,0,0,0,'2021-05-25 00:28:52',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2021-05-24 00:08:02','2021-05-24 00:08:02','2021-05-25 03:31:36','0ae2b90c-515e-4fdb-ae4f-c71b41731a27');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Shared images','','2021-05-24 00:08:00','2021-05-24 00:08:00','1f0f4a77-6739-420f-87db-a8ed40850b1a'),(2,NULL,2,'Site images','','2021-05-24 00:08:00','2021-05-24 00:08:00','a4c11ef7-5653-4fb0-b49b-b5009908f913'),(3,NULL,3,'Site documents','','2021-05-24 00:08:00','2021-05-24 00:08:00','ae5617b2-2f93-40b3-a5cd-ad22d023f0ed'),(4,NULL,4,'Shared documents','','2021-05-24 00:08:00','2021-05-24 00:08:00','f04957c6-f01f-4ab5-bbd8-8efdb541fa7e'),(5,1,1,'AOC','AOC/','2021-05-24 23:26:49','2021-05-24 23:26:49','accd72fb-4fe9-497e-88ad-52cecf0bd41c'),(6,NULL,NULL,'Temporary source',NULL,'2021-05-25 00:47:17','2021-05-25 00:47:17','79276663-f16c-4748-943f-42ea34803c33'),(7,6,NULL,'user_10','user_10/','2021-05-25 00:47:17','2021-05-25 00:47:17','321b9cfb-c3e6-4fac-a2d7-4d5234aec1f5'),(8,1,1,'logos','logos/','2021-05-25 05:23:37','2021-05-25 05:23:37','28395e90-11f2-483c-bf03-5668c02d2f19'),(9,NULL,5,'Shared images','','2021-05-25 06:34:28','2021-05-25 06:34:28','6bf63ec2-063c-4706-bf17-271f72afd86d'),(10,9,5,'Logos','Logos/','2021-05-25 06:35:03','2021-05-25 06:35:03','a8a91f53-a1be-4d4b-a253-eba92180fba3'),(11,9,5,'AOC','AOC/','2021-05-25 06:35:03','2021-05-25 06:35:03','9aa76752-2af9-4d28-bf56-cf68552bdc1d'),(12,4,4,'AOC','AOC/','2021-05-25 07:35:40','2021-05-25 07:35:40','100804d2-969f-4548-9ef2-ec0e7d01f4e5'),(13,9,5,'Favicons','Favicons/','2021-05-25 07:35:46','2021-05-25 07:35:46','ab118e14-9f5e-41d3-8a55-2dcaa77c4af4');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,1,'Shared images','sharedImages','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','site',NULL,'{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"6 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"shared/images\"}',0,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 06:26:29','35b5ffbd-9878-4e66-8a46-11adf9162b06'),(2,3,'Site images','siteImages','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','site',NULL,'{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"3 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"1\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"$S3_IMAGES\"}',0,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 00:48:06','e06bad3e-e63c-49ac-b605-164d334f58f8'),(3,7,'Site documents','siteDocuments','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','site',NULL,'{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"12 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"$S3_DOCS\"}',0,'2021-05-24 00:08:00','2021-05-24 00:08:00','2021-05-25 00:48:12','6b51a275-7999-4ae0-bbde-0f0c7a4aad5c'),(4,9,'Shared documents','sharedDocuments','craft\\awss3\\Volume',1,'$CLOUDFRONT_URL','site',NULL,'{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"12 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"shared/docs/\"}',1,'2021-05-24 00:08:00','2021-05-24 00:08:00',NULL,'007cf408-5171-4608-bb10-37e9d01c33e7'),(5,21,'Shared images','sharedImages','craft\\awss3\\Volume',1,'@cloudfrontUrl','site',NULL,'{\"addSubfolderToRootUrl\":\"1\",\"autoFocalPoint\":\"\",\"bucket\":\"$S3_BUCKET\",\"bucketSelectionMode\":\"manual\",\"cfDistributionId\":\"$CLOUDFRONT_DISTRIBUTION_ID\",\"cfPrefix\":\"$CLOUDFRONT_PATH_PREFIX\",\"expires\":\"6 months\",\"keyId\":\"$S3_KEY_ID\",\"makeUploadsPublic\":\"\",\"region\":\"$S3_REGION\",\"secret\":\"$S3_SECRET\",\"storageClass\":\"\",\"subfolder\":\"shared/images/\"}',2,'2021-05-25 06:34:28','2021-05-25 06:34:28',NULL,'37e0968a-18b5-4f97-b792-d34a431b19fd');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,10,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":1,\"section\":\"*\",\"limit\":10}',1,'2021-05-24 06:12:20','2021-05-24 06:12:20','43aa111a-f06e-447a-80bc-03b83a3ed45e'),(2,10,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2021-05-24 06:12:20','2021-05-24 06:12:20','4f6ddbd0-5de2-488b-b42b-b87d10e09d3f'),(3,10,'craft\\widgets\\Updates',3,NULL,'[]',1,'2021-05-24 06:12:20','2021-05-24 06:12:20','c8b24510-eacd-480f-a60b-7241be7ddca4'),(4,10,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2021-05-24 06:12:20','2021-05-24 06:12:20','f75b0629-a9e0-43e5-86b2-0c7299ee7669');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'newapp'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-25  7:40:56
