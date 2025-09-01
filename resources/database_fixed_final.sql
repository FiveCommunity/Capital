-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           11.8.3-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para five_roleplay
DROP DATABASE IF EXISTS `five_roleplay`;
CREATE DATABASE IF NOT EXISTS `five_roleplay` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `five_roleplay`;

-- Copiando estrutura para tabela five_roleplay.bank_fines
DROP TABLE IF EXISTS `bank_fines`;
CREATE TABLE IF NOT EXISTS `bank_fines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `value` bigint(20) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.bank_pixs
DROP TABLE IF EXISTS `bank_pixs`;
CREATE TABLE IF NOT EXISTS `bank_pixs` (
  `user_id` int(11) NOT NULL,
  `pix` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `pix` (`pix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.bank_statements
DROP TABLE IF EXISTS `bank_statements`;
CREATE TABLE IF NOT EXISTS `bank_statements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `value` bigint(20) NOT NULL,
  `type` varchar(8) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.banneds
DROP TABLE IF EXISTS `banneds`;
CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `days` int(11) NOT NULL,
  `ban_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `staff` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.blacklist
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE IF NOT EXISTS `blacklist` (
  `user_id` int(11) NOT NULL,
  `org` varchar(50) NOT NULL,
  `expires` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.business
DROP TABLE IF EXISTS `business`;
CREATE TABLE IF NOT EXISTS `business` (
  `business_name` varchar(50) NOT NULL,
  `business_owner` int(11) NOT NULL,
  `business_safe` bigint(20) NOT NULL DEFAULT 0,
  `business_rental` varchar(50) NOT NULL,
  PRIMARY KEY (`business_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.clothes
DROP TABLE IF EXISTS `clothes`;
CREATE TABLE IF NOT EXISTS `clothes` (
  `title` varchar(50) NOT NULL,
  `preset` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`title`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.courses
DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `course` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.dealership
DROP TABLE IF EXISTS `dealership`;
CREATE TABLE IF NOT EXISTS `dealership` (
  `car` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `dealer` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`car`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.dynamic
DROP TABLE IF EXISTS `dynamic`;
CREATE TABLE IF NOT EXISTS `dynamic` (
  `user_id` int(10) unsigned NOT NULL,
  `action` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`,`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.fine
DROP TABLE IF EXISTS `fine`;
CREATE TABLE IF NOT EXISTS `fine` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `fine_reason` varchar(50) NOT NULL,
  `fine_value` bigint(20) NOT NULL,
  `fine_time` varchar(50) NOT NULL,
  `fine_description` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.homes
DROP TABLE IF EXISTS `homes`;
CREATE TABLE IF NOT EXISTS `homes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `home` varchar(50) NOT NULL DEFAULT '',
  `home_owner` tinyint(4) NOT NULL DEFAULT 0,
  `garages` tinyint(4) NOT NULL DEFAULT 0,
  `tax` varchar(20) NOT NULL DEFAULT '0',
  `configs` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `residents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `vip` tinyint(4) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `interior` varchar(50) NOT NULL DEFAULT '',
  `blip` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `spawn` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_home` (`home`),
  KEY `idx_price` (`price`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.homes_garages
DROP TABLE IF EXISTS `homes_garages`;
CREATE TABLE IF NOT EXISTS `homes_garages` (
  `home` varchar(50) NOT NULL DEFAULT '',
  `blip` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `spawn` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `max_vehicles` int(11) NOT NULL DEFAULT 2,
  PRIMARY KEY (`home`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.homes_wardrobe
DROP TABLE IF EXISTS `homes_wardrobe`;
CREATE TABLE IF NOT EXISTS `homes_wardrobe` (
  `home` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `preset` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`home`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.identity
DROP TABLE IF EXISTS `identity`;
CREATE TABLE IF NOT EXISTS `identity` (
  `user_id` int(10) unsigned NOT NULL,
  `url` text NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.inventory
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `identifier` varchar(50) NOT NULL,
  `items` longtext NOT NULL,
  `max_slots` int(11) NOT NULL DEFAULT 30,
  `max_weight` int(11) NOT NULL DEFAULT 100,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.mdt
DROP TABLE IF EXISTS `mdt`;
CREATE TABLE IF NOT EXISTS `mdt` (
  `mdt_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `value` text NOT NULL DEFAULT '',
  `data` varchar(50) NOT NULL DEFAULT '',
  `info` text NOT NULL DEFAULT '',
  `officer` varchar(50) NOT NULL,
  PRIMARY KEY (`mdt_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_last_phone
DROP TABLE IF EXISTS `phone_last_phone`;
CREATE TABLE IF NOT EXISTS `phone_last_phone` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_notifications
DROP TABLE IF EXISTS `phone_notifications`;
CREATE TABLE IF NOT EXISTS `phone_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `show_avatar` tinyint(1) DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_phones
DROP TABLE IF EXISTS `phone_phones`;
CREATE TABLE IF NOT EXISTS `phone_phones` (
  `id` varchar(100) NOT NULL,
  `owner_id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pin` varchar(4) DEFAULT NULL,
  `face_id` varchar(100) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `is_setup` tinyint(1) DEFAULT 0,
  `assigned` tinyint(1) DEFAULT 0,
  `battery` int(11) NOT NULL DEFAULT 100,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_phone_blocked_numbers
DROP TABLE IF EXISTS `phone_phone_blocked_numbers`;
CREATE TABLE IF NOT EXISTS `phone_phone_blocked_numbers` (
  `phone_number` varchar(15) NOT NULL,
  `blocked_number` varchar(15) NOT NULL,
  PRIMARY KEY (`phone_number`,`blocked_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_phone_calls
DROP TABLE IF EXISTS `phone_phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_phone_calls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `answered` tinyint(1) DEFAULT 0,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_caller` (`caller`),
  KEY `idx_callee` (`callee`),
  KEY `idx_calls_missed` (`callee`,`answered`),
  KEY `idx_calls_callee_id` (`callee`),
  KEY `idx_calls_caller_id` (`caller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_phone_contacts
DROP TABLE IF EXISTS `phone_phone_contacts`;
CREATE TABLE IF NOT EXISTS `phone_phone_contacts` (
  `contact_phone_number` varchar(15) NOT NULL,
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `profile_image` varchar(500) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  `phone_number` varchar(15) NOT NULL,
  PRIMARY KEY (`contact_phone_number`,`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_phone_voicemail
DROP TABLE IF EXISTS `phone_phone_voicemail`;
CREATE TABLE IF NOT EXISTS `phone_phone_voicemail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `url` varchar(500) NOT NULL,
  `duration` int(11) NOT NULL,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.phone_photo_albums
DROP TABLE IF EXISTS `phone_photo_albums`;
CREATE TABLE IF NOT EXISTS `phone_photo_albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_number` (`phone_number`),
  CONSTRAINT `phone_photo_albums_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.pix
DROP TABLE IF EXISTS `pix`;
CREATE TABLE IF NOT EXISTS `pix` (
  `user_id` int(10) unsigned NOT NULL,
  `chave` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.relationship
DROP TABLE IF EXISTS `relationship`;
CREATE TABLE IF NOT EXISTS `relationship` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_1` int(10) unsigned NOT NULL,
  `user_2` int(10) unsigned NOT NULL,
  `relation` varchar(50) NOT NULL,
  `start_relationship` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_1` (`user_1`),
  KEY `idx_user_2` (`user_2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.skins_players
DROP TABLE IF EXISTS `skins_players`;
CREATE TABLE IF NOT EXISTS `skins_players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `skin` longtext NOT NULL,
  `owned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.spray
DROP TABLE IF EXISTS `spray`;
CREATE TABLE IF NOT EXISTS `spray` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `interior` tinyint(4) NOT NULL,
  `x` float(8,4) NOT NULL,
  `y` float(8,4) NOT NULL,
  `z` float(8,4) NOT NULL,
  `rx` float(8,4) NOT NULL,
  `ry` float(8,4) NOT NULL,
  `rz` float(8,4) NOT NULL,
  `scale` float(8,4) NOT NULL,
  `spray_text` varchar(10) NOT NULL,
  `font` varchar(32) NOT NULL,
  `color` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.srv_data
DROP TABLE IF EXISTS `srv_data`;
CREATE TABLE IF NOT EXISTS `srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.tebex
DROP TABLE IF EXISTS `tebex`;
CREATE TABLE IF NOT EXISTS `tebex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `product` varchar(100) NOT NULL,
  `method` varchar(50) NOT NULL,
  `executed` tinyint(4) NOT NULL DEFAULT 0,
  `execution_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `steam` varchar(20) NOT NULL DEFAULT '',
  `whitelist` tinyint(4) NOT NULL DEFAULT 0,
  `banned` tinyint(4) NOT NULL DEFAULT 0,
  `chars` int(11) DEFAULT 1,
  `priority` int(11) DEFAULT 0,
  `ip` varchar(15) NOT NULL DEFAULT '0.0.0.0',
  `discord` varchar(255) DEFAULT NULL,
  `al_premium` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`,`steam`) USING BTREE,
  UNIQUE KEY `steam_unique` (`steam`),
  KEY `idx_users_steam` (`steam`),
  KEY `idx_users_whitelist` (`whitelist`),
  KEY `idx_users_banned` (`banned`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_characters
DROP TABLE IF EXISTS `user_characters`;
CREATE TABLE IF NOT EXISTS `user_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(20) NOT NULL,
  `firstname` varchar(16) NOT NULL,
  `lastname` varchar(16) NOT NULL,
  `age` int(11) NOT NULL,
  `registration` varchar(8) NOT NULL,
  `phone` varchar(7) NOT NULL,
  `rh` varchar(3) NOT NULL,
  `drive_license` varchar(255) NOT NULL DEFAULT '{}',
  `garages` int(11) NOT NULL DEFAULT 1,
  `homes` int(11) NOT NULL DEFAULT 1,
  `last_login` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `registration` (`registration`),
  UNIQUE KEY `phone` (`phone`),
  KEY `idx_steam` (`steam`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_data
DROP TABLE IF EXISTS `user_data`;
CREATE TABLE IF NOT EXISTS `user_data` (
  `user_id` int(10) unsigned NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_datatable
DROP TABLE IF EXISTS `user_datatable`;
CREATE TABLE IF NOT EXISTS `user_datatable` (
  `user_id` int(10) unsigned NOT NULL,
  `user_character` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_tattoo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_clothes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `reset_character` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_groups
DROP TABLE IF EXISTS `user_groups`;
CREATE TABLE IF NOT EXISTS `user_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` varchar(50) NOT NULL,
  `grade_id` varchar(50) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `expire` varchar(20) DEFAULT '0',
  `last_service` datetime DEFAULT NULL,
  `hours_worked` time DEFAULT '00:00:00',
  `hours_worked_week` time DEFAULT '00:00:00',
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_ids
DROP TABLE IF EXISTS `user_ids`;
CREATE TABLE IF NOT EXISTS `user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`identifier`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_moneys
DROP TABLE IF EXISTS `user_moneys`;
CREATE TABLE IF NOT EXISTS `user_moneys` (
  `user_id` int(10) unsigned NOT NULL,
  `bank` bigint(20) unsigned NOT NULL DEFAULT 0,
  `paypal` bigint(20) unsigned NOT NULL DEFAULT 0,
  `coins` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_pets
DROP TABLE IF EXISTS `user_pets`;
CREATE TABLE IF NOT EXISTS `user_pets` (
  `user_id` int(11) NOT NULL,
  `breed` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `water` decimal(5,2) NOT NULL DEFAULT 0.00,
  `food` decimal(5,2) NOT NULL DEFAULT 0.00,
  `vip` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`breed`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_tokens
DROP TABLE IF EXISTS `user_tokens`;
CREATE TABLE IF NOT EXISTS `user_tokens` (
  `token` varchar(100) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `idx_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.user_vehicles
DROP TABLE IF EXISTS `user_vehicles`;
CREATE TABLE IF NOT EXISTS `user_vehicles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `vehicle` varchar(50) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `service` tinyint(4) NOT NULL DEFAULT 0,
  `detained` int(10) NOT NULL DEFAULT 0,
  `ipva` int(11) NOT NULL DEFAULT 0,
  `rented` int(11) NOT NULL DEFAULT -1,
  `state` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `custom` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'null',
  `share_user` int(11) NOT NULL DEFAULT -1,
  `share_expires` int(11) NOT NULL DEFAULT -1,
  `tracker` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`) USING BTREE,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_share_user` (`share_user`),
  KEY `idx_vehicles_user` (`user_id`),
  KEY `idx_vehicles_plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela five_roleplay.weazel
DROP TABLE IF EXISTS `weazel`;
CREATE TABLE IF NOT EXISTS `weazel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext NOT NULL,
  `description` longtext NOT NULL,
  `author` varchar(255) NOT NULL,
  `video` longtext NOT NULL,
  `img` longtext NOT NULL,
  `visualizations` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
