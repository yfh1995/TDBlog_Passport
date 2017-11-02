-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-11-02 14:02:39
-- 服务器版本： 10.1.26-MariaDB
-- PHP Version: 7.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tdblog`
--

-- --------------------------------------------------------

--
-- 表的结构 `admin_configs`
--

CREATE TABLE `admin_configs` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '配置键',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '配置值',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态，0：关闭配置，1：开启配置',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统参数配置表';

--
-- 转存表中的数据 `admin_configs`
--

INSERT INTO `admin_configs` (`id`, `key`, `value`, `status`, `created_at`, `updated_at`) VALUES
(1, 'backend_page_size', '20', 1, '2017-09-29 03:42:48', '2017-09-29 03:42:48'),
(2, 'email_min_length', '255', 1, '2017-10-26 05:40:16', NULL),
(3, 'password_min_length', '5', 1, '2017-10-26 05:40:16', NULL),
(4, 'password_max_length', '255', 1, '2017-10-26 05:40:29', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `admin_emoticons`
--

CREATE TABLE `admin_emoticons` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL COMMENT '所属表情包组',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '表情名',
  `file_id` int(11) NOT NULL COMMENT '表情图片id',
  `sort` int(11) NOT NULL COMMENT '排序，同一表情包组下有效',
  `owner_id` int(11) NOT NULL DEFAULT '0' COMMENT '拥有者，0：系统',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `admin_emoticon_group`
--

CREATE TABLE `admin_emoticon_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '表情包组组名',
  `sort` int(11) NOT NULL COMMENT '排序，同一表情包组下有效',
  `owner_id` int(11) NOT NULL DEFAULT '0' COMMENT '拥有者，0：系统',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `admin_files`
--

CREATE TABLE `admin_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '文件路径',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '文件名',
  `size` bigint(20) NOT NULL COMMENT '大小',
  `format` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '后缀名',
  `md5` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'md5值',
  `owner_num` int(11) NOT NULL DEFAULT '1' COMMENT '文件拥有者数量，当此值为0时，删除文件',
  `download_num` int(11) NOT NULL DEFAULT '0' COMMENT '下载量',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `admin_menu`
--

CREATE TABLE `admin_menu` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permission_slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '所需权限',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_menu`
--

INSERT INTO `admin_menu` (`id`, `parent_id`, `order`, `title`, `icon`, `uri`, `permission_slug`, `created_at`, `updated_at`) VALUES
(1, 0, 1, '首页', 'fa-bar-chart', '/', 'BackendIndex', NULL, '2017-09-28 10:29:51'),
(2, 0, 2, '管理', 'fa-tasks', '', 'BackendAdmin', NULL, '2017-09-29 02:01:11'),
(3, 2, 3, '用户', 'fa-users', 'auth/users', 'BackendAdminUser', NULL, '2017-09-29 02:01:26'),
(4, 2, 4, '角色', 'fa-user', 'auth/roles', 'BackendAdminRole', NULL, '2017-09-29 02:01:38'),
(5, 2, 5, '权限', 'fa-user', 'auth/permissions', 'BackendAdminPermission', NULL, '2017-09-29 02:01:51'),
(6, 2, 6, '菜单', 'fa-bars', 'auth/menu', 'BackendAdminMenu', NULL, '2017-09-29 02:02:02'),
(7, 2, 7, '日志', 'fa-history', 'auth/logs', 'BackendAdminLog', NULL, '2017-09-29 02:02:14'),
(8, 0, 9, 'Helpers', 'fa-gears', '', 'BackendHelper', NULL, '2017-09-29 02:45:04'),
(9, 8, 10, 'Scaffold', 'fa-keyboard-o', 'helpers/scaffold', 'BackendHelperCsaffold', NULL, '2017-09-29 02:45:04'),
(10, 8, 11, 'Database terminal', 'fa-database', 'helpers/terminal/database', 'BackendHelperDatabase', NULL, '2017-09-29 02:45:04'),
(11, 8, 12, 'Laravel artisan', 'fa-terminal', 'helpers/terminal/artisan', 'BackendHelperArtisan', NULL, '2017-09-29 02:45:04'),
(13, 0, 8, '模块', 'fa-cubes', '', 'BackendIndex', '2017-09-29 02:44:45', '2017-09-29 02:45:04'),
(14, 2, 0, '配置', 'fa-cog', 'auth/configs', 'BackendIndex', '2017-09-29 02:54:22', '2017-09-29 02:54:22'),
(15, 2, 0, '文件', 'fa-file', 'auth/files', 'BackendAdminFile', '2017-09-29 05:51:12', '2017-09-29 05:51:12'),
(16, 13, 0, '二级', 'fa-adjust', '', 'BackendIndex', '2017-10-09 05:52:23', '2017-10-09 05:52:23'),
(17, 16, 0, '三级', 'fa-anchor', '', 'BackendIndex', '2017-10-09 05:52:45', '2017-10-09 05:52:45'),
(18, 17, 0, '四级', 'fa-bars', '', 'BackendIndex', '2017-10-09 05:53:02', '2017-10-09 05:53:02'),
(19, 18, 0, '五级', 'fa-amazon', '', 'BackendIndex', '2017-10-09 06:35:36', '2017-10-09 06:35:36');

-- --------------------------------------------------------

--
-- 表的结构 `admin_modules`
--

CREATE TABLE `admin_modules` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '模块名',
  `icon` int(11) NOT NULL COMMENT '图标id',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '模块链接',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='系统模块表';

-- --------------------------------------------------------

--
-- 表的结构 `admin_operation_log`
--

CREATE TABLE `admin_operation_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `input` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_operation_log`
--

INSERT INTO `admin_operation_log` (`id`, `user_id`, `path`, `method`, `ip`, `input`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 03:37:23', '2017-09-22 03:37:23'),
(2, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 03:38:02', '2017-09-22 03:38:02'),
(3, 1, 'admin/auth/setting', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 03:38:09', '2017-09-22 03:38:09'),
(4, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:41:04', '2017-09-22 03:41:04'),
(5, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:41:49', '2017-09-22 03:41:49'),
(6, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:41:52', '2017-09-22 03:41:52'),
(7, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:42:19', '2017-09-22 03:42:19'),
(8, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:42:49', '2017-09-22 03:42:49'),
(9, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:42:51', '2017-09-22 03:42:51'),
(10, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:43:15', '2017-09-22 03:43:15'),
(11, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:43:42', '2017-09-22 03:43:42'),
(12, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:43:50', '2017-09-22 03:43:50'),
(13, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:43:52', '2017-09-22 03:43:52'),
(14, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:44:19', '2017-09-22 03:44:19'),
(15, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:45:28', '2017-09-22 03:45:28'),
(16, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:46:12', '2017-09-22 03:46:12'),
(17, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 03:46:49', '2017-09-22 03:46:49'),
(18, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-22 06:08:54', '2017-09-22 06:08:54'),
(19, 1, 'admin', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:09:01', '2017-09-22 06:09:01'),
(20, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 06:09:23', '2017-09-22 06:09:23'),
(21, 1, 'admin', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:13', '2017-09-22 06:12:13'),
(22, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:15', '2017-09-22 06:12:15'),
(23, 1, 'admin/auth/logs', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:20', '2017-09-22 06:12:20'),
(24, 1, 'admin/auth/logs', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:26', '2017-09-22 06:12:26'),
(25, 1, 'admin/auth/logs', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:28', '2017-09-22 06:12:28'),
(26, 1, 'admin/auth/logs', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:31', '2017-09-22 06:12:31'),
(27, 1, 'admin', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:12:54', '2017-09-22 06:12:54'),
(28, 1, 'admin/helpers/scaffold', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:13:02', '2017-09-22 06:13:02'),
(29, 1, 'admin/helpers/terminal/database', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:13:06', '2017-09-22 06:13:06'),
(30, 1, 'admin/helpers/terminal/database', 'POST', '::1', '{\"c\":\"db:mysql\",\"q\":\"select * from admin_menu;\",\"_token\":\"FncM5M0LLa6PiBF4anx29Womw44yo4JUbA8X2TFz\"}', '2017-09-22 06:13:39', '2017-09-22 06:13:39'),
(31, 1, 'admin/helpers/terminal/artisan', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:13:51', '2017-09-22 06:13:51'),
(32, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:16:20', '2017-09-22 06:16:20'),
(33, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:16:32', '2017-09-22 06:16:32'),
(34, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-22 06:17:47', '2017-09-22 06:17:47'),
(35, 1, 'admin/auth/roles', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:50', '2017-09-22 06:17:50'),
(36, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:51', '2017-09-22 06:17:51'),
(37, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:52', '2017-09-22 06:17:52'),
(38, 1, 'admin/auth/menu', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:53', '2017-09-22 06:17:53'),
(39, 1, 'admin/auth/roles', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:54', '2017-09-22 06:17:54'),
(40, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:55', '2017-09-22 06:17:55'),
(41, 1, 'admin/auth/menu', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:17:56', '2017-09-22 06:17:56'),
(42, 1, 'admin/auth/roles', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:19:07', '2017-09-22 06:19:07'),
(43, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:19:09', '2017-09-22 06:19:09'),
(44, 1, 'admin/auth/permissions/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:19:47', '2017-09-22 06:19:47'),
(45, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:19:53', '2017-09-22 06:19:53'),
(46, 1, 'admin/auth/menu', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 06:19:56', '2017-09-22 06:19:56'),
(47, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 07:06:46', '2017-09-22 07:06:46'),
(48, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 07:06:54', '2017-09-22 07:06:54'),
(49, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 07:32:58', '2017-09-22 07:32:58'),
(50, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 07:33:00', '2017-09-22 07:33:00'),
(51, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 09:02:21', '2017-09-22 09:02:21'),
(52, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 09:02:28', '2017-09-22 09:02:28'),
(53, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 10:02:28', '2017-09-22 10:02:28'),
(54, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 10:06:58', '2017-09-22 10:06:58'),
(55, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-22 10:07:30', '2017-09-22 10:07:30'),
(56, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 10:32:05', '2017-09-22 10:32:05'),
(57, 1, 'admin', 'GET', '::1', '[]', '2017-09-22 10:38:05', '2017-09-22 10:38:05'),
(58, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 02:52:59', '2017-09-25 02:52:59'),
(59, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 03:05:15', '2017-09-25 03:05:15'),
(60, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-25 03:09:55', '2017-09-25 03:09:55'),
(61, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 03:26:52', '2017-09-25 03:26:52'),
(62, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 03:35:23', '2017-09-25 03:35:23'),
(63, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-25 03:37:20', '2017-09-25 03:37:20'),
(64, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 03:37:24', '2017-09-25 03:37:24'),
(65, 1, 'admin/auth/setting', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-25 03:37:31', '2017-09-25 03:37:31'),
(66, 1, 'admin/auth/setting', 'GET', '::1', '[]', '2017-09-25 03:37:31', '2017-09-25 03:37:31'),
(67, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-25 03:40:15', '2017-09-25 03:40:15'),
(68, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:38:51', '2017-09-25 06:38:51'),
(69, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:39:31', '2017-09-25 06:39:31'),
(70, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:40:23', '2017-09-25 06:40:23'),
(71, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:40:25', '2017-09-25 06:40:25'),
(72, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:40:37', '2017-09-25 06:40:37'),
(73, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:42:47', '2017-09-25 06:42:47'),
(74, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 06:43:21', '2017-09-25 06:43:21'),
(75, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 08:46:03', '2017-09-25 08:46:03'),
(76, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 08:46:52', '2017-09-25 08:46:52'),
(77, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 08:47:05', '2017-09-25 08:47:05'),
(78, 1, 'admin/auth/logout', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-25 08:47:09', '2017-09-25 08:47:09'),
(79, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 08:48:19', '2017-09-25 08:48:19'),
(80, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 08:48:26', '2017-09-25 08:48:26'),
(81, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 09:08:41', '2017-09-25 09:08:41'),
(82, 1, 'admin', 'GET', '::1', '[]', '2017-09-25 09:10:30', '2017-09-25 09:10:30'),
(83, 1, 'admin', 'GET', '::1', '[]', '2017-09-27 03:41:20', '2017-09-27 03:41:20'),
(84, 1, 'admin', 'GET', '::1', '[]', '2017-09-27 03:41:34', '2017-09-27 03:41:34'),
(85, 1, 'admin', 'GET', '::1', '[]', '2017-09-27 06:40:21', '2017-09-27 06:40:21'),
(86, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 06:40:24', '2017-09-27 06:40:24'),
(87, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 06:40:25', '2017-09-27 06:40:25'),
(88, 1, 'admin/auth/permissions/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 06:40:28', '2017-09-27 06:40:28'),
(89, 1, 'admin/auth/permissions/create', 'GET', '::1', '[]', '2017-09-27 06:40:28', '2017-09-27 06:40:28'),
(90, 1, 'admin/auth/permissions', 'POST', '::1', '{\"slug\":\"BackendIndex\",\"name\":\"\\u540e\\u53f0\\u9996\\u9875\\u6743\\u9650\",\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/permissions\"}', '2017-09-27 06:41:58', '2017-09-27 06:41:58'),
(91, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 06:41:58', '2017-09-27 06:41:58'),
(92, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 06:41:59', '2017-09-27 06:41:59'),
(93, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 06:47:06', '2017-09-27 06:47:06'),
(94, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 06:47:23', '2017-09-27 06:47:23'),
(95, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 06:47:23', '2017-09-27 06:47:23'),
(96, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 06:47:27', '2017-09-27 06:47:27'),
(97, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 06:47:28', '2017-09-27 06:47:28'),
(98, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 06:47:38', '2017-09-27 06:47:38'),
(99, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 06:47:38', '2017-09-27 06:47:38'),
(100, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 06:47:39', '2017-09-27 06:47:39'),
(101, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 06:48:35', '2017-09-27 06:48:35'),
(102, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:00:22', '2017-09-27 07:00:22'),
(103, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:00:23', '2017-09-27 07:00:23'),
(104, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:00:28', '2017-09-27 07:00:28'),
(105, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:00:29', '2017-09-27 07:00:29'),
(106, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:22:42', '2017-09-27 07:22:42'),
(107, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:22:42', '2017-09-27 07:22:42'),
(108, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:22:43', '2017-09-27 07:22:43'),
(109, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:23:18', '2017-09-27 07:23:18'),
(110, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:23:29', '2017-09-27 07:23:29'),
(111, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:23:30', '2017-09-27 07:23:30'),
(112, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:24:31', '2017-09-27 07:24:31'),
(113, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:24:32', '2017-09-27 07:24:32'),
(114, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:24:32', '2017-09-27 07:24:32'),
(115, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:26:34', '2017-09-27 07:26:34'),
(116, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:26:34', '2017-09-27 07:26:34'),
(117, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:26:37', '2017-09-27 07:26:37'),
(118, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '[]', '2017-09-27 07:26:37', '2017-09-27 07:26:37'),
(119, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:26:44', '2017-09-27 07:26:44'),
(120, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:26:45', '2017-09-27 07:26:45'),
(121, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:26:54', '2017-09-27 07:26:54'),
(122, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:26:55', '2017-09-27 07:26:55'),
(123, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:27:10', '2017-09-27 07:27:10'),
(124, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:27:11', '2017-09-27 07:27:11'),
(125, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:27:14', '2017-09-27 07:27:14'),
(126, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '[]', '2017-09-27 07:27:14', '2017-09-27 07:27:14'),
(127, 1, 'admin/auth/permissions/1', 'PUT', '::1', '{\"slug\":\"BackendIndex\",\"name\":\"\\u540e\\u53f0\\u9996\\u9875\\u6743\\u96501\",\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/permissions\"}', '2017-09-27 07:27:59', '2017-09-27 07:27:59'),
(128, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:27:59', '2017-09-27 07:27:59'),
(129, 1, 'admin/auth/permissions/1', 'GET', '::1', '[]', '2017-09-27 07:28:00', '2017-09-27 07:28:00'),
(130, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:28:18', '2017-09-27 07:28:18'),
(131, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:28:18', '2017-09-27 07:28:18'),
(132, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:28:20', '2017-09-27 07:28:20'),
(133, 1, 'admin/auth/permissions/1/edit', 'GET', '::1', '[]', '2017-09-27 07:28:21', '2017-09-27 07:28:21'),
(134, 1, 'admin/auth/permissions/1', 'PUT', '::1', '{\"slug\":\"BackendIndex\",\"name\":\"\\u540e\\u53f0\\u9996\\u9875\\u6743\\u9650\",\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/permissions\"}', '2017-09-27 07:28:24', '2017-09-27 07:28:24'),
(135, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:28:24', '2017-09-27 07:28:24'),
(136, 1, 'admin/auth/permissions/1', 'GET', '::1', '[]', '2017-09-27 07:28:25', '2017-09-27 07:28:25'),
(137, 1, 'admin/auth/permissions', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:28:29', '2017-09-27 07:28:29'),
(138, 1, 'admin/auth/permissions', 'GET', '::1', '[]', '2017-09-27 07:28:30', '2017-09-27 07:28:30'),
(139, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:28:36', '2017-09-27 07:28:36'),
(140, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:28:36', '2017-09-27 07:28:36'),
(141, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:28:38', '2017-09-27 07:28:38'),
(142, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:28:38', '2017-09-27 07:28:38'),
(143, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:29:21', '2017-09-27 07:29:21'),
(144, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:29:21', '2017-09-27 07:29:21'),
(145, 1, 'admin/auth/users/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:29:23', '2017-09-27 07:29:23'),
(146, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 07:29:24', '2017-09-27 07:29:24'),
(147, 1, 'admin/auth/users', 'POST', '::1', '{\"username\":\"test\",\"name\":\"test\",\"password\":\"123456\",\"password_confirmation\":\"multiple\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:29:43', '2017-09-27 07:29:43'),
(148, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 07:29:44', '2017-09-27 07:29:44'),
(149, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:29:44', '2017-09-27 07:29:44'),
(150, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:29:49', '2017-09-27 07:29:49'),
(151, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 07:43:09', '2017-09-27 07:43:09'),
(152, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:43:10', '2017-09-27 07:43:10'),
(153, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin1\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:43:16', '2017-09-27 07:43:16'),
(154, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:43:16', '2017-09-27 07:43:16'),
(155, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:43:17', '2017-09-27 07:43:17'),
(156, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:43:30', '2017-09-27 07:43:30'),
(157, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:44:00', '2017-09-27 07:44:00'),
(158, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:47:15', '2017-09-27 07:47:15'),
(159, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin1\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:47:22', '2017-09-27 07:47:22'),
(160, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:47:22', '2017-09-27 07:47:22'),
(161, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:47:23', '2017-09-27 07:47:23'),
(162, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:47:44', '2017-09-27 07:47:44'),
(163, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:47:48', '2017-09-27 07:47:48'),
(164, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:47:52', '2017-09-27 07:47:52'),
(165, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:47:57', '2017-09-27 07:47:57'),
(166, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin1\",\"name\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 07:56:48', '2017-09-27 07:56:48'),
(167, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 07:56:48', '2017-09-27 07:56:48'),
(168, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:56:49', '2017-09-27 07:56:49'),
(169, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"admin\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\"}', '2017-09-27 07:57:21', '2017-09-27 07:57:21'),
(170, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:57:22', '2017-09-27 07:57:22'),
(171, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:57:22', '2017-09-27 07:57:22'),
(172, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"admin\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\"}', '2017-09-27 07:57:50', '2017-09-27 07:57:50'),
(173, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 07:57:50', '2017-09-27 07:57:50'),
(174, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 07:57:51', '2017-09-27 07:57:51'),
(175, 1, 'admin', 'GET', '::1', '[]', '2017-09-27 08:03:04', '2017-09-27 08:03:04'),
(176, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 08:03:15', '2017-09-27 08:03:15'),
(177, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:03:16', '2017-09-27 08:03:16'),
(178, 1, 'admin/auth/users/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 08:03:18', '2017-09-27 08:03:18'),
(179, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 08:03:18', '2017-09-27 08:03:18'),
(180, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 08:05:08', '2017-09-27 08:05:08'),
(181, 1, 'admin/auth/users', 'POST', '::1', '{\"username\":\"test\",\"name\":\"test\",\"password\":\"123456\",\"password_confirmation\":\"123456\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\"}', '2017-09-27 08:06:01', '2017-09-27 08:06:01'),
(182, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 08:06:01', '2017-09-27 08:06:01'),
(183, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:06:02', '2017-09-27 08:06:02'),
(184, 1, 'admin/auth/users', 'POST', '::1', '{\"username\":\"test\",\"name\":\"test\",\"password\":\"123456\",\"password_confirmation\":\"123456\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\"}', '2017-09-27 08:12:37', '2017-09-27 08:12:37'),
(185, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:12:37', '2017-09-27 08:12:37'),
(186, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:12:38', '2017-09-27 08:12:38'),
(187, 1, 'admin/auth/users/2', 'DELETE', '::1', '{\"_method\":\"delete\",\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\"}', '2017-09-27 08:12:49', '2017-09-27 08:12:49'),
(188, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 08:12:49', '2017-09-27 08:12:49'),
(189, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:12:50', '2017-09-27 08:12:50'),
(190, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:22:24', '2017-09-27 08:22:24'),
(191, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:22:50', '2017-09-27 08:22:50'),
(192, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:23:14', '2017-09-27 08:23:14'),
(193, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:23:21', '2017-09-27 08:23:21'),
(194, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:24:46', '2017-09-27 08:24:46'),
(195, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:25:59', '2017-09-27 08:25:59'),
(196, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:28:39', '2017-09-27 08:28:39'),
(197, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:28:52', '2017-09-27 08:28:52'),
(198, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 08:28:56', '2017-09-27 08:28:56'),
(199, 1, 'admin/auth/roles', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:02:16', '2017-09-27 09:02:16'),
(200, 1, 'admin/auth/roles', 'GET', '::1', '[]', '2017-09-27 09:02:16', '2017-09-27 09:02:16'),
(201, 1, 'admin/auth/roles/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:02:19', '2017-09-27 09:02:19'),
(202, 1, 'admin/auth/roles/1/edit', 'GET', '::1', '[]', '2017-09-27 09:02:20', '2017-09-27 09:02:20'),
(203, 1, 'admin/auth/roles', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:10:11', '2017-09-27 09:10:11'),
(204, 1, 'admin/auth/roles', 'GET', '::1', '[]', '2017-09-27 09:10:12', '2017-09-27 09:10:12'),
(205, 1, 'admin/auth/menu', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:12:33', '2017-09-27 09:12:33'),
(206, 1, 'admin/auth/menu', 'GET', '::1', '[]', '2017-09-27 09:12:33', '2017-09-27 09:12:33'),
(207, 1, 'admin/auth/menu/2/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:14:41', '2017-09-27 09:14:41'),
(208, 1, 'admin/auth/menu/2/edit', 'GET', '::1', '[]', '2017-09-27 09:14:42', '2017-09-27 09:14:42'),
(209, 1, 'admin/auth/menu/3/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:15:01', '2017-09-27 09:15:01'),
(210, 1, 'admin/auth/menu/3/edit', 'GET', '::1', '[]', '2017-09-27 09:15:02', '2017-09-27 09:15:02'),
(211, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:24:33', '2017-09-27 09:24:33'),
(212, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:24:33', '2017-09-27 09:24:33'),
(213, 1, 'admin/auth/users/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:24:37', '2017-09-27 09:24:37'),
(214, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 09:24:37', '2017-09-27 09:24:37'),
(215, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:24:53', '2017-09-27 09:24:53'),
(216, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:24:54', '2017-09-27 09:24:54'),
(217, 1, 'admin/auth/users/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:24:58', '2017-09-27 09:24:58'),
(218, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 09:24:58', '2017-09-27 09:24:58'),
(219, 1, 'admin/auth/users', 'POST', '::1', '{\"username\":\"test\",\"name\":\"test\",\"password\":\"123456\",\"password_confirmation\":\"123456\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 09:25:42', '2017-09-27 09:25:42'),
(220, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:25:43', '2017-09-27 09:25:43'),
(221, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:25:43', '2017-09-27 09:25:43'),
(222, 1, 'admin/auth/users/3', 'DELETE', '::1', '{\"_method\":\"delete\",\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\"}', '2017-09-27 09:26:09', '2017-09-27 09:26:09'),
(223, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:26:09', '2017-09-27 09:26:09'),
(224, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:26:10', '2017-09-27 09:26:10'),
(225, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:30:21', '2017-09-27 09:30:21'),
(226, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:30:22', '2017-09-27 09:30:22'),
(227, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:36:02', '2017-09-27 09:36:02'),
(228, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:36:02', '2017-09-27 09:36:02'),
(229, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:36:27', '2017-09-27 09:36:27'),
(230, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:37:49', '2017-09-27 09:37:49'),
(231, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:38:02', '2017-09-27 09:38:02'),
(232, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:38:03', '2017-09-27 09:38:03'),
(233, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828338@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 09:38:08', '2017-09-27 09:38:08'),
(234, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:38:09', '2017-09-27 09:38:09'),
(235, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 09:38:09', '2017-09-27 09:38:09'),
(236, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 09:38:22', '2017-09-27 09:38:22'),
(237, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:38:22', '2017-09-27 09:38:22'),
(238, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 09:38:23', '2017-09-27 09:38:23'),
(239, 1, 'admin/auth/users/1', 'PUT', '::1', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"\"],\"_token\":\"i5ti7Vp973mwU5fa18FY22tGnSYmP19vYWzHARBg\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/localhost:8001\\/admin\\/auth\\/users\"}', '2017-09-27 09:38:33', '2017-09-27 09:38:33'),
(240, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:38:33', '2017-09-27 09:38:33'),
(241, 1, 'admin/auth/users/1', 'GET', '::1', '[]', '2017-09-27 09:38:33', '2017-09-27 09:38:33'),
(242, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:38:56', '2017-09-27 09:38:56'),
(243, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:38:58', '2017-09-27 09:38:58'),
(244, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-09-27 09:38:58', '2017-09-27 09:38:58'),
(245, 1, 'admin/auth/users/create', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:39:12', '2017-09-27 09:39:12'),
(246, 1, 'admin/auth/users/create', 'GET', '::1', '[]', '2017-09-27 09:39:13', '2017-09-27 09:39:13'),
(247, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:41:47', '2017-09-27 09:41:47'),
(248, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-09-27 09:41:47', '2017-09-27 09:41:47'),
(249, 1, 'admin/auth/menu', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-09-27 09:50:58', '2017-09-27 09:50:58'),
(250, 1, 'admin/auth/menu', 'GET', '::1', '[]', '2017-09-27 09:50:58', '2017-09-27 09:50:58'),
(251, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 01:29:46', '2017-09-28 01:29:46'),
(252, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-09-28 01:32:03', '2017-09-28 01:32:03'),
(253, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:33:32', '2017-09-28 01:33:32'),
(254, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-09-28 01:33:33', '2017-09-28 01:33:33'),
(255, 1, 'admin/helpers/scaffold', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:34:43', '2017-09-28 01:34:43'),
(256, 1, 'admin/helpers/scaffold', 'GET', '172.0.0.152', '[]', '2017-09-28 01:34:44', '2017-09-28 01:34:44'),
(257, 1, 'admin/helpers/terminal/database', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:34:48', '2017-09-28 01:34:48'),
(258, 1, 'admin/helpers/terminal/database', 'GET', '172.0.0.152', '[]', '2017-09-28 01:34:49', '2017-09-28 01:34:49'),
(259, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:35:37', '2017-09-28 01:35:37'),
(260, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-09-28 01:35:38', '2017-09-28 01:35:38'),
(261, 1, 'admin/auth/users', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:38:36', '2017-09-28 01:38:36'),
(262, 1, 'admin/auth/users', 'GET', '172.0.0.152', '[]', '2017-09-28 01:38:37', '2017-09-28 01:38:37'),
(263, 1, 'admin/auth/roles', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:38:41', '2017-09-28 01:38:41'),
(264, 1, 'admin/auth/roles', 'GET', '172.0.0.152', '[]', '2017-09-28 01:38:41', '2017-09-28 01:38:41'),
(265, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:38:45', '2017-09-28 01:38:45'),
(266, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-09-28 01:38:46', '2017-09-28 01:38:46'),
(267, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-09-28 01:38:55', '2017-09-28 01:38:55'),
(268, 1, 'admin/auth/users', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:39:51', '2017-09-28 01:39:51'),
(269, 1, 'admin/auth/users', 'GET', '172.0.0.152', '[]', '2017-09-28 01:39:51', '2017-09-28 01:39:51'),
(270, 1, 'admin/auth/permissions', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:39:57', '2017-09-28 01:39:57'),
(271, 1, 'admin/auth/permissions', 'GET', '172.0.0.152', '[]', '2017-09-28 01:39:58', '2017-09-28 01:39:58'),
(272, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:40:52', '2017-09-28 01:40:52'),
(273, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-09-28 01:40:52', '2017-09-28 01:40:52'),
(274, 1, 'admin/helpers/terminal/artisan', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:54:03', '2017-09-28 01:54:03'),
(275, 1, 'admin/helpers/terminal/artisan', 'GET', '172.0.0.177', '[]', '2017-09-28 01:54:03', '2017-09-28 01:54:03'),
(276, 1, 'admin/helpers/terminal/database', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 01:54:33', '2017-09-28 01:54:33'),
(277, 1, 'admin/helpers/terminal/database', 'GET', '172.0.0.177', '[]', '2017-09-28 01:54:33', '2017-09-28 01:54:33'),
(278, 1, 'admin/helpers/terminal/database', 'POST', '172.0.0.177', '{\"c\":\"db:mysql\",\"q\":\"select * from admin_user\",\"_token\":\"PpaYwxHFnpe8mgjckP0V3eAIZTR5BnetfTaqDRkp\"}', '2017-09-28 01:54:52', '2017-09-28 01:54:52'),
(279, 1, 'admin/helpers/terminal/database', 'POST', '172.0.0.177', '{\"c\":\"db:mysql\",\"q\":\"select * from admin_user;\",\"_token\":\"PpaYwxHFnpe8mgjckP0V3eAIZTR5BnetfTaqDRkp\"}', '2017-09-28 01:55:04', '2017-09-28 01:55:04'),
(280, 1, 'admin/helpers/terminal/database', 'POST', '172.0.0.177', '{\"c\":\"db:mysql\",\"q\":\"select * from admin_users\",\"_token\":\"PpaYwxHFnpe8mgjckP0V3eAIZTR5BnetfTaqDRkp\"}', '2017-09-28 01:55:11', '2017-09-28 01:55:11'),
(281, 1, 'admin/helpers/terminal/database', 'GET', '172.0.0.177', '[]', '2017-09-28 02:03:11', '2017-09-28 02:03:11'),
(282, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-09-28 02:58:47', '2017-09-28 02:58:47'),
(283, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:10:55', '2017-09-28 09:10:55'),
(284, 1, 'admin/auth/logout', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 09:10:59', '2017-09-28 09:10:59'),
(285, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:32:08', '2017-09-28 09:32:08'),
(286, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:32:44', '2017-09-28 09:32:44'),
(287, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:33:43', '2017-09-28 09:33:43'),
(288, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:36:13', '2017-09-28 09:36:13'),
(289, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:41:31', '2017-09-28 09:41:31'),
(290, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:55:38', '2017-09-28 09:55:38'),
(291, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:56:17', '2017-09-28 09:56:17'),
(292, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:57:08', '2017-09-28 09:57:08'),
(293, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 09:58:12', '2017-09-28 09:58:12'),
(294, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 10:11:14', '2017-09-28 10:11:14'),
(295, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 10:11:33', '2017-09-28 10:11:33'),
(296, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 10:11:57', '2017-09-28 10:11:57'),
(297, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 10:13:08', '2017-09-28 10:13:08'),
(298, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-28 10:13:18', '2017-09-28 10:13:18'),
(299, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:16:28', '2017-09-28 10:16:28'),
(300, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:16:29', '2017-09-28 10:16:29'),
(301, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:19:50', '2017-09-28 10:19:50'),
(302, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:21:41', '2017-09-28 10:21:41'),
(303, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:21:48', '2017-09-28 10:21:48'),
(304, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:24:18', '2017-09-28 10:24:18'),
(305, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:26:05', '2017-09-28 10:26:05'),
(306, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:26:20', '2017-09-28 10:26:20'),
(307, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:26:21', '2017-09-28 10:26:21'),
(308, 1, 'admin/auth/menu/1', 'PUT', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"\\u9996\\u9875\",\"icon\":\"fa-bar-chart\",\"uri\":\"\\/\",\"permission_slug\":[\"BackendIndex\",\"\"],\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\"}', '2017-09-28 10:26:34', '2017-09-28 10:26:34'),
(309, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:04', '2017-09-28 10:29:04'),
(310, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:29:26', '2017-09-28 10:29:26'),
(311, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:26', '2017-09-28 10:29:26'),
(312, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:42', '2017-09-28 10:29:42'),
(313, 1, 'admin/auth/menu/1', 'PUT', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"\\u9996\\u9875\",\"icon\":\"fa-bar-chart\",\"uri\":\"\\/\",\"permission_slug\":\"BackendIndex\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\"}', '2017-09-28 10:29:51', '2017-09-28 10:29:51'),
(314, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:51', '2017-09-28 10:29:51'),
(315, 1, 'admin/auth/menu/1', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:51', '2017-09-28 10:29:51'),
(316, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:52', '2017-09-28 10:29:52'),
(317, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:29:55', '2017-09-28 10:29:55'),
(318, 1, 'admin/auth/menu/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:29:55', '2017-09-28 10:29:55'),
(319, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:30:08', '2017-09-28 10:30:08'),
(320, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-28 10:30:09', '2017-09-28 10:30:09'),
(321, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:30:36', '2017-09-28 10:30:36'),
(322, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:30:37', '2017-09-28 10:30:37'),
(323, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:30:46', '2017-09-28 10:30:46'),
(324, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:31:07', '2017-09-28 10:31:07'),
(325, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:08', '2017-09-28 10:31:08'),
(326, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdmin\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:31:42', '2017-09-28 10:31:42'),
(327, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:42', '2017-09-28 10:31:42'),
(328, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:42', '2017-09-28 10:31:42'),
(329, 1, 'admin/auth/permissions/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:31:45', '2017-09-28 10:31:45'),
(330, 1, 'admin/auth/permissions/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:45', '2017-09-28 10:31:45'),
(331, 1, 'admin/auth/permissions/1', 'PUT', '172.0.0.177', '{\"slug\":\"BackendIndex\",\"name\":\"\\u540e\\u53f0\\u9996\\u9875\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:31:51', '2017-09-28 10:31:51'),
(332, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:52', '2017-09-28 10:31:52'),
(333, 1, 'admin/auth/permissions/1', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:52', '2017-09-28 10:31:52'),
(334, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:31:56', '2017-09-28 10:31:56'),
(335, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:31:56', '2017-09-28 10:31:56'),
(336, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:32:02', '2017-09-28 10:32:02'),
(337, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:03', '2017-09-28 10:32:03'),
(338, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminUser\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u7528\\u6237\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:32:44', '2017-09-28 10:32:44'),
(339, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:44', '2017-09-28 10:32:44'),
(340, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:45', '2017-09-28 10:32:45'),
(341, 1, 'admin/auth/permissions/3/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:32:50', '2017-09-28 10:32:50'),
(342, 1, 'admin/auth/permissions/3/edit', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:51', '2017-09-28 10:32:51'),
(343, 1, 'admin/auth/permissions/3', 'PUT', '172.0.0.177', '{\"slug\":\"BackendAdminUser\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u7528\\u6237\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:32:56', '2017-09-28 10:32:56'),
(344, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:56', '2017-09-28 10:32:56'),
(345, 1, 'admin/auth/permissions/3', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:57', '2017-09-28 10:32:57'),
(346, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:32:59', '2017-09-28 10:32:59'),
(347, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:32:59', '2017-09-28 10:32:59'),
(348, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:33:04', '2017-09-28 10:33:04'),
(349, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:33:04', '2017-09-28 10:33:04'),
(350, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminRole\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u89d2\\u8272\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:33:35', '2017-09-28 10:33:35'),
(351, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:33:35', '2017-09-28 10:33:35'),
(352, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:33:35', '2017-09-28 10:33:35'),
(353, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:33:39', '2017-09-28 10:33:39'),
(354, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:33:39', '2017-09-28 10:33:39'),
(355, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminPermission\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u6743\\u9650\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:34:18', '2017-09-28 10:34:18'),
(356, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:34:18', '2017-09-28 10:34:18'),
(357, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:34:19', '2017-09-28 10:34:19'),
(358, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:34:22', '2017-09-28 10:34:22'),
(359, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:34:22', '2017-09-28 10:34:22'),
(360, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminMenu\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u83dc\\u5355\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:35:11', '2017-09-28 10:35:11'),
(361, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:35:11', '2017-09-28 10:35:11'),
(362, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:35:12', '2017-09-28 10:35:12'),
(363, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:35:13', '2017-09-28 10:35:13'),
(364, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:35:14', '2017-09-28 10:35:14'),
(365, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminLog\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u65e5\\u5fd7\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:35:49', '2017-09-28 10:35:49'),
(366, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:35:49', '2017-09-28 10:35:49'),
(367, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:35:50', '2017-09-28 10:35:50'),
(368, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:36:01', '2017-09-28 10:36:01'),
(369, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:36:02', '2017-09-28 10:36:02'),
(370, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendHelper\",\"name\":\"\\u540e\\u53f0\\u5e2e\\u52a9\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"CLFTnZ1E2g3QA7AzdMIUZherDsa7WimOtoltqzQo\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-28 10:36:37', '2017-09-28 10:36:37'),
(371, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:36:37', '2017-09-28 10:36:37'),
(372, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-28 10:36:37', '2017-09-28 10:36:37'),
(373, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-28 10:36:41', '2017-09-28 10:36:41'),
(374, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-28 10:36:42', '2017-09-28 10:36:42'),
(375, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:32:00', '2017-09-29 01:32:00'),
(376, 1, 'admin/helpers/scaffold', 'GET', '172.0.0.177', '[]', '2017-09-29 01:32:49', '2017-09-29 01:32:49'),
(377, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:34:05', '2017-09-29 01:34:05');
INSERT INTO `admin_operation_log` (`id`, `user_id`, `path`, `method`, `ip`, `input`, `created_at`, `updated_at`) VALUES
(378, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-29 01:34:05', '2017-09-29 01:34:05'),
(379, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendHelperCsaffold\",\"name\":\"\\u540e\\u53f0\\u5e2e\\u52a9\\u624b\\u811a\\u67b6\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-29 01:34:45', '2017-09-29 01:34:45'),
(380, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:34:46', '2017-09-29 01:34:46'),
(381, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:34:46', '2017-09-29 01:34:46'),
(382, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:34:56', '2017-09-29 01:34:56'),
(383, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-29 01:34:57', '2017-09-29 01:34:57'),
(384, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendHelperDatabase\",\"name\":\"\\u540e\\u53f0\\u5e2e\\u52a9\\u6570\\u636e\\u5e93\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-29 01:35:16', '2017-09-29 01:35:16'),
(385, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:35:16', '2017-09-29 01:35:16'),
(386, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:35:17', '2017-09-29 01:35:17'),
(387, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:35:39', '2017-09-29 01:35:39'),
(388, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-29 01:35:40', '2017-09-29 01:35:40'),
(389, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendHelperArtisan\",\"name\":\"\\u540e\\u53f0\\u5e2e\\u52a9Laravel\\u547d\\u4ee4\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-29 01:36:32', '2017-09-29 01:36:32'),
(390, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:36:32', '2017-09-29 01:36:32'),
(391, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:36:33', '2017-09-29 01:36:33'),
(392, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:36:51', '2017-09-29 01:36:51'),
(393, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 01:36:52', '2017-09-29 01:36:52'),
(394, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:36:54', '2017-09-29 01:36:54'),
(395, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 01:36:55', '2017-09-29 01:36:55'),
(396, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:37:06', '2017-09-29 01:37:06'),
(397, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:37:07', '2017-09-29 01:37:07'),
(398, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:37:09', '2017-09-29 01:37:09'),
(399, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 01:37:09', '2017-09-29 01:37:09'),
(400, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 01:37:49', '2017-09-29 01:37:49'),
(401, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:37:50', '2017-09-29 01:37:50'),
(402, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 01:37:50', '2017-09-29 01:37:50'),
(403, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 01:37:55', '2017-09-29 01:37:55'),
(404, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-29 01:38:06', '2017-09-29 01:38:06'),
(405, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:38:34', '2017-09-29 01:38:34'),
(406, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:38:35', '2017-09-29 01:38:35'),
(407, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:40:06', '2017-09-29 01:40:06'),
(408, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:42:09', '2017-09-29 01:42:09'),
(409, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:45:07', '2017-09-29 01:45:07'),
(410, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:47:43', '2017-09-29 01:47:43'),
(411, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:48:42', '2017-09-29 01:48:42'),
(412, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:49:20', '2017-09-29 01:49:20'),
(413, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:55:51', '2017-09-29 01:55:51'),
(414, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:56:14', '2017-09-29 01:56:14'),
(415, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 01:56:52', '2017-09-29 01:56:52'),
(416, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:57:31', '2017-09-29 01:57:31'),
(417, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:57:31', '2017-09-29 01:57:31'),
(418, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:57:33', '2017-09-29 01:57:33'),
(419, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 01:57:34', '2017-09-29 01:57:34'),
(420, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 01:57:47', '2017-09-29 01:57:47'),
(421, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:57:47', '2017-09-29 01:57:47'),
(422, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 01:57:48', '2017-09-29 01:57:48'),
(423, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 01:57:57', '2017-09-29 01:57:57'),
(424, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:59:13', '2017-09-29 01:59:13'),
(425, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:59:13', '2017-09-29 01:59:13'),
(426, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 01:59:15', '2017-09-29 01:59:15'),
(427, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 01:59:16', '2017-09-29 01:59:16'),
(428, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 01:59:28', '2017-09-29 01:59:28'),
(429, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 01:59:29', '2017-09-29 01:59:29'),
(430, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 01:59:29', '2017-09-29 01:59:29'),
(431, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:00:21', '2017-09-29 02:00:21'),
(432, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:00:21', '2017-09-29 02:00:21'),
(433, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:00:23', '2017-09-29 02:00:23'),
(434, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:00:23', '2017-09-29 02:00:23'),
(435, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:00:51', '2017-09-29 02:00:51'),
(436, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:00:51', '2017-09-29 02:00:51'),
(437, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:00:51', '2017-09-29 02:00:51'),
(438, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:00:56', '2017-09-29 02:00:56'),
(439, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:00:56', '2017-09-29 02:00:56'),
(440, 1, 'admin/auth/menu/2/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:01:01', '2017-09-29 02:01:01'),
(441, 1, 'admin/auth/menu/2/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:02', '2017-09-29 02:01:02'),
(442, 1, 'admin/auth/menu/2', 'PUT', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"\\u7ba1\\u7406\",\"icon\":\"fa-tasks\",\"uri\":\"\",\"permission_slug\":\"BackendAdmin\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\"}', '2017-09-29 02:01:11', '2017-09-29 02:01:11'),
(443, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:11', '2017-09-29 02:01:11'),
(444, 1, 'admin/auth/menu/2', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:12', '2017-09-29 02:01:12'),
(445, 1, 'admin/auth/menu/2/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:12', '2017-09-29 02:01:12'),
(446, 1, 'admin/auth/menu/3/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:18', '2017-09-29 02:01:18'),
(447, 1, 'admin/auth/menu/3', 'PUT', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u7528\\u6237\",\"icon\":\"fa-users\",\"uri\":\"auth\\/users\",\"permission_slug\":\"BackendAdminUser\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/2\\/edit\"}', '2017-09-29 02:01:25', '2017-09-29 02:01:25'),
(448, 1, 'admin/auth/menu/2/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:26', '2017-09-29 02:01:26'),
(449, 1, 'admin/auth/menu/3', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:26', '2017-09-29 02:01:26'),
(450, 1, 'admin/auth/menu/3/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:27', '2017-09-29 02:01:27'),
(451, 1, 'admin/auth/menu/4/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:33', '2017-09-29 02:01:33'),
(452, 1, 'admin/auth/menu/4', 'PUT', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u89d2\\u8272\",\"icon\":\"fa-user\",\"uri\":\"auth\\/roles\",\"permission_slug\":\"BackendAdminRole\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/3\\/edit\"}', '2017-09-29 02:01:38', '2017-09-29 02:01:38'),
(453, 1, 'admin/auth/menu/3/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:39', '2017-09-29 02:01:39'),
(454, 1, 'admin/auth/menu/4', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:39', '2017-09-29 02:01:39'),
(455, 1, 'admin/auth/menu/4/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:39', '2017-09-29 02:01:39'),
(456, 1, 'admin/auth/menu/5/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:44', '2017-09-29 02:01:44'),
(457, 1, 'admin/auth/menu/5', 'PUT', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u6743\\u9650\",\"icon\":\"fa-user\",\"uri\":\"auth\\/permissions\",\"permission_slug\":\"BackendAdminPermission\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/4\\/edit\"}', '2017-09-29 02:01:51', '2017-09-29 02:01:51'),
(458, 1, 'admin/auth/menu/4/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:51', '2017-09-29 02:01:51'),
(459, 1, 'admin/auth/menu/5', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:52', '2017-09-29 02:01:52'),
(460, 1, 'admin/auth/menu/5/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:52', '2017-09-29 02:01:52'),
(461, 1, 'admin/auth/menu/6/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:01:56', '2017-09-29 02:01:56'),
(462, 1, 'admin/auth/menu/6', 'PUT', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u83dc\\u5355\",\"icon\":\"fa-bars\",\"uri\":\"auth\\/menu\",\"permission_slug\":\"BackendAdminMenu\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/5\\/edit\"}', '2017-09-29 02:02:02', '2017-09-29 02:02:02'),
(463, 1, 'admin/auth/menu/5/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:02', '2017-09-29 02:02:02'),
(464, 1, 'admin/auth/menu/6', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:03', '2017-09-29 02:02:03'),
(465, 1, 'admin/auth/menu/6/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:03', '2017-09-29 02:02:03'),
(466, 1, 'admin/auth/menu/7/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:08', '2017-09-29 02:02:08'),
(467, 1, 'admin/auth/menu/7', 'PUT', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u65e5\\u5fd7\",\"icon\":\"fa-history\",\"uri\":\"auth\\/logs\",\"permission_slug\":\"BackendAdminLog\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/6\\/edit\"}', '2017-09-29 02:02:14', '2017-09-29 02:02:14'),
(468, 1, 'admin/auth/menu/6/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:15', '2017-09-29 02:02:15'),
(469, 1, 'admin/auth/menu/7', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:15', '2017-09-29 02:02:15'),
(470, 1, 'admin/auth/menu/7/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:16', '2017-09-29 02:02:16'),
(471, 1, 'admin/auth/menu/8/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:19', '2017-09-29 02:02:19'),
(472, 1, 'admin/auth/menu/8', 'PUT', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"Helpers\",\"icon\":\"fa-gears\",\"uri\":\"\",\"permission_slug\":\"BackendHelper\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/7\\/edit\"}', '2017-09-29 02:02:27', '2017-09-29 02:02:27'),
(473, 1, 'admin/auth/menu/7/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:28', '2017-09-29 02:02:28'),
(474, 1, 'admin/auth/menu/8', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:28', '2017-09-29 02:02:28'),
(475, 1, 'admin/auth/menu/8/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:29', '2017-09-29 02:02:29'),
(476, 1, 'admin/auth/menu/9/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:33', '2017-09-29 02:02:33'),
(477, 1, 'admin/auth/menu/9', 'PUT', '172.0.0.177', '{\"parent_id\":\"8\",\"title\":\"Scaffold\",\"icon\":\"fa-keyboard-o\",\"uri\":\"helpers\\/scaffold\",\"permission_slug\":\"BackendHelperCsaffold\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/8\\/edit\"}', '2017-09-29 02:02:41', '2017-09-29 02:02:41'),
(478, 1, 'admin/auth/menu/8/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:41', '2017-09-29 02:02:41'),
(479, 1, 'admin/auth/menu/9', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:41', '2017-09-29 02:02:41'),
(480, 1, 'admin/auth/menu/9/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:42', '2017-09-29 02:02:42'),
(481, 1, 'admin/auth/menu/10/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:46', '2017-09-29 02:02:46'),
(482, 1, 'admin/auth/menu/10', 'PUT', '172.0.0.177', '{\"parent_id\":\"8\",\"title\":\"Database terminal\",\"icon\":\"fa-database\",\"uri\":\"helpers\\/terminal\\/database\",\"permission_slug\":\"BackendHelperDatabase\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/9\\/edit\"}', '2017-09-29 02:02:51', '2017-09-29 02:02:51'),
(483, 1, 'admin/auth/menu/9/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:51', '2017-09-29 02:02:51'),
(484, 1, 'admin/auth/menu/10', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:52', '2017-09-29 02:02:52'),
(485, 1, 'admin/auth/menu/10/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:52', '2017-09-29 02:02:52'),
(486, 1, 'admin/auth/menu/11/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:02:56', '2017-09-29 02:02:56'),
(487, 1, 'admin/auth/menu/11', 'PUT', '172.0.0.177', '{\"parent_id\":\"8\",\"title\":\"Laravel artisan\",\"icon\":\"fa-terminal\",\"uri\":\"helpers\\/terminal\\/artisan\",\"permission_slug\":\"BackendHelperArtisan\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/menu\\/10\\/edit\"}', '2017-09-29 02:03:01', '2017-09-29 02:03:01'),
(488, 1, 'admin/auth/menu/10/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:01', '2017-09-29 02:03:01'),
(489, 1, 'admin/auth/menu/11', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:02', '2017-09-29 02:03:02'),
(490, 1, 'admin/auth/menu/11/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:02', '2017-09-29 02:03:02'),
(491, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:03:16', '2017-09-29 02:03:16'),
(492, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:16', '2017-09-29 02:03:16'),
(493, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:03:18', '2017-09-29 02:03:18'),
(494, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:19', '2017-09-29 02:03:19'),
(495, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:03:23', '2017-09-29 02:03:23'),
(496, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:24', '2017-09-29 02:03:24'),
(497, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:24', '2017-09-29 02:03:24'),
(498, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:03:39', '2017-09-29 02:03:39'),
(499, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:39', '2017-09-29 02:03:39'),
(500, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:03:41', '2017-09-29 02:03:41'),
(501, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:42', '2017-09-29 02:03:42'),
(502, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:03:48', '2017-09-29 02:03:48'),
(503, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:49', '2017-09-29 02:03:49'),
(504, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:50', '2017-09-29 02:03:50'),
(505, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:03:58', '2017-09-29 02:03:58'),
(506, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:03:58', '2017-09-29 02:03:58'),
(507, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:04:55', '2017-09-29 02:04:55'),
(508, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 02:04:55', '2017-09-29 02:04:55'),
(509, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:04:58', '2017-09-29 02:04:58'),
(510, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:04:59', '2017-09-29 02:04:59'),
(511, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:05:18', '2017-09-29 02:05:18'),
(512, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 02:05:19', '2017-09-29 02:05:19'),
(513, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '{\"_export_\":\"1\"}', '2017-09-29 02:05:58', '2017-09-29 02:05:58'),
(514, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:06:54', '2017-09-29 02:06:54'),
(515, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:06:55', '2017-09-29 02:06:55'),
(516, 1, 'admin/auth/logs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:06:57', '2017-09-29 02:06:57'),
(517, 1, 'admin/auth/logs', 'GET', '172.0.0.177', '[]', '2017-09-29 02:06:58', '2017-09-29 02:06:58'),
(518, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:09:20', '2017-09-29 02:09:20'),
(519, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:09:20', '2017-09-29 02:09:20'),
(520, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:09:27', '2017-09-29 02:09:27'),
(521, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:09:27', '2017-09-29 02:09:27'),
(522, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:13:48', '2017-09-29 02:13:48'),
(523, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:13:49', '2017-09-29 02:13:49'),
(524, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:13:49', '2017-09-29 02:13:49'),
(525, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:11', '2017-09-29 02:14:11'),
(526, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:14:16', '2017-09-29 02:14:16'),
(527, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:16', '2017-09-29 02:14:16'),
(528, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:14:19', '2017-09-29 02:14:19'),
(529, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:19', '2017-09-29 02:14:19'),
(530, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:14:27', '2017-09-29 02:14:27'),
(531, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:27', '2017-09-29 02:14:27'),
(532, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:28', '2017-09-29 02:14:28'),
(533, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:14:31', '2017-09-29 02:14:31'),
(534, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:32', '2017-09-29 02:14:32'),
(535, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:14:34', '2017-09-29 02:14:34'),
(536, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:35', '2017-09-29 02:14:35'),
(537, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:14:41', '2017-09-29 02:14:41'),
(538, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:41', '2017-09-29 02:14:41'),
(539, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:14:42', '2017-09-29 02:14:42'),
(540, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:15:18', '2017-09-29 02:15:18'),
(541, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:18', '2017-09-29 02:15:18'),
(542, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:15:20', '2017-09-29 02:15:20'),
(543, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:21', '2017-09-29 02:15:21'),
(544, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:15:26', '2017-09-29 02:15:26'),
(545, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:27', '2017-09-29 02:15:27'),
(546, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:27', '2017-09-29 02:15:27'),
(547, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:15:30', '2017-09-29 02:15:30'),
(548, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:31', '2017-09-29 02:15:31'),
(549, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:15:33', '2017-09-29 02:15:33'),
(550, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:33', '2017-09-29 02:15:33'),
(551, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:15:39', '2017-09-29 02:15:39'),
(552, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:39', '2017-09-29 02:15:39'),
(553, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:15:40', '2017-09-29 02:15:40'),
(554, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:16:04', '2017-09-29 02:16:04'),
(555, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:16:04', '2017-09-29 02:16:04'),
(556, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:16:07', '2017-09-29 02:16:07'),
(557, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:16:07', '2017-09-29 02:16:07'),
(558, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:16:12', '2017-09-29 02:16:12'),
(559, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:16:53', '2017-09-29 02:16:53'),
(560, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:16:54', '2017-09-29 02:16:54'),
(561, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:16:57', '2017-09-29 02:16:57'),
(562, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:16:58', '2017-09-29 02:16:58'),
(563, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:17:00', '2017-09-29 02:17:00'),
(564, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:21:46', '2017-09-29 02:21:46'),
(565, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:21:46', '2017-09-29 02:21:46'),
(566, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:21:48', '2017-09-29 02:21:48'),
(567, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:21:49', '2017-09-29 02:21:49'),
(568, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:21:51', '2017-09-29 02:21:51'),
(569, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:21:52', '2017-09-29 02:21:52'),
(570, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:21:55', '2017-09-29 02:21:55'),
(571, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:22:08', '2017-09-29 02:22:08'),
(572, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:22:08', '2017-09-29 02:22:08'),
(573, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:22:11', '2017-09-29 02:22:11'),
(574, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:22:12', '2017-09-29 02:22:12'),
(575, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:22:21', '2017-09-29 02:22:21'),
(576, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:26:11', '2017-09-29 02:26:11'),
(577, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:26:12', '2017-09-29 02:26:12'),
(578, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:26:14', '2017-09-29 02:26:14'),
(579, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:26:14', '2017-09-29 02:26:14'),
(580, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:26:17', '2017-09-29 02:26:17'),
(581, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:30:52', '2017-09-29 02:30:52'),
(582, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:31:02', '2017-09-29 02:31:02'),
(583, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:31:02', '2017-09-29 02:31:02'),
(584, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:31:04', '2017-09-29 02:31:04'),
(585, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:31:05', '2017-09-29 02:31:05'),
(586, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:41:09', '2017-09-29 02:41:09'),
(587, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:41:09', '2017-09-29 02:41:09'),
(588, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"3\",\"title\":\"\\u6d4b\\u8bd5\",\"icon\":\"fa-bars\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 02:41:32', '2017-09-29 02:41:32'),
(589, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:41:33', '2017-09-29 02:41:33'),
(590, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:41:33', '2017-09-29 02:41:33'),
(591, 1, 'admin/auth/menu/12', 'DELETE', '172.0.0.177', '{\"_method\":\"delete\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 02:41:49', '2017-09-29 02:41:49'),
(592, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:41:49', '2017-09-29 02:41:49'),
(593, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:41:50', '2017-09-29 02:41:50'),
(594, 1, 'admin/auth/menu/3/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:43:54', '2017-09-29 02:43:54'),
(595, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"\\u6a21\\u5757\",\"icon\":\"fa-cubes\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 02:44:45', '2017-09-29 02:44:45'),
(596, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:44:45', '2017-09-29 02:44:45'),
(597, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:44:46', '2017-09-29 02:44:46'),
(598, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_order\":\"[{\\\"id\\\":1},{\\\"id\\\":2,\\\"children\\\":[{\\\"id\\\":3},{\\\"id\\\":4},{\\\"id\\\":5},{\\\"id\\\":6},{\\\"id\\\":7}]},{\\\"id\\\":13},{\\\"id\\\":8,\\\"children\\\":[{\\\"id\\\":9},{\\\"id\\\":10},{\\\"id\\\":11}]}]\"}', '2017-09-29 02:45:04', '2017-09-29 02:45:04'),
(599, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:45:05', '2017-09-29 02:45:05'),
(600, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:45:05', '2017-09-29 02:45:05'),
(601, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u914d\\u7f6e\",\"icon\":\"fa-cog\",\"uri\":\"auth\\/configs\",\"permission_slug\":\"BackendIndex\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 02:54:22', '2017-09-29 02:54:22'),
(602, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:54:22', '2017-09-29 02:54:22'),
(603, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:54:22', '2017-09-29 02:54:22'),
(604, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:54:30', '2017-09-29 02:54:30'),
(605, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 02:54:31', '2017-09-29 02:54:31'),
(606, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:54:35', '2017-09-29 02:54:35'),
(607, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-29 02:54:35', '2017-09-29 02:54:35'),
(608, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminConfigs\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u914d\\u7f6e\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-29 02:55:08', '2017-09-29 02:55:08'),
(609, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:09', '2017-09-29 02:55:09'),
(610, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:09', '2017-09-29 02:55:09'),
(611, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:55:15', '2017-09-29 02:55:15'),
(612, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:15', '2017-09-29 02:55:15'),
(613, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"0\",\"title\":\"\",\"icon\":\"fa-bars\",\"uri\":\"\",\"permission_slug\":\"BackendAdminConfigs\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 02:55:23', '2017-09-29 02:55:23'),
(614, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:23', '2017-09-29 02:55:23'),
(615, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:24', '2017-09-29 02:55:24'),
(616, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:55:30', '2017-09-29 02:55:30'),
(617, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:31', '2017-09-29 02:55:31'),
(618, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 02:55:33', '2017-09-29 02:55:33'),
(619, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:33', '2017-09-29 02:55:33'),
(620, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 02:55:41', '2017-09-29 02:55:41'),
(621, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:41', '2017-09-29 02:55:41'),
(622, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 02:55:42', '2017-09-29 02:55:42'),
(623, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:19:30', '2017-09-29 03:19:30'),
(624, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 03:19:30', '2017-09-29 03:19:30'),
(625, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 03:20:12', '2017-09-29 03:20:12'),
(626, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 03:20:31', '2017-09-29 03:20:31'),
(627, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 03:24:28', '2017-09-29 03:24:28'),
(628, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:24:35', '2017-09-29 03:24:35'),
(629, 1, 'admin/auth/roles/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 03:24:35', '2017-09-29 03:24:35'),
(630, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 03:24:47', '2017-09-29 03:24:47'),
(631, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 03:25:26', '2017-09-29 03:25:26'),
(632, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:27:36', '2017-09-29 03:27:36'),
(633, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 03:27:36', '2017-09-29 03:27:36'),
(634, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:28:56', '2017-09-29 03:28:56'),
(635, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:29:45', '2017-09-29 03:29:45'),
(636, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:31:06', '2017-09-29 03:31:06'),
(637, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 03:31:06', '2017-09-29 03:31:06'),
(638, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:31:08', '2017-09-29 03:31:08'),
(639, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 03:31:09', '2017-09-29 03:31:09'),
(640, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:31:13', '2017-09-29 03:31:13'),
(641, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:33:39', '2017-09-29 03:33:39'),
(642, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:40:20', '2017-09-29 03:40:20'),
(643, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:41:17', '2017-09-29 03:41:17'),
(644, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:41:47', '2017-09-29 03:41:47'),
(645, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:42:48', '2017-09-29 03:42:48'),
(646, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 03:42:49', '2017-09-29 03:42:49'),
(647, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 03:42:49', '2017-09-29 03:42:49'),
(648, 1, 'admin/auth/configs/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 03:43:22', '2017-09-29 03:43:22'),
(649, 1, 'admin/auth/configs/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 03:43:22', '2017-09-29 03:43:22'),
(650, 1, 'admin/auth/configs/1', 'PUT', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 03:43:27', '2017-09-29 03:43:27'),
(651, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 04:02:57', '2017-09-29 04:02:57'),
(652, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 04:02:57', '2017-09-29 04:02:57'),
(653, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 04:02:59', '2017-09-29 04:02:59'),
(654, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 04:03:00', '2017-09-29 04:03:00'),
(655, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 04:03:04', '2017-09-29 04:03:04'),
(656, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 04:03:05', '2017-09-29 04:03:05'),
(657, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 04:03:20', '2017-09-29 04:03:20'),
(658, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 04:03:34', '2017-09-29 04:03:34'),
(659, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 04:03:35', '2017-09-29 04:03:35'),
(660, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:23:42', '2017-09-29 05:23:42'),
(661, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 05:23:43', '2017-09-29 05:23:43'),
(662, 1, 'admin/auth/configs', 'POST', '172.0.0.177', '{\"key\":\"BACKEND_PAGE_SIZE\",\"value\":\"20\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/configs\"}', '2017-09-29 05:23:51', '2017-09-29 05:23:51'),
(663, 1, 'admin/auth/configs/create', 'GET', '172.0.0.177', '[]', '2017-09-29 05:23:51', '2017-09-29 05:23:51'),
(664, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 05:23:52', '2017-09-29 05:23:52'),
(665, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:24:08', '2017-09-29 05:24:08'),
(666, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-29 05:24:09', '2017-09-29 05:24:09'),
(667, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:49:03', '2017-09-29 05:49:03'),
(668, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 05:49:04', '2017-09-29 05:49:04'),
(669, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:49:17', '2017-09-29 05:49:17'),
(670, 1, 'admin/auth/permissions/create', 'GET', '172.0.0.177', '[]', '2017-09-29 05:49:18', '2017-09-29 05:49:18'),
(671, 1, 'admin/auth/permissions', 'POST', '172.0.0.177', '{\"slug\":\"BackendAdminFile\",\"name\":\"\\u540e\\u53f0\\u7ba1\\u7406\\u6587\\u4ef6\\u83dc\\u5355\\u6743\\u9650\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/permissions\"}', '2017-09-29 05:50:01', '2017-09-29 05:50:01'),
(672, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:02', '2017-09-29 05:50:02'),
(673, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:02', '2017-09-29 05:50:02'),
(674, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:50:09', '2017-09-29 05:50:09'),
(675, 1, 'admin/auth/roles', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:09', '2017-09-29 05:50:09'),
(676, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:50:12', '2017-09-29 05:50:12'),
(677, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:12', '2017-09-29 05:50:12');
INSERT INTO `admin_operation_log` (`id`, `user_id`, `path`, `method`, `ip`, `input`, `created_at`, `updated_at`) VALUES
(678, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:50:17', '2017-09-29 05:50:17'),
(679, 1, 'admin/auth/users/1/edit', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:17', '2017-09-29 05:50:17'),
(680, 1, 'admin/auth/users/1', 'PUT', '172.0.0.177', '{\"username\":\"admin\",\"name\":\"admin\",\"email\":\"690828339@qq.com\",\"password\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"password_confirmation\":\"$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe\",\"activated\":\"1\",\"roles\":[\"1\",\"\"],\"permissions\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"\"],\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/172.0.0.177:8002\\/admin\\/auth\\/users\"}', '2017-09-29 05:50:23', '2017-09-29 05:50:23'),
(681, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:24', '2017-09-29 05:50:24'),
(682, 1, 'admin/auth/users/1', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:25', '2017-09-29 05:50:25'),
(683, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:50:29', '2017-09-29 05:50:29'),
(684, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 05:50:30', '2017-09-29 05:50:30'),
(685, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"2\",\"title\":\"\\u6587\\u4ef6\",\"icon\":\"fa-file\",\"uri\":\"auth\\/files\",\"permission_slug\":\"BackendAdminFile\",\"_token\":\"uraKd1vRghyquf7BDxdZQkqQtmATsyset8VbPO1P\"}', '2017-09-29 05:51:12', '2017-09-29 05:51:12'),
(686, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 05:51:12', '2017-09-29 05:51:12'),
(687, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 05:51:13', '2017-09-29 05:51:13'),
(688, 1, 'admin/auth/files', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 05:51:17', '2017-09-29 05:51:17'),
(689, 1, 'admin/auth/files', 'GET', '172.0.0.177', '[]', '2017-09-29 05:51:17', '2017-09-29 05:51:17'),
(690, 1, 'admin/auth/files', 'GET', '172.0.0.177', '[]', '2017-09-29 05:51:49', '2017-09-29 05:51:49'),
(691, 1, 'admin/auth/files', 'GET', '172.0.0.177', '[]', '2017-09-29 05:52:16', '2017-09-29 05:52:16'),
(692, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-09-29 08:13:59', '2017-09-29 08:13:59'),
(693, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-09-29 08:15:16', '2017-09-29 08:15:16'),
(694, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-09-29 08:15:16', '2017-09-29 08:15:16'),
(695, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-09-30 02:07:51', '2017-09-30 02:07:51'),
(696, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-10-09 01:44:44', '2017-10-09 01:44:44'),
(697, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:26:07', '2017-10-09 05:26:07'),
(698, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:27:59', '2017-10-09 05:27:59'),
(699, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:29:36', '2017-10-09 05:29:36'),
(700, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:29:49', '2017-10-09 05:29:49'),
(701, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:34:59', '2017-10-09 05:34:59'),
(702, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:35:26', '2017-10-09 05:35:26'),
(703, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:36:07', '2017-10-09 05:36:07'),
(704, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:36:47', '2017-10-09 05:36:47'),
(705, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:37:02', '2017-10-09 05:37:02'),
(706, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 05:47:54', '2017-10-09 05:47:54'),
(707, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 05:48:55', '2017-10-09 05:48:55'),
(708, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:49:22', '2017-10-09 05:49:22'),
(709, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 05:49:22', '2017-10-09 05:49:22'),
(710, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:49:24', '2017-10-09 05:49:24'),
(711, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 05:49:25', '2017-10-09 05:49:25'),
(712, 1, 'admin/helpers/terminal/artisan', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:49:29', '2017-10-09 05:49:29'),
(713, 1, 'admin/helpers/terminal/artisan', 'GET', '172.0.0.152', '[]', '2017-10-09 05:49:30', '2017-10-09 05:49:30'),
(714, 1, 'admin/auth/users', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:49:53', '2017-10-09 05:49:53'),
(715, 1, 'admin/auth/users', 'GET', '172.0.0.152', '[]', '2017-10-09 05:49:54', '2017-10-09 05:49:54'),
(716, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:50:02', '2017-10-09 05:50:02'),
(717, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:50:03', '2017-10-09 05:50:03'),
(718, 1, 'admin/auth/menu/11/edit', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:50:19', '2017-10-09 05:50:19'),
(719, 1, 'admin/auth/menu/11/edit', 'GET', '172.0.0.152', '[]', '2017-10-09 05:50:20', '2017-10-09 05:50:20'),
(720, 1, 'admin/auth/menu/15/edit', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:50:54', '2017-10-09 05:50:54'),
(721, 1, 'admin/auth/menu/15/edit', 'GET', '172.0.0.152', '[]', '2017-10-09 05:50:55', '2017-10-09 05:50:55'),
(722, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:51:13', '2017-10-09 05:51:13'),
(723, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:51:22', '2017-10-09 05:51:22'),
(724, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:51:28', '2017-10-09 05:51:28'),
(725, 1, 'admin/auth/menu/13/edit', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:51:30', '2017-10-09 05:51:30'),
(726, 1, 'admin/auth/menu/13/edit', 'GET', '172.0.0.152', '[]', '2017-10-09 05:51:31', '2017-10-09 05:51:31'),
(727, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:51:45', '2017-10-09 05:51:45'),
(728, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:51:46', '2017-10-09 05:51:46'),
(729, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:52:04', '2017-10-09 05:52:04'),
(730, 1, 'admin/auth/menu', 'POST', '172.0.0.152', '{\"parent_id\":\"13\",\"title\":\"\\u4e8c\\u7ea7\",\"icon\":\"fa-adjust\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"l9wRdhsJbNHcvoLGmy3Fy5DpO6VoUIo1QU72oxz4\"}', '2017-10-09 05:52:23', '2017-10-09 05:52:23'),
(731, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:52:23', '2017-10-09 05:52:23'),
(732, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:52:24', '2017-10-09 05:52:24'),
(733, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:52:29', '2017-10-09 05:52:29'),
(734, 1, 'admin/auth/menu', 'POST', '172.0.0.152', '{\"parent_id\":\"16\",\"title\":\"\\u4e09\\u7ea7\",\"icon\":\"fa-anchor\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"l9wRdhsJbNHcvoLGmy3Fy5DpO6VoUIo1QU72oxz4\"}', '2017-10-09 05:52:45', '2017-10-09 05:52:45'),
(735, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:52:45', '2017-10-09 05:52:45'),
(736, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:52:46', '2017-10-09 05:52:46'),
(737, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:53:01', '2017-10-09 05:53:01'),
(738, 1, 'admin/auth/menu', 'POST', '172.0.0.152', '{\"parent_id\":\"17\",\"title\":\"\\u56db\\u7ea7\",\"icon\":\"fa-bars\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"l9wRdhsJbNHcvoLGmy3Fy5DpO6VoUIo1QU72oxz4\"}', '2017-10-09 05:53:02', '2017-10-09 05:53:02'),
(739, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:53:03', '2017-10-09 05:53:03'),
(740, 1, 'admin/auth/menu', 'GET', '172.0.0.152', '[]', '2017-10-09 05:53:04', '2017-10-09 05:53:04'),
(741, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:55:04', '2017-10-09 05:55:04'),
(742, 1, 'admin', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 05:55:12', '2017-10-09 05:55:12'),
(743, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:55:12', '2017-10-09 05:55:12'),
(744, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 05:57:59', '2017-10-09 05:57:59'),
(745, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:58:07', '2017-10-09 05:58:07'),
(746, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 05:59:43', '2017-10-09 05:59:43'),
(747, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:00:44', '2017-10-09 06:00:44'),
(748, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:01:49', '2017-10-09 06:01:49'),
(749, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:06:05', '2017-10-09 06:06:05'),
(750, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:06:34', '2017-10-09 06:06:34'),
(751, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:06:54', '2017-10-09 06:06:54'),
(752, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:07:24', '2017-10-09 06:07:24'),
(753, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:09:10', '2017-10-09 06:09:10'),
(754, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:09:59', '2017-10-09 06:09:59'),
(755, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:10:08', '2017-10-09 06:10:08'),
(756, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:10:12', '2017-10-09 06:10:12'),
(757, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:13:06', '2017-10-09 06:13:06'),
(758, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:25:09', '2017-10-09 06:25:09'),
(759, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 06:25:16', '2017-10-09 06:25:16'),
(760, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:25:35', '2017-10-09 06:25:35'),
(761, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 06:25:50', '2017-10-09 06:25:50'),
(762, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:29:25', '2017-10-09 06:29:25'),
(763, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:31:56', '2017-10-09 06:31:56'),
(764, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 06:32:20', '2017-10-09 06:32:20'),
(765, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:33:36', '2017-10-09 06:33:36'),
(766, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 06:33:52', '2017-10-09 06:33:52'),
(767, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:34:45', '2017-10-09 06:34:45'),
(768, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-10-09 06:35:09', '2017-10-09 06:35:09'),
(769, 1, 'admin/auth/menu', 'POST', '172.0.0.177', '{\"parent_id\":\"18\",\"title\":\"\\u4e94\\u7ea7\",\"icon\":\"fa-amazon\",\"uri\":\"\",\"permission_slug\":\"BackendIndex\",\"_token\":\"4PYPRh0QcRP5BZp5cQJcquHDFsTWCiQwDAVNw1iU\"}', '2017-10-09 06:35:36', '2017-10-09 06:35:36'),
(770, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-10-09 06:35:36', '2017-10-09 06:35:36'),
(771, 1, 'admin/auth/menu', 'GET', '172.0.0.177', '[]', '2017-10-09 06:35:37', '2017-10-09 06:35:37'),
(772, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:40:34', '2017-10-09 06:40:34'),
(773, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:40:57', '2017-10-09 06:40:57'),
(774, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:43:36', '2017-10-09 06:43:36'),
(775, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:44:40', '2017-10-09 06:44:40'),
(776, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:45:15', '2017-10-09 06:45:15'),
(777, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:45:30', '2017-10-09 06:45:30'),
(778, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 06:46:03', '2017-10-09 06:46:03'),
(779, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 06:58:11', '2017-10-09 06:58:11'),
(780, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 07:09:33', '2017-10-09 07:09:33'),
(781, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 07:09:33', '2017-10-09 07:09:33'),
(782, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:09:42', '2017-10-09 07:09:42'),
(783, 1, 'admin', 'GET', '172.0.0.152', '{\"_pjax\":\"#pjax-container\"}', '2017-10-09 07:10:38', '2017-10-09 07:10:38'),
(784, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 07:10:39', '2017-10-09 07:10:39'),
(785, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 07:18:28', '2017-10-09 07:18:28'),
(786, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:31:42', '2017-10-09 07:31:42'),
(787, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:32:06', '2017-10-09 07:32:06'),
(788, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:33:24', '2017-10-09 07:33:24'),
(789, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:33:44', '2017-10-09 07:33:44'),
(790, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:35:06', '2017-10-09 07:35:06'),
(791, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:35:16', '2017-10-09 07:35:16'),
(792, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:35:56', '2017-10-09 07:35:56'),
(793, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:35:58', '2017-10-09 07:35:58'),
(794, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:36:18', '2017-10-09 07:36:18'),
(795, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:36:29', '2017-10-09 07:36:29'),
(796, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 07:42:51', '2017-10-09 07:42:51'),
(797, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 07:43:09', '2017-10-09 07:43:09'),
(798, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-09 08:01:39', '2017-10-09 08:01:39'),
(799, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:01:57', '2017-10-09 08:01:57'),
(800, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:11:05', '2017-10-09 08:11:05'),
(801, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:22:28', '2017-10-09 08:22:28'),
(802, 1, 'admin', 'GET', '172.0.0.152', '[]', '2017-10-09 08:23:20', '2017-10-09 08:23:20'),
(803, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:23:49', '2017-10-09 08:23:49'),
(804, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:24:00', '2017-10-09 08:24:00'),
(805, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:25:19', '2017-10-09 08:25:19'),
(806, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:34:11', '2017-10-09 08:34:11'),
(807, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:55:28', '2017-10-09 08:55:28'),
(808, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:56:26', '2017-10-09 08:56:26'),
(809, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:57:25', '2017-10-09 08:57:25'),
(810, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 08:58:00', '2017-10-09 08:58:00'),
(811, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 09:33:16', '2017-10-09 09:33:16'),
(812, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 09:33:32', '2017-10-09 09:33:32'),
(813, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 09:37:19', '2017-10-09 09:37:19'),
(814, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 09:44:21', '2017-10-09 09:44:21'),
(815, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:22:59', '2017-10-09 10:22:59'),
(816, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:23:12', '2017-10-09 10:23:12'),
(817, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:25:57', '2017-10-09 10:25:57'),
(818, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:27:12', '2017-10-09 10:27:12'),
(819, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:32:47', '2017-10-09 10:32:47'),
(820, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:33:03', '2017-10-09 10:33:03'),
(821, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:33:08', '2017-10-09 10:33:08'),
(822, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:33:22', '2017-10-09 10:33:22'),
(823, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-09 10:33:42', '2017-10-09 10:33:42'),
(824, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 01:29:51', '2017-10-10 01:29:51'),
(825, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 01:34:26', '2017-10-10 01:34:26'),
(826, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 01:34:44', '2017-10-10 01:34:44'),
(827, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:08:53', '2017-10-10 03:08:53'),
(828, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:22:55', '2017-10-10 03:22:55'),
(829, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:28:47', '2017-10-10 03:28:47'),
(830, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:31:26', '2017-10-10 03:31:26'),
(831, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:31:53', '2017-10-10 03:31:53'),
(832, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:32:24', '2017-10-10 03:32:24'),
(833, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 03:34:19', '2017-10-10 03:34:19'),
(834, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 03:34:56', '2017-10-10 03:34:56'),
(835, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:11:49', '2017-10-10 08:11:49'),
(836, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:11:54', '2017-10-10 08:11:54'),
(837, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:17:46', '2017-10-10 08:17:46'),
(838, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:24:21', '2017-10-10 08:24:21'),
(839, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:41:14', '2017-10-10 08:41:14'),
(840, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:46:51', '2017-10-10 08:46:51'),
(841, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:49:49', '2017-10-10 08:49:49'),
(842, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 08:53:19', '2017-10-10 08:53:19'),
(843, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:55:27', '2017-10-10 08:55:27'),
(844, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 08:55:45', '2017-10-10 08:55:45'),
(845, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 08:56:56', '2017-10-10 08:56:56'),
(846, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:01:51', '2017-10-10 09:01:51'),
(847, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:05:42', '2017-10-10 09:05:42'),
(848, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:05:46', '2017-10-10 09:05:46'),
(849, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:08:39', '2017-10-10 09:08:39'),
(850, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:09:17', '2017-10-10 09:09:17'),
(851, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:09:56', '2017-10-10 09:09:56'),
(852, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:10:03', '2017-10-10 09:10:03'),
(853, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:11:48', '2017-10-10 09:11:48'),
(854, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:12:27', '2017-10-10 09:12:27'),
(855, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:14:30', '2017-10-10 09:14:30'),
(856, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:15:21', '2017-10-10 09:15:21'),
(857, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:15:27', '2017-10-10 09:15:27'),
(858, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:17:00', '2017-10-10 09:17:00'),
(859, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:17:24', '2017-10-10 09:17:24'),
(860, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:20:04', '2017-10-10 09:20:04'),
(861, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:20:23', '2017-10-10 09:20:23'),
(862, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:23:43', '2017-10-10 09:23:43'),
(863, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-10 09:24:09', '2017-10-10 09:24:09'),
(864, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-10 09:24:10', '2017-10-10 09:24:10'),
(865, 1, 'admin', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-10 09:25:50', '2017-10-10 09:25:50'),
(866, 1, 'admin', 'GET', '172.0.0.177', '[]', '2017-10-10 09:25:50', '2017-10-10 09:25:50'),
(867, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:26:29', '2017-10-10 09:26:29'),
(868, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:31:55', '2017-10-10 09:31:55'),
(869, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:32:03', '2017-10-10 09:32:03'),
(870, 1, 'admin/auth/users', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-10 09:32:42', '2017-10-10 09:32:42'),
(871, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-10 09:32:43', '2017-10-10 09:32:43'),
(872, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:42:58', '2017-10-10 09:42:58'),
(873, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:43:53', '2017-10-10 09:43:53'),
(874, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:47:39', '2017-10-10 09:47:39'),
(875, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:48:30', '2017-10-10 09:48:30'),
(876, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:49:31', '2017-10-10 09:49:31'),
(877, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:50:02', '2017-10-10 09:50:02'),
(878, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:50:20', '2017-10-10 09:50:20'),
(879, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:51:33', '2017-10-10 09:51:33'),
(880, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:52:15', '2017-10-10 09:52:15'),
(881, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:53:21', '2017-10-10 09:53:21'),
(882, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:53:47', '2017-10-10 09:53:47'),
(883, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:55:39', '2017-10-10 09:55:39'),
(884, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 09:57:01', '2017-10-10 09:57:01'),
(885, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:01:37', '2017-10-10 10:01:37'),
(886, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:02:06', '2017-10-10 10:02:06'),
(887, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:02:32', '2017-10-10 10:02:32'),
(888, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:04:29', '2017-10-10 10:04:29'),
(889, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:08:46', '2017-10-10 10:08:46'),
(890, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:08:57', '2017-10-10 10:08:57'),
(891, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:11:03', '2017-10-10 10:11:03'),
(892, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:11:14', '2017-10-10 10:11:14'),
(893, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:11:30', '2017-10-10 10:11:30'),
(894, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:11:37', '2017-10-10 10:11:37'),
(895, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:14:23', '2017-10-10 10:14:23'),
(896, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:15:02', '2017-10-10 10:15:02'),
(897, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:15:43', '2017-10-10 10:15:43'),
(898, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:17:26', '2017-10-10 10:17:26'),
(899, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:18:16', '2017-10-10 10:18:16'),
(900, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:19:14', '2017-10-10 10:19:14'),
(901, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:19:20', '2017-10-10 10:19:20'),
(902, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:19:34', '2017-10-10 10:19:34'),
(903, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:19:37', '2017-10-10 10:19:37'),
(904, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:19:40', '2017-10-10 10:19:40'),
(905, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:20:47', '2017-10-10 10:20:47'),
(906, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:21:21', '2017-10-10 10:21:21'),
(907, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:23:59', '2017-10-10 10:23:59'),
(908, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:25:57', '2017-10-10 10:25:57'),
(909, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:26:12', '2017-10-10 10:26:12'),
(910, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:27:54', '2017-10-10 10:27:54'),
(911, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:27:57', '2017-10-10 10:27:57'),
(912, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:27:59', '2017-10-10 10:27:59'),
(913, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:01', '2017-10-10 10:28:01'),
(914, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:03', '2017-10-10 10:28:03'),
(915, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:05', '2017-10-10 10:28:05'),
(916, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:06', '2017-10-10 10:28:06'),
(917, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:08', '2017-10-10 10:28:08'),
(918, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:10', '2017-10-10 10:28:10'),
(919, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:11', '2017-10-10 10:28:11'),
(920, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:30', '2017-10-10 10:28:30'),
(921, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:33', '2017-10-10 10:28:33'),
(922, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:35', '2017-10-10 10:28:35'),
(923, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:37', '2017-10-10 10:28:37'),
(924, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:39', '2017-10-10 10:28:39'),
(925, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:41', '2017-10-10 10:28:41'),
(926, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-10 10:28:43', '2017-10-10 10:28:43'),
(927, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:31:11', '2017-10-11 01:31:11'),
(928, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:33:19', '2017-10-11 01:33:19'),
(929, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:33:54', '2017-10-11 01:33:54'),
(930, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:35:26', '2017-10-11 01:35:26'),
(931, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:46:07', '2017-10-11 01:46:07'),
(932, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:46:26', '2017-10-11 01:46:26'),
(933, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:46:31', '2017-10-11 01:46:31'),
(934, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:47:00', '2017-10-11 01:47:00'),
(935, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:47:35', '2017-10-11 01:47:35'),
(936, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:48:07', '2017-10-11 01:48:07'),
(937, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:48:28', '2017-10-11 01:48:28'),
(938, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 01:49:44', '2017-10-11 01:49:44'),
(939, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:07:00', '2017-10-11 02:07:00'),
(940, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:07:07', '2017-10-11 02:07:07'),
(941, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:10:27', '2017-10-11 02:10:27'),
(942, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:11:21', '2017-10-11 02:11:21'),
(943, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:16:22', '2017-10-11 02:16:22'),
(944, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:21:23', '2017-10-11 02:21:23'),
(945, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:22:13', '2017-10-11 02:22:13'),
(946, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:22:25', '2017-10-11 02:22:25'),
(947, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:22:29', '2017-10-11 02:22:29'),
(948, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:28:26', '2017-10-11 02:28:26'),
(949, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:32:49', '2017-10-11 02:32:49'),
(950, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-11 02:33:02', '2017-10-11 02:33:02'),
(951, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 02:34:34', '2017-10-11 02:34:34'),
(952, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:11:47', '2017-10-11 05:11:47'),
(953, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:13:23', '2017-10-11 05:13:23'),
(954, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:17:57', '2017-10-11 05:17:57'),
(955, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:20:06', '2017-10-11 05:20:06'),
(956, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:33:27', '2017-10-11 05:33:27'),
(957, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:33:50', '2017-10-11 05:33:50'),
(958, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:36:09', '2017-10-11 05:36:09'),
(959, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:39:27', '2017-10-11 05:39:27'),
(960, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:39:45', '2017-10-11 05:39:45'),
(961, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:40:16', '2017-10-11 05:40:16'),
(962, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:40:59', '2017-10-11 05:40:59'),
(963, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:42:02', '2017-10-11 05:42:02'),
(964, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:42:40', '2017-10-11 05:42:40'),
(965, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:43:56', '2017-10-11 05:43:56'),
(966, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:44:41', '2017-10-11 05:44:41'),
(967, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:49:24', '2017-10-11 05:49:24'),
(968, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:50:57', '2017-10-11 05:50:57'),
(969, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:51:10', '2017-10-11 05:51:10'),
(970, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:51:19', '2017-10-11 05:51:19'),
(971, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:52:44', '2017-10-11 05:52:44'),
(972, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:52:51', '2017-10-11 05:52:51'),
(973, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:53:19', '2017-10-11 05:53:19'),
(974, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:54:11', '2017-10-11 05:54:11'),
(975, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:54:34', '2017-10-11 05:54:34'),
(976, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:54:55', '2017-10-11 05:54:55'),
(977, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 05:55:09', '2017-10-11 05:55:09'),
(978, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 06:09:14', '2017-10-11 06:09:14'),
(979, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 06:11:40', '2017-10-11 06:11:40'),
(980, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 06:12:26', '2017-10-11 06:12:26'),
(981, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:04:45', '2017-10-11 07:04:45'),
(982, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:05:49', '2017-10-11 07:05:49'),
(983, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:06:04', '2017-10-11 07:06:04'),
(984, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:06:14', '2017-10-11 07:06:14'),
(985, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:08:07', '2017-10-11 07:08:07'),
(986, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:08:09', '2017-10-11 07:08:09'),
(987, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:09:01', '2017-10-11 07:09:01'),
(988, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:09:10', '2017-10-11 07:09:10'),
(989, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:09:31', '2017-10-11 07:09:31'),
(990, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:09:59', '2017-10-11 07:09:59'),
(991, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:10:07', '2017-10-11 07:10:07'),
(992, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:12:30', '2017-10-11 07:12:30'),
(993, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:14:10', '2017-10-11 07:14:10'),
(994, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:14:37', '2017-10-11 07:14:37'),
(995, 1, 'admin/test', 'GET', '172.0.0.177', '{\"id\":\"\"}', '2017-10-11 07:14:49', '2017-10-11 07:14:49'),
(996, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-11 07:23:01', '2017-10-11 07:23:01'),
(997, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:23:41', '2017-10-11 07:23:41'),
(998, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-11 07:24:45', '2017-10-11 07:24:45'),
(999, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-11 07:24:54', '2017-10-11 07:24:54'),
(1000, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:44:20', '2017-10-11 07:44:20'),
(1001, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 07:49:10', '2017-10-11 07:49:10'),
(1002, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:15:52', '2017-10-11 09:15:52'),
(1003, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:18:35', '2017-10-11 09:18:35'),
(1004, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:19:35', '2017-10-11 09:19:35'),
(1005, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:20:02', '2017-10-11 09:20:02'),
(1006, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:23:42', '2017-10-11 09:23:42'),
(1007, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:24:00', '2017-10-11 09:24:00'),
(1008, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:24:09', '2017-10-11 09:24:09'),
(1009, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:27:16', '2017-10-11 09:27:16'),
(1010, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:27:39', '2017-10-11 09:27:39'),
(1011, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:28:29', '2017-10-11 09:28:29'),
(1012, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:32:33', '2017-10-11 09:32:33'),
(1013, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:32:55', '2017-10-11 09:32:55'),
(1014, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-11 09:33:56', '2017-10-11 09:33:56'),
(1015, 1, 'admin/auth/users', 'GET', '172.0.0.177', '[]', '2017-10-12 01:20:35', '2017-10-12 01:20:35'),
(1016, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:21:09', '2017-10-12 01:21:09'),
(1017, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:35:48', '2017-10-12 01:35:48'),
(1018, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:35:53', '2017-10-12 01:35:53'),
(1019, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:38:13', '2017-10-12 01:38:13'),
(1020, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:39:16', '2017-10-12 01:39:16'),
(1021, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:41:10', '2017-10-12 01:41:10'),
(1022, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:42:24', '2017-10-12 01:42:24'),
(1023, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:43:54', '2017-10-12 01:43:54'),
(1024, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:44:13', '2017-10-12 01:44:13'),
(1025, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:46:32', '2017-10-12 01:46:32'),
(1026, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:47:03', '2017-10-12 01:47:03'),
(1027, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:48:41', '2017-10-12 01:48:41'),
(1028, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:51:44', '2017-10-12 01:51:44'),
(1029, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:52:50', '2017-10-12 01:52:50'),
(1030, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:53:33', '2017-10-12 01:53:33'),
(1031, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:54:39', '2017-10-12 01:54:39'),
(1032, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:57:07', '2017-10-12 01:57:07'),
(1033, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 01:58:14', '2017-10-12 01:58:14'),
(1034, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:00:21', '2017-10-12 02:00:21'),
(1035, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:00:50', '2017-10-12 02:00:50'),
(1036, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:03:39', '2017-10-12 02:03:39'),
(1037, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:04:10', '2017-10-12 02:04:10'),
(1038, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:04:27', '2017-10-12 02:04:27'),
(1039, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:05:47', '2017-10-12 02:05:47'),
(1040, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:14:57', '2017-10-12 02:14:57'),
(1041, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:20:49', '2017-10-12 02:20:49'),
(1042, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:24:11', '2017-10-12 02:24:11'),
(1043, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:25:38', '2017-10-12 02:25:38'),
(1044, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:26:20', '2017-10-12 02:26:20'),
(1045, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:27:41', '2017-10-12 02:27:41'),
(1046, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:27:55', '2017-10-12 02:27:55'),
(1047, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:28:21', '2017-10-12 02:28:21'),
(1048, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:28:57', '2017-10-12 02:28:57'),
(1049, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:30:09', '2017-10-12 02:30:09'),
(1050, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:34:38', '2017-10-12 02:34:38'),
(1051, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:34:52', '2017-10-12 02:34:52'),
(1052, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:36:02', '2017-10-12 02:36:02'),
(1053, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-12 02:36:54', '2017-10-12 02:36:54'),
(1054, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-10-12 02:36:55', '2017-10-12 02:36:55'),
(1055, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"per_page\":\"10\",\"_pjax\":\"#pjax-container\"}', '2017-10-12 02:37:01', '2017-10-12 02:37:01'),
(1056, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"per_page\":\"10\"}', '2017-10-12 02:37:01', '2017-10-12 02:37:01'),
(1057, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:43:37', '2017-10-12 02:43:37'),
(1058, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:43:54', '2017-10-12 02:43:54'),
(1059, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:49:39', '2017-10-12 02:49:39'),
(1060, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:50:05', '2017-10-12 02:50:05'),
(1061, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:51:06', '2017-10-12 02:51:06'),
(1062, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:51:46', '2017-10-12 02:51:46'),
(1063, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:52:05', '2017-10-12 02:52:05'),
(1064, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:52:32', '2017-10-12 02:52:32'),
(1065, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:52:47', '2017-10-12 02:52:47'),
(1066, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:55:44', '2017-10-12 02:55:44'),
(1067, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:56:49', '2017-10-12 02:56:49'),
(1068, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:57:09', '2017-10-12 02:57:09'),
(1069, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:57:58', '2017-10-12 02:57:58'),
(1070, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:58:01', '2017-10-12 02:58:01'),
(1071, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 02:58:10', '2017-10-12 02:58:10'),
(1072, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:02:02', '2017-10-12 03:02:02'),
(1073, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:04:13', '2017-10-12 03:04:13'),
(1074, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:04:55', '2017-10-12 03:04:55'),
(1075, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:05:09', '2017-10-12 03:05:09'),
(1076, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:06:42', '2017-10-12 03:06:42'),
(1077, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:07:06', '2017-10-12 03:07:06'),
(1078, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:07:31', '2017-10-12 03:07:31'),
(1079, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:10:52', '2017-10-12 03:10:52'),
(1080, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:15:13', '2017-10-12 03:15:13'),
(1081, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:20:12', '2017-10-12 03:20:12'),
(1082, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:20:31', '2017-10-12 03:20:31'),
(1083, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:21:32', '2017-10-12 03:21:32'),
(1084, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:21:39', '2017-10-12 03:21:39'),
(1085, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:27:31', '2017-10-12 03:27:31'),
(1086, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:27:35', '2017-10-12 03:27:35'),
(1087, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:30:47', '2017-10-12 03:30:47'),
(1088, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:33:50', '2017-10-12 03:33:50'),
(1089, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:37:25', '2017-10-12 03:37:25'),
(1090, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:37:32', '2017-10-12 03:37:32'),
(1091, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:37:39', '2017-10-12 03:37:39'),
(1092, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:38:20', '2017-10-12 03:38:20'),
(1093, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:38:24', '2017-10-12 03:38:24'),
(1094, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:39:23', '2017-10-12 03:39:23'),
(1095, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:39:26', '2017-10-12 03:39:26'),
(1096, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:40:00', '2017-10-12 03:40:00'),
(1097, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:40:04', '2017-10-12 03:40:04'),
(1098, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:40:07', '2017-10-12 03:40:07'),
(1099, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:42:09', '2017-10-12 03:42:09'),
(1100, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:42:39', '2017-10-12 03:42:39'),
(1101, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:42:49', '2017-10-12 03:42:49'),
(1102, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 03:42:52', '2017-10-12 03:42:52'),
(1103, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:15:02', '2017-10-12 07:15:02'),
(1104, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:15:20', '2017-10-12 07:15:20'),
(1105, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:15:53', '2017-10-12 07:15:53'),
(1106, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:16:12', '2017-10-12 07:16:12'),
(1107, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:18:59', '2017-10-12 07:18:59'),
(1108, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:20:37', '2017-10-12 07:20:37'),
(1109, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:21:55', '2017-10-12 07:21:55'),
(1110, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:22:16', '2017-10-12 07:22:16'),
(1111, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:24:03', '2017-10-12 07:24:03'),
(1112, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:24:36', '2017-10-12 07:24:36'),
(1113, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:27:40', '2017-10-12 07:27:40'),
(1114, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:31:00', '2017-10-12 07:31:00'),
(1115, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:32:18', '2017-10-12 07:32:18'),
(1116, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:32:47', '2017-10-12 07:32:47'),
(1117, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:37:33', '2017-10-12 07:37:33'),
(1118, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:38:28', '2017-10-12 07:38:28'),
(1119, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:41:46', '2017-10-12 07:41:46'),
(1120, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:43:45', '2017-10-12 07:43:45'),
(1121, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:45:02', '2017-10-12 07:45:02'),
(1122, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:46:22', '2017-10-12 07:46:22'),
(1123, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 07:59:56', '2017-10-12 07:59:56'),
(1124, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:00:13', '2017-10-12 08:00:13'),
(1125, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:00:22', '2017-10-12 08:00:22'),
(1126, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:03:03', '2017-10-12 08:03:03'),
(1127, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:27:36', '2017-10-12 08:27:36'),
(1128, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:28:48', '2017-10-12 08:28:48'),
(1129, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:36:15', '2017-10-12 08:36:15'),
(1130, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-12 08:39:21', '2017-10-12 08:39:21'),
(1131, 1, 'admin/auth/configs', 'GET', '172.0.0.177', '[]', '2017-10-12 08:39:22', '2017-10-12 08:39:22'),
(1132, 1, 'admin/auth/files', 'GET', '172.0.0.177', '{\"_pjax\":\"#pjax-container\"}', '2017-10-12 08:39:27', '2017-10-12 08:39:27'),
(1133, 1, 'admin/auth/files', 'GET', '172.0.0.177', '[]', '2017-10-12 08:39:27', '2017-10-12 08:39:27'),
(1134, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '{\"per_page\":\"10\"}', '2017-10-12 08:39:40', '2017-10-12 08:39:40'),
(1135, 1, 'admin/auth/permissions', 'GET', '172.0.0.177', '[]', '2017-10-12 08:39:41', '2017-10-12 08:39:41'),
(1136, 1, 'admin/test', 'GET', '172.0.0.177', '{\"id\":\"\"}', '2017-10-12 08:43:01', '2017-10-12 08:43:01'),
(1137, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:43:13', '2017-10-12 08:43:13'),
(1138, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:43:17', '2017-10-12 08:43:17'),
(1139, 1, 'admin/test', 'GET', '172.0.0.177', '[]', '2017-10-12 08:43:30', '2017-10-12 08:43:30'),
(1140, 1, 'admin', 'GET', '::1', '[]', '2017-10-23 03:45:41', '2017-10-23 03:45:41'),
(1141, 1, 'admin/auth/users', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-10-23 03:45:45', '2017-10-23 03:45:45'),
(1142, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-10-23 03:45:45', '2017-10-23 03:45:45'),
(1143, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-10-23 04:00:31', '2017-10-23 04:00:31'),
(1144, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-10-23 04:00:31', '2017-10-23 04:00:31'),
(1145, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-10-23 07:36:06', '2017-10-23 07:36:06'),
(1146, 1, 'admin/auth/users', 'GET', '::1', '[]', '2017-10-23 07:49:36', '2017-10-23 07:49:36'),
(1147, 1, 'admin/auth/users/1/edit', 'GET', '::1', '{\"_pjax\":\"#pjax-container\"}', '2017-10-23 07:49:39', '2017-10-23 07:49:39'),
(1148, 1, 'admin/auth/users/1/edit', 'GET', '::1', '[]', '2017-10-23 07:49:40', '2017-10-23 07:49:40');

-- --------------------------------------------------------

--
-- 表的结构 `admin_permissions`
--

CREATE TABLE `admin_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_permissions`
--

INSERT INTO `admin_permissions` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, '后台首页菜单权限', 'BackendIndex', '2017-09-27 06:41:58', '2017-09-28 10:31:52'),
(2, '后台管理菜单权限', 'BackendAdmin', '2017-09-28 10:31:42', '2017-09-28 10:31:42'),
(3, '后台管理用户菜单权限', 'BackendAdminUser', '2017-09-28 10:32:44', '2017-09-28 10:32:56'),
(4, '后台管理角色菜单权限', 'BackendAdminRole', '2017-09-28 10:33:35', '2017-09-28 10:33:35'),
(5, '后台管理权限菜单权限', 'BackendAdminPermission', '2017-09-28 10:34:18', '2017-09-28 10:34:18'),
(6, '后台管理菜单菜单权限', 'BackendAdminMenu', '2017-09-28 10:35:11', '2017-09-28 10:35:11'),
(7, '后台管理日志菜单权限', 'BackendAdminLog', '2017-09-28 10:35:49', '2017-09-28 10:35:49'),
(8, '后台帮助菜单权限', 'BackendHelper', '2017-09-28 10:36:37', '2017-09-28 10:36:37'),
(9, '后台帮助手脚架菜单权限', 'BackendHelperCsaffold', '2017-09-29 01:34:45', '2017-09-29 01:34:45'),
(10, '后台帮助数据库菜单权限', 'BackendHelperDatabase', '2017-09-29 01:35:16', '2017-09-29 01:35:16'),
(11, '后台帮助Laravel命令菜单权限', 'BackendHelperArtisan', '2017-09-29 01:36:32', '2017-09-29 01:36:32'),
(12, '后台管理配置菜单权限', 'BackendAdminConfigs', '2017-09-29 02:55:08', '2017-09-29 02:55:08'),
(13, '后台管理文件菜单权限', 'BackendAdminFile', '2017-09-29 05:50:01', '2017-09-29 05:50:01');

-- --------------------------------------------------------

--
-- 表的结构 `admin_private_letter`
--

CREATE TABLE `admin_private_letter` (
  `id` int(10) UNSIGNED NOT NULL,
  `from` int(11) NOT NULL COMMENT '消息发出者',
  `to` int(11) NOT NULL COMMENT '消息接收者',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '消息标题',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '消息主体',
  `type` tinyint(4) NOT NULL COMMENT '0：全站信息，1：私人信息',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `admin_resource`
--

CREATE TABLE `admin_resource` (
  `id` int(10) UNSIGNED NOT NULL,
  `module_id` int(11) NOT NULL COMMENT '模型id',
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '资源对应的键',
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '资源对应的值',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='模块资源表';

-- --------------------------------------------------------

--
-- 表的结构 `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Administrator', 'administrator', '2017-09-22 03:31:22', '2017-09-22 03:31:22');

-- --------------------------------------------------------

--
-- 表的结构 `admin_role_menu`
--

CREATE TABLE `admin_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_role_menu`
--

INSERT INTO `admin_role_menu` (`role_id`, `menu_id`, `created_at`, `updated_at`) VALUES
(1, 2, NULL, NULL),
(1, 8, NULL, NULL),
(1, 2, NULL, NULL),
(1, 8, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `admin_role_permissions`
--

CREATE TABLE `admin_role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `admin_role_users`
--

CREATE TABLE `admin_role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_role_users`
--

INSERT INTO `admin_role_users` (`role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(1, 1, NULL, NULL),
(1, 2, NULL, NULL),
(1, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `admin_table_version`
--

CREATE TABLE `admin_table_version` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '数据表名',
  `version_code` int(11) NOT NULL DEFAULT '0' COMMENT '版本号',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='受版本控制的表信息';

-- --------------------------------------------------------

--
-- 表的结构 `admin_table_version_changes`
--

CREATE TABLE `admin_table_version_changes` (
  `id` int(10) UNSIGNED NOT NULL,
  `old_version_code` int(11) NOT NULL COMMENT '旧版本号',
  `new_version_code` int(11) NOT NULL COMMENT '新版本号',
  `table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '发生数据变更的数据表',
  `table_id` int(11) NOT NULL COMMENT '做出改变的数据id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='受版本控制的表版本变迁信息';

-- --------------------------------------------------------

--
-- 表的结构 `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户真实姓名',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系地址',
  `avatar` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '头像',
  `activation_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '激活码',
  `activated` tinyint(4) NOT NULL DEFAULT '0' COMMENT '激活状态，0：未激活，1：激活',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_users`
--

INSERT INTO `admin_users` (`id`, `username`, `email`, `password`, `name`, `phone`, `address`, `avatar`, `activation_code`, `activated`, `remember_token`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'admin', '690828339@qq.com', '$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe', 'admin', NULL, NULL, '', '', 1, '3R0fltv3cV8aun6bBIawwTRVkiVDNNsgeaEvOLOTatbTMQX5z9PyV7CDJcdy', NULL, NULL, '2017-09-28 09:10:59');

-- --------------------------------------------------------

--
-- 表的结构 `admin_users_bk`
--

CREATE TABLE `admin_users_bk` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(190) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_users_bk`
--

INSERT INTO `admin_users_bk` (`id`, `username`, `password`, `name`, `avatar`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$fdTS0KucQeAtcM1Pu1lvI.6hnmkmCteADk86LbJNZglBx8rkqwYNe', 'Administrator', NULL, 'z3OCSSRwG76GeuYlntVBl3pX9hfQLsOO29Kh1zUjaa8fgViwwHYD5Ea2iNNe', '2017-09-22 03:31:22', '2017-09-22 10:07:30');

-- --------------------------------------------------------

--
-- 表的结构 `admin_user_permissions`
--

CREATE TABLE `admin_user_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `admin_user_permissions`
--

INSERT INTO `admin_user_permissions` (`user_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL),
(1, 2, NULL, NULL),
(1, 3, NULL, NULL),
(1, 4, NULL, NULL),
(1, 5, NULL, NULL),
(1, 6, NULL, NULL),
(1, 7, NULL, NULL),
(1, 8, NULL, NULL),
(1, 9, NULL, NULL),
(1, 10, NULL, NULL),
(1, 11, NULL, NULL),
(1, 12, NULL, NULL),
(1, 13, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `blog_approve_and_disapprove`
--

CREATE TABLE `blog_approve_and_disapprove` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `object_id` int(11) NOT NULL COMMENT '操作对象id，对象为文章时，为文章id，对象为评论时，为评论id',
  `type` tinyint(4) NOT NULL COMMENT '操作类型，0：文章推荐，1：文章不推荐，2：评论推荐，3：评论不推荐',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `blog_articles`
--

CREATE TABLE `blog_articles` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '作者id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '文章分组id',
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '文章标题',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `read_amount` int(11) NOT NULL DEFAULT '0' COMMENT '阅读量',
  `reply_amount` int(11) NOT NULL DEFAULT '0' COMMENT '回复量',
  `approve_amount` int(11) NOT NULL DEFAULT '0' COMMENT '赞同数',
  `disapprove_amount` int(11) NOT NULL DEFAULT '0' COMMENT '不赞同数',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `blog_article_group`
--

CREATE TABLE `blog_article_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(11) NOT NULL COMMENT '分类拥有者id',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '文章分组名',
  `article_num` int(11) NOT NULL DEFAULT '0' COMMENT '分组文章数量',
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '描述',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `blog_article_quality`
--

CREATE TABLE `blog_article_quality` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '收藏者id',
  `article_id` int(11) NOT NULL COMMENT '收藏文章id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `blog_replys`
--

CREATE TABLE `blog_replys` (
  `id` int(10) UNSIGNED NOT NULL,
  `article_id` int(11) NOT NULL COMMENT '文章id',
  `user_id` int(11) NOT NULL COMMENT '回复者id',
  `to_id` int(11) NOT NULL COMMENT '回复对象id',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '回复内容',
  `approve_amount` int(11) NOT NULL DEFAULT '0' COMMENT '赞同数',
  `disapprove_amount` int(11) NOT NULL DEFAULT '0' COMMENT '不赞同数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `blog_user_info`
--

CREATE TABLE `blog_user_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `article_num` int(11) NOT NULL DEFAULT '0' COMMENT '发表文章数量',
  `reply_num` int(11) NOT NULL DEFAULT '0' COMMENT '评论数',
  `received_reply_num` int(11) NOT NULL DEFAULT '0' COMMENT '被评论数',
  `read_num` int(11) NOT NULL DEFAULT '0' COMMENT '被阅读量',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2016_01_04_173148_create_admin_tables', 1),
('2014_10_12_000000_create_users_table', 2),
('2014_10_12_100000_create_password_resets_table', 2),
('2017_05_17_125314_create_base_user_info_table', 2),
('2017_05_17_125439_create_base_files_table', 2),
('2017_05_17_125539_create_storage_catalogs_table', 2),
('2017_05_17_130108_create_storage_format_group_table', 2),
('2017_05_17_130130_create_storage_formats_table', 2),
('2017_05_17_130206_create_storage_share_table', 2),
('2017_05_17_130324_create_base_permissions_table', 2),
('2017_05_17_131232_create_base_permission_role_table', 2),
('2017_05_17_131437_create_base_permission_user_table', 2),
('2017_05_17_131643_create_base_roles_table', 2),
('2017_05_17_131705_create_base_role_user_table', 2),
('2017_05_17_131752_create_base_configs_table', 2),
('2017_05_17_133359_create_blog_articles_table', 2),
('2017_05_17_133426_create_blog_replys_table', 2),
('2017_05_17_133719_create_base_emoticons_table', 2),
('2017_05_17_134044_create_base_emoticon_group_table', 2),
('2017_05_17_134508_create_blog_article_group_table', 2),
('2017_05_17_140850_create_base_private_letter_table', 2),
('2017_05_17_143841_create_storage_user_info_table', 2),
('2017_05_17_143900_create_blog_user_info_table', 2),
('2017_05_18_140726_create_base_permission_dependence_table', 2),
('2017_05_20_074456_create_base_modules_table', 2),
('2017_05_20_080008_create_base_table_version_table', 2),
('2017_05_20_080607_create_base_table_version_changes_table', 2),
('2017_05_20_085712_create_base_resource_table', 2),
('2017_05_21_042754_create_blog_article_quality_table', 2),
('2017_05_21_052656_create_blog_approve_and_disapprove_table', 2),
('2017_05_21_170405_add_table_name_to_base_table_version_changes_table', 2),
('2016_06_01_000001_create_oauth_auth_codes_table', 3),
('2016_06_01_000002_create_oauth_access_tokens_table', 3),
('2016_06_01_000003_create_oauth_refresh_tokens_table', 3),
('2016_06_01_000004_create_oauth_clients_table', 3),
('2016_06_01_000005_create_oauth_personal_access_clients_table', 3);

-- --------------------------------------------------------

--
-- 表的结构 `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('2218707f4b766f301061164a1f6bb97036a1ec11a9cc9c633113ed7071c549f1a47b8e2c435042be', 1, 3, 'Laravel', '[]', 0, '2017-10-28 08:27:38', '2017-10-28 08:27:38', '2018-10-28 16:27:38'),
('59b79d3ce0fbd83e767768a161d23dc61ecbfa6d957e5debf53661471de1e45879d68174be4a30df', 1, 3, 'Laravel', '[]', 0, '2017-10-28 08:28:08', '2017-10-28 08:28:08', '2018-10-28 16:28:08'),
('61091e54e47755f226739eb80573105721356499906bc896408e0837265ee6b4fdad022187630ab7', 1, 1, 'MyApp', '[]', 0, '2017-10-25 22:42:06', '2017-10-25 22:42:06', '2018-10-26 06:42:06'),
('c5875010a8a6ff786b4d598adfa2868440fc8df9e33a35b51c6c9d86afeb4fd95c520ab8de71c3ca', 1, 1, 'MyApp', '[]', 0, '2017-10-25 22:40:21', '2017-10-25 22:40:21', '2018-10-26 06:40:21');

-- --------------------------------------------------------

--
-- 表的结构 `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', '5T3ydSAcRqW4K0Z5ilhdfQl1fgUM2ng3DASfLiGF', 'http://localhost', 1, 0, 0, '2017-10-24 23:21:09', '2017-10-24 23:21:09'),
(2, NULL, 'Laravel Password Grant Client', 'A6rgOPJOyE0IEbj9gZZgZsXwRx8hfhIoxX0Tnpuo', 'http://localhost', 0, 1, 0, '2017-10-24 23:21:09', '2017-10-24 23:21:09'),
(3, NULL, 'Laravel Personal Access Client', 'rwA9fM2ey0XPdD47UhcnUjQR36siqmKaUp1SM1Z2', 'http://localhost', 1, 0, 0, '2017-10-28 08:27:31', '2017-10-28 08:27:31'),
(4, NULL, 'Laravel Password Grant Client', 'gZAKWbgRcaRP1J9JSvVwlErps9PlmFDELMdxuAkO', 'http://localhost', 0, 1, 0, '2017-10-28 08:27:31', '2017-10-28 08:27:31');

-- --------------------------------------------------------

--
-- 表的结构 `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2017-10-24 23:21:09', '2017-10-24 23:21:09'),
(2, 3, '2017-10-28 08:27:31', '2017-10-28 08:27:31');

-- --------------------------------------------------------

--
-- 表的结构 `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `storage_catalogs`
--

CREATE TABLE `storage_catalogs` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(11) NOT NULL COMMENT '拥有者id',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父目录id',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '目录名',
  `download_num` int(11) NOT NULL DEFAULT '0' COMMENT '下载数量',
  `size` bigint(20) NOT NULL DEFAULT '-1' COMMENT '目录大小',
  `is_file` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'false：目录，true：文件',
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '格式，如：png，若为目录则为空',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `storage_formats`
--

CREATE TABLE `storage_formats` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(11) NOT NULL COMMENT '文件类型分组id',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '格式名，如png',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `storage_format_group`
--

CREATE TABLE `storage_format_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '文件分类名',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `storage_share`
--

CREATE TABLE `storage_share` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '描述',
  `share_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '分享码',
  `catalog_id` int(11) NOT NULL COMMENT '分享目录id',
  `user_id` int(11) NOT NULL COMMENT '分享者id',
  `deadline` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '分享截至时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `storage_user_info`
--

CREATE TABLE `storage_user_info` (
  `id` int(10) UNSIGNED NOT NULL,
  `used_space` bigint(20) NOT NULL DEFAULT '0' COMMENT '已使用空间',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_configs`
--
ALTER TABLE `admin_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `base_configs_key_unique` (`key`);

--
-- Indexes for table `admin_emoticons`
--
ALTER TABLE `admin_emoticons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_emoticon_group`
--
ALTER TABLE `admin_emoticon_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_files`
--
ALTER TABLE `admin_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `md5` (`md5`);

--
-- Indexes for table `admin_menu`
--
ALTER TABLE `admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_modules`
--
ALTER TABLE `admin_modules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_operation_log`
--
ALTER TABLE `admin_operation_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_operation_log_user_id_index` (`user_id`);

--
-- Indexes for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_permissions_name_unique` (`name`);

--
-- Indexes for table `admin_private_letter`
--
ALTER TABLE `admin_private_letter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_resource`
--
ALTER TABLE `admin_resource`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `base_resource_key_unique` (`key`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_roles_name_unique` (`name`);

--
-- Indexes for table `admin_role_menu`
--
ALTER TABLE `admin_role_menu`
  ADD KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`);

--
-- Indexes for table `admin_role_permissions`
--
ALTER TABLE `admin_role_permissions`
  ADD KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`);

--
-- Indexes for table `admin_role_users`
--
ALTER TABLE `admin_role_users`
  ADD KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`);

--
-- Indexes for table `admin_table_version`
--
ALTER TABLE `admin_table_version`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_table_version_changes`
--
ALTER TABLE `admin_table_version_changes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `name_2` (`name`),
  ADD KEY `email` (`email`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `admin_users_bk`
--
ALTER TABLE `admin_users_bk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_users_username_unique` (`username`);

--
-- Indexes for table `admin_user_permissions`
--
ALTER TABLE `admin_user_permissions`
  ADD KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`);

--
-- Indexes for table `blog_approve_and_disapprove`
--
ALTER TABLE `blog_approve_and_disapprove`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_articles`
--
ALTER TABLE `blog_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_article_group`
--
ALTER TABLE `blog_article_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_article_quality`
--
ALTER TABLE `blog_article_quality`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_replys`
--
ALTER TABLE `blog_replys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_user_info`
--
ALTER TABLE `blog_user_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `storage_catalogs`
--
ALTER TABLE `storage_catalogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `storage_formats`
--
ALTER TABLE `storage_formats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `storage_format_group`
--
ALTER TABLE `storage_format_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `storage_share`
--
ALTER TABLE `storage_share`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `storage_user_info`
--
ALTER TABLE `storage_user_info`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `admin_configs`
--
ALTER TABLE `admin_configs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `admin_emoticons`
--
ALTER TABLE `admin_emoticons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_emoticon_group`
--
ALTER TABLE `admin_emoticon_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_files`
--
ALTER TABLE `admin_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_menu`
--
ALTER TABLE `admin_menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用表AUTO_INCREMENT `admin_modules`
--
ALTER TABLE `admin_modules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_operation_log`
--
ALTER TABLE `admin_operation_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1149;

--
-- 使用表AUTO_INCREMENT `admin_permissions`
--
ALTER TABLE `admin_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- 使用表AUTO_INCREMENT `admin_private_letter`
--
ALTER TABLE `admin_private_letter`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_resource`
--
ALTER TABLE `admin_resource`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `admin_table_version`
--
ALTER TABLE `admin_table_version`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_table_version_changes`
--
ALTER TABLE `admin_table_version_changes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `admin_users_bk`
--
ALTER TABLE `admin_users_bk`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用表AUTO_INCREMENT `blog_approve_and_disapprove`
--
ALTER TABLE `blog_approve_and_disapprove`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `blog_articles`
--
ALTER TABLE `blog_articles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `blog_article_group`
--
ALTER TABLE `blog_article_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `blog_article_quality`
--
ALTER TABLE `blog_article_quality`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `blog_replys`
--
ALTER TABLE `blog_replys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `blog_user_info`
--
ALTER TABLE `blog_user_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用表AUTO_INCREMENT `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用表AUTO_INCREMENT `storage_catalogs`
--
ALTER TABLE `storage_catalogs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `storage_formats`
--
ALTER TABLE `storage_formats`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `storage_format_group`
--
ALTER TABLE `storage_format_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `storage_share`
--
ALTER TABLE `storage_share`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `storage_user_info`
--
ALTER TABLE `storage_user_info`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
