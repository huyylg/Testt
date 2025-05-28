SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;

DROP TABLE IF EXISTS `_bof_ads`;
CREATE TABLE IF NOT EXISTS `_bof_ads` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL CHECK (json_valid(`data`)),
  `url` text DEFAULT NULL,
  `place_id` varchar(60) DEFAULT NULL,
  `fund_total` float DEFAULT 0,
  `fund_spent` float DEFAULT 0,
  `fund_remain` float DEFAULT 0,
  `fund_limit` float DEFAULT 0,
  `fund_spent_day` float DEFAULT 0,
  `fund_spent_day_code` varchar(6) DEFAULT NULL,
  `sta_clicks` int(11) DEFAULT 0,
  `sta_views` int(11) DEFAULT 0,
  `active` int(1) NOT NULL DEFAULT 1,
  `time_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `type` (`type`),
  KEY `place_id` (`place_id`),
  KEY `active` (`active`),
  KEY `fund_remain` (`fund_remain`),
  KEY `fund_limit` (`fund_limit`),
  KEY `fund_spent_day` (`fund_spent_day`),
  KEY `fund_spent_day_code` (`fund_spent_day_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_blacklist`;
CREATE TABLE IF NOT EXISTS `_bof_blacklist` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `object_type` varchar(50) NOT NULL,
  `code` varchar(150) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `object_type_2` (`object_type`,`code`),
  KEY `object_type` (`object_type`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_cache_db`;
CREATE TABLE IF NOT EXISTS `_bof_cache_db` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `query_hash` varchar(32) NOT NULL,
  `params_hash` varchar(32) DEFAULT NULL,
  `results` longblob DEFAULT NULL,
  `used` int(9) DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_used` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `time_expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `query_hash` (`query_hash`),
  KEY `params_hash` (`params_hash`),
  KEY `__select` (`query_hash`,`params_hash`,`time_add`) USING BTREE,
  KEY `time_add` (`time_add`),
  KEY `time_expire` (`time_expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_cache_files_access`;
CREATE TABLE IF NOT EXISTS `_bof_cache_files_access` (
  `action` varchar(10) NOT NULL DEFAULT 'stream',
  `object_type` varchar(20) NOT NULL,
  `object_hash` varchar(32) NOT NULL,
  `source_hash` varchar(32) NOT NULL,
  `path_hash` varchar(32) NOT NULL,
  `key1` varchar(32) NOT NULL,
  `key2` varchar(32) NOT NULL,
  `key3` varchar(32) NOT NULL,
  `user_agent` text NOT NULL,
  `user_ip` tinytext NOT NULL,
  `downloads` int(11) NOT NULL DEFAULT 0,
  `downloads_max` int(11) DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_expire` timestamp NULL DEFAULT NULL,
  KEY `object_type` (`object_type`,`object_hash`,`source_hash`,`path_hash`,`key1`,`key2`,`key3`),
  KEY `time_expire` (`time_expire`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_cache_sessions`;
CREATE TABLE IF NOT EXISTS `_bof_cache_sessions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(60) NOT NULL,
  `push_id` tinytext DEFAULT NULL,
  `user_id` int(7) NOT NULL,
  `ip` varchar(18) NOT NULL,
  `ip_country` varchar(30) DEFAULT NULL,
  `platform_type` varchar(30) NOT NULL,
  `device_type` varchar(30) DEFAULT NULL,
  `data` blob DEFAULT NULL,
  `time_online` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `active` int(1) DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `session_id` (`session_id`),
  KEY `user_id` (`user_id`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_cache_sessions_admin`;
CREATE TABLE IF NOT EXISTS `_bof_cache_sessions_admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(60) NOT NULL,
  `push_id` tinytext DEFAULT NULL,
  `user_id` int(7) NOT NULL,
  `ip` varchar(18) NOT NULL,
  `ip_country` varchar(30) DEFAULT NULL,
  `platform_type` varchar(30) NOT NULL,
  `device_type` varchar(30) DEFAULT NULL,
  `data` blob DEFAULT NULL,
  `time_online` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `active` int(1) DEFAULT 1,
  `_time_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `session_id` (`session_id`),
  KEY `user_id` (`user_id`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_cache_stream_royalties`;
CREATE TABLE IF NOT EXISTS `_bof_cache_stream_royalties` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(30) NOT NULL,
  `target_id` int(11) NOT NULL,
  `time_end` timestamp NOT NULL,
  `sta_plays` int(11) NOT NULL DEFAULT 0,
  `sta_plays_unique` int(11) NOT NULL DEFAULT 0,
  `sta_paid` float NOT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `target_id` (`target_id`),
  KEY `time_end` (`time_end`),
  KEY `target_type` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_currencies`;
CREATE TABLE IF NOT EXISTS `_bof_currencies` (
  `ID` int(4) NOT NULL AUTO_INCREMENT,
  `code` varchar(60) NOT NULL,
  `type` varchar(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `iso_code` varchar(3) NOT NULL,
  `symbol` varchar(100) NOT NULL,
  `format` varchar(20) NOT NULL,
  `active` int(1) NOT NULL DEFAULT 1,
  `_default` int(1) NOT NULL DEFAULT 0,
  `exchange_rate` float DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `code` (`code`),
  KEY `iso_code` (`iso_code`),
  KEY `active` (`active`),
  KEY `_default` (`_default`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_bof_currencies` (`ID`, `code`, `type`, `name`, `iso_code`, `symbol`, `format`, `active`, `_default`, `exchange_rate`, `time_add`) VALUES(1, 'unitedstatesdollar', 'n', 'United States Dollar', 'USD', '$', 'left_np_1', 1, 1, NULL, '2022-10-04 00:35:20');

DROP TABLE IF EXISTS `_bof_files`;
CREATE TABLE IF NOT EXISTS `_bof_files` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `pass` varchar(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  `host_id` int(11) DEFAULT NULL,
  `dest_host_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `path` tinytext NOT NULL,
  `name` tinytext DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `data` mediumtext DEFAULT NULL,
  `object_type` varchar(30) NOT NULL,
  `size` float DEFAULT NULL,
  `used` int(4) NOT NULL DEFAULT 0,
  `used_in` longtext DEFAULT NULL,
  `used_in_object` varchar(30) DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_moved` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `pass` (`pass`),
  KEY `type` (`type`),
  KEY `host_id` (`host_id`),
  KEY `user_id` (`user_id`),
  KEY `used` (`used`),
  KEY `object_type` (`object_type`),
  KEY `time_add` (`time_add`),
  KEY `time_used` (`time_moved`),
  KEY `used_in_object` (`used_in_object`),
  KEY `dest_host_id` (`dest_host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(1, '654701570c', 'image', 1, 0, 1, 'files/page_widget_bg/23/05/09/645a396cc2bec/0_rocket launch. monsters in the background_esrgan-v1-x2plus.png', '0_rocket launch. monsters in the background_esrgan-v1-x2plus', 'png', 'image/png', '{\"total_size\":1092595,\"width\":1024,\"height\":1024,\"size\":1092595,\"dominant_color\":{\"hex\":\"697477\",\"rgb\":\"105, 116, 119\"}}', 'page_widget_bg', 1092600, 1, 'page_widget65', 'page_widget', '2023-05-09 16:45:39', '2023-05-09 15:45:40');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(2, '450caac95e', 'image', 1, 0, 1, 'files/page_img/23/05/09/645a3985cc8f5/989898.png', '989898', 'png', 'image/png', '{\"total_size\":51809,\"width\":666,\"height\":671,\"size\":51809,\"dominant_color\":{\"hex\":\"6e6d75\",\"rgb\":\"110, 109, 117\"}}', 'page_img', 51809, 1, 'page_widget80', 'page_widget', '2023-05-09 16:46:04', '2023-05-09 15:46:05');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(3, '056e8a8249', 'image', 1, 0, 1, 'files/logo/23/05/09/645a39df015f7/63f3b1054e808.png', '63f3b1054e808', 'png', 'image/png', '{\"total_size\":10033,\"width\":554,\"height\":128,\"size\":10033,\"dominant_color\":{\"hex\":\"222222\",\"rgb\":\"34, 34, 34\"}}', 'logo', 10033, 1, 'st_logo', NULL, '2023-05-09 16:47:20', '2023-05-09 15:47:35');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(4, '0a16b038c0', 'image', 1, 0, 1, 'files/logo/23/05/09/645a39df12c2a/63f2773628e00.png', '63f2773628e00', 'png', 'image/png', '{\"total_size\":11126,\"width\":500,\"height\":116,\"size\":11126,\"dominant_color\":{\"hex\":\"0\",\"rgb\":\"0, 0, 0\"}}', 'logo', 11126, 1, 'st_secondary_logo', NULL, '2023-05-09 16:47:25', '2023-05-09 15:47:35');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(5, 'bef4cd8156', 'image', 1, 0, 1, 'files/logo/23/05/09/645a39df21de3/rkhm.png', 'rkhm', 'png', 'image/png', '{\"total_size\":5655,\"width\":160,\"height\":150,\"size\":5655,\"dominant_color\":{\"hex\":\"c28131\",\"rgb\":\"194, 129, 49\"}}', 'logo', 5655, 1, 'st_admin_logo', NULL, '2023-05-09 16:47:29', '2023-05-09 15:47:35');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(6, '8de60d39f8', 'image', 1, 0, 1, 'files/icon/23/05/09/645a39df307aa/rkhm_645a39dbef3dd.png', 'rkhm_645a39dbef3dd', 'png', 'image/png', '{\"total_size\":5655,\"width\":160,\"height\":150,\"size\":5655,\"dominant_color\":{\"hex\":\"c28131\",\"rgb\":\"194, 129, 49\"}}', 'icon', 5655, 1, 'st_icon', NULL, '2023-05-09 16:47:32', '2023-05-09 15:47:35');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(7, '136c6c3a5f', 'image', 1, 0, 1, 'files/placeholder/23/05/09/645a3b28208fd/dummy_500x500_7e877e_292e29_dm2.png', 'dummy_500x500_7e877e_292e29_dm2', 'png', 'image/png', '{\"total_size\":3837,\"width\":500,\"height\":500,\"size\":3837,\"dominant_color\":{\"hex\":\"292e29\",\"rgb\":\"41, 46, 41\"}}', 'placeholder', 3837, 1, 'st_placeholder', NULL, '2023-05-09 16:48:36', '2023-05-09 15:53:04');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(8, '3f8529ae20', 'image', 1, 0, 1, 'files/placeholder/23/05/09/645a3b285158e/avatar.png', 'avatar', 'png', 'image/png', '{\"total_size\":118127,\"width\":345,\"height\":346,\"size\":118127,\"dominant_color\":{\"hex\":\"3c7495\",\"rgb\":\"60, 116, 149\"}}', 'placeholder', 118127, 1, 'st_phu_avatar', NULL, '2023-05-09 16:53:03', '2023-05-09 15:53:04');
INSERT INTO `_bof_files` (`ID`, `pass`, `type`, `host_id`, `dest_host_id`, `user_id`, `path`, `name`, `extension`, `mime_type`, `data`, `object_type`, `size`, `used`, `used_in`, `used_in_object`, `time_add`, `time_moved`) VALUES(9, '6d69a35746', 'image', 1, 0, 1, 'files/placeholder/23/05/09/645a3c3befd57/0_trippy skeletons_esrgan-v1-x2plus -1-.png', '0_trippy skeletons_esrgan-v1-x2plus -1-', 'png', 'image/png', '{\"total_size\":1687544,\"width\":1024,\"height\":1024,\"size\":1687544,\"dominant_color\":{\"hex\":\"636b7b\",\"rgb\":\"99, 107, 123\"}}', 'placeholder', 1687540, 1, 'st_phu_bg', NULL, '2023-05-09 16:57:38', '2023-05-09 15:57:39');

DROP TABLE IF EXISTS `_bof_files_hosts`;
CREATE TABLE IF NOT EXISTS `_bof_files_hosts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `comment` text DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `data` text DEFAULT NULL,
  `s_files_count` int(11) NOT NULL DEFAULT 0,
  `s_files_size` bigint(11) NOT NULL DEFAULT 0,
  `time_upload` timestamp NULL DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_bof_files_hosts` (`ID`, `name`, `comment`, `type`, `data`, `s_files_count`, `s_files_size`, `time_upload`, `time_add`) VALUES(1, 'Localhost', 'This server', 'localhost', '{\"path\":\"uploads\"}', 110, 77372024, '2021-11-22 18:41:12', '2021-11-22 18:41:12');

DROP TABLE IF EXISTS `_bof_log_api_requests`;
CREATE TABLE IF NOT EXISTS `_bof_log_api_requests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `endpoint_name` varchar(30) DEFAULT NULL,
  `endpoint_data` mediumtext DEFAULT NULL,
  `user_id` int(8) DEFAULT NULL,
  `request_url` text DEFAULT NULL,
  `request_sessid` varchar(50) DEFAULT NULL,
  `request_cookies` mediumtext DEFAULT NULL,
  `request_posts` mediumtext DEFAULT NULL,
  `request_params` mediumtext DEFAULT NULL,
  `request_headers` mediumtext DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `ip_country` varchar(2) DEFAULT NULL,
  `device_cordova` varchar(20) DEFAULT NULL,
  `device_is_virtual` int(1) DEFAULT NULL,
  `device_manufacturer` varchar(100) DEFAULT NULL,
  `device_model` varchar(100) DEFAULT NULL,
  `device_platform` varchar(100) DEFAULT NULL,
  `device_version` varchar(20) DEFAULT NULL,
  `device_uuid` varchar(100) DEFAULT NULL,
  `device_serial` varchar(100) DEFAULT NULL,
  `object_type` varchar(30) DEFAULT NULL,
  `object_hash` varchar(32) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `bofClient_slug` varchar(150) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `sta` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ip` (`ip`),
  KEY `time_add` (`time_add`),
  KEY `page_type` (`endpoint_name`),
  KEY `request_sessid` (`request_sessid`),
  KEY `object_type` (`object_type`,`object_hash`),
  KEY `object_type_2` (`object_type`,`object_id`),
  KEY `bofClient_slug` (`bofClient_slug`),
  KEY `endpoint_name` (`endpoint_name`,`user_id`,`object_type`,`bofClient_slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_api_requests_admin`;
CREATE TABLE IF NOT EXISTS `_bof_log_api_requests_admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `endpoint_name` varchar(30) DEFAULT NULL,
  `endpoint_data` mediumtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_url` text DEFAULT NULL,
  `request_sessid` varchar(50) DEFAULT NULL,
  `request_cookies` mediumtext DEFAULT NULL,
  `request_posts` mediumtext DEFAULT NULL,
  `request_params` mediumtext DEFAULT NULL,
  `request_headers` mediumtext DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `ip_country` varchar(2) DEFAULT NULL,
  `device_cordova` varchar(20) DEFAULT NULL,
  `device_is_virtual` int(1) DEFAULT NULL,
  `device_manufacturer` varchar(100) DEFAULT NULL,
  `device_model` varchar(100) DEFAULT NULL,
  `device_platform` varchar(100) DEFAULT NULL,
  `device_version` varchar(20) DEFAULT NULL,
  `device_uuid` varchar(100) DEFAULT NULL,
  `device_serial` varchar(100) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `sta` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ip` (`ip`),
  KEY `time_add` (`time_add`),
  KEY `page_type` (`endpoint_name`),
  KEY `request_sessid` (`request_sessid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_cronjob_g`;
CREATE TABLE IF NOT EXISTS `_bof_log_cronjob_g` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PID` int(11) NOT NULL,
  `code` varchar(20) NOT NULL,
  `title` tinytext DEFAULT NULL,
  `detail` mediumtext DEFAULT NULL,
  `time_start` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_end` timestamp NULL DEFAULT NULL,
  `sta` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `PID` (`PID`),
  KEY `code` (`code`),
  KEY `sta` (`sta`),
  KEY `time_start` (`time_start`),
  KEY `time_end` (`time_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_cronjob_p`;
CREATE TABLE IF NOT EXISTS `_bof_log_cronjob_p` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PID` int(11) NOT NULL,
  `GID` int(11) NOT NULL,
  `text` longtext NOT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `PID` (`PID`),
  KEY `GID` (`GID`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_curls`;
CREATE TABLE IF NOT EXISTS `_bof_log_curls` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `hook` varchar(32) DEFAULT NULL,
  `url` varchar(400) NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `request_body` mediumtext DEFAULT NULL,
  `request_header` text DEFAULT NULL,
  `response_body` longblob DEFAULT NULL,
  `response_body_size` bigint(20) DEFAULT NULL,
  `response_header` text DEFAULT NULL,
  `response_header_code` int(4) DEFAULT NULL,
  `used` int(11) DEFAULT 0,
  `time_used` timestamp NULL DEFAULT NULL,
  `time_start` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_expire` timestamp NULL DEFAULT NULL,
  `time_exe` float NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `hook` (`hook`),
  KEY `hook_2` (`hook`,`time_start`),
  KEY `response_body_size` (`response_body_size`,`time_start`),
  KEY `hook_3` (`hook`,`response_header_code`,`time_start`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_db`;
CREATE TABLE IF NOT EXISTS `_bof_log_db` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `table` varchar(100) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `query` mediumtext DEFAULT NULL,
  `params` mediumtext DEFAULT NULL,
  `safe` int(1) DEFAULT NULL,
  `exe_time` float NOT NULL,
  `critical` int(1) DEFAULT NULL,
  `error` mediumtext DEFAULT NULL,
  `time_start` timestamp NOT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `exe_time` (`exe_time`),
  KEY `table` (`table`),
  KEY `action` (`action`),
  KEY `time_add` (`time_start`),
  KEY `critical` (`critical`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_ips`;
CREATE TABLE IF NOT EXISTS `_bof_log_ips` (
  `IP` varchar(39) NOT NULL,
  `source` varchar(30) NOT NULL,
  `continent` varchar(2) DEFAULT NULL,
  `country` varchar(2) DEFAULT NULL,
  `region` varchar(2) DEFAULT NULL,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `full_response` longtext DEFAULT NULL CHECK (json_valid(`full_response`)),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`IP`),
  KEY `time_expire` (`time_expire`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_requests`;
CREATE TABLE IF NOT EXISTS `_bof_log_requests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `endpoint_name` varchar(30) DEFAULT NULL,
  `endpoint_data` mediumtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_url` text DEFAULT NULL,
  `request_sessid` varchar(50) DEFAULT NULL,
  `request_cookies` mediumtext DEFAULT NULL,
  `request_posts` mediumtext DEFAULT NULL,
  `request_params` mediumtext DEFAULT NULL,
  `request_headers` mediumtext DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `ip_country` varchar(2) DEFAULT NULL,
  `agent` tinytext DEFAULT NULL,
  `agent_model` varchar(50) DEFAULT NULL,
  `agent_type` varchar(10) DEFAULT NULL,
  `agent_os` varchar(30) DEFAULT NULL,
  `agent_browser` varchar(30) DEFAULT NULL,
  `agent_engine` varchar(30) DEFAULT NULL,
  `referer` varchar(100) DEFAULT NULL,
  `referer_full` mediumtext DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `sta` int(1) DEFAULT NULL,
  `result` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ip` (`ip`),
  KEY `time_add` (`time_add`),
  KEY `page_type` (`endpoint_name`),
  KEY `request_sessid` (`request_sessid`),
  KEY `agent_type` (`agent_type`),
  KEY `agent_os` (`agent_os`),
  KEY `agent_browser` (`agent_browser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_log_requests_admin`;
CREATE TABLE IF NOT EXISTS `_bof_log_requests_admin` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `endpoint_name` varchar(30) DEFAULT NULL,
  `endpoint_data` mediumtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `request_url` text DEFAULT NULL,
  `request_sessid` varchar(50) DEFAULT NULL,
  `request_cookies` mediumtext DEFAULT NULL,
  `request_posts` mediumtext DEFAULT NULL,
  `request_params` mediumtext DEFAULT NULL,
  `request_headers` mediumtext DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `ip_country` varchar(2) DEFAULT NULL,
  `agent` tinytext DEFAULT NULL,
  `agent_model` varchar(50) DEFAULT NULL,
  `agent_type` varchar(10) DEFAULT NULL,
  `agent_os` varchar(30) DEFAULT NULL,
  `agent_browser` varchar(30) DEFAULT NULL,
  `agent_engine` varchar(30) DEFAULT NULL,
  `referer` varchar(100) DEFAULT NULL,
  `referer_full` mediumtext DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `sta` int(1) DEFAULT NULL,
  `result` text DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ip` (`ip`),
  KEY `time_add` (`time_add`),
  KEY `page_type` (`endpoint_name`),
  KEY `request_sessid` (`request_sessid`),
  KEY `agent_type` (`agent_type`),
  KEY `agent_os` (`agent_os`),
  KEY `agent_browser` (`agent_browser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_notification`;
CREATE TABLE IF NOT EXISTS `_bof_notification` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `hook` varchar(100) NOT NULL,
  `def_setting` longtext DEFAULT NULL CHECK (json_valid(`def_setting`)),
  `detail` mediumtext DEFAULT NULL,
  `detail_params` longtext DEFAULT NULL CHECK (json_valid(`detail_params`)),
  `setting` longtext DEFAULT NULL CHECK (json_valid(`setting`)),
  `texts` longtext DEFAULT NULL CHECK (json_valid(`texts`)),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hook` (`hook`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(1, 'new_follower', '{}', 'User is followed by another user', '{\"username\":\"Follower\'s username\"}', '{\"methods\":{\"all\":true,\"db\":true,\"email\":false,\"push\":true}}', '{\"title\":\"@<b>%username%<\\/b> started following you\"}', '2023-01-28 00:12:29');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(2, 'new_playlist_subscriber', '{}', 'User\'s playlist is added to another user\'s library', '{\"username\":\"Adder\'s username\",\"playlist_name\":\"The playlist\'s name\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true}}', '{\"title\":\"@<b>%username%<\\/b> added your playlist: #<b>%playlist_name%<\\/b> to their library\"}', '2023-01-28 03:24:51');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(3, 'welcome', NULL, 'User verified their email', NULL, '{\"methods\":{\"all\":true,\"email\":false,\"push\":false,\"db\":true}}', '{\"title\":\"Welcome!\",\"content\":\"Thanks for signing up! Enjoy our content and lets us know what you think!\"}', '2023-01-28 07:47:21');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(4, 'plan_purchased', NULL, 'User purchased a subscription plan', '{\"plan_name\":\"Purchased plan name\",\"plan_period\":\"Purchased period\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true}}', '{\"title\":\"Successfully purchased <b>%plan_name%<\\/b>. Period: <b>%plan_period%<\\/b>\",\"email_title\":\"Successful Purchase\",\"email_content\":\"You have successfully purchased <b>%plan_name%<\\/b>. Period: <b>%plan_period%<\\/b>\"}', '2023-01-29 00:21:40');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(5, 'item_purchased', NULL, 'User purchased an item', '{\"item_name\":\"Item\'s name\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true}}', '{\"title\":\"Successfully purchased <b>%item_name%<\\/b>\",\"email_title\":\"Successful Purchase\",\"email_content\":\"You have successfully purchased <b>%item_name%<\\/b>. Thank you\"}', '2023-01-29 01:12:08');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(6, 'payment_ok', NULL, 'User had a successful payment & received the fund', '{\"order_id\":\"Order ID\",\"amount\":\"Amount\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true,\"email\":false}}', '{\"title\":\"Successful Payment\",\"content\":\"Your payment <b>#%order_id%<\\/b> was approved and <b>%amount%<\\/b> was added to your wallet\"}', '2023-01-29 01:12:19');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(7, 'payment_rejected', NULL, 'User had a payment rejected', '{\"order_id\":\"Order ID\",\"amount\":\"Amount\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true,\"email\":false}}', '{\"title\":\"Payment Rejected\",\"content\":\"Your payment #%order_id% was rejected\"}', '2023-01-29 01:12:39');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(8, 'verification_ok', NULL, 'User verification request to become manager was approved', NULL, '{\"methods\":{\"all\":true,\"db\":true,\"email\":false,\"push\":true}}', '{\"title\":\"Request approved\"}', '2023-01-29 01:12:39');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(9, 'verification_rejected', NULL, 'User verification request to become manager was rejected', NULL, '{\"methods\":{\"all\":true,\"db\":true,\"push\":true,\"email\":false}}', '{\"title\":\"Request rejected\"}', '2023-01-29 01:12:49');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(10, 'item_sold', NULL, 'User had a sale as manager of a creator', '{\"item_name\":\"Item name\",\"amount\":\"Amount\",\"share\":\"Seller\'s share\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true}}', '{\"title\":\"New sale\",\"content\":\"Your item <b>%item_name%<\\/b> was sold for <b>%amount%<\\/b> and your share <b>%share%<\\/b> was added to your wallet\"}', '2023-01-29 01:13:24');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(11, 'collabed_in_playlist', NULL, 'User got collabed in another user\'s playlist', '{\"name\":\"Playlist name\",\"user\":\"The user that added you\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true}}', '{\"title\":\"You got collabed!\",\"content\":\"You have been chosen as a collaborator in %name% playlist by %user%!\"}', '2023-01-29 01:14:32');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(12, 'creator_update', NULL, 'User\'s subscribed creator has a new release', '{\"creator_name\":\"Creator name\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true,\"email\":false}}', '{\"title\":\"New update from subscribed creator\",\"content\":\"%creator_name% has released new content\"}', '2023-01-29 01:14:51');
INSERT INTO `_bof_notification` (`ID`, `hook`, `def_setting`, `detail`, `detail_params`, `setting`, `texts`, `time_add`) VALUES(13, 'playlist_update', NULL, 'User\'s subscribed playlist ( by adding-to-library or being-a-collaborator or owner ) has been updated by other user', '{\"name\":\"Playlist name\",\"user\":\"The user that updated playlist\"}', '{\"methods\":{\"all\":true,\"db\":true,\"push\":true,\"email\":false}}', '{\"title\":\"<b>%name%<\\/b> playlist has been updated\",\"content\":\"<b>%name%<\\/b> playlist has been updated by %user%. Check it out!\",\"email_title\":\"Playlist update\"}', '2023-04-15 15:29:30');

DROP TABLE IF EXISTS `_bof_plug_logs`;
CREATE TABLE IF NOT EXISTS `_bof_plug_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(9) NOT NULL,
  `code` varchar(20) NOT NULL,
  `text` mediumtext NOT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `process_id` (`process_id`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

DROP TABLE IF EXISTS `_bof_plug_processes`;
CREATE TABLE IF NOT EXISTS `_bof_plug_processes` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `extension_type` varchar(20) NOT NULL,
  `extension_name` varchar(60) NOT NULL,
  `extension_version` varchar(6) NOT NULL,
  `action` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sta` int(11) DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_start` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_finish` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `time_add` (`time_add`),
  KEY `time_start` (`time_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_bof_setting`;
CREATE TABLE IF NOT EXISTS `_bof_setting` (
  `var` varchar(100) NOT NULL,
  `val` longtext NOT NULL,
  `type` varchar(10) DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`var`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('_ic', '1', NULL, '2023-03-10 06:45:36', '2023-04-28 03:13:21');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_audio_c_f', '0.5', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_audio_interval', '1', NULL, '2023-02-15 23:26:58', '2023-04-19 20:15:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_audio_v_f', '0.5', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_audio_view_f', '0.13', NULL, '2023-02-15 23:26:58', '2023-02-16 13:37:27');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_banner_c_f', '0.5', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_banner_click_f', '0.08', NULL, '2023-02-15 23:26:58', '2023-02-15 23:27:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_banner_v_f', '0.1', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_banner_view_f', '0.01', NULL, '2023-02-15 23:19:14', '2023-02-15 23:21:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_google_auto_code', '', NULL, '2023-02-15 23:19:14', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_popup_c_f', '0.5', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_popup_v_f', '1', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ads_script_v_f', '0.5', NULL, '2023-02-17 14:21:27', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('client_auto_images', '1', NULL, '2023-03-23 17:27:33', '2023-03-23 18:42:50');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('client_give_attr', '1', NULL, '2023-03-23 17:27:33', '2023-03-23 17:27:37');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('client_give_attribute', '', NULL, '2023-03-23 17:41:17', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('client_private', '', NULL, '2023-03-23 17:27:33', '2023-03-23 17:27:37');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond', '1', NULL, '2022-12-22 18:37:48', '2023-05-08 11:13:03');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_db_cleaner', '1', NULL, '2023-04-04 01:23:13', '2023-05-07 00:30:46');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_hd_cleaner', '1', NULL, '2023-04-04 03:15:27', '2023-05-07 00:30:46');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_interval', '1', NULL, '2023-04-03 21:18:26', '2023-05-09 05:54:22');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_royalty_payer', '0', NULL, '2023-04-04 03:15:27', '2023-05-09 05:54:27');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_setting_map', '', 'json', '2023-05-07 00:30:46', '2023-05-09 05:48:18');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_stat', '0', NULL, '2022-12-08 12:58:41', null);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('crond_times', '', 'json', '2023-05-07 00:49:58', '2023-05-09 05:48:10');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('custom_js', '', NULL, '2023-02-14 14:32:53', '2023-02-14 15:42:29');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('download_available_sources', 'audio_quality_1,audio_quality_2,audio_quality_3,audio_quality_4,audio_quality_5,video_quality_1,video_quality_2,video_quality_3,video_quality_4,video_quality_5', 'imploded', '2022-11-26 12:53:09', '2023-02-15 15:46:14');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fh_setting', '{\"default\":\"1\"}', 'json', '2021-11-24 18:55:21', '2023-01-20 21:49:15');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('font_name', 'Montserrat', NULL, '2023-02-14 13:38:51', '2023-02-14 14:17:06');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('font_size', '12', NULL, '2023-02-14 13:41:46', '2023-02-14 13:41:59');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('footer_sign', '', NULL, '2023-05-06 04:44:45', '2023-05-06 06:14:44');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_audio_br_min', '64', 'string', '2021-11-25 00:57:39', '2023-03-08 05:47:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_audio_fl', 'mp3', 'imploded', '2021-11-25 00:54:26', '2022-11-20 06:49:05');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_audio_size_max', '20', 'string', '2021-11-25 00:53:32', '2023-03-08 05:47:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_audio_size_min', '1', 'string', '2021-11-25 00:53:42', '2022-08-28 20:21:28');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_audio_waveform', '', NULL, '2022-11-19 10:16:41', '2023-03-08 05:47:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_bgp', '', NULL, '2022-12-10 17:25:02', '2023-05-07 10:42:50');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_chunk', '1', 'raw', '2021-11-25 00:57:59', '2023-04-20 01:59:22');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_chunk_size', '1', 'string', '2021-11-25 00:49:46', '2023-01-20 22:55:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_dim_max', '2000*1500', 'string', '2021-11-25 03:15:32', '2021-12-06 17:58:14');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_dim_min', '100*50', 'string', '2021-11-25 03:15:32', '2022-08-11 21:35:41');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_fl', 'jpg,gif,png', 'imploded', '2021-11-25 03:15:32', '2022-01-10 21:29:08');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_resize', '1', 'raw', '2021-11-25 19:28:21', '2021-12-12 19:54:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_size_max', '10', 'string', '2021-11-25 03:15:32', '2021-12-06 17:53:58');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_image_size_min', '0.01', 'string', '2021-11-25 03:15:32', '2021-12-06 17:53:58');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_video_fl', 'mp4', 'imploded', '2022-09-02 03:10:07', '2023-05-09 05:52:40');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_video_size_max', '60', NULL, '2022-09-02 03:10:07', '2022-10-23 15:18:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_video_size_min', '1', NULL, '2022-09-02 03:10:07', '2022-09-02 03:10:07');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_video_width_max', '2000', NULL, '2022-09-02 04:35:09', '2022-09-02 04:35:09');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('fs_video_width_min', '100', NULL, '2022-09-02 03:10:07', '2022-09-02 03:10:07');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_coinpayments', '1', NULL, '2022-01-18 01:18:53', '2022-01-18 01:18:53');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_kkiapay', '1', NULL, '2022-01-18 01:09:35', '2022-01-18 01:09:35');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_offline', '1', NULL, '2022-01-17 23:41:58', '2022-01-17 23:42:41');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_offline_detail', 'Wire %amount% USD to following account then email info@gmail.com\r\nBank name, Location\r\nAccount number 0000-11-22-33\r\nBusyowl DigiMuse Version 2.0 💣💣', NULL, '2022-01-17 23:41:58', '2023-01-31 08:27:00');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_offline_fee', '5', NULL, '2023-01-30 02:45:33', '2023-01-30 02:45:46');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal', '', NULL, '2022-01-17 23:45:10', '2023-03-08 05:45:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal_auto', '', NULL, '2023-01-31 06:18:36', '2023-03-08 05:45:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal_fee', '', NULL, '2023-01-31 08:26:05', '2023-03-08 05:45:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal_key', '', NULL, '2022-01-17 23:46:27', '2023-03-08 05:45:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal_mode', 'sandbox', NULL, '2022-01-17 23:45:10', '2022-01-17 23:46:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_paypal_secret', '', NULL, '2022-01-17 23:46:27', '2023-03-08 05:45:20');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe', '', NULL, '2022-01-17 23:54:02', '2023-03-08 05:45:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe_auto', '', NULL, '2023-01-31 03:44:23', '2023-03-08 05:45:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe_fee', '', NULL, '2023-01-31 03:44:53', '2023-03-08 05:45:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe_key', '', NULL, '2022-01-17 23:54:02', '2023-03-08 05:45:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe_mode', 'sandbox', NULL, '2022-01-17 23:54:02', '2022-01-17 23:54:02');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('gateway_stripe_secret', '', NULL, '2022-01-17 23:54:02', '2023-03-08 05:45:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_from', '', NULL, '2023-03-08 05:46:13', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_s_addr', '', NULL, '2022-01-30 09:51:16', '2023-03-08 05:46:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_s_encrypt', 'tls', NULL, '2022-01-30 09:51:16', '2022-01-30 09:51:16');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_s_password', '', NULL, '2022-01-30 09:51:16', '2023-03-08 05:46:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_s_port', '', NULL, '2022-01-30 09:51:16', '2023-03-08 05:46:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ma_server', 'localhost', NULL, '2022-01-30 09:51:16', '2023-02-28 17:16:09');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('menus_ps', '{\"desk\":\"1\",\"mob\":\"2\",\"footer\":\"4\"}', 'json', '2023-04-17 17:00:51', '2023-05-09 05:54:52');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('ms_s_username', '', NULL, '2022-01-30 09:51:16', '2023-03-08 05:46:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('muse_available_sources', 'audio_quality_1,audio_quality_2,audio_quality_3,audio_quality_4,audio_quality_5,video_quality_1,video_quality_2,video_quality_3,video_quality_4,video_quality_5,soundcloud,youtube', 'imploded', '2022-09-03 19:24:38', '2022-09-05 04:11:30');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('offline_download_button', 'onuse', NULL, '2023-02-15 13:27:12', '2023-02-15 15:27:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('plugins', 'bof_music', 'imploded', '2021-10-09 11:15:36', '2023-05-04 04:37:28');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('plyr_hide_yt_frame', '', NULL, '2023-04-18 20:51:38', '2023-05-02 10:18:04');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_a_book', '{\"title\":\"Listen to %title% by %writer_name%\"}', 'json', '2023-05-02 00:41:02', '2023-05-02 01:49:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_b_post', '{\"title\":\"%title% by @%author_username%\"}', 'json', '2023-05-02 00:19:35', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_m_album', '{\"title\":\"Listen to %type% album: %title% by %artist_name%\"}', 'json', '2023-05-02 00:37:32', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_m_track', '{\"title\":\"Stream %album_title% - %title% by %artist_name%\"}', 'json', '2023-05-01 22:09:41', '2023-05-02 01:49:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_p_episode', '{\"title\":\"Stream %show_title% - %title% by %podcaster_name%\"}', 'json', '2023-05-02 00:33:29', '2023-05-02 00:34:23');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_p_podcaster', '{\"title\":\"Listen to %name% podcasts!\"}', 'json', '2023-05-02 01:49:34', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_p_show', '{\"title\":\"Listen to %title% by %podcaster_name%\"}', 'json', '2023-05-02 00:29:31', '2023-05-02 01:49:34');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('seo_ugc_playlist', '{\"title\":\"Listen to %title% by @%owner_username%\"}', 'json', '2023-05-02 00:16:22', NULL);
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('session_cc', '33', NULL, '2023-03-23 17:52:03', '2023-03-26 01:59:38');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('session_ip_lock', '', NULL, '2022-01-30 07:04:52', '2023-04-07 13:24:39');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('session_life', '', NULL, '2022-01-30 07:04:52', '2023-03-26 01:59:38');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('session_max', '10', NULL, '2022-01-30 07:04:52', '2023-04-07 13:24:43');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('session_pf_lock', '', NULL, '2022-01-30 07:04:52', '2023-05-04 00:31:29');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('shortname', 'rkhmusic', NULL, '2023-02-19 15:47:02', '2023-05-09 05:25:05');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('sitename', 'RKHM', NULL, '2022-01-30 06:52:50', '2023-05-09 05:24:38');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('sl_facebook', '', NULL, '2022-01-30 06:52:50', '2023-05-09 05:25:06');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('spotify_client_key', '', 'string', '2021-10-22 18:10:11', '2023-04-30 02:28:44');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('spotify_token', '', 'string', '2021-11-06 09:08:33', '2023-05-09 02:56:00');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('theme', 'shady', NULL, '2022-04-28 09:05:29', '2023-04-29 21:13:41');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('theme_color', '009ad2', NULL, '2023-02-14 13:50:34', '2023-02-20 16:08:37');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('theme_color_rgb', '0, 154, 210', NULL, '2023-02-14 14:03:33', '2023-02-20 16:08:38');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('title_name', 'DM2', NULL, '2022-06-22 09:23:40', '2022-06-22 09:23:40');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('upgrade_button', 'never', NULL, '2023-02-15 13:29:27', '2023-02-15 15:12:13');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('upload_button', 'onuse', NULL, '2023-02-15 13:28:13', '2023-03-25 18:10:57');
INSERT INTO `_bof_setting` (`var`, `val`, `type`, `time_add`, `time_update`) VALUES('br_m_album', '1', NULL, '2023-02-15 13:28:13', '2023-03-25 18:10:57');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('secondary_logo', '4');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('admin_logo', '5');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('logo', '3');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('icon', '6');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('placeholder', '7');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('phu_avatar', '8');
INSERT INTO `_bof_setting` (`var`, `val`) VALUES('phu_bg', '9');

DROP TABLE IF EXISTS `_c_b_categories`;
CREATE TABLE IF NOT EXISTS `_c_b_categories` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_posts` int(6) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_posts` (`s_posts`),
  KEY `code` (`code`),
  KEY `time_add` (`time_add`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_c_b_posts`;
CREATE TABLE IF NOT EXISTS `_c_b_posts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `title` tinytext NOT NULL,
  `content` longtext NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `user_id` int(8) NOT NULL,
  `price` float DEFAULT 0,
  `price_setting` longtext DEFAULT NULL CHECK (json_valid(`price_setting`)),
  `st_comment` int(1) DEFAULT 0,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_shares` int(9) NOT NULL DEFAULT 0,
  `s_categories` int(2) NOT NULL DEFAULT 0,
  `time_edit` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  `active` int(1) DEFAULT 1,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `user_id` (`user_id`),
  KEY `time_add` (`time_add`),
  KEY `time_edit` (`time_edit`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_shares` (`s_shares`),
  KEY `s_categories` (`s_categories`),
  KEY `active` (`active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_c_b_posts_relations`;
CREATE TABLE IF NOT EXISTS `_c_b_posts_relations` (
  `post_id` int(9) NOT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `i` int(3) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`post_id`,`target_id`,`type`),
  KEY `ID1` (`post_id`,`type`),
  KEY `ID2` (`target_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_c_b_tags`;
CREATE TABLE IF NOT EXISTS `_c_b_tags` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_posts` int(6) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `code` (`code`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_posts` (`s_posts`),
  KEY `time_add` (`time_add`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_d_languages`;
CREATE TABLE IF NOT EXISTS `_d_languages` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code2` varchar(2) NOT NULL,
  `code3` varchar(3) NOT NULL,
  `_default` int(11) NOT NULL DEFAULT 0,
  `_index` int(11) NOT NULL DEFAULT 0,
  `s_items` int(5) NOT NULL DEFAULT 0,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `code2` (`code2`),
  UNIQUE KEY `code3` (`code3`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_d_languages` (`ID`, `name`, `code2`, `code3`, `_default`, `_index`, `s_items`, `time_add`) VALUES(1, 'English', 'en', 'eng', 1, 1, 411, '2022-03-08 11:44:04');

DROP TABLE IF EXISTS `_d_languages_items`;
CREATE TABLE IF NOT EXISTS `_d_languages_items` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `hook` varchar(40) NOT NULL,
  `lang_code2` varchar(2) NOT NULL DEFAULT 'en',
  `text` tinytext DEFAULT NULL,
  `used` int(11) NOT NULL DEFAULT 0,
  `used_be` int(11) NOT NULL DEFAULT 0,
  `used_ce` int(11) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hook` (`hook`,`lang_code2`),
  KEY `lang_code2` (`lang_code2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(1, 'login', 'en', 'login', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(2, 'email', 'en', 'email', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(3, 'password', 'en', 'password', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(4, 'continue', 'en', 'continue', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(5, 'signup', 'en', 'sign up', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(6, 'login_recover_text', 'en', 'recover your password', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(7, 'ok', 'en', 'ok', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(8, 'invalid_input', 'en', '%input_name% is invalid', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(9, 'retry', 'en', 'retry', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(10, 'welcome', 'en', 'welcome', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(11, 'messenger', 'en', 'Messenger', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(12, 'logout', 'en', 'logout', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(13, 'setting', 'en', 'setting', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(14, 'account_setting', 'en', 'account setting', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(15, 'browse', 'en', 'browse', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(16, 'more', 'en', 'more', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(17, 'back', 'en', 'back', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(18, 'search', 'en', 'search', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(19, 'search_placeholder', 'en', 'Search ....', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(20, 'filter', 'en', 'filter', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(21, 'next', 'en', 'next', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(22, 'playlists', 'en', 'playlists', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(23, 'made_for_you', 'en', 'made for you', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(24, 'likes', 'en', 'likes', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(25, 'subscriptions', 'en', 'subscriptions', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(26, 'history', 'en', 'history', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(27, 'nothing_to_see', 'en', 'Nothing to see here', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(28, 'play', 'en', 'play', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(29, 'm_album', 'en', 'Album', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(30, 'tracks', 'en', 'tracks', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(31, 'm_track', 'en', 'Track', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(32, 'm_artist', 'en', 'Artist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(33, 'plays', 'en', 'plays', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(34, 'a_book', 'en', 'Audio book', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(35, 'p_show', 'en', 'Podcast', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(36, 'episodes', 'en', 'episodes', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(37, 'a_writer', 'en', 'Writer', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(38, 'subscribers', 'en', 'subscriber', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(39, 'books', 'en', 'books', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(40, 'p_podcaster', 'en', 'Podcaster', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(41, 'm_genre', 'en', 'Genre', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(42, 'r_station', 'en', 'Radio', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(43, 'p_episode', 'en', 'Podcast episode', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(44, 'profile', 'en', 'profile', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(45, 'upload', 'en', 'upload', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(46, 'done', 'en', 'done', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(47, 'previous', 'en', 'previous', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(48, 'unsubscribed', 'en', 'unsubscribe', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(49, 'views', 'en', 'views', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(50, 'views_unique', 'en', 'unique views', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(51, 'posts', 'en', 'posts', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(52, 'albums', 'en', 'albums', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(53, 'artists', 'en', 'artists', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(54, 'play_next', 'en', 'play next', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(55, 'add_to_queue', 'en', 'add to queue', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(56, 'add_to_playlist', 'en', 'add to playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(57, 'share', 'en', 'share', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(58, 'open', 'en', 'open', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(59, 'like', 'en', 'like', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(60, 'open_artist', 'en', 'open artist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(61, 'open_genre', 'en', 'open genre', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(62, 'subscribe', 'en', 'subscribe', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(63, 'unsubscribe', 'en', 'unsubscribe', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(64, 'unlike', 'en', 'unlike', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(65, 'send', 'en', 'send', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(66, 'open_tag', 'en', 'open tag', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(67, 'loading', 'en', 'loading ...', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(68, 'recent', 'en', 'Recently', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(69, 'second', 'en', 'second', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(70, 'minute', 'en', 'minute', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(71, 'hour', 'en', 'hour', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(72, 'day', 'en', 'day', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(73, 'month', 'en', 'month', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(74, 'year', 'en', 'year', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(75, 'seconds', 'en', 'seconds', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(76, 'minutes', 'en', 'minutes', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(77, 'hours', 'en', 'hours', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(78, 'days', 'en', 'days', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(79, 'months', 'en', 'months', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(80, 'years', 'en', 'years', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(81, 'downloads', 'en', 'downloads', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(82, 'select', 'en', 'select', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(83, 'saved', 'en', 'saved', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(84, 'create_new', 'en', 'create new', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(85, 'translators', 'en', 'translators', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(86, 'narrators', 'en', 'narrators', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(87, 'writers', 'en', 'writers', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(88, 'stations', 'en', 'stations', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(89, 'podcasters', 'en', 'podcasters', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(90, 'shows', 'en', 'shows', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(91, 'edit_episodes', 'en', 'edit episode', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(92, 'edit_show', 'en', 'edit show', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(93, 'podcast', 'en', 'podcast', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(94, 'affiliate', 'en', 'affiliate', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(95, 'download', 'en', 'download', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(96, 'free', 'en', 'free', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(97, 'failed', 'en', 'failed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(98, 'purchase', 'en', 'purchase', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(99, 'buy', 'en', 'buy', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(100, 'nothing_found', 'en', 'nothing found', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(101, 'insufficient_fund', 'en', 'insufficient funds', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(102, 'purchased', 'en', 'purchased', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(103, 'security', 'en', 'security', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(104, 'transactions', 'en', 'transactions', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(105, 'notifications', 'en', 'notifications', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(106, 'music', 'en', 'music', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(107, 'audio', 'en', 'audio', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(108, 'video', 'en', 'video', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(109, 'youtube', 'en', 'YouTube', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(110, 'soundcloud', 'en', 'SoundCloud', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(111, 'edit_album', 'en', 'Edit album', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(112, 'edit_tracks', 'en', 'Edit tracks', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(113, 'upload_audio', 'en', 'upload audio', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(114, 'upload_video', 'en', 'upload video', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(115, 'import_youtube', 'en', 'import YouTube', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(116, 'import_soundcloud', 'en', 'import SoundCloud', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(117, 'uploads', 'en', 'uploads', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(118, 'light_toggle', 'en', 'Dark/Light switch', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(119, 'change_language', 'en', 'Change Language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(120, 'change_currency', 'en', 'Change Currency', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(121, 'plans_title', 'en', 'Premium plans', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(122, 'plans_subtitle', 'en', 'Go the extra mile', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(123, 'plan', 'en', 'plan', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(124, 'period', 'en', 'period', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(125, 'price', 'en', 'price', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(126, 'confirm', 'en', 'confirm', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(127, 'monthly', 'en', 'monthly', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(128, '3months', 'en', '3months', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(129, 'yearly', 'en', 'yearly', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(130, 'move', 'en', 'move', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(131, 'fullscreen', 'en', 'fullscreen', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(132, 'hide', 'en', 'hide', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(133, 'lyrics', 'en', 'lyrics', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(134, 'queue', 'en', 'queue', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(135, 'infinite_play_tip', 'en', 'Extend your queue by related content', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(136, 'infinite_play', 'en', 'Infinite Play', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(137, 'processing_dots', 'en', 'processing ...', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(138, 'pageload_failed', 'en', 'failed to load the page', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(139, 'choose_name', 'en', 'choose a name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(140, 'privacy', 'en', 'privacy', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(141, 'edit_playlist', 'en', 'edit playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(142, 'name', 'en', 'name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(143, 'playlist_privacy', 'en', 'Who should be able to access this playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(144, 'public', 'en', 'public', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(145, 'private', 'en', 'private', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(146, 'cancel', 'en', 'cancel', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(147, 'not_found', 'en', 'not found', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(148, 'max', 'en', 'max', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(149, 'min', 'en', 'min', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(150, 'up_rule_extensions', 'en', 'Acceotable extensions', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(151, 'up_rule_filesize', 'en', 'Acceotable file size', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(152, 'up_rule_img_dim', 'en', 'Acceptable image dimensions', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(153, 'up_rule_vid_widh', 'en', 'Acceptable video dimensions', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(154, 'up_rule_audio_bit', 'en', 'Minimum bitrate', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(155, 'manage', 'en', 'manage', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(156, 'edit', 'en', 'edit', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(157, 'delete', 'en', 'delete', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(158, 'confirm_remove_playlist', 'en', 'really remove playlist?', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(159, 'enter_a_name', 'en', 'enter a name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(160, 'create', 'en', 'create', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(161, 'open_profile', 'en', 'open profile', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(162, 'subscribed', 'en', 'subscribed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(163, 'edited', 'en', 'edited', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(164, 'own_profile', 'en', 'your profile', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(165, 'followers', 'en', 'followers', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(166, 'library', 'en', 'library', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(167, 'edit_profile', 'en', 'edit profile', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(168, 'playlist', 'en', 'playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(169, 'your_playlist', 'en', 'your playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(170, 'add_to_library', 'en', 'add to library', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(171, 'last_update', 'en', 'last update', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(172, 'ups1_ct', 'en', 'content type', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(173, 'ups2_st', 'en', 'source type', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(174, 'ups3_up', 'en', 'upload', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(175, 'ups1t', 'en', 'What do you want to upload?', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(176, 'ups2t', 'en', 'How do you want to provide the source?', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(177, 'ups3ut', 'en', 'Upload files', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(178, 'ups3it', 'en', 'Import media', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(179, 'album', 'en', 'album', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(180, 'single_tracks', 'en', 'single track', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(181, 'upload_click', 'en', 'Or click here to select', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(182, 'upload_rules', 'en', 'rules', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(183, 'upload_dragdrop', 'en', 'Drag &amp; Drop files to start', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(184, 'file', 'en', 'file', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(185, 'files', 'en', 'files', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(186, 'img_too_big', 'en', 'Image is too big. Max: %max%px', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(187, 'img_too_small', 'en', 'Image is too small. Min: %min%px', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(188, 'invalid_image', 'en', 'Invalid image', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(189, 'invalid_format', 'en', 'Invalid format: %cur%', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(190, 'audio_too_low', 'en', 'Bitrate is too low. Min: %min%. Uploaded: %cur%', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(191, 'vid_too_small', 'en', 'Video width is too small. Min: %min%px', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(192, 'vid_too_big', 'en', 'Video width is too big. Max: %max%px', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(193, 'invalid_file', 'en', 'invalid file', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(194, 'invalid_file_big', 'en', 'invalid file - too big', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(195, 'cover', 'en', 'cover', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(196, 'title', 'en', 'title', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(197, 'album_type', 'en', 'album type', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(198, 'artist_name', 'en', 'artist name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(199, 'release_date', 'en', 'release date', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(200, 'genres', 'en', 'genres', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(201, 'tags', 'en', 'tags', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(202, 'languages', 'en', 'languages', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(203, 'description', 'en', 'description', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(204, 'save', 'en', 'save', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(205, 'featured_artists', 'en', 'featured artists', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(206, 'album_cd', 'en', 'album CD', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(207, 'album_order', 'en', 'album order', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(208, 'price_force_free', 'en', 'force free', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(209, 'basic', 'en', 'basic', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(210, 'playlist_extended', 'en', 'added to playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(211, 'deleted', 'en', 'deleted', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(212, 'removed', 'en', 'removed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(213, 'submit', 'en', 'submit', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(214, 'podcaster_name', 'en', 'podcaster name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(215, 'language', 'en', 'language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(216, 'country', 'en', 'country', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(217, 'categories', 'en', 'categories', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(218, 'copyright', 'en', 'copyright', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(219, 'show', 'en', 'podcast show', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(220, 'show_season', 'en', 'show season', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(221, 'show_order', 'en', 'show order in season', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(222, 'invalid_form_item', 'en', 'failed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(223, 'youtube_id', 'en', 'YouTube ID', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(224, 'youtube_id_url_tip', 'en', 'Enter the ID or full web-address of a YouTube video', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(225, 'soundcloud_id', 'en', 'SoundCloud ID', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(226, 'soundcloud_id_tip', 'en', 'Enter the ID of a SoundCloud audio', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(227, 'liked', 'en', 'liked', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(228, 'select_an_item', 'en', 'select an item', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(229, 'remove_from_que', 'en', 'remove from queue', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(230, 'cant_play', 'en', 'there is a problem with this item, try another', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(231, 'user', 'en', 'user', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(232, 'unliked', 'en', 'unliked', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(233, 'access_denied', 'en', 'no access', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(234, 'a_language', 'en', 'audiobook language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(235, 'r_region', 'en', 'radio region', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(236, 'your_online', 'en', 'You are back online!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(237, 'your_offline_desc', 'en', 'Try screaming for help or browse downloaded content', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(238, 'your_offline_btn', 'en', 'View downloads', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(239, 'your_offline', 'en', 'No internet connection!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(240, 'download_e_title', 'en', 'Get your files offline', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(241, 'download_e_desc', 'en', 'Download in-app and your files will show up here', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(242, 'playlist_created', 'en', 'playlist created', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(243, 'login_failed', 'en', 'login failed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(244, 'username', 'en', 'username', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(245, 'invalid_username', 'en', 'invalid_username', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(246, 'pws_dont_match', 'en', 'pws_dont_match', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(247, '404_title', 'en', 'Not found', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(248, '404_desc', 'en', '404 Error: failed to find requested resource', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(249, 'username_taken', 'en', 'username is taken', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(250, 'email_taken', 'en', 'email is taken', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(251, 'recovery_email_sent', 'en', 'Check your inbox, if this email exists, we\'ll send you a recovery email', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(252, 'signup_terms', 'en', 'Signing up means agreeing with out terms of use', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(253, 'recover', 'en', 'recover', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(254, 'recover_confirm', 'en', 'recover', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(255, 'verification_code', 'en', 'verification code', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(256, 'new_password', 'en', 'new password', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(257, 'changed_pw', 'en', 'password changed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(258, 'password_repeat', 'en', 'repeat password', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(259, 'ok_login', 'en', 'welcome', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(260, 'signup_disabled', 'en', 'signup is disabled', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(261, 'verify_first', 'en', 'please verify your email now', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(262, 'verification', 'en', 'verification', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(263, 'followed', 'en', 'followed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(264, 'unfollow', 'en', 'unfollow', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(265, 'unfollowed', 'en', 'unfollowed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(266, 'follow', 'en', 'follow', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(267, 'message', 'en', 'message', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(268, 'left_group', 'en', 'left group', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(269, 'failed_pending', 'en', 'pending. try again later', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(270, 'p_category', 'en', 'category', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(271, 'invalid_youtube_id', 'en', 'YT invalid ID', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(272, '404', 'en', '404', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(273, 'youtube_request_failed', 'en', 'YT request failed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(274, 'chapar_title_new_follower', 'en', '&lt;b&gt;%username%&lt;/b&gt; started following you!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(275, 'chapar_title_playlist_follower', 'en', '<b>%username%</b> subscribed to <b>%playlist_name%</b> playlist!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(276, 'payment_result', 'en', 'Payment result', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(277, 'b_post', 'en', 'post', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(278, 'b_category', 'en', 'category', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(279, 'b_tag', 'en', 'tag', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(280, 'registered', 'en', 'registered', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(281, 'already_uploaded', 'en', 'this item is already uploaded', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(282, 'upgrade', 'en', 'upgrade', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(283, 'countries', 'en', 'countries', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(284, 'cities', 'en', 'cities', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(285, 'email_dont_talk', 'en', 'This email was sent by system. Don&#039;t reply to it please', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(286, 'soundcloud_embed', 'en', 'SoundCloud Embed code', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(287, 'soundcloud_embed_tip', 'en', 'Paste embed code here. App will extract required information from it. Only \"SoundCloud tracks\" are supported', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(288, 'invalid_soundcloud_embed_nt', 'en', 'SoundCloud embed code is valid, but only tracks are supported. This is not a track', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(289, 'invalid_soundcloud_embed', 'en', 'SoundCloud embed code is invalid', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(290, 'single_episode', 'en', 'Single Episode', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(291, 'collabs', 'en', 'Collaborators', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(292, 'playlist_collabs', 'en', 'You can allow other people to co-manage this playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(293, 'insufficient_fund_tip', 'en', 'You don\'t have enough funds to proceed. Add some funds and try again', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(294, 'successful', 'en', 'successful', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(295, 'purchase_ok_tip', 'en', 'Your purchase has been processed, you have access now! Thanks for the purchase', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(296, 'success', 'en', 'successful', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(297, 'have_access_already_tip', 'en', 'You already have access to this subscription plan', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(298, 'biography', 'en', 'biography', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(299, 'city', 'en', 'city', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(300, 'birthday', 'en', 'birthday', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(301, 'deathday', 'en', 'deathday', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(302, 'a_narrator', 'en', 'narrator', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(303, 'a_genre', 'en', 'genre', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(304, 'social_links', 'en', 'social links', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(305, 'noti_new_follower', 'en', 'New follower', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(306, 'noti_new_playlist_subscriber', 'en', 'New playlist subscriber', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(307, 'noti_plan_purchased', 'en', 'Premium-plan purchase successful', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(308, 'noti_item_purchased', 'en', 'Purchase successful', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(309, 'noti_payment_ok', 'en', 'Payment successful', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(310, 'noti_payment_rejected', 'en', 'Payment rejected', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(311, 'noti_verification_ok', 'en', 'Verification done', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(312, 'noti_verification_rejected', 'en', 'Verification rejected', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(313, 'noti_item_sold', 'en', 'New sale', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(314, 'noti_collabed_in_playlist', 'en', 'Playlist collab', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(315, 'noti_creator_update', 'en', 'New content', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(316, 'noti_new_group_message', 'en', 'New group message', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(317, 'noti_new_1on1_message', 'en', 'New direct message', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(318, 'noti_playlist_update', 'en', 'Playlist update', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(319, 'noti_new_follower_tip', 'en', 'Executed when another user follows you', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(320, 'noti_new_playlist_subscriber_tip', 'en', 'Executed when someone adds your playlist to their library', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(321, 'noti_plan_purchased_tip', 'en', 'Executed when you subscribe to a premium plan', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(322, 'noti_item_purchased_tip', 'en', 'Executed when you make a successful purchase', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(323, 'noti_payment_ok_tip', 'en', 'Executed when your payment is confirmed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(324, 'noti_payment_rejected_tip', 'en', 'Executed when your payment is rejected/failed', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(325, 'noti_verification_ok_tip', 'en', 'Executed when your request to become a creator is accepted', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(326, 'noti_verification_rejected_tip', 'en', 'Executed when your request to become a creator is rejected', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(327, 'noti_item_sold_tip', 'en', 'Executed when someone purchases your content', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(328, 'noti_collabed_in_playlist_tip', 'en', 'Executed when you are added as a collaborator to a playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(329, 'noti_creator_update_tip', 'en', 'Executed when a creator you are subscribed to has new content', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(330, 'noti_new_group_message_tip', 'en', 'Executed when you have a group message', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(331, 'noti_new_1on1_message_tip', 'en', 'Executed when you have a new message', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(332, 'noti_playlist_update_tip', 'en', 'Executed when a playlist you have added to your library is updated', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(333, 'links', 'en', 'links', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(334, 'remove_from_playlist', 'en', 'remove from playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(335, 'request_submited', 'en', 'request submitted', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(336, 'bad_inputs', 'en', 'bad inputs', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(337, 'item', 'en', 'item', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(338, 'msngr_nada', 'en', 'Nothing to show!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(339, 'msngr_nada_tip', 'en', 'It\'s okay! Try subscribing to artists or users and things will appear here!', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(340, 'not_push_tip', 'en', 'Turn on desktop notifications to stay updated', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(341, 'turn_on', 'en', 'turn on', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(342, 'maybe_later', 'en', 'maybe later', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(343, 'mark_as_read', 'en', 'Mark as read', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(344, 'add_funds', 'en', 'add funds', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(345, 'pay_method', 'en', 'Payment method', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(346, 'pay', 'en', 'pay', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(347, 'amount', 'en', 'amount', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(348, 'service_fee', 'en', 'Service fee', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(349, 'service_fee_ced', 'en', 'Amount you\'ll pay', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(350, 'activated', 'en', 'activated', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(351, 'avatar', 'en', 'avatar', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(352, 'user_cover_tip', 'en', 'Used on top of your profile as background image', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(353, 'old_password', 'en', 'old password', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(354, 'no_transactions', 'en', 'No transactions yet', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(355, 'your_funds', 'en', 'Your funds', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(356, 'offline_transfer', 'en', 'offline transfer', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(357, 'deposit', 'en', 'deposit', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(358, 'disperse', 'en', 'disperse', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(359, 'withdraw', 'en', 'withdrawal', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(360, 'commission', 'en', 'commission', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(361, 'sale', 'en', 'sale', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(362, 'payment', 'en', 'payment', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(363, 'user_subs_plan', 'en', 'Subscription Plan', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(364, 'featured_in', 'en', 'featured in', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(365, 'similar_podcasters', 'en', 'Similar Podcasters', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(366, 'related_by_podcaster', 'en', 'Related by podcaster', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(367, 'related_by_writer', 'en', 'related by writer', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(368, 'related_by_translator', 'en', 'related by translator', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(369, 'related_by_narrator', 'en', 'related by narrator', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(370, 'related_by_genre', 'en', 'related by genre', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(371, 'related_by_tag', 'en', 'related by tag', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(372, 'related_by_language', 'en', 'related by language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(373, 'studio_albums', 'en', 'studio albums', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(374, 'single_albums', 'en', 'single albums', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(375, 'related_artists', 'en', 'related artists', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(376, 'related_by_artist', 'en', 'related by artist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(377, 'related_by_ft_artist', 'en', 'Related by featured-artist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(378, 'related_by_lang', 'en', 'Related by language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(379, 'related_by_region', 'en', 'Related by region', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(380, 'related_by_country', 'en', 'Related by country', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(381, 'related_by_city', 'en', 'Related by city', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(382, 'weekly', 'en', 'weekly', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(383, '6months', 'en', '6 months', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(384, 'ugc_playlist', 'en', 'User Playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(385, 'r_country', 'en', 'Radio - Country', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(386, 'nothing_found_s_tip', 'en', 'Try browsing or use other keywords', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(387, 'purchases', 'en', 'purchases', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(388, 'collaborators', 'en', 'Collaborators', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(389, 'playlist_colab_tip', 'en', 'Other users that can manage this playlist', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(390, 'related_by_album', 'en', 'related by album', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(391, 'open_album', 'en', 'open album', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(392, 'open_podcaster', 'en', 'open podcaster', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(393, 'open_category', 'en', 'open category', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(394, 'open_show', 'en', 'open show', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(395, 'open_language', 'en', 'open language', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(396, 'open_region', 'en', 'open region', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(397, 'open_country', 'en', 'open country', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(398, 'open_city', 'en', 'open city', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(399, 'real_name', 'en', 'real name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(400, 'stage_name', 'en', 'stage name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(401, 'attach_document', 'en', 'attach document', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(402, 'additional_data', 'en', 'additional data', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(403, 'podcasting_name', 'en', 'podcasting name', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(404, 'verified', 'en', 'verified', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(405, 'last_release', 'en', 'last release', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(406, 'open_writer', 'en', 'open writer', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(407, 'open_narrator', 'en', 'open narrator', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(408, 'time_add', 'en', 'date created', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(409, 'user_points', 'en', 'points', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(410, 'signup_time', 'en', 'Account age', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(411, 'items', 'en', 'items', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(412, 'childs', 'en', 'childs', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(413, 'blacklisted', 'en', 'blacklisted', 0, 0, 0, '2023-05-06 06:50:43');
INSERT INTO `_d_languages_items` (`ID`, `hook`, `lang_code2`, `text`, `used`, `used_be`, `used_ce`, `time_add`) VALUES(414, 'remove_from_library', 'en', 'Remove from library', 0, 0, 0, '2023-05-06 06:50:43');

DROP TABLE IF EXISTS `_d_menus`;
CREATE TABLE IF NOT EXISTS `_d_menus` (
  `ID` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `comment` text NOT NULL,
  `targets` longtext DEFAULT NULL CHECK (json_valid(`targets`)),
  `structure` longtext DEFAULT NULL CHECK (json_valid(`structure`)),
  `_def` int(1) NOT NULL DEFAULT 0,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_d_menus` (`ID`, `name`, `comment`, `targets`, `structure`, `_def`, `time_add`) VALUES(1, 'Sidebar - Desktop', '', NULL, '[{\"title\":\"RKHM\",\"href\":\"\",\"icon\":\"\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"childs\":[{\"title\":\"Home\",\"href\":\"\\/\",\"icon\":\"home\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Search\",\"href\":\"search\",\"icon\":\"cloud-search-outline\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"title_ar\":\"\"},{\"title\":\"Browse albums\",\"href\":\"browse\\/m_album\",\"icon\":\"magnify\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]},{\"title\":\"User\",\"href\":\"\",\"icon\":\"account\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"childs\":[{\"title\":\"Profile\",\"href\":\"user_area\",\"icon\":\"account\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Add funds\",\"href\":\"user_pay\",\"icon\":\"cash-plus\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Upload\",\"href\":\"upload\",\"icon\":\"account-box\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"title_fa\":\"\"},{\"title\":\"Playlists\",\"href\":\"user_library?tab=playlist\",\"icon\":\"playlist-music\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Likes\",\"href\":\"user_library?tab=likes\",\"icon\":\"cards-heart\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Upgrade\",\"href\":\"subscription_plans\",\"icon\":\"power-plug-outline\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Artist verification\",\"href\":\"become_verified\",\"icon\":\"police-badge\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]}]', 1, '2022-04-20 22:41:39');
INSERT INTO `_d_menus` (`ID`, `name`, `comment`, `targets`, `structure`, `_def`, `time_add`) VALUES(2, 'Navbar - Mobile', '', NULL, '[{\"title\":\"RKHM\",\"href\":\"\",\"icon\":\"home\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"childs\":[{\"title\":\"Home\",\"href\":\"\\/\",\"icon\":\"home\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Browse albums\",\"href\":\"browse\\/m_album\",\"icon\":\"magnify\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]},{\"title\":\"Search\",\"href\":\"search\",\"icon\":\"magnify\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]', 1, '2023-02-19 21:14:20');
INSERT INTO `_d_menus` (`ID`, `name`, `comment`, `targets`, `structure`, `_def`, `time_add`) VALUES(3, 'User Dropdown', '', NULL, '[{\"title\":\"Profile\",\"href\":\"user_area\",\"icon\":\"account\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Add funds\",\"href\":\"user_pay\",\"icon\":\"cash-plus\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Upload\",\"href\":\"upload\",\"icon\":\"account-box\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\",\"title_fa\":\"\"},{\"title\":\"Playlists\",\"href\":\"user_library?tab=playlist\",\"icon\":\"playlist-music\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Likes\",\"href\":\"user_library?tab=likes\",\"icon\":\"cards-heart\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Upgrade\",\"href\":\"subscription_plans\",\"icon\":\"power-plug-outline\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"},{\"title\":\"Artist verification\",\"href\":\"become_verified\",\"icon\":\"police-badge\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]', 1, '2022-09-09 03:47:36');
INSERT INTO `_d_menus` (`ID`, `name`, `comment`, `targets`, `structure`, `_def`, `time_add`) VALUES(4, 'Footer', '', NULL, '[{\"title\":\"Login\",\"href\":\"user_auth?do=login\",\"icon\":\"\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"1\"},{\"title\":\"Terms\",\"href\":\"terms\",\"icon\":\"\",\"user_roles_exclude\":\"\",\"user_roles_only\":\"\"}]', 0, '2023-05-09 17:17:10');

DROP TABLE IF EXISTS `_d_pages`;
CREATE TABLE IF NOT EXISTS `_d_pages` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` text DEFAULT NULL,
  `class` tinytext DEFAULT NULL,
  `s_widgets` int(4) NOT NULL DEFAULT 0,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(11) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_d_pages` (`ID`, `hash`, `name`, `comment`, `class`, `s_widgets`, `time_add`, `time_update`, `seo_url`, `seo_image`, `seo_data`, `active`) VALUES(2, 'd795afd3aa22ca05ba3b3760b7770472', 'Landing page', '', 'no_sidebar fw_container', 6, '2023-03-25 00:36:19', '2023-05-09 17:13:47', '/', 0, '{\"title\":\"Unleash Your Inner Music Maverick\"}', 1);
INSERT INTO `_d_pages` (`ID`, `hash`, `name`, `comment`, `class`, `s_widgets`, `time_add`, `time_update`, `seo_url`, `seo_image`, `seo_data`, `active`) VALUES(1, '5f711117c6e1548ba845c3e8c3de7d8a', 'Search', '', '', 1, '2023-04-26 23:11:39', '2023-05-09 15:08:37', 'search', 0, '{\"title\":\"Discover Your Next Adventure\"}', 1);
INSERT INTO `_d_pages` (`ID`, `hash`, `name`, `comment`, `class`, `s_widgets`, `time_add`, `time_update`, `seo_url`, `seo_image`, `seo_data`, `active`) VALUES(3, 'a9d49ac5174335d20016d4d68e63b87c', 'Artist Verification', '', 'no_sidebar', 3, '2023-05-09 14:27:05', '2023-05-09 14:56:57', 'become_verified', 0, '[]', 1);
INSERT INTO `_d_pages` (`ID`, `hash`, `name`, `comment`, `class`, `s_widgets`, `time_add`, `time_update`, `seo_url`, `seo_image`, `seo_data`, `active`) VALUES(4, '73800b6020e53bbe2836aaeccf116213', 'Terms of usage', '', '', 1, '2023-05-09 14:57:59', '2023-05-09 15:07:28', 'terms', 0, '[]', 1);

DROP TABLE IF EXISTS `_d_pages_widgets`;
CREATE TABLE IF NOT EXISTS `_d_pages_widgets` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(5) NOT NULL,
  `unique_id` varchar(10) NOT NULL,
  `i` varchar(13) NOT NULL DEFAULT '9999',
  `name` varchar(30) NOT NULL,
  `args` longtext NOT NULL,
  `active` int(1) DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(1, '98d9d12f6c', '1', 'search_form', '{\"wid_name\":\"search_form\",\"wid_title\":\"Search\",\"wid_sub_data\":\"Find Your Perfect Match in Seconds!\",\"wid_id\":\"98d9d12f6c\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, '6d5cf0be59', 'c74bc15ad7_1', 'cta', '{\"wid_name\":\"cta\",\"wid_title\":\"Setup\",\"wid_sub_data\":\"How to use RKHM?\",\"background_color\":\"linear-gradient(43deg, #22201d 0%, #009ad2 100%)\",\"font_size\":\"large\",\"img_place\":\"right\",\"height\":\"full\",\"btn_title_1\":\"Docs\",\"btn_link_1\":\"https:\\/\\/support.busyowl.co\\/documentation\\/setup101\",\"wid_id\":\"6d5cf0be59\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, 'ee276fb167', 'c74bc15ad7_0', 'cta', '{\"wid_name\":\"cta\",\"wid_title\":\"Ready to launch!\",\"wid_sub_data\":\"Strap in, folks! It&#039;s rocket time \\ud83d\\ude80\",\"wid_bg_img\":1,\"background_color\":\"radial-gradient(rgba(var(--bg_color),0.6), rgba(var(--bg_color),0.86))\",\"font_size\":\"vlarge\",\"img_place\":\"left\",\"height\":\"full\",\"wid_id\":\"ee276fb167\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, 'c74bc15ad7', '1', 'grid', '{\"wid_name\":\"grid\",\"fitMain\":1,\"columns\":\"8_4\",\"background_color\":\"linear-gradient(to right, #56ccf2, #2f80ed)\",\"wid_id\":\"c74bc15ad7\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(3, '2ae105eb7e', '1', 'cta', '{\"wid_name\":\"cta\",\"wid_title\":\"Sell your content\",\"wid_sub_data\":\"Verify your identity &amp; start earning money\",\"background_color\":\"linear-gradient(to right, #2193b0, #6dd5ed)\",\"font_color\":\"#fff\",\"font_size\":\"vlarge\",\"img\":2,\"img_place\":\"right\",\"height\":\"full\",\"btn_title_1\":\"Submit request\",\"btn_link_1\":\"user_verify?tab=artist\",\"wid_id\":\"2ae105eb7e\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(3, 'cac8631e14', '2', 'steps_list', '{\"wid_name\":\"steps_list\",\"wid_title\":\"Your Roadmap\",\"wid_sub_data\":\"How to earn money as an artist?\",\"features\":\"%7B%22a11d30c3%22%3A%7B%22icon%22%3A%22%22%2C%22title%22%3A%22Sign%20up%22%2C%22text%22%3A%22Sign%20up%20using%20your%20email%20address%22%7D%2C%2207ea9a2d%22%3A%7B%22icon%22%3A%22%22%2C%22title%22%3A%22Verify%22%2C%22text%22%3A%22Submit%20requested%20information%22%7D%2C%2252630d2b%22%3A%7B%22icon%22%3A%22%22%2C%22title%22%3A%22Wait%22%2C%22text%22%3A%22Wait%20for%20us%20to%20review%20your%20request%22%7D%2C%22a97b5205%22%3A%7B%22icon%22%3A%22%22%2C%22title%22%3A%22Upload%22%2C%22text%22%3A%22Upload%20your%20content%20%26%20put%20a%20price%20tag%20on%20them%22%7D%2C%229d2bd000%22%3A%7B%22icon%22%3A%22%22%2C%22title%22%3A%22Withdraw%22%2C%22text%22%3A%22Submit%20a%20request%20to%20withdraw%20your%20earned%20money%22%7D%7D\",\"wid_id\":\"cac8631e14\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(3, '2935ac5481', '3', 'm_artist', '{\"has_manager\":\"1\",\"order_by\":\"name\",\"wid_title\":\"Verified Artists\",\"wid_limit\":10,\"wid_type\":\"slider\",\"wid_slider_size\":\"medium\",\"wid_slider_rows\":1,\"wid_name\":\"m_artist\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(4, 'c89dc0c902', '1', 'text', '{\"wid_name\":\"text\",\"wid_id\":\"c89dc0c902\",\"editor_js\":\"{\\\"time\\\":1683628585966,\\\"blocks\\\":[{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"Welcome to our music sharing\\\\\\/streaming\\\\\\/selling platform! By using our platform, you agree to the following terms of usage:\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"1. Use of the Platform\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"Our platform is designed to allow users to share, stream, and sell music. You may only use our platform for lawful purposes and in compliance with all applicable laws and regulations.\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"2. User Accounts\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"To use our platform, you must create a user account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"3. Content\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"You are solely responsible for the content that you share, stream, or sell on our platform. You represent and warrant that you have all necessary rights to the content and that the content does not infringe on the intellectual property rights of any third party.\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"4. Prohibited Activities\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"You may not use our platform to engage in any of the following activities:\\\"}},{\\\"type\\\":\\\"list\\\",\\\"data\\\":{\\\"style\\\":\\\"ordered\\\",\\\"items\\\":[\\\"Violating any laws or regulations\\\",\\\"Infringing on the intellectual property rights of any third party\\\",\\\"Uploading or sharing content that is illegal, offensive, or harmful\\\",\\\"Interfering with the proper functioning of the platform\\\",\\\"Attempting to gain unauthorized access to the platform or to other users\' accounts\\\"]}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"5. Payment\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"If you sell music on our platform, you will receive payment for your sales in accordance with our payment policies. We reserve the right to withhold payment for any sales that violate our terms of usage.\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"6. Termination\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"We may terminate your user account and\\\\\\/or access to our platform at any time and for any reason, without notice.\\\"}},{\\\"type\\\":\\\"header\\\",\\\"data\\\":{\\\"text\\\":\\\"7. Changes to the Terms\\\",\\\"level\\\":2}},{\\\"type\\\":\\\"paragraph\\\",\\\"data\\\":{\\\"text\\\":\\\"We reserve the right to modify these terms of usage at any time. Your continued use of our platform after any such modifications constitutes your acceptance of the updated terms\\\"}}],\\\"version\\\":\\\"2.26.5\\\",\\\"html\\\":\\\"<div class=\'editorjs_html_wrapper\'><p>Welcome to our music sharing\\\\\\/streaming\\\\\\/selling platform! By using our platform, you agree to the following terms of usage:<\\\\\\/p><h2>1. Use of the Platform<\\\\\\/h2><p>Our platform is designed to allow users to share, stream, and sell music. You may only use our platform for lawful purposes and in compliance with all applicable laws and regulations.<\\\\\\/p><h2>2. User Accounts<\\\\\\/h2><p>To use our platform, you must create a user account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.<\\\\\\/p><h2>3. Content<\\\\\\/h2><p>You are solely responsible for the content that you share, stream, or sell on our platform. You represent and warrant that you have all necessary rights to the content and that the content does not infringe on the intellectual property rights of any third party.<\\\\\\/p><h2>4. Prohibited Activities<\\\\\\/h2><p>You may not use our platform to engage in any of the following activities:<\\\\\\/p><ol><li>Violating any laws or regulations<\\\\\\/li><li>Infringing on the intellectual property rights of any third party<\\\\\\/li><li>Uploading or sharing content that is illegal, offensive, or harmful<\\\\\\/li><li>Interfering with the proper functioning of the platform<\\\\\\/li><li>Attempting to gain unauthorized access to the platform or to other users\' accounts<\\\\\\/li><\\\\\\/ol><h2>5. Payment<\\\\\\/h2><p>If you sell music on our platform, you will receive payment for your sales in accordance with our payment policies. We reserve the right to withhold payment for any sales that violate our terms of usage.<\\\\\\/p><h2>6. Termination<\\\\\\/h2><p>We may terminate your user account and\\\\\\/or access to our platform at any time and for any reason, without notice.<\\\\\\/p><h2>7. Changes to the Terms<\\\\\\/h2><p>We reserve the right to modify these terms of usage at any time. Your continued use of our platform after any such modifications constitutes your acceptance of the updated terms<\\\\\\/p><\\\\\\/div>\\\",\\\"files\\\":{\\\"images\\\":[],\\\"videos\\\":[]}}\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, '07e3de4c02', '3e92c18162_0', 'cta', '{\"wid_name\":\"cta\",\"wid_title\":\"Support\",\"wid_sub_data\":\"Need help? We&#039;ve got your app covered!\",\"font_size\":\"medium\",\"img_place\":\"left\",\"height\":\"auto\",\"btn_title_1\":\"Support Center\",\"btn_link_1\":\"https:\\/\\/support.busyowl.co\\/\",\"wid_id\":\"07e3de4c02\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, '0b4b1ad6aa', '3e92c18162_1', 'cta', '{\"wid_name\":\"cta\",\"wid_title\":\"Get Inspired\",\"wid_sub_data\":\"&quot;Export&quot; favorite page from demo site &amp; &quot;import&quot; to your app!\",\"font_size\":\"medium\",\"img_place\":\"left\",\"height\":\"auto\",\"btn_title_1\":\"Demo\",\"btn_link_1\":\"https:\\/\\/support.busyowl.co\\/documentation\\/demo\",\"wid_id\":\"0b4b1ad6aa\"}');
INSERT INTO `_d_pages_widgets` (`page_id`, `unique_id`, `i`, `name`, `args`) VALUES(2, '3e92c18162', '2', 'grid', '{\"wid_name\":\"grid\",\"fitMain\":1,\"columns\":\"6_6\",\"wid_id\":\"3e92c18162\"}');

DROP TABLE IF EXISTS `_u_actions`;
CREATE TABLE IF NOT EXISTS `_u_actions` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `user_id` int(7) NOT NULL,
  `type` varchar(60) NOT NULL,
  `object_name` varchar(50) NOT NULL,
  `object_id` int(11) NOT NULL,
  `related_object_type` varchar(50) DEFAULT NULL,
  `related_object_id` int(11) DEFAULT NULL,
  `extra_data` mediumblob DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `object_type` (`object_name`,`object_id`),
  KEY `related_object_type` (`related_object_type`,`related_object_id`),
  KEY `time_add` (`time_add`),
  KEY `user_id_2` (`user_id`,`type`),
  KEY `user_id_3` (`user_id`,`type`,`object_name`,`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_list`;
CREATE TABLE IF NOT EXISTS `_u_list` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `username` varchar(50) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(150) NOT NULL,
  `role_ids` tinytext DEFAULT NULL,
  `external_addresses` text DEFAULT NULL,
  `avatar_id` int(11) DEFAULT NULL,
  `bg_img_id` int(11) DEFAULT NULL,
  `fund` float DEFAULT 0,
  `fund_by_deposit` float DEFAULT 0,
  `fund_by_revenue` float DEFAULT 0,
  `fund_by_referring` float NOT NULL DEFAULT 0,
  `s_posts` int(7) NOT NULL DEFAULT 0,
  `s_followers` int(11) DEFAULT 0,
  `s_followings` int(5) DEFAULT 0,
  `s_subscriptions` int(7) NOT NULL DEFAULT 0,
  `s_likes` int(7) DEFAULT 0,
  `s_playlists` int(5) DEFAULT 0,
  `s_playlists_followers` int(7) DEFAULT 0,
  `s_payments` int(11) NOT NULL DEFAULT 0,
  `s_transactions` int(11) NOT NULL DEFAULT 0,
  `feed_setting` tinytext DEFAULT NULL,
  `not_setting` tinytext DEFAULT NULL,
  `email_setting` tinytext DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_verify` timestamp NULL DEFAULT NULL,
  `time_online` timestamp NULL DEFAULT NULL,
  `time_notified` timestamp NULL DEFAULT NULL,
  `time_verify_try` timestamp NULL DEFAULT NULL,
  `verification_code` varchar(32) DEFAULT NULL,
  `extraData` mediumblob DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `hash` (`hash`),
  KEY `time_online` (`time_online`),
  KEY `time_verify` (`time_verify`),
  KEY `time_add` (`time_add`),
  KEY `time_notified` (`time_notified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_notifications`;
CREATE TABLE IF NOT EXISTS `_u_notifications` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `hook` varchar(100) NOT NULL,
  `user_id` int(7) DEFAULT NULL,
  `target_email` varchar(200) DEFAULT NULL,
  `target_push_count` int(3) DEFAULT NULL,
  `triggerer_object` varchar(60) DEFAULT NULL,
  `triggerer_id` int(11) DEFAULT NULL,
  `source_object` varchar(60) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  `message_type` varchar(100) NOT NULL,
  `message_texts` longtext DEFAULT NULL CHECK (json_valid(`message_texts`)),
  `message_params` longtext DEFAULT NULL CHECK (json_valid(`message_params`)),
  `message_image` text DEFAULT NULL,
  `message_link` text DEFAULT NULL,
  `method_email` int(1) DEFAULT 0,
  `method_push` int(1) DEFAULT 0,
  `extra` longtext DEFAULT NULL CHECK (json_valid(`extra`)),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_seen` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `method_email` (`method_email`),
  KEY `method_push` (`method_push`),
  KEY `source_object` (`source_object`),
  KEY `source_id` (`source_id`),
  KEY `source_object_2` (`source_object`,`source_id`),
  KEY `time_seen` (`time_seen`),
  KEY `time_add` (`time_add`),
  KEY `target_object` (`triggerer_object`),
  KEY `target_id` (`triggerer_id`),
  KEY `target_email` (`target_email`),
  KEY `user_id_2` (`user_id`,`source_object`,`source_id`),
  KEY `hook` (`hook`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_payments`;
CREATE TABLE IF NOT EXISTS `_u_payments` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `_num` varchar(12) NOT NULL,
  `_key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `currency` varchar(3) NOT NULL,
  `data` mediumtext DEFAULT NULL,
  `gateway_name` varchar(30) NOT NULL,
  `gateway_id` varchar(100) DEFAULT NULL,
  `gateway_amount` float DEFAULT NULL,
  `gateway_currency` varchar(3) DEFAULT NULL,
  `gateway_data` mediumtext DEFAULT NULL,
  `paid` int(1) NOT NULL DEFAULT 0,
  `approved` int(1) NOT NULL DEFAULT 0,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_pay` timestamp NULL DEFAULT NULL,
  `time_approve` timestamp NULL DEFAULT NULL,
  `time_reject` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `gateway_name` (`gateway_name`),
  KEY `_key` (`_key`),
  KEY `user_id` (`user_id`),
  KEY `gateway_id` (`gateway_id`),
  KEY `time_add` (`time_add`),
  KEY `time_pay` (`time_pay`),
  KEY `time_approve` (`time_approve`),
  KEY `time_reject` (`time_reject`),
  KEY `paid` (`paid`),
  KEY `approved` (`approved`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_playlists`;
CREATE TABLE IF NOT EXISTS `_u_playlists` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cover_id` int(11) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `private` int(1) NOT NULL DEFAULT 0,
  `object_type` varchar(50) DEFAULT NULL,
  `s_items` int(4) NOT NULL DEFAULT 0,
  `s_subscribers` int(9) NOT NULL DEFAULT 0,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(11) NOT NULL DEFAULT 0,
  `extra_data` longtext DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `time_update` timestamp NOT NULL DEFAULT current_timestamp(),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(11) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  KEY `user_id` (`user_id`),
  KEY `time_add` (`time_add`),
  KEY `private` (`private`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_properties`;
CREATE TABLE IF NOT EXISTS `_u_properties` (
  `ID` int(7) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `user_id` int(7) NOT NULL,
  `type` varchar(60) NOT NULL,
  `object_name` varchar(50) NOT NULL,
  `object_id` int(11) NOT NULL,
  `related_object_name` varchar(50) DEFAULT NULL,
  `related_object_id` int(11) DEFAULT NULL,
  `i` int(4) DEFAULT NULL,
  `extra_data` tinyblob DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `object_type` (`object_name`,`object_id`),
  KEY `time_add` (`time_add`),
  KEY `user_id_2` (`user_id`,`type`),
  KEY `type_2` (`type`,`related_object_name`,`related_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_push_subs`;
CREATE TABLE IF NOT EXISTS `_u_push_subs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(7) NOT NULL,
  `data` longtext NOT NULL CHECK (json_valid(`data`)),
  `data_hash` varchar(32) NOT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `data_hash` (`data_hash`),
  KEY `time_add` (`time_add`),
  KEY `user_id_2` (`user_id`,`data_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_relations`;
CREATE TABLE IF NOT EXISTS `_u_relations` (
  `user_id` int(9) NOT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `i` int(3) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`target_id`,`type`),
  KEY `ID1` (`user_id`,`type`),
  KEY `ID2` (`target_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_requests`;
CREATE TABLE IF NOT EXISTS `_u_requests` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  `user_id` int(7) NOT NULL,
  `real_name` varchar(150) NOT NULL,
  `extra_data` longtext DEFAULT NULL CHECK (json_valid(`extra_data`)),
  `additional_data` mediumtext NOT NULL,
  `sta` int(1) DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_review` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `time_add` (`time_add`),
  KEY `time_review` (`time_review`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_roles`;
CREATE TABLE IF NOT EXISTS `_u_roles` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `comment` text DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `def` int(1) NOT NULL DEFAULT 0,
  `bofAdmin_access` longtext DEFAULT NULL,
  `access` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `comparators` longtext DEFAULT NULL,
  `s_users` int(11) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `type` (`type`),
  KEY `def` (`def`),
  KEY `type_2` (`type`,`def`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `_u_roles` (`ID`, `name`, `comment`, `type`, `def`, `bofAdmin_access`, `access`, `data`, `comparators`, `s_users`, `time_add`) VALUES(1, 'Guests', 'Not logged-in visitors', 'guest', 1, '[]', NULL, '{\"guest\":{\"guest_ads\":true,\"guest_download\":true,\"guest_download_in\":true,\"guest_download_out\":true,\"guest_language\":true,\"guest_signup\":true,\"guest_signup_verify\":true,\"guest_player\":\"audio_quality_1;audio_quality_2;audio_quality_3;audio_quality_4;audio_quality_5;video_quality_1;video_quality_2;video_quality_3;video_quality_4;video_quality_5;soundcloud;youtube\",\"guest_download_types\":\"audio_quality_1;audio_quality_2;audio_quality_3;audio_quality_4;audio_quality_5;video_quality_1;video_quality_2;video_quality_3;video_quality_4;video_quality_5\"},\"podcaster\":[],\"artist\":[]}', NULL, 0, '2021-12-28 22:36:56');
INSERT INTO `_u_roles` (`ID`, `name`, `comment`, `type`, `def`, `bofAdmin_access`, `access`, `data`, `comparators`, `s_users`, `time_add`) VALUES(2, 'Users', 'Logged-in users\r\nDefault role for new users', 'user', 1, '[]', NULL, '{\"user\":{\"user_ads\":true,\"user_language\":true,\"user_download\":true,\"user_download_in\":true,\"user_download_out\":true,\"user_upload\":true,\"user_upload_music\":true,\"user_upload_music_types\":\"audio;video;soundcloud;youtube\",\"user_upload_podcast\":true,\"user_upload_podcast_types\":\"audio;video;youtube\",\"user_premium\":\"none\",\"user_premium_b_post\":false,\"user_premium_p_podcaster\":false,\"user_premium_p_show\":false,\"user_premium_p_tag\":false,\"user_premium_p_category\":false,\"user_premium_m_artist\":false,\"user_premium_m_genre\":false,\"user_premium_m_tag\":false,\"user_player\":\"audio_quality_1;audio_quality_2;audio_quality_3;audio_quality_4;audio_quality_5;video_quality_1;video_quality_2;video_quality_3;video_quality_4;video_quality_5;soundcloud;youtube\",\"user_download_types\":\"audio_quality_1;audio_quality_2;audio_quality_3;audio_quality_4;audio_quality_5;video_quality_1;video_quality_2;video_quality_3;video_quality_4;video_quality_5\",\"user_p_download_types\":null,\"user_p_player\":null},\"podcaster\":[],\"artist\":[]}', NULL, 186, '2021-12-29 00:04:07');
INSERT INTO `_u_roles` (`ID`, `name`, `comment`, `type`, `def`, `bofAdmin_access`, `access`, `data`, `comparators`, `s_users`, `time_add`) VALUES(3, 'Moderators', 'Logged-in users with limited access to admin', 'moderator', 1, '{\"objects\":[\"language\"],\"objects_args\":{\"language\":{\"new\":true,\"list\":true}},\"type\":\"all\"}', NULL, '{\"podcaster\":[]}', NULL, 0, '2021-12-29 00:09:43');
INSERT INTO `_u_roles` (`ID`, `name`, `comment`, `type`, `def`, `bofAdmin_access`, `access`, `data`, `comparators`, `s_users`, `time_add`) VALUES(4, 'Admins', 'Logged-in super heroes', 'admin', 1, NULL, NULL, NULL, NULL, 1, '2021-12-29 00:11:00');

DROP TABLE IF EXISTS `_u_setting`;
CREATE TABLE IF NOT EXISTS `_u_setting` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(7) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'raw',
  `var` varchar(40) NOT NULL,
  `val` longtext NOT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `time_update` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `user_id` (`user_id`,`var`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_subs`;
CREATE TABLE IF NOT EXISTS `_u_subs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(7) NOT NULL,
  `subs_plan_id` int(3) NOT NULL,
  `subs_plan_time_range` varchar(20) NOT NULL,
  `subs_plan_price` float DEFAULT 0,
  `time_purchased` timestamp NULL DEFAULT current_timestamp(),
  `time_expire` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `subs_plan` (`subs_plan_id`),
  KEY `user_id_2` (`user_id`,`time_expire`),
  KEY `user_id_3` (`user_id`,`subs_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_subs_plans`;
CREATE TABLE IF NOT EXISTS `_u_subs_plans` (
  `ID` int(3) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` tinytext NOT NULL,
  `detail` mediumtext NOT NULL,
  `prices` mediumtext NOT NULL,
  `discount` float DEFAULT NULL,
  `target_role_id` int(3) NOT NULL,
  `active` int(1) DEFAULT 1,
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

DROP TABLE IF EXISTS `_u_transactions`;
CREATE TABLE IF NOT EXISTS `_u_transactions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_fund` float NOT NULL,
  `amount` float NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `revenue` float NOT NULL DEFAULT 0,
  `type` varchar(30) NOT NULL,
  `object_type` varchar(50) DEFAULT NULL,
  `object_id` int(11) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `object_type` (`object_type`),
  KEY `object_id` (`object_id`),
  KEY `time_add` (`time_add`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

ALTER TABLE `_d_pages` ADD `pre_design` VARCHAR(30) NULL DEFAULT NULL AFTER `class`, ADD INDEX (`pre_design`);
ALTER TABLE `_d_pages_widgets` ADD INDEX(`active`);
ALTER TABLE `_d_pages_widgets` ADD INDEX(`page_id`);
ALTER TABLE `_d_pages_widgets` ADD INDEX(`unique_id`);
ALTER TABLE `_d_pages_widgets` ADD INDEX(`i`);
ALTER TABLE `_d_pages_widgets` ADD `native` VARCHAR(20) NULL DEFAULT NULL AFTER `args`, ADD INDEX (`native`);
ALTER TABLE `_d_pages` CHANGE `active` `active` INT(1) NOT NULL DEFAULT '1';
ALTER TABLE `_d_pages` ADD INDEX(`active`);
ALTER TABLE `_d_pages_widgets` CHANGE `i` `i` VARCHAR(14) NOT NULL DEFAULT '9999';

ALTER TABLE `_u_list` ADD `s_managed_artists` INT(3) NOT NULL DEFAULT '0' AFTER `s_transactions`, ADD INDEX (`s_managed_artists`);

INSERT INTO `_u_roles` ( `name`, `comment`, `type`, `def`, `bofAdmin_access`, `access`, `data`, `comparators`, `s_users`) VALUES
('Artist Managers', 'Default `Artist Manager` role', 'artist', 1, '[]', NULL, '{\"artist\":{\"fixed_fee\":0,\"dyna_fee\":30,\"streaming_royalty\":0.001},\"affiliate\":[]}', NULL, 0);

CREATE TABLE IF NOT EXISTS `_c_m_albums` (
  `ID` int(8) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(150) NOT NULL,
  `title` tinytext NOT NULL,
  `type` varchar(20) NOT NULL,
  `price` float DEFAULT NULL,
  `price_setting` longtext DEFAULT NULL CHECK (json_valid(`price_setting`)),
  `explicit` int(1) DEFAULT 0,
  `description` mediumtext DEFAULT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `artist_id` int(8) NOT NULL,
  `uploader_id` int(8) DEFAULT NULL,
  `spotify_id` varchar(30) DEFAULT NULL,
  `spotify_cover` text DEFAULT NULL,
  `spotify_popularity` int(3) DEFAULT NULL,
  `s_tracks` int(3) NOT NULL DEFAULT 0,
  `s_tracks_duration` int(6) NOT NULL DEFAULT 0,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_likes` int(6) NOT NULL DEFAULT 0,
  `s_reposts` int(6) NOT NULL DEFAULT 0,
  `s_comments` int(9) NOT NULL DEFAULT 0,
  `s_sales` int(6) NOT NULL DEFAULT 0,
  `s_shares` int(9) NOT NULL DEFAULT 0,
  `s_popularity` int(3) NOT NULL DEFAULT 0,
  `s_sources_local` int(1) NOT NULL DEFAULT 0,
  `time_play` timestamp NULL DEFAULT NULL,
  `time_spotify` timestamp NULL DEFAULT NULL,
  `time_release` date DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `seo_url` (`seo_url`),
  KEY `type` (`type`),
  KEY `price` (`price`),
  KEY `explicit` (`explicit`),
  KEY `artist_id` (`artist_id`),
  KEY `user_id` (`uploader_id`),
  KEY `spotify_id` (`spotify_id`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_likes` (`s_likes`),
  KEY `s_reposts` (`s_reposts`),
  KEY `s_comments` (`s_comments`),
  KEY `s_sales` (`s_sales`),
  KEY `s_shares` (`s_shares`),
  KEY `s_popularity` (`s_popularity`),
  KEY `time_play` (`time_play`),
  KEY `time_release` (`time_release`),
  KEY `time_add` (`time_add`),
  KEY `s_tracks` (`s_tracks`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_albums_relations` (
  `album_id` int(9) NOT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `i` int(6) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`album_id`,`target_id`,`type`),
  KEY `ID1` (`album_id`,`type`),
  KEY `ID2` (`target_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_artists` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(150) NOT NULL,
  `name` text DEFAULT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `manager_id` int(9) DEFAULT NULL,
  `spotify_id` varchar(36) DEFAULT NULL,
  `spotify_cover` text DEFAULT NULL,
  `spotify_popularity` int(3) DEFAULT NULL,
  `spotify_followers` bigint(20) DEFAULT NULL,
  `bio_name` varchar(200) DEFAULT NULL,
  `bio_country` varchar(100) DEFAULT NULL,
  `bio_city` varchar(100) DEFAULT NULL,
  `bio_content` longtext DEFAULT NULL,
  `bio_birthday` datetime DEFAULT NULL,
  `bio_deathday` datetime DEFAULT NULL,
  `external_addresses` text DEFAULT NULL,
  `s_albums` int(4) NOT NULL DEFAULT 0,
  `s_subscribers` int(7) NOT NULL DEFAULT 0,
  `s_tracks` int(5) NOT NULL DEFAULT 0,
  `s_tracks_as_ft` int(5) NOT NULL DEFAULT 0,
  `s_albums_as_ft` int(4) NOT NULL DEFAULT 0,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_popularity` int(3) NOT NULL DEFAULT 0,
  `s_managed` int(1) DEFAULT 0,
  `time_play` timestamp NULL DEFAULT NULL,
  `time_release` datetime DEFAULT NULL,
  `time_spotify` timestamp NULL DEFAULT NULL,
  `time_spotify_related` timestamp NULL DEFAULT NULL,
  `time_spotify_albums` timestamp NULL DEFAULT NULL,
  `time_spotify_discography` timestamp NULL DEFAULT NULL,
  `time_spotify_tracks` timestamp NULL DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `seo_url` (`seo_url`),
  KEY `spotify_id` (`spotify_id`),
  KEY `spotify_popularity` (`spotify_popularity`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `time_add` (`time_add`),
  KEY `time_release` (`time_release`),
  KEY `time_play` (`time_play`),
  KEY `s_popularity` (`s_popularity`),
  KEY `s_albums` (`s_albums`),
  KEY `s_subscribers` (`s_subscribers`),
  KEY `s_tracks` (`s_tracks`),
  KEY `s_tracks_as_ft` (`s_tracks_as_ft`),
  KEY `s_albums_as_ft` (`s_albums_as_ft`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_artists_relations` (
  `artist_id` int(9) NOT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `i` int(3) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`artist_id`,`target_id`,`type`),
  KEY `ID1` (`artist_id`,`type`),
  KEY `ID2` (`target_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_cronjobs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `comment` tinytext DEFAULT NULL,
  `update_interval` float NOT NULL,
  `execution_interval` int(11) NOT NULL DEFAULT 1,
  `item_limit` int(4) NOT NULL DEFAULT 10,
  `dynamic` tinyint(1) NOT NULL DEFAULT 0,
  `object_type` varchar(20) NOT NULL,
  `object_filters` text DEFAULT NULL,
  `api_name` varchar(20) NOT NULL,
  `api_ids` text DEFAULT NULL,
  `cache` mediumtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `active` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`ID`),
  KEY `update_interval` (`update_interval`,`time_update`,`active`),
  KEY `execution_interval` (`execution_interval`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_cronjobs_spotify` (
  `cron_id` int(5) NOT NULL,
  `spotify_id` varchar(22) NOT NULL,
  `local_id` int(8) DEFAULT NULL,
  `time_check` timestamp NULL DEFAULT NULL,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cron_id`,`spotify_id`),
  KEY `local_id` (`local_id`),
  KEY `time_check` (`time_check`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_events` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `name` varchar(300) NOT NULL,
  `cover_id` int(11) DEFAULT NULL,
  `manager_id` int(11) NOT NULL,
  `price` float DEFAULT NULL,
  `maximum` int(6) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `website` tinytext DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(11) NOT NULL DEFAULT 0,
  `s_sales` int(11) NOT NULL DEFAULT 0,
  `time_add` timestamp NOT NULL DEFAULT current_timestamp(),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(11) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_genres` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(100) NOT NULL,
  `parent_id` int(5) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_tracks` int(11) NOT NULL DEFAULT 0,
  `s_albums` int(9) NOT NULL DEFAULT 0,
  `s_artists` int(9) NOT NULL DEFAULT 0,
  `s_childs` int(5) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `code` (`code`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_tracks` (`s_tracks`),
  KEY `s_albums` (`s_albums`),
  KEY `s_artists` (`s_artists`),
  KEY `time_add` (`time_add`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`),
  KEY `parent_id` (`parent_id`),
  KEY `s_childs` (`s_childs`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_langs` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_tracks` int(11) NOT NULL DEFAULT 0,
  `s_albums` int(9) NOT NULL DEFAULT 0,
  `s_artists` int(9) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `code` (`code`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_tracks` (`s_tracks`),
  KEY `s_albums` (`s_albums`),
  KEY `s_artists` (`s_artists`),
  KEY `time_add` (`time_add`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_tags` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_tracks` int(11) NOT NULL DEFAULT 0,
  `s_albums` int(9) NOT NULL DEFAULT 0,
  `s_artists` int(9) NOT NULL DEFAULT 0,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `seo_url` (`seo_url`),
  UNIQUE KEY `hash` (`hash`),
  KEY `code` (`code`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_tracks` (`s_tracks`),
  KEY `s_albums` (`s_albums`),
  KEY `s_artists` (`s_artists`),
  KEY `time_add` (`time_add`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_tracks` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) NOT NULL,
  `code` varchar(150) NOT NULL,
  `title` tinytext NOT NULL,
  `duration` int(4) DEFAULT NULL,
  `price` float DEFAULT 0,
  `price_setting` longtext DEFAULT NULL CHECK (json_valid(`price_setting`)),
  `explicit` int(1) NOT NULL DEFAULT 0,
  `cover_id` int(7) DEFAULT NULL,
  `bg_id` int(7) DEFAULT NULL,
  `artist_id` int(8) NOT NULL,
  `album_id` int(8) NOT NULL,
  `album_index` int(3) DEFAULT NULL,
  `album_cd` int(2) DEFAULT NULL,
  `album_artist_id` int(8) DEFAULT NULL,
  `album_price` float DEFAULT NULL,
  `uploader_id` int(8) DEFAULT NULL,
  `spotify_id` varchar(36) DEFAULT NULL,
  `spotify_cover` text DEFAULT NULL,
  `spotify_popularity` int(3) DEFAULT NULL,
  `musixmatch_id` int(11) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `lyrics` longtext DEFAULT NULL,
  `s_views` int(11) NOT NULL DEFAULT 0,
  `s_views_unique` int(9) NOT NULL DEFAULT 0,
  `s_plays` int(11) NOT NULL DEFAULT 0,
  `s_plays_unique` int(9) NOT NULL DEFAULT 0,
  `s_likes` int(6) NOT NULL DEFAULT 0,
  `s_reposts` int(9) NOT NULL DEFAULT 0,
  `s_downloads` int(9) NOT NULL DEFAULT 0,
  `s_downloads_unique` int(9) NOT NULL DEFAULT 0,
  `s_comments` int(9) NOT NULL DEFAULT 0,
  `s_playlists` int(6) NOT NULL DEFAULT 0,
  `s_sales` int(6) NOT NULL DEFAULT 0,
  `s_shares` int(9) NOT NULL DEFAULT 0,
  `s_popularity` int(3) NOT NULL DEFAULT 0,
  `s_sources` int(2) NOT NULL DEFAULT 0,
  `s_sources_local` int(1) NOT NULL DEFAULT 0,
  `s_muse_report` int(6) DEFAULT 0,
  `time_play` timestamp NULL DEFAULT NULL,
  `time_release` datetime DEFAULT NULL,
  `time_spotify` timestamp NULL DEFAULT NULL,
  `time_musixmatch` timestamp NULL DEFAULT NULL,
  `time_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  `translations` longtext DEFAULT NULL CHECK (json_valid(`translations`)),
  `seo_url` varchar(200) NOT NULL,
  `seo_image` int(7) DEFAULT NULL,
  `seo_data` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `seo_url` (`seo_url`),
  KEY `price` (`price`),
  KEY `explicit` (`explicit`),
  KEY `artist_id` (`artist_id`),
  KEY `album_id` (`album_id`),
  KEY `album_artist_id` (`album_artist_id`),
  KEY `user_id` (`uploader_id`),
  KEY `spotify_id` (`spotify_id`),
  KEY `spotify_popularity` (`spotify_popularity`),
  KEY `s_views` (`s_views`),
  KEY `s_views_unique` (`s_views_unique`),
  KEY `s_plays` (`s_plays`),
  KEY `time_add` (`time_add`),
  KEY `time_release` (`time_release`),
  KEY `time_play` (`time_play`),
  KEY `s_sources_local` (`s_sources_local`),
  KEY `s_sources` (`s_sources`),
  KEY `s_plays_unique` (`s_plays_unique`),
  KEY `s_likes` (`s_likes`),
  KEY `s_reposts` (`s_reposts`),
  KEY `s_downloads` (`s_downloads`),
  KEY `s_dowloads_unique` (`s_downloads_unique`),
  KEY `s_comments` (`s_comments`),
  KEY `s_playlists` (`s_playlists`),
  KEY `s_sales` (`s_sales`),
  KEY `s_shares` (`s_shares`),
  KEY `s_popularity` (`s_popularity`),
  KEY `time_spotify` (`time_spotify`),
  KEY `cover_id` (`cover_id`),
  KEY `bg_id` (`bg_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_tracks_relations` (
  `track_id` int(9) NOT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `i` int(4) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`track_id`,`target_id`,`type`),
  KEY `ID1` (`track_id`,`type`),
  KEY `ID2` (`target_id`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
CREATE TABLE IF NOT EXISTS `_c_m_tracks_sources` (
  `ID` int(9) NOT NULL AUTO_INCREMENT,
  `hash` varchar(32) DEFAULT NULL,
  `target_id` int(9) NOT NULL,
  `type` varchar(10) NOT NULL,
  `title` tinytext DEFAULT NULL,
  `download_able` int(1) DEFAULT NULL,
  `stream_able` int(1) DEFAULT NULL,
  `encrypted` int(1) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `quality` int(1) DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `force_free` int(1) NOT NULL DEFAULT 0,
  `protected` int(1) NOT NULL DEFAULT 0,
  `queue` int(1) NOT NULL DEFAULT 0,
  `queue_old` int(11) DEFAULT NULL,
  `time_add` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ID`),
  UNIQUE KEY `hash` (`hash`),
  KEY `track_id` (`target_id`),
  KEY `type` (`type`),
  KEY `track_id_2` (`target_id`,`type`),
  KEY `quality` (`quality`),
  KEY `force_free` (`force_free`),
  KEY `queue` (`queue`),
  KEY `download_able` (`download_able`),
  KEY `stream_able` (`stream_able`),
  KEY `protected` (`protected`),
  KEY `encrypted` (`encrypted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

TRUNCATE TABLE `_bof_log_db`;
COMMIT;
