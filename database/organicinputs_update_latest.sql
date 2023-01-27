-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 15, 2022 at 09:12 PM
-- Server version: 5.7.31
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `organicinputs_update`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_role_id` bigint(20) NOT NULL DEFAULT '2',
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `phone`, `admin_role_id`, `image`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Festu Bett', '254722229862', 1, 'def.png', 'festusbet@gmail.com', NULL, '$2y$10$BSCG3r1tOxpz2pn7KRuDMOGIrN.mevCWkILdtQytPjGYxv9q8Q8kG', 'tJ7iMyMbgVtmx0VL8leI3aX6cvpgAwTwHl3R7NBYUPSgl5zTEfv53cHcN7kJ', '2022-02-06 21:27:33', '2022-02-06 21:27:33');

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE IF NOT EXISTS `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `module_access` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `module_access`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Master Admin', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_wallets`
--

DROP TABLE IF EXISTS `admin_wallets`;
CREATE TABLE IF NOT EXISTS `admin_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) DEFAULT NULL,
  `inhouse_earning` double NOT NULL DEFAULT '0',
  `withdrawn` double NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `commission_earned` double(8,2) NOT NULL DEFAULT '0.00',
  `delivery_charge_earned` double(8,2) NOT NULL DEFAULT '0.00',
  `pending_amount` double(8,2) NOT NULL DEFAULT '0.00',
  `total_tax_collected` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_wallets`
--

INSERT INTO `admin_wallets` (`id`, `admin_id`, `inhouse_earning`, `withdrawn`, `created_at`, `updated_at`, `commission_earned`, `delivery_charge_earned`, `pending_amount`, `total_tax_collected`) VALUES
(1, 1, 20, 0, NULL, '2022-02-15 17:01:43', 0.00, 3.00, 644.00, 0.00),
(2, 1, 0, 0, '2022-02-06 21:27:36', '2022-02-06 21:27:36', 0.00, 0.00, 652.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `admin_wallet_histories`
--

DROP TABLE IF EXISTS `admin_wallet_histories`;
CREATE TABLE IF NOT EXISTS `admin_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `payment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'received',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
CREATE TABLE IF NOT EXISTS `attributes` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

DROP TABLE IF EXISTS `banners`;
CREATE TABLE IF NOT EXISTS `banners` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `published` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `billing_addresses`
--

DROP TABLE IF EXISTS `billing_addresses`;
CREATE TABLE IF NOT EXISTS `billing_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contact_person_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` int(10) UNSIGNED DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE IF NOT EXISTS `brands` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Brand Name (EN)', '2022-02-06-61fffaf5e3d2e.png', 1, '2022-02-06 19:44:38', '2022-02-06 19:44:38');

-- --------------------------------------------------------

--
-- Table structure for table `business_settings`
--

DROP TABLE IF EXISTS `business_settings`;
CREATE TABLE IF NOT EXISTS `business_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_settings`
--

INSERT INTO `business_settings` (`id`, `type`, `value`, `created_at`, `updated_at`) VALUES
(1, 'system_default_currency', '8', '2020-10-11 07:43:44', '2022-02-06 20:00:28'),
(2, 'language', '[{\"id\":\"1\",\"name\":\"english\",\"code\":\"en\",\"status\":1}]', '2020-10-11 07:53:02', '2021-06-10 21:16:25'),
(4, 'cash_on_delivery', '{\"status\":\"1\"}', NULL, '2021-05-25 21:21:15'),
(6, 'ssl_commerz_payment', '{\"status\":\"0\",\"store_id\":null,\"store_password\":null}', '2020-11-09 08:36:51', '2021-07-06 12:29:46'),
(7, 'paypal', '{\"status\":\"0\",\"paypal_client_id\":null,\"paypal_secret\":null}', '2020-11-09 08:51:39', '2021-07-06 12:29:57'),
(8, 'stripe', '{\"status\":\"0\",\"api_key\":null,\"published_key\":null}', '2020-11-09 09:01:47', '2021-07-06 12:30:05'),
(9, 'paytm', '{\"status\":\"0\",\"paytm_merchant_id\":\"dbzfb\",\"paytm_merchant_key\":\"sdfbsdfb\",\"paytm_merchant_website\":\"dsfbsdf\",\"paytm_channel\":\"sdfbsdf\",\"paytm_industry_type\":\"sdfb\"}', '2020-11-09 09:19:08', '2020-11-09 09:19:56'),
(10, 'company_phone', '000000000', NULL, '2020-12-08 14:15:01'),
(11, 'company_name', 'Organic Input', NULL, '2021-02-27 18:11:53'),
(12, 'company_web_logo', '2021-05-25-60ad1b313a9d4.png', NULL, '2021-05-25 21:43:45'),
(13, 'company_mobile_logo', '2021-02-20-6030c88c91911.png', NULL, '2021-02-20 14:30:04'),
(14, 'terms_condition', '<p>terms and conditions</p>', NULL, '2021-06-11 01:51:36'),
(15, 'about_us', '<p>this is about us page. hello and hi from about page description..</p>', NULL, '2021-06-11 01:42:53'),
(16, 'sms_nexmo', '{\"status\":\"0\",\"nexmo_key\":\"custo5cc042f7abf4c\",\"nexmo_secret\":\"custo5cc042f7abf4c@ssl\"}', NULL, NULL),
(17, 'company_email', 'Copy@6amtech.com', NULL, '2021-03-15 12:29:51'),
(18, 'colors', '{\"primary\":\"#12b6fd\",\"secondary\":\"#706b6b\"}', '2020-10-11 13:53:02', '2022-02-07 13:37:04'),
(19, 'company_footer_logo', '2021-02-20-6030c8a02a5f9.png', NULL, '2021-02-20 14:30:24'),
(20, 'company_copyright_text', 'CopyRight 6amTech@2021', NULL, '2021-03-15 12:30:47'),
(21, 'download_app_apple_stroe', '{\"status\":\"0\",\"link\":\"https:\\/\\/www.target.com\\/s\\/apple+store++now?ref=tgt_adv_XS000000&AFID=msn&fndsrc=tgtao&DFA=71700000012505188&CPNG=Electronics_Portable+Computers&adgroup=Portable+Computers&LID=700000001176246&LNM=apple+store+near+me+now&MT=b&network=s&device=c&location=12&targetid=kwd-81913773633608:loc-12&ds_rl=1246978&ds_rl=1248099&gclsrc=ds\"}', NULL, '2022-02-07 13:34:25'),
(22, 'download_app_google_stroe', '{\"status\":\"1\",\"link\":\"https:\\/\\/play.google.com\\/store?hl=en_US&gl=US\"}', NULL, '2020-12-08 12:54:48'),
(23, 'company_fav_icon', '2021-03-02-603df1634614f.png', '2020-10-11 13:53:02', '2021-03-02 14:03:48'),
(24, 'fcm_topic', '', NULL, NULL),
(25, 'fcm_project_id', '', NULL, NULL),
(26, 'push_notification_key', 'Put your firebase server key here.', NULL, NULL),
(27, 'order_pending_message', '{\"status\":\"1\",\"message\":\"order pen message\"}', NULL, NULL),
(28, 'order_confirmation_msg', '{\"status\":\"1\",\"message\":\"Order con Message\"}', NULL, NULL),
(29, 'order_processing_message', '{\"status\":\"1\",\"message\":\"Order pro Message\"}', NULL, NULL),
(30, 'out_for_delivery_message', '{\"status\":\"1\",\"message\":\"Order ouut Message\"}', NULL, NULL),
(31, 'order_delivered_message', '{\"status\":\"1\",\"message\":\"Order del Message\"}', NULL, NULL),
(32, 'razor_pay', '{\"status\":\"0\",\"razor_key\":null,\"razor_secret\":null}', NULL, '2021-07-06 12:30:14'),
(33, 'sales_commission', '0', NULL, '2021-06-11 18:13:13'),
(34, 'seller_registration', '1', NULL, '2021-06-04 21:02:48'),
(35, 'pnc_language', '[\"en\"]', NULL, NULL),
(36, 'order_returned_message', '{\"status\":\"1\",\"message\":\"Order hh Message\"}', NULL, NULL),
(37, 'order_failed_message', '{\"status\":null,\"message\":\"Order fa Message\"}', NULL, NULL),
(40, 'delivery_boy_assign_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(41, 'delivery_boy_start_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(42, 'delivery_boy_delivered_message', '{\"status\":0,\"message\":\"\"}', NULL, NULL),
(43, 'terms_and_conditions', '', NULL, NULL),
(44, 'minimum_order_value', '1', NULL, NULL),
(45, 'privacy_policy', '<p>my privacy policy</p>\r\n\r\n<p>&nbsp;</p>', NULL, '2021-07-06 11:09:07'),
(46, 'paystack', '{\"status\":\"0\",\"publicKey\":null,\"secretKey\":null,\"paymentUrl\":\"https:\\/\\/api.paystack.co\",\"merchantEmail\":null}', NULL, '2021-07-06 12:30:35'),
(47, 'senang_pay', '{\"status\":\"0\",\"secret_key\":null,\"merchant_id\":null}', NULL, '2021-07-06 12:30:23'),
(48, 'currency_model', 'single_currency', NULL, NULL),
(49, 'social_login', '[{\"login_medium\":\"google\",\"client_id\":\"\",\"client_secret\":\"\",\"status\":\"\"},{\"login_medium\":\"facebook\",\"client_id\":\"\",\"client_secret\":\"\",\"status\":\"\"}]', NULL, NULL),
(50, 'digital_payment', '{\"status\":\"0\"}', '2022-02-07 16:01:56', '2022-02-07 16:01:56'),
(51, 'phone_verification', '0', NULL, NULL),
(52, 'email_verification', '0', NULL, NULL),
(53, 'order_verification', '0', NULL, NULL),
(54, 'country_code', 'KE', NULL, NULL),
(55, 'pagination_limit', '10', NULL, NULL),
(56, 'shipping_method', 'sellerwise_shipping', NULL, NULL),
(57, 'paymob_accept', '{\"status\":\"0\",\"api_key\":\"\",\"iframe_id\":\"\",\"integration_id\":\"\",\"hmac\":\"\"}', NULL, NULL),
(58, 'bkash', '{\"status\":\"0\",\"api_key\":\"\",\"api_secret\":\"\",\"username\":\"\",\"password\":\"\"}', NULL, NULL),
(59, 'forgot_password_verification', 'email', NULL, NULL),
(60, 'paytabs', '{\"status\":0,\"profile_id\":\"\",\"server_key\":\"\",\"base_url\":\"https:\\/\\/secure-egypt.paytabs.com\\/\"}', NULL, '2021-11-21 03:01:40'),
(61, 'stock_limit', '10', NULL, NULL),
(62, 'flutterwave', '{\"status\":\"0\",\"public_key\":null,\"secret_key\":null,\"hash\":null}', NULL, '2022-02-07 16:01:46'),
(63, 'mercadopago', '{\"status\":\"0\",\"public_key\":null,\"access_token\":null}', NULL, '2022-02-07 16:02:14'),
(64, 'announcement', '{\"status\":\"0\",\"color\":\"#000000\",\"text_color\":\"#000000\",\"announcement\":null}', NULL, NULL),
(65, 'fawry_pay', '{\"status\":0,\"merchant_code\":\"\",\"security_key\":\"\"}', NULL, '2022-01-18 09:46:30'),
(66, 'recaptcha', '{\"status\":0,\"site_key\":\"\",\"secret_key\":\"\"}', NULL, '2022-01-18 09:46:30'),
(67, 'currency_symbol_position', 'left', '2022-02-07 13:34:06', '2022-02-07 13:34:06'),
(68, 'timezone', 'Africa/Nairobi', NULL, NULL),
(69, 'default_location', '{\"lat\":null,\"lng\":null}', NULL, NULL),
(70, 'mpesa_pay', '{\"status\":\"1\",\"mpesa_pass_key\":\"bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919\",\"mpesa_business_short_code\":\"174379\",\"mpesa_consumer_key\":\"AwPScKPinSoskssqfo3kmbv0BWEZoURt\",\"mpesa_consumer_secret\":\"YhXq9gZJVg6mpAWM\"}', '2021-12-06 16:16:01', '2022-01-29 16:35:30'),
(71, 'mail_config', '{\"name\":\"Organic Input\",\"host\":\"smtp.gmail.com\",\"driver\":\"SMTP\",\"port\":\"587\",\"username\":\"festusbetd@gmail.com\",\"email_id\":\"festusbetd@gmail.com\",\"encryption\":\"TLS\",\"password\":\"hrge wmil avva vaen\"}', '2020-10-12 07:29:18', '2022-02-07 20:10:21'),
(72, 'sms_mode', '1', NULL, '2021-02-27 18:11:53'),
(73, '2factor_sms', '{\"status\":0,\"api_key\":\"test\"}', '2022-02-14 14:38:39', '2022-02-14 14:38:39'),
(74, 'celcom_confirmation', '{\"status\":\"1\",\"api_key\":null}', '2022-02-14 12:06:07', '2022-02-14 12:06:07'),
(75, 'celcom_processing', '{\"status\":\"1\",\"api_key\":null}', '2022-02-14 14:35:56', '2022-02-14 14:35:56'),
(76, 'celcom_order_delivery', '{\"status\":\"1\",\"api_key\":null}', '2022-02-14 14:36:07', '2022-02-14 14:36:07'),
(77, 'celcom_delivered', '{\"status\":\"1\",\"api_key\":null}', '2022-02-14 14:36:15', '2022-02-14 14:36:15'),
(78, 'celcom_failed', '{\"status\":\"0\",\"api_key\":null}', '2022-02-15 17:05:00', '2022-02-15 17:05:00'),
(79, 'celcom_returned', '{\"status\":\"0\",\"api_key\":null}', '2022-02-14 14:38:47', '2022-02-14 14:38:47');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
CREATE TABLE IF NOT EXISTS `carts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `cart_group_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choices` text COLLATE utf8mb4_unicode_ci,
  `variations` text COLLATE utf8mb4_unicode_ci,
  `variant` text COLLATE utf8mb4_unicode_ci,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `price` double(8,2) NOT NULL DEFAULT '1.00',
  `unit_pricing` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` double(8,2) NOT NULL DEFAULT '1.00',
  `discount` double(8,2) NOT NULL DEFAULT '1.00',
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shop_info` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `customer_id`, `cart_group_id`, `product_id`, `color`, `choices`, `variations`, `variant`, `quantity`, `price`, `unit_pricing`, `tax`, `discount`, `slug`, `name`, `thumbnail`, `seller_id`, `seller_is`, `created_at`, `updated_at`, `shop_info`) VALUES
(30, 10, '10-K3sWN-1644959279', 1, NULL, '[]', '[]', '', 3, 1.00, '0', 0.00, 0.00, 'product-name-en-B0zH9G', 'Product Name (EN)', '2022-02-06-61fffb7d1d22b.png', 1, 'admin', '2022-02-15 21:07:59', '2022-02-15 21:08:14', 'Organic Input');

-- --------------------------------------------------------

--
-- Table structure for table `cart_shippings`
--

DROP TABLE IF EXISTS `cart_shippings`;
CREATE TABLE IF NOT EXISTS `cart_shippings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cart_group_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method_id` bigint(20) DEFAULT NULL,
  `shipping_cost` double(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cart_shippings`
--

INSERT INTO `cart_shippings` (`id`, `cart_group_id`, `shipping_method_id`, `shipping_cost`, `created_at`, `updated_at`) VALUES
(1, '4-wDnDW-1644166027', 2, 5.00, '2022-02-06 19:47:22', '2022-02-06 19:47:22'),
(2, '10-4aIKJ-1644811555', 10, 1.00, '2022-02-14 04:06:05', '2022-02-14 04:31:12'),
(4, '10-PEujc-1644821061', 11, 2.00, '2022-02-14 06:53:49', '2022-02-14 07:04:10'),
(12, '10-l4HXR-1644914132', 10, 1.00, '2022-02-15 08:35:51', '2022-02-15 08:35:51'),
(16, '10-0CtHD-1644952899', 10, 1.00, '2022-02-15 19:24:34', '2022-02-15 20:01:33'),
(19, '10-K3sWN-1644959279', 11, 2.00, '2022-02-15 21:08:23', '2022-02-15 21:08:23');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `home_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `icon`, `parent_id`, `position`, `created_at`, `updated_at`, `home_status`) VALUES
(1, 'Category Name (EN)', 'category-name-en', '2022-02-06-61fffb1192d86.png', 0, 0, '2022-02-06 19:45:05', '2022-02-06 19:45:05', 0),
(2, 'Sub category Name (EN)', 'sub-category-name-en', NULL, 1, 1, '2022-02-06 19:45:28', '2022-02-06 19:45:28', 0),
(3, 'Sub sub category Name (EN)', 'sub-sub-category-name-en', NULL, 2, 2, '2022-02-06 19:45:41', '2022-02-06 19:45:41', 0);

-- --------------------------------------------------------

--
-- Table structure for table `chattings`
--

DROP TABLE IF EXISTS `chattings`;
CREATE TABLE IF NOT EXISTS `chattings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `seller_id` bigint(20) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sent_by_customer` tinyint(1) NOT NULL DEFAULT '0',
  `sent_by_seller` tinyint(1) NOT NULL DEFAULT '0',
  `seen_by_customer` tinyint(1) NOT NULL DEFAULT '1',
  `seen_by_seller` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shop_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
CREATE TABLE IF NOT EXISTS `colors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `colors`
--

INSERT INTO `colors` (`id`, `name`, `code`, `created_at`, `updated_at`) VALUES
(1, 'IndianRed', '#CD5C5C', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(2, 'LightCoral', '#F08080', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(3, 'Salmon', '#FA8072', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(4, 'DarkSalmon', '#E9967A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(5, 'LightSalmon', '#FFA07A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(6, 'Crimson', '#DC143C', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(7, 'Red', '#FF0000', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(8, 'FireBrick', '#B22222', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(9, 'DarkRed', '#8B0000', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(10, 'Pink', '#FFC0CB', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(11, 'LightPink', '#FFB6C1', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(12, 'HotPink', '#FF69B4', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(13, 'DeepPink', '#FF1493', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(14, 'MediumVioletRed', '#C71585', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(15, 'PaleVioletRed', '#DB7093', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(16, 'LightSalmon', '#FFA07A', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(17, 'Coral', '#FF7F50', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(18, 'Tomato', '#FF6347', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(19, 'OrangeRed', '#FF4500', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(20, 'DarkOrange', '#FF8C00', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(21, 'Orange', '#FFA500', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(22, 'Gold', '#FFD700', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(23, 'Yellow', '#FFFF00', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(24, 'LightYellow', '#FFFFE0', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(25, 'LemonChiffon', '#FFFACD', '2018-11-05 02:12:26', '2018-11-05 02:12:26'),
(26, 'LightGoldenrodYellow', '#FAFAD2', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(27, 'PapayaWhip', '#FFEFD5', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(28, 'Moccasin', '#FFE4B5', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(29, 'PeachPuff', '#FFDAB9', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(30, 'PaleGoldenrod', '#EEE8AA', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(31, 'Khaki', '#F0E68C', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(32, 'DarkKhaki', '#BDB76B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(33, 'Lavender', '#E6E6FA', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(34, 'Thistle', '#D8BFD8', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(35, 'Plum', '#DDA0DD', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(36, 'Violet', '#EE82EE', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(37, 'Orchid', '#DA70D6', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(38, 'Fuchsia', '#FF00FF', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(39, 'Magenta', '#FF00FF', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(40, 'MediumOrchid', '#BA55D3', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(41, 'MediumPurple', '#9370DB', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(42, 'Amethyst', '#9966CC', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(43, 'BlueViolet', '#8A2BE2', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(44, 'DarkViolet', '#9400D3', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(45, 'DarkOrchid', '#9932CC', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(46, 'DarkMagenta', '#8B008B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(47, 'Purple', '#800080', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(48, 'Indigo', '#4B0082', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(49, 'SlateBlue', '#6A5ACD', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(50, 'DarkSlateBlue', '#483D8B', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(51, 'MediumSlateBlue', '#7B68EE', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(52, 'GreenYellow', '#ADFF2F', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(53, 'Chartreuse', '#7FFF00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(54, 'LawnGreen', '#7CFC00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(55, 'Lime', '#00FF00', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(56, 'LimeGreen', '#32CD32', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(57, 'PaleGreen', '#98FB98', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(58, 'LightGreen', '#90EE90', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(59, 'MediumSpringGreen', '#00FA9A', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(60, 'SpringGreen', '#00FF7F', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(61, 'MediumSeaGreen', '#3CB371', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(62, 'SeaGreen', '#2E8B57', '2018-11-05 02:12:27', '2018-11-05 02:12:27'),
(63, 'ForestGreen', '#228B22', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(64, 'Green', '#008000', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(65, 'DarkGreen', '#006400', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(66, 'YellowGreen', '#9ACD32', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(67, 'OliveDrab', '#6B8E23', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(68, 'Olive', '#808000', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(69, 'DarkOliveGreen', '#556B2F', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(70, 'MediumAquamarine', '#66CDAA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(71, 'DarkSeaGreen', '#8FBC8F', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(72, 'LightSeaGreen', '#20B2AA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(73, 'DarkCyan', '#008B8B', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(74, 'Teal', '#008080', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(75, 'Aqua', '#00FFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(77, 'LightCyan', '#E0FFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(78, 'PaleTurquoise', '#AFEEEE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(79, 'Aquamarine', '#7FFFD4', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(80, 'Turquoise', '#40E0D0', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(81, 'MediumTurquoise', '#48D1CC', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(82, 'DarkTurquoise', '#00CED1', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(83, 'CadetBlue', '#5F9EA0', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(84, 'SteelBlue', '#4682B4', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(85, 'LightSteelBlue', '#B0C4DE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(86, 'PowderBlue', '#B0E0E6', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(87, 'LightBlue', '#ADD8E6', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(88, 'SkyBlue', '#87CEEB', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(89, 'LightSkyBlue', '#87CEFA', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(90, 'DeepSkyBlue', '#00BFFF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(91, 'DodgerBlue', '#1E90FF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(92, 'CornflowerBlue', '#6495ED', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(93, 'MediumSlateBlue', '#7B68EE', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(94, 'RoyalBlue', '#4169E1', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(95, 'Blue', '#0000FF', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(96, 'MediumBlue', '#0000CD', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(97, 'DarkBlue', '#00008B', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(98, 'Navy', '#000080', '2018-11-05 02:12:28', '2018-11-05 02:12:28'),
(99, 'MidnightBlue', '#191970', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(100, 'Cornsilk', '#FFF8DC', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(101, 'BlanchedAlmond', '#FFEBCD', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(102, 'Bisque', '#FFE4C4', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(103, 'NavajoWhite', '#FFDEAD', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(104, 'Wheat', '#F5DEB3', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(105, 'BurlyWood', '#DEB887', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(106, 'Tan', '#D2B48C', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(107, 'RosyBrown', '#BC8F8F', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(108, 'SandyBrown', '#F4A460', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(109, 'Goldenrod', '#DAA520', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(110, 'DarkGoldenrod', '#B8860B', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(111, 'Peru', '#CD853F', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(112, 'Chocolate', '#D2691E', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(113, 'SaddleBrown', '#8B4513', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(114, 'Sienna', '#A0522D', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(115, 'Brown', '#A52A2A', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(116, 'Maroon', '#800000', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(117, 'White', '#FFFFFF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(118, 'Snow', '#FFFAFA', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(119, 'Honeydew', '#F0FFF0', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(120, 'MintCream', '#F5FFFA', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(121, 'Azure', '#F0FFFF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(122, 'AliceBlue', '#F0F8FF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(123, 'GhostWhite', '#F8F8FF', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(124, 'WhiteSmoke', '#F5F5F5', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(125, 'Seashell', '#FFF5EE', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(126, 'Beige', '#F5F5DC', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(127, 'OldLace', '#FDF5E6', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(128, 'FloralWhite', '#FFFAF0', '2018-11-05 02:12:29', '2018-11-05 02:12:29'),
(129, 'Ivory', '#FFFFF0', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(130, 'AntiqueWhite', '#FAEBD7', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(131, 'Linen', '#FAF0E6', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(132, 'LavenderBlush', '#FFF0F5', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(133, 'MistyRose', '#FFE4E1', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(134, 'Gainsboro', '#DCDCDC', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(135, 'LightGrey', '#D3D3D3', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(136, 'Silver', '#C0C0C0', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(137, 'DarkGray', '#A9A9A9', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(138, 'Gray', '#808080', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(139, 'DimGray', '#696969', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(140, 'LightSlateGray', '#778899', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(141, 'SlateGray', '#708090', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(142, 'DarkSlateGray', '#2F4F4F', '2018-11-05 02:12:30', '2018-11-05 02:12:30'),
(143, 'Black', '#000000', '2018-11-05 02:12:30', '2018-11-05 02:12:30');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `feedback` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reply` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
CREATE TABLE IF NOT EXISTS `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coupon_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `min_purchase` decimal(8,2) NOT NULL DEFAULT '0.00',
  `max_discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percentage',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exchange_rate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `symbol`, `code`, `exchange_rate`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USD', '$', 'USD', '1', 0, NULL, '2022-02-06 20:02:37'),
(2, 'BDT', '৳', 'BDT', '84', 0, NULL, '2022-02-06 19:58:24'),
(3, 'Indian Rupi', '₹', 'INR', '60', 0, '2020-10-15 17:23:04', '2022-02-06 19:58:25'),
(4, 'Euro', '€', 'EUR', '100', 0, '2021-05-25 21:00:23', '2022-02-06 19:58:26'),
(5, 'YEN', '¥', 'JPY', '110', 0, '2021-06-10 22:08:31', '2022-02-06 19:58:27'),
(6, 'Ringgit', 'RM', 'MYR', '4.16', 0, '2021-07-03 11:08:33', '2022-02-06 19:58:29'),
(7, 'Rand', 'R', 'ZAR', '14.26', 0, '2021-07-03 11:12:38', '2022-02-06 19:58:30'),
(8, 'Kenyan shilling', 'KES', 'KES', '1', 1, '2022-02-06 19:59:30', '2022-02-06 19:59:36');

-- --------------------------------------------------------

--
-- Table structure for table `customer_wallets`
--

DROP TABLE IF EXISTS `customer_wallets`;
CREATE TABLE IF NOT EXISTS `customer_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `balance` decimal(8,2) NOT NULL DEFAULT '0.00',
  `royality_points` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_wallet_histories`
--

DROP TABLE IF EXISTS `customer_wallet_histories`;
CREATE TABLE IF NOT EXISTS `customer_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `transaction_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `transaction_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_method` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deal_of_the_days`
--

DROP TABLE IF EXISTS `deal_of_the_days`;
CREATE TABLE IF NOT EXISTS `deal_of_the_days` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_type` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'amount',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_histories`
--

DROP TABLE IF EXISTS `delivery_histories`;
CREATE TABLE IF NOT EXISTS `delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `deliveryman_id` bigint(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_men`
--

DROP TABLE IF EXISTS `delivery_men`;
CREATE TABLE IF NOT EXISTS `delivery_men` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) DEFAULT NULL,
  `f_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_number` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `auth_token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '6yIRXJRRfp78qJsAoKZZ6TTqhzuNJ3TcdvPBmk6n',
  `fcm_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `delivery_men_phone_unique` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_deals`
--

DROP TABLE IF EXISTS `feature_deals`;
CREATE TABLE IF NOT EXISTS `feature_deals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flash_deals`
--

DROP TABLE IF EXISTS `flash_deals`;
CREATE TABLE IF NOT EXISTS `flash_deals` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `deal_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flash_deal_products`
--

DROP TABLE IF EXISTS `flash_deal_products`;
CREATE TABLE IF NOT EXISTS `flash_deal_products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `flash_deal_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `discount_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `help_topics`
--

DROP TABLE IF EXISTS `help_topics`;
CREATE TABLE IF NOT EXISTS `help_topics` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `ranking` int(11) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2020_09_08_105159_create_admins_table', 1),
(5, '2020_09_08_111837_create_admin_roles_table', 1),
(6, '2020_09_16_142451_create_categories_table', 2),
(7, '2020_09_16_181753_create_categories_table', 3),
(8, '2020_09_17_134238_create_brands_table', 4),
(9, '2020_09_17_203054_create_attributes_table', 5),
(10, '2020_09_19_112509_create_coupons_table', 6),
(11, '2020_09_19_161802_create_curriencies_table', 7),
(12, '2020_09_20_114509_create_sellers_table', 8),
(13, '2020_09_23_113454_create_shops_table', 9),
(14, '2020_09_23_115615_create_shops_table', 10),
(15, '2020_09_23_153822_create_shops_table', 11),
(16, '2020_09_21_122817_create_products_table', 12),
(17, '2020_09_22_140800_create_colors_table', 12),
(18, '2020_09_28_175020_create_products_table', 13),
(19, '2020_09_28_180311_create_products_table', 14),
(20, '2020_10_04_105041_create_search_functions_table', 15),
(21, '2020_10_05_150730_create_customers_table', 15),
(22, '2020_10_08_133548_create_wishlists_table', 16),
(23, '2016_06_01_000001_create_oauth_auth_codes_table', 17),
(24, '2016_06_01_000002_create_oauth_access_tokens_table', 17),
(25, '2016_06_01_000003_create_oauth_refresh_tokens_table', 17),
(26, '2016_06_01_000004_create_oauth_clients_table', 17),
(27, '2016_06_01_000005_create_oauth_personal_access_clients_table', 17),
(28, '2020_10_06_133710_create_product_stocks_table', 17),
(29, '2020_10_06_134636_create_flash_deals_table', 17),
(30, '2020_10_06_134719_create_flash_deal_products_table', 17),
(31, '2020_10_08_115439_create_orders_table', 17),
(32, '2020_10_08_115453_create_order_details_table', 17),
(33, '2020_10_08_121135_create_shipping_addresses_table', 17),
(34, '2020_10_10_171722_create_business_settings_table', 17),
(35, '2020_09_19_161802_create_currencies_table', 18),
(36, '2020_10_12_152350_create_reviews_table', 18),
(37, '2020_10_12_161834_create_reviews_table', 19),
(38, '2020_10_12_180510_create_support_tickets_table', 20),
(39, '2020_10_14_140130_create_transactions_table', 21),
(40, '2020_10_14_143553_create_customer_wallets_table', 21),
(41, '2020_10_14_143607_create_customer_wallet_histories_table', 21),
(42, '2020_10_22_142212_create_support_ticket_convs_table', 21),
(43, '2020_10_24_234813_create_banners_table', 22),
(44, '2020_10_27_111557_create_shipping_methods_table', 23),
(45, '2020_10_27_114154_add_url_to_banners_table', 24),
(46, '2020_10_28_170308_add_shipping_id_to_order_details', 25),
(47, '2020_11_02_140528_add_discount_to_order_table', 26),
(48, '2020_11_03_162723_add_column_to_order_details', 27),
(49, '2020_11_08_202351_add_url_to_banners_table', 28),
(50, '2020_11_10_112713_create_help_topic', 29),
(51, '2020_11_10_141513_create_contacts_table', 29),
(52, '2020_11_15_180036_add_address_column_user_table', 30),
(53, '2020_11_18_170209_add_status_column_to_product_table', 31),
(54, '2020_11_19_115453_add_featured_status_product', 32),
(55, '2020_11_21_133302_create_deal_of_the_days_table', 33),
(56, '2020_11_20_172332_add_product_id_to_products', 34),
(57, '2020_11_27_234439_add__state_to_shipping_addresses', 34),
(58, '2020_11_28_091929_create_chattings_table', 35),
(59, '2020_12_02_011815_add_bank_info_to_sellers', 36),
(60, '2020_12_08_193234_create_social_medias_table', 37),
(61, '2020_12_13_122649_shop_id_to_chattings', 37),
(62, '2020_12_14_145116_create_seller_wallet_histories_table', 38),
(63, '2020_12_14_145127_create_seller_wallets_table', 38),
(64, '2020_12_15_174804_create_admin_wallets_table', 39),
(65, '2020_12_15_174821_create_admin_wallet_histories_table', 39),
(66, '2020_12_15_214312_create_feature_deals_table', 40),
(67, '2020_12_17_205712_create_withdraw_requests_table', 41),
(68, '2021_02_22_161510_create_notifications_table', 42),
(69, '2021_02_24_154706_add_deal_type_to_flash_deals', 43),
(70, '2021_03_03_204349_add_cm_firebase_token_to_users', 44),
(71, '2021_04_17_134848_add_column_to_order_details_stock', 45),
(72, '2021_05_12_155401_add_auth_token_seller', 46),
(73, '2021_06_03_104531_ex_rate_update', 47),
(74, '2021_06_03_222413_amount_withdraw_req', 48),
(75, '2021_06_04_154501_seller_wallet_withdraw_bal', 49),
(76, '2021_06_04_195853_product_dis_tax', 50),
(77, '2021_05_27_103505_create_product_translations_table', 51),
(78, '2021_06_17_054551_create_soft_credentials_table', 51),
(79, '2021_06_29_212549_add_active_col_user_table', 52),
(80, '2021_06_30_212619_add_col_to_contact', 53),
(81, '2021_07_01_160828_add_col_daily_needs_products', 54),
(82, '2021_07_04_182331_add_col_seller_sales_commission', 55),
(83, '2021_08_07_190655_add_seo_columns_to_products', 56),
(84, '2021_08_07_205913_add_col_to_category_table', 56),
(85, '2021_08_07_210808_add_col_to_shops_table', 56),
(86, '2021_08_14_205216_change_product_price_col_type', 56),
(87, '2021_08_16_201505_change_order_price_col', 56),
(88, '2021_08_16_201552_change_order_details_price_col', 56),
(89, '2019_09_29_154000_create_payment_cards_table', 57),
(90, '2021_08_17_213934_change_col_type_seller_earning_history', 57),
(91, '2021_08_17_214109_change_col_type_admin_earning_history', 57),
(92, '2021_08_17_214232_change_col_type_admin_wallet', 57),
(93, '2021_08_17_214405_change_col_type_seller_wallet', 57),
(94, '2021_08_22_184834_add_publish_to_products_table', 57),
(95, '2021_09_08_211832_add_social_column_to_users_table', 57),
(96, '2021_09_13_165535_add_col_to_user', 57),
(97, '2021_09_19_061647_add_limit_to_coupons_table', 57),
(98, '2021_09_20_020716_add_coupon_code_to_orders_table', 57),
(99, '2021_09_23_003059_add_gst_to_sellers_table', 57),
(100, '2021_09_28_025411_create_order_transactions_table', 57),
(101, '2021_10_02_185124_create_carts_table', 57),
(102, '2021_10_02_190207_create_cart_shippings_table', 57),
(103, '2021_10_03_194334_add_col_order_table', 57),
(104, '2021_10_03_200536_add_shipping_cost', 57),
(105, '2021_10_04_153201_add_col_to_order_table', 57),
(106, '2021_10_07_172701_add_col_cart_shop_info', 57),
(107, '2021_10_07_184442_create_phone_or_email_verifications_table', 57),
(108, '2021_10_07_185416_add_user_table_email_verified', 57),
(109, '2021_10_11_192739_add_transaction_amount_table', 57),
(110, '2021_10_11_200850_add_order_verification_code', 57),
(111, '2021_10_12_083241_add_col_to_order_transaction', 57),
(112, '2021_10_12_084440_add_seller_id_to_order', 57),
(113, '2021_10_12_102853_change_col_type', 57),
(114, '2021_10_12_110434_add_col_to_admin_wallet', 57),
(115, '2021_10_12_110829_add_col_to_seller_wallet', 57),
(116, '2021_10_13_091801_add_col_to_admin_wallets', 57),
(117, '2021_10_13_092000_add_col_to_seller_wallets_tax', 57),
(118, '2021_10_13_165947_rename_and_remove_col_seller_wallet', 57),
(119, '2021_10_13_170258_rename_and_remove_col_admin_wallet', 57),
(120, '2021_10_14_061603_column_update_order_transaction', 57),
(121, '2021_10_15_103339_remove_col_from_seller_wallet', 57),
(122, '2021_10_15_104419_add_id_col_order_tran', 57),
(123, '2021_10_15_213454_update_string_limit', 57),
(124, '2021_10_16_234037_change_col_type_translation', 57),
(125, '2021_10_16_234329_change_col_type_translation_1', 57),
(126, '2021_10_27_091250_add_shipping_address_in_order', 58),
(127, '2021_01_24_205114_create_paytabs_invoices_table', 59),
(128, '2021_11_20_043814_change_pass_reset_email_col', 59),
(129, '2021_11_25_043109_create_delivery_men_table', 60),
(130, '2021_11_25_062242_add_auth_token_delivery_man', 60),
(131, '2021_11_27_043405_add_deliveryman_in_order_table', 60),
(132, '2021_11_27_051432_create_delivery_histories_table', 60),
(133, '2021_11_27_051512_add_fcm_col_for_delivery_man', 60),
(134, '2021_12_15_123216_add_columns_to_banner', 60),
(135, '2022_01_04_100543_add_order_note_to_orders_table', 60),
(136, '2022_01_10_034952_add_lat_long_to_shipping_addresses_table', 60),
(137, '2022_01_10_045517_create_billing_addresses_table', 60),
(138, '2022_01_11_040755_add_is_billing_to_shipping_addresses_table', 60),
(139, '2022_01_11_053404_add_billing_to_orders_table', 60),
(140, '2022_01_11_234310_add_firebase_toke_to_sellers_table', 60),
(141, '2022_01_16_121801_change_colu_type', 60);

-- --------------------------------------------------------

--
-- Table structure for table `mpesa_logs`
--

DROP TABLE IF EXISTS `mpesa_logs`;
CREATE TABLE IF NOT EXISTS `mpesa_logs` (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `TransID` varchar(100) DEFAULT NULL,
  `merchantRequestID` varchar(100) DEFAULT NULL,
  `resultCode` varchar(100) DEFAULT NULL,
  `resultDesc` varchar(100) DEFAULT NULL,
  `log` varchar(10000) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mpesa_logs`
--

INSERT INTO `mpesa_logs` (`id`, `TransID`, `merchantRequestID`, `resultCode`, `resultDesc`, `log`, `created_at`, `updated_at`) VALUES
(4, 'ws_CO_04112017184930742', '21605-295434-4', '0', 'The service request is processed successfully.', '{\"responses\":[{\"response-code\":200,\"response-description\":\"Success\",\"mobile\":\"254722229862\",\"messageid\":\"RgAxII1wkxsckOzi\",\"networkid\":1}]}{\n    \"message\": \"The Response content must be a string or object implementing __toString(), \\\"boolean\\\" given.\",\n    \"exception\": \"UnexpectedValueException\",\n    \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\symfony\\\\http-foundation\\\\Response.php\",\n    \"line\": 406,\n    \"trace\": [\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Http\\\\Response.php\",\n            \"line\": 45,\n            \"function\": \"setContent\",\n            \"class\": \"Symfony\\\\Component\\\\HttpFoundation\\\\Response\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\symfony\\\\http-foundation\\\\Response.php\",\n            \"line\": 205,\n            \"function\": \"setContent\",\n            \"class\": \"Illuminate\\\\Http\\\\Response\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 749,\n            \"function\": \"__construct\",\n            \"class\": \"Symfony\\\\Component\\\\HttpFoundation\\\\Response\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 721,\n            \"function\": \"toResponse\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"::\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 681,\n            \"function\": \"prepareResponse\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 130,\n            \"function\": \"Illuminate\\\\Routing\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\app\\\\Http\\\\Middleware\\\\APILocalizationMiddleware.php\",\n            \"line\": 22,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"App\\\\Http\\\\Middleware\\\\APILocalizationMiddleware\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Middleware\\\\SubstituteBindings.php\",\n            \"line\": 41,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Routing\\\\Middleware\\\\SubstituteBindings\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Middleware\\\\ThrottleRequests.php\",\n            \"line\": 59,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Routing\\\\Middleware\\\\ThrottleRequests\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 105,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 683,\n            \"function\": \"then\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 658,\n            \"function\": \"runRouteWithinStack\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 624,\n            \"function\": \"runRoute\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Routing\\\\Router.php\",\n            \"line\": 613,\n            \"function\": \"dispatchToRoute\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Http\\\\Kernel.php\",\n            \"line\": 170,\n            \"function\": \"dispatch\",\n            \"class\": \"Illuminate\\\\Routing\\\\Router\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 130,\n            \"function\": \"Illuminate\\\\Foundation\\\\Http\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Foundation\\\\Http\\\\Kernel\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\barryvdh\\\\laravel-debugbar\\\\src\\\\Middleware\\\\InjectDebugbar.php\",\n            \"line\": 67,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Barryvdh\\\\Debugbar\\\\Middleware\\\\InjectDebugbar\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\TransformsRequest.php\",\n            \"line\": 21,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\TransformsRequest\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\TransformsRequest.php\",\n            \"line\": 21,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\TransformsRequest\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\ValidatePostSize.php\",\n            \"line\": 27,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\ValidatePostSize\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\CheckForMaintenanceMode.php\",\n            \"line\": 63,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Illuminate\\\\Foundation\\\\Http\\\\Middleware\\\\CheckForMaintenanceMode\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\fideloper\\\\proxy\\\\src\\\\TrustProxies.php\",\n            \"line\": 57,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 171,\n            \"function\": \"handle\",\n            \"class\": \"Fideloper\\\\Proxy\\\\TrustProxies\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\organic\\\\vendor\\\\laravel\\\\framework\\\\src\\\\Illuminate\\\\Pipeline\\\\Pipeline.php\",\n            \"line\": 105,\n            \"function\": \"Illuminate\\\\Pipeline\\\\{closure}\",\n            \"class\": \"Illuminate\\\\Pipeline\\\\Pipeline\",\n            \"type\": \"->\"\n        },\n        {\n            \"file\": \"C:\\\\wamp64\\\\www\\\\orga', NULL, '2022-01-25 23:26:12');

-- --------------------------------------------------------

--
-- Table structure for table `mpesa_transactions`
--

DROP TABLE IF EXISTS `mpesa_transactions`;
CREATE TABLE IF NOT EXISTS `mpesa_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TransID` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ThirdPartyTransID` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransactionType` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransTime` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TransAmount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BusinessShortCode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillRefNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AccountReference` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `InvoiceNumber` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resultCode` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resultDesc` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OrgAccountBalance` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MSISDN` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FirstName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MiddleName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastName` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `response` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `TransID` (`TransID`)
) ENGINE=MyISAM AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mpesa_transactions`
--

INSERT INTO `mpesa_transactions` (`id`, `TransID`, `ThirdPartyTransID`, `TransactionType`, `TransTime`, `TransAmount`, `BusinessShortCode`, `BillRefNumber`, `AccountReference`, `InvoiceNumber`, `resultCode`, `resultDesc`, `OrgAccountBalance`, `MSISDN`, `FirstName`, `MiddleName`, `LastName`, `response`, `created_at`, `updated_at`) VALUES
(123, 'ws_CO_150220221942115871', '45171-43647670-1', '', '20220207222801', '2', '174379', 'QB79T0QZJ5', '10-y7ktk-1644943459', '', '0', 'The service request is processed successfully.', '', '254722229862', '', '', '', NULL, '2022-02-07 19:28:37', '2022-02-07 19:28:37');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('46c0ae27a747a1f49f4b77a5c775702b1e18c0ccbb683434d63e1b009cea9e851398899aa1ce1992', 4, 1, 'LaravelAuthApp', '[]', 0, '2022-02-06 19:42:43', '2022-02-06 19:42:43', '2023-02-06 22:42:43'),
('6840b7d4ed685bf2e0dc593affa0bd3b968065f47cc226d39ab09f1422b5a1d9666601f3f60a79c1', 98, 1, 'LaravelAuthApp', '[]', 1, '2021-07-05 09:25:41', '2021-07-05 09:25:41', '2022-07-05 15:25:41'),
('9b38e57a9fc8fb76817e3b66de7d3de76e7b88af4d904f01a44d2a1d00105d40cbeea9de53bb25f6', 3, 1, 'LaravelAuthApp', '[]', 0, '2022-02-06 19:41:16', '2022-02-06 19:41:16', '2023-02-06 22:41:16'),
('c42cdd5ae652b8b2cbac4f2f4b496e889e1a803b08672954c8bbe06722b54160e71dce3e02331544', 98, 1, 'LaravelAuthApp', '[]', 1, '2021-07-05 09:24:36', '2021-07-05 09:24:36', '2022-07-05 15:24:36');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, '6amtech', 'GEUx5tqkviM6AAQcz4oi1dcm1KtRdJPgw41lj0eI', 'http://localhost', 1, 0, 0, '2020-10-21 18:27:22', '2020-10-21 18:27:22');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-10-21 18:27:23', '2020-10-21 18:27:23');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_county` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `order_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_ref` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_amount` double NOT NULL DEFAULT '0',
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `discount_amount` double NOT NULL DEFAULT '0',
  `discount_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_method_id` bigint(20) NOT NULL DEFAULT '0',
  `shipping_cost` double(8,2) NOT NULL DEFAULT '0.00',
  `order_group_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def-order-group',
  `order_cart_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `seller_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address_data` json DEFAULT NULL,
  `delivery_man_id` bigint(20) DEFAULT NULL,
  `order_note` text COLLATE utf8mb4_unicode_ci,
  `billing_address` bigint(20) UNSIGNED DEFAULT NULL,
  `billing_address_data` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100076 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `customer_phone_number`, `customer_email_address`, `customer_id_number`, `customer_county`, `customer_type`, `payment_status`, `order_status`, `payment_method`, `transaction_ref`, `order_amount`, `shipping_address`, `created_at`, `updated_at`, `discount_amount`, `discount_type`, `coupon_code`, `shipping_method_id`, `shipping_cost`, `order_group_id`, `order_cart_id`, `verification_code`, `seller_id`, `seller_is`, `shipping_address_data`, `delivery_man_id`, `order_note`, `billing_address`, `billing_address_data`) VALUES
(100001, '10', '254722229862', 'festusbet@gmail.com', '32802426', 'Bomet', 'customer', 'paid', 'failed', 'cash_on_delivery', '', 2, '4', '2022-02-15 16:49:45', '2022-02-15 20:33:01', 0, NULL, '0', 10, 1.00, '2659-8kGDf-1644943785', '2659-8kGDf-1644943785', '807213', 1, 'admin', '{\"id\": 4, \"zip\": \"5536\", \"city\": \"SORIK\", \"phone\": \"254722229862\", \"state\": null, \"address\": \"TESTTS\", \"country\": \"KENYA\", \"latitude\": \"\", \"longitude\": \"\", \"created_at\": \"2022-02-14T09:36:46.000000Z\", \"is_billing\": 0, \"updated_at\": \"2022-02-14T09:36:46.000000Z\", \"customer_id\": 10, \"address_type\": \"home\", \"delivery_date\": null, \"delivery_time\": null, \"contact_person_name\": \"Festus Bett\"}', NULL, NULL, 4, '{\"id\":4,\"customer_id\":10,\"contact_person_name\":\"Festus Bett\",\"delivery_date\":null,\"delivery_time\":null,\"address_type\":\"home\",\"address\":\"TESTTS\",\"city\":\"SORIK\",\"zip\":\"5536\",\"phone\":\"254722229862\",\"created_at\":\"2022-02-14T09:36:46.000000Z\",\"updated_at\":\"2022-02-14T09:36:46.000000Z\",\"state\":null,\"country\":\"KENYA\",\"latitude\":\"\",\"longitude\":\"\",\"is_billing\":0}'),
(100002, '10', '254722229862', 'festusbet@gmail.com', '32802426', 'Bomet', 'customer', 'unpaid', 'delivered', 'cash_on_delivery', '', 2, '4', '2022-02-15 16:50:50', '2022-02-15 17:00:07', 0, NULL, '0', 9, 1.00, '1695-IPYH6-1644943850', '1695-IPYH6-1644943850', '891831', 32802426, 'seller', '{\"id\": 4, \"zip\": \"5536\", \"city\": \"SORIK\", \"phone\": \"254722229862\", \"state\": null, \"address\": \"TESTTS\", \"country\": \"KENYA\", \"latitude\": \"\", \"longitude\": \"\", \"created_at\": \"2022-02-14T09:36:46.000000Z\", \"is_billing\": 0, \"updated_at\": \"2022-02-14T09:36:46.000000Z\", \"customer_id\": 10, \"address_type\": \"home\", \"delivery_date\": null, \"delivery_time\": null, \"contact_person_name\": \"Festus Bett\"}', NULL, NULL, 4, '{\"id\":4,\"customer_id\":10,\"contact_person_name\":\"Festus Bett\",\"delivery_date\":null,\"delivery_time\":null,\"address_type\":\"home\",\"address\":\"TESTTS\",\"city\":\"SORIK\",\"zip\":\"5536\",\"phone\":\"254722229862\",\"created_at\":\"2022-02-14T09:36:46.000000Z\",\"updated_at\":\"2022-02-14T09:36:46.000000Z\",\"state\":null,\"country\":\"KENYA\",\"latitude\":\"\",\"longitude\":\"\",\"is_billing\":0}'),
(100003, '10', '254722229862', 'festusbet@gmail.com', '32802426', 'Bomet', 'customer', 'unpaid', 'pending', 'cash_on_delivery', '', 3, '4', '2022-02-15 21:01:21', '2022-02-15 21:01:21', 0, NULL, '0', 11, 2.00, '9164-AnZyk-1644958881', '9164-AnZyk-1644958881', '978311', 1, 'admin', '{\"id\": 4, \"zip\": \"5536\", \"city\": \"SORIK\", \"phone\": \"254722229862\", \"state\": null, \"address\": \"TESTTS\", \"country\": \"KENYA\", \"latitude\": \"\", \"longitude\": \"\", \"created_at\": \"2022-02-14T09:36:46.000000Z\", \"is_billing\": 0, \"updated_at\": \"2022-02-14T09:36:46.000000Z\", \"customer_id\": 10, \"address_type\": \"home\", \"delivery_date\": null, \"delivery_time\": null, \"contact_person_name\": \"Festus Bett\"}', NULL, 'Test', 4, '{\"id\":4,\"customer_id\":10,\"contact_person_name\":\"Festus Bett\",\"delivery_date\":null,\"delivery_time\":null,\"address_type\":\"home\",\"address\":\"TESTTS\",\"city\":\"SORIK\",\"zip\":\"5536\",\"phone\":\"254722229862\",\"created_at\":\"2022-02-14T09:36:46.000000Z\",\"updated_at\":\"2022-02-14T09:36:46.000000Z\",\"state\":null,\"country\":\"KENYA\",\"latitude\":\"\",\"longitude\":\"\",\"is_billing\":0}'),
(100004, '10', '254722229862', 'festusbet@gmail.com', '32802426', 'Bomet', 'customer', 'unpaid', 'pending', 'cash_on_delivery', '', 5, '4', '2022-02-15 21:05:11', '2022-02-15 21:05:11', 0, NULL, '0', 11, 2.00, '8951-YRdlz-1644959111', '8951-YRdlz-1644959111', '732270', 1, 'admin', '{\"id\": 4, \"zip\": \"5536\", \"city\": \"SORIK\", \"phone\": \"254722229862\", \"state\": null, \"address\": \"TESTTS\", \"country\": \"KENYA\", \"latitude\": \"\", \"longitude\": \"\", \"created_at\": \"2022-02-14T09:36:46.000000Z\", \"is_billing\": 0, \"updated_at\": \"2022-02-14T09:36:46.000000Z\", \"customer_id\": 10, \"address_type\": \"home\", \"delivery_date\": null, \"delivery_time\": null, \"contact_person_name\": \"Festus Bett\"}', NULL, 'ggdgdd', 4, '{\"id\":4,\"customer_id\":10,\"contact_person_name\":\"Festus Bett\",\"delivery_date\":null,\"delivery_time\":null,\"address_type\":\"home\",\"address\":\"TESTTS\",\"city\":\"SORIK\",\"zip\":\"5536\",\"phone\":\"254722229862\",\"created_at\":\"2022-02-14T09:36:46.000000Z\",\"updated_at\":\"2022-02-14T09:36:46.000000Z\",\"state\":null,\"country\":\"KENYA\",\"latitude\":\"\",\"longitude\":\"\",\"is_billing\":0}');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `product_details` text COLLATE utf8mb4_unicode_ci,
  `qty` int(11) NOT NULL DEFAULT '0',
  `price` double NOT NULL DEFAULT '0',
  `tax` double NOT NULL DEFAULT '0',
  `discount` double NOT NULL DEFAULT '0',
  `delivery_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `shipping_method_id` bigint(20) DEFAULT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_stock_decreased` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`) VALUES
(1, 100001, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":100,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-06T19:46:53.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 2, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 17:15:24', '2022-02-15 20:33:01', NULL, '', '[]', 'discount_on_product', 0),
(2, 100002, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":98,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T17:15:24.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 2, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 17:18:29', '2022-02-08 18:57:44', NULL, '', '[]', 'discount_on_product', 1),
(3, 100003, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":96,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T17:18:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 2, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 17:18:59', '2022-02-07 17:18:59', NULL, '', '[]', 'discount_on_product', 1),
(4, 100004, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":100,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T14:37:05.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:28:59', '2022-02-07 19:28:59', NULL, '', '[]', 'discount_on_product', 1),
(5, 100005, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":99,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:28:59.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:29:29', '2022-02-07 19:29:29', NULL, '', '[]', 'discount_on_product', 1),
(6, 100006, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":98,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:29:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:36:35', '2022-02-07 19:36:35', NULL, '', '[]', 'discount_on_product', 1),
(7, 100007, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":97,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:36:35.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:37:18', '2022-02-07 19:37:18', NULL, '', '[]', 'discount_on_product', 1),
(8, 100008, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":96,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:37:18.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:37:48', '2022-02-07 19:37:48', NULL, '', '[]', 'discount_on_product', 1),
(9, 100009, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":2,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":95,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:37:48.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 2, 0, 0, 'pending', 'unpaid', '2022-02-07 19:38:46', '2022-02-07 19:38:46', NULL, '', '[]', 'discount_on_product', 1),
(10, 100010, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":94,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:39:54.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 19:49:09', '2022-02-07 19:49:09', NULL, '', '[]', 'discount_on_product', 1),
(11, 100011, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":93,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:49:09.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 19:52:29', '2022-02-07 19:52:29', NULL, '', '[]', 'discount_on_product', 1),
(12, 100012, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":92,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:52:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 19:55:22', '2022-02-07 19:55:22', NULL, '', '[]', 'discount_on_product', 1),
(13, 100013, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":91,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:55:22.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 19:58:08', '2022-02-07 19:58:08', NULL, '', '[]', 'discount_on_product', 1),
(14, 100014, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":90,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:58:08.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 19:59:14', '2022-02-07 19:59:14', NULL, '', '[]', 'discount_on_product', 1),
(15, 100015, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":89,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T19:59:14.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:01:37', '2022-02-07 20:01:37', NULL, '', '[]', 'discount_on_product', 1),
(16, 100016, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":88,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T20:01:37.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:10:29', '2022-02-07 20:10:29', NULL, '', '[]', 'discount_on_product', 1),
(17, 100001, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":87,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T20:10:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:19:02', '2022-02-15 20:33:01', NULL, '', '[]', 'discount_on_product', 0),
(18, 100002, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":94,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-07T19:39:28.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:28:24', '2022-02-08 18:57:44', NULL, '', '[]', 'discount_on_product', 1),
(19, 100003, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":86,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T20:19:02.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:32:11', '2022-02-07 20:32:11', NULL, '', '[]', 'discount_on_product', 1),
(20, 100003, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":85,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T20:32:11.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 20:32:11', '2022-02-07 20:32:11', NULL, '', '[]', 'discount_on_product', 1),
(21, 100004, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":86,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-07T21:35:22.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-07 21:40:03', '2022-02-07 21:40:03', NULL, '', '[]', 'discount_on_product', 1),
(22, 100005, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":\"\",\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":83,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-08T18:57:44.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 10, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 06:38:14', '2022-02-14 06:38:14', NULL, '', '[]', 'discount_on_product', 1),
(23, 100006, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":73,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T06:38:14.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 8, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 08:10:21', '2022-02-14 08:10:21', NULL, '', '[]', 'discount_on_product', 1),
(24, 100007, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":65,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T08:10:21.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:22:16', '2022-02-14 15:22:16', NULL, '', '[]', 'discount_on_product', 1),
(25, 100008, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":61,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:22:16.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:22:27', '2022-02-14 15:22:27', NULL, '', '[]', 'discount_on_product', 1),
(26, 100009, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":57,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:22:27.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:24:42', '2022-02-14 15:24:42', NULL, '', '[]', 'discount_on_product', 1),
(27, 100010, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":53,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:24:42.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:27:32', '2022-02-14 15:27:32', NULL, '', '[]', 'discount_on_product', 1),
(28, 100011, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":49,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:27:32.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:31:06', '2022-02-14 15:31:06', NULL, '', '[]', 'discount_on_product', 1),
(29, 100012, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":45,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:31:06.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:31:25', '2022-02-14 15:31:25', NULL, '', '[]', 'discount_on_product', 1),
(30, 100013, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":41,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:31:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:31:46', '2022-02-14 15:31:46', NULL, '', '[]', 'discount_on_product', 1),
(31, 100014, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":37,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:31:46.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:32:05', '2022-02-14 15:32:05', NULL, '', '[]', 'discount_on_product', 1),
(32, 100015, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":33,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:32:05.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:32:25', '2022-02-14 15:32:25', NULL, '', '[]', 'discount_on_product', 1),
(33, 100016, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":29,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:32:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:33:07', '2022-02-14 15:33:07', NULL, '', '[]', 'discount_on_product', 1),
(34, 100017, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":25,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:33:07.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:34:24', '2022-02-14 15:34:24', NULL, '', '[]', 'discount_on_product', 1),
(35, 100018, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":21,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:34:24.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:35:00', '2022-02-14 15:35:00', NULL, '', '[]', 'discount_on_product', 1),
(36, 100019, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":17,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:35:00.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:35:22', '2022-02-14 15:35:22', NULL, '', '[]', 'discount_on_product', 1);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`) VALUES
(37, 100020, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":13,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:35:22.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:35:34', '2022-02-14 15:35:34', NULL, '', '[]', 'discount_on_product', 1),
(38, 100021, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":9,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:35:34.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:35:47', '2022-02-14 15:35:47', NULL, '', '[]', 'discount_on_product', 1),
(39, 100022, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":5,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:35:47.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:36:08', '2022-02-14 15:36:08', NULL, '', '[]', 'discount_on_product', 1),
(40, 100023, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:36:08.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:36:37', '2022-02-14 15:36:37', NULL, '', '[]', 'discount_on_product', 1),
(41, 100024, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-3,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:36:37.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:37:27', '2022-02-14 15:37:27', NULL, '', '[]', 'discount_on_product', 1),
(42, 100025, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-7,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:37:27.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:37:49', '2022-02-14 15:37:49', NULL, '', '[]', 'discount_on_product', 1),
(43, 100026, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-11,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:37:49.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:38:29', '2022-02-14 15:38:29', NULL, '', '[]', 'discount_on_product', 1),
(44, 100027, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-15,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:38:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:39:59', '2022-02-14 15:39:59', NULL, '', '[]', 'discount_on_product', 1),
(45, 100028, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-19,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:39:59.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:40:40', '2022-02-14 15:40:40', NULL, '', '[]', 'discount_on_product', 1),
(46, 100029, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-23,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:40:40.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:41:23', '2022-02-14 15:41:23', NULL, '', '[]', 'discount_on_product', 1),
(47, 100030, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-27,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:41:23.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:42:15', '2022-02-14 15:42:15', NULL, '', '[]', 'discount_on_product', 1),
(48, 100031, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-31,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:42:15.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:42:24', '2022-02-15 11:23:12', NULL, '', '[]', 'discount_on_product', 1),
(49, 100032, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-35,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:42:24.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:42:32', '2022-02-14 15:42:32', NULL, '', '[]', 'discount_on_product', 1),
(50, 100033, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-39,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:42:32.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:42:58', '2022-02-14 15:42:58', NULL, '', '[]', 'discount_on_product', 1),
(51, 100034, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-43,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:42:58.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:44:04', '2022-02-14 15:44:04', NULL, '', '[]', 'discount_on_product', 1),
(52, 100035, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-47,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:44:04.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:44:33', '2022-02-14 15:44:33', NULL, '', '[]', 'discount_on_product', 1),
(53, 100036, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-51,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:44:33.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:44:41', '2022-02-14 15:44:41', NULL, '', '[]', 'discount_on_product', 1),
(54, 100037, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-55,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:44:41.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:44:55', '2022-02-14 15:44:55', NULL, '', '[]', 'discount_on_product', 1),
(55, 100038, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-59,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:44:55.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:45:12', '2022-02-14 15:45:12', NULL, '', '[]', 'discount_on_product', 1),
(56, 100039, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-63,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:45:12.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:45:44', '2022-02-14 15:45:44', NULL, '', '[]', 'discount_on_product', 1),
(57, 100040, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-67,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:45:44.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:46:00', '2022-02-14 15:46:00', NULL, '', '[]', 'discount_on_product', 1),
(58, 100041, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-71,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:46:00.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:46:31', '2022-02-14 15:46:31', NULL, '', '[]', 'discount_on_product', 1),
(59, 100042, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-75,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:46:31.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:46:51', '2022-02-14 15:46:51', NULL, '', '[]', 'discount_on_product', 1),
(60, 100043, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-79,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:46:51.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:47:38', '2022-02-14 15:47:38', NULL, '', '[]', 'discount_on_product', 1),
(61, 100044, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-83,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:47:38.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:47:56', '2022-02-14 15:47:56', NULL, '', '[]', 'discount_on_product', 1),
(62, 100045, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-87,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:47:56.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 15:49:15', '2022-02-14 15:49:15', NULL, '', '[]', 'discount_on_product', 1),
(63, 100046, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-91,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T15:49:15.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:02:02', '2022-02-14 17:02:02', NULL, '', '[]', 'discount_on_product', 1),
(64, 100047, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-95,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:02:02.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:02:19', '2022-02-14 17:02:19', NULL, '', '[]', 'discount_on_product', 1),
(65, 100048, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-99,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:02:19.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:02:35', '2022-02-14 17:02:35', NULL, '', '[]', 'discount_on_product', 1),
(66, 100049, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-103,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:02:35.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:04:35', '2022-02-14 17:04:35', NULL, '', '[]', 'discount_on_product', 1),
(67, 100050, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-107,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:04:35.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:04:58', '2022-02-15 15:36:04', NULL, '', '[]', 'discount_on_product', 0),
(68, 100051, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-111,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:04:58.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:05:39', '2022-02-15 10:25:19', NULL, '', '[]', 'discount_on_product', 0),
(69, 100052, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-115,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:05:39.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:06:10', '2022-02-14 17:06:10', NULL, '', '[]', 'discount_on_product', 1),
(70, 100053, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-119,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:06:10.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:06:30', '2022-02-14 17:06:30', NULL, '', '[]', 'discount_on_product', 1),
(71, 100054, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-123,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:06:30.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:07:49', '2022-02-14 17:07:49', NULL, '', '[]', 'discount_on_product', 1),
(72, 100055, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-127,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:07:49.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:08:43', '2022-02-14 17:08:43', NULL, '', '[]', 'discount_on_product', 1);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`) VALUES
(73, 100056, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-131,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:08:43.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:10:18', '2022-02-14 17:10:18', NULL, '', '[]', 'discount_on_product', 1),
(74, 100057, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-135,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:10:18.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:11:28', '2022-02-14 17:11:28', NULL, '', '[]', 'discount_on_product', 1),
(75, 100058, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-139,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:11:28.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:12:05', '2022-02-14 17:12:05', NULL, '', '[]', 'discount_on_product', 1),
(76, 100059, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-143,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:12:05.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:14:23', '2022-02-14 17:14:23', NULL, '', '[]', 'discount_on_product', 1),
(77, 100060, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-147,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:14:23.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:14:46', '2022-02-14 17:14:46', NULL, '', '[]', 'discount_on_product', 1),
(78, 100061, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-151,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:14:46.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:15:32', '2022-02-14 17:15:32', NULL, '', '[]', 'discount_on_product', 1),
(79, 100062, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-155,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:15:32.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:17:04', '2022-02-14 17:17:04', NULL, '', '[]', 'discount_on_product', 1),
(80, 100063, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-159,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:17:04.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:17:22', '2022-02-14 17:17:22', NULL, '', '[]', 'discount_on_product', 1),
(81, 100064, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-163,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:17:22.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:17:50', '2022-02-14 17:17:50', NULL, '', '[]', 'discount_on_product', 1),
(82, 100065, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-167,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:17:50.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:18:44', '2022-02-14 17:18:44', NULL, '', '[]', 'discount_on_product', 1),
(83, 100066, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-171,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:18:44.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:19:22', '2022-02-14 17:19:22', NULL, '', '[]', 'discount_on_product', 1),
(84, 100067, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-175,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:19:22.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:23:23', '2022-02-14 17:23:23', NULL, '', '[]', 'discount_on_product', 1),
(85, 100068, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-179,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:23:23.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:26:55', '2022-02-14 17:26:55', NULL, '', '[]', 'discount_on_product', 1),
(86, 100069, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-183,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:26:55.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:27:31', '2022-02-14 17:27:31', NULL, '', '[]', 'discount_on_product', 1),
(87, 100070, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-187,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:27:31.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:28:29', '2022-02-14 17:28:29', NULL, '', '[]', 'discount_on_product', 1),
(88, 100071, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-191,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:28:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-14 17:33:03', '2022-02-14 17:33:03', NULL, '', '[]', 'discount_on_product', 1),
(89, 100072, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-195,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-14T17:33:03.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:08:15', '2022-02-15 05:08:15', NULL, '', '[]', 'discount_on_product', 1),
(90, 100073, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-199,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:08:15.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:08:20', '2022-02-15 05:08:20', NULL, '', '[]', 'discount_on_product', 1),
(91, 100074, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-203,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:08:20.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:13:43', '2022-02-15 05:13:43', NULL, '', '[]', 'discount_on_product', 1),
(92, 100075, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-207,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:13:43.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:15:16', '2022-02-15 05:15:16', NULL, '', '[]', 'discount_on_product', 1),
(93, 100001, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-211,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:15:16.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:19:15', '2022-02-15 20:33:01', NULL, '', '[]', 'discount_on_product', 0),
(94, 100002, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-215,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:19:15.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:19:19', '2022-02-15 05:19:19', NULL, '', '[]', 'discount_on_product', 1),
(95, 100003, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-219,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:19:19.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:21:04', '2022-02-15 05:21:04', NULL, '', '[]', 'discount_on_product', 1),
(96, 100004, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-223,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:21:04.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:23:49', '2022-02-15 05:23:49', NULL, '', '[]', 'discount_on_product', 1),
(97, 100005, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-227,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:23:49.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:24:35', '2022-02-15 05:24:35', NULL, '', '[]', 'discount_on_product', 1),
(98, 100006, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-231,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:24:35.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:25:11', '2022-02-15 05:25:11', NULL, '', '[]', 'discount_on_product', 1),
(99, 100007, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-235,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:25:11.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:26:35', '2022-02-15 05:26:35', NULL, '', '[]', 'discount_on_product', 1),
(100, 100008, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-239,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:26:35.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:28:33', '2022-02-15 05:28:33', NULL, '', '[]', 'discount_on_product', 1),
(101, 100009, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-243,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:28:33.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:29:57', '2022-02-15 05:29:57', NULL, '', '[]', 'discount_on_product', 1),
(102, 100010, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-247,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:29:57.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:33:57', '2022-02-15 05:33:57', NULL, '', '[]', 'discount_on_product', 1),
(103, 100011, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-251,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:33:57.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:35:15', '2022-02-15 05:35:15', NULL, '', '[]', 'discount_on_product', 1),
(104, 100012, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-255,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:35:15.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:36:49', '2022-02-15 05:36:49', NULL, '', '[]', 'discount_on_product', 1),
(105, 100013, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-259,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:36:49.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:37:09', '2022-02-15 05:37:09', NULL, '', '[]', 'discount_on_product', 1),
(106, 100014, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-263,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:37:09.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:37:25', '2022-02-15 05:37:25', NULL, '', '[]', 'discount_on_product', 1),
(107, 100015, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-267,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:37:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:38:01', '2022-02-15 05:38:01', NULL, '', '[]', 'discount_on_product', 1),
(108, 100016, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-271,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:38:01.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:38:37', '2022-02-15 05:38:37', NULL, '', '[]', 'discount_on_product', 1);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`) VALUES
(109, 100017, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-275,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:38:37.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:38:52', '2022-02-15 05:38:52', NULL, '', '[]', 'discount_on_product', 1),
(110, 100018, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-279,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:38:52.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:40:07', '2022-02-15 05:40:07', NULL, '', '[]', 'discount_on_product', 1),
(111, 100019, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-283,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:40:07.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:41:45', '2022-02-15 05:41:45', NULL, '', '[]', 'discount_on_product', 1),
(112, 100020, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-287,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:41:45.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:42:10', '2022-02-15 05:42:10', NULL, '', '[]', 'discount_on_product', 1),
(113, 100021, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-291,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:42:10.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:42:23', '2022-02-15 05:42:23', NULL, '', '[]', 'discount_on_product', 1),
(114, 100022, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-295,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:42:23.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 05:46:43', '2022-02-15 05:46:43', NULL, '', '[]', 'discount_on_product', 1),
(115, 100023, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-299,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T05:46:43.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:00:19', '2022-02-15 06:00:19', NULL, '', '[]', 'discount_on_product', 1),
(116, 100024, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-303,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:00:19.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:02:19', '2022-02-15 06:02:19', NULL, '', '[]', 'discount_on_product', 1),
(117, 100025, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-307,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:02:19.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:04:07', '2022-02-15 06:04:07', NULL, '', '[]', 'discount_on_product', 1),
(118, 100026, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-311,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:04:07.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:05:31', '2022-02-15 06:05:31', NULL, '', '[]', 'discount_on_product', 1),
(119, 100027, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-315,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:05:31.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:07:25', '2022-02-15 06:07:25', NULL, '', '[]', 'discount_on_product', 1),
(120, 100028, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-319,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:07:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:09:02', '2022-02-15 06:09:02', NULL, '', '[]', 'discount_on_product', 1),
(121, 100029, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":-323,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:09:02.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 4, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:12:08', '2022-02-15 06:12:08', NULL, '', '[]', 'discount_on_product', 1),
(122, 100030, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":93,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-08T18:57:44.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:19:31', '2022-02-15 06:19:31', NULL, '', '[]', 'discount_on_product', 1),
(123, 100031, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":92,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-15T06:19:31.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:20:00', '2022-02-15 11:23:12', NULL, '', '[]', 'discount_on_product', 1),
(124, 100032, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":2000,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:12:08.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 06:45:29', '2022-02-15 06:45:29', NULL, '', '[]', 'discount_on_product', 1),
(125, 100033, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1999,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T06:45:29.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 07:02:17', '2022-02-15 07:02:17', NULL, '', '[]', 'discount_on_product', 1),
(126, 100034, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1998,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T07:02:17.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:23:21', '2022-02-15 08:23:21', NULL, '', '[]', 'discount_on_product', 1),
(127, 100035, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1997,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:23:21.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:32:48', '2022-02-15 08:32:48', NULL, '', '[]', 'discount_on_product', 1),
(128, 100036, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1996,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:32:48.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:36:57', '2022-02-15 08:36:57', NULL, '', '[]', 'discount_on_product', 1),
(129, 100037, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1995,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:36:57.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:38:25', '2022-02-15 08:38:25', NULL, '', '[]', 'discount_on_product', 1),
(130, 100038, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1994,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:38:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:48:27', '2022-02-15 08:48:27', NULL, '', '[]', 'discount_on_product', 1),
(131, 100039, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1993,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:48:27.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:50:19', '2022-02-15 08:50:19', NULL, '', '[]', 'discount_on_product', 1),
(132, 100040, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1992,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:50:19.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:50:58', '2022-02-15 08:50:58', NULL, '', '[]', 'discount_on_product', 1),
(133, 100041, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1991,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:50:58.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:51:08', '2022-02-15 08:51:08', NULL, '', '[]', 'discount_on_product', 1),
(134, 100042, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1990,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:51:08.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:52:27', '2022-02-15 08:52:27', NULL, '', '[]', 'discount_on_product', 1),
(135, 100043, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1989,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:52:27.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 08:52:31', '2022-02-15 08:52:31', NULL, '', '[]', 'discount_on_product', 1),
(136, 100044, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1988,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T08:52:31.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:08:47', '2022-02-15 09:08:47', NULL, '', '[]', 'discount_on_product', 1),
(137, 100045, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1987,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:08:47.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:09:14', '2022-02-15 09:09:14', NULL, '', '[]', 'discount_on_product', 1),
(138, 100046, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1986,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:09:14.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:09:32', '2022-02-15 09:09:32', NULL, '', '[]', 'discount_on_product', 1),
(139, 100047, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1985,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:09:32.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:09:51', '2022-02-15 09:09:51', NULL, '', '[]', 'discount_on_product', 1),
(140, 100048, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1984,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:09:51.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:10:06', '2022-02-15 09:10:06', NULL, '', '[]', 'discount_on_product', 1),
(141, 100049, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1983,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:10:06.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:10:25', '2022-02-15 09:10:25', NULL, '', '[]', 'discount_on_product', 1),
(142, 100050, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1982,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:10:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:10:39', '2022-02-15 15:36:04', NULL, '', '[]', 'discount_on_product', 0),
(143, 100051, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":1,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1981,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T09:10:39.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 09:11:28', '2022-02-15 10:25:19', NULL, '', '[]', 'discount_on_product', 0),
(144, 100052, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1990,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T15:36:04.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 16:42:25', '2022-02-15 16:42:25', NULL, '', '[]', 'discount_on_product', 1);
INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `seller_id`, `product_details`, `qty`, `price`, `tax`, `discount`, `delivery_status`, `payment_status`, `created_at`, `updated_at`, `shipping_method_id`, `variant`, `variation`, `discount_type`, `is_stock_decreased`) VALUES
(145, 100053, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1989,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T16:42:25.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 16:45:46', '2022-02-15 16:45:46', NULL, '', '[]', 'discount_on_product', 1),
(146, 100001, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1988,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T16:45:46.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 16:49:45', '2022-02-15 20:33:01', NULL, '', '[]', 'discount_on_product', 0),
(147, 100002, 3, 32802426, '{\"id\":3,\"added_by\":\"seller\",\"user_id\":32802426,\"name\":\"Name (EN)\",\"slug\":\"name-en-ozcDdh\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-07-62012d8c926c5.png\\\"]\",\"thumbnail\":\"2022-02-07-62012d8c93931.png\",\"featured\":0,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"current_stock\":900,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-07T14:32:44.000000Z\",\"updated_at\":\"2022-02-15T11:23:12.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta title\",\"meta_description\":\"Meta description\",\"meta_image\":\"2022-02-07-62012d8c94670.png\",\"request_status\":0,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 16:50:50', '2022-02-15 16:50:50', NULL, '', '[]', 'discount_on_product', 1),
(148, 100003, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1995,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T20:33:01.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 1, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 21:01:21', '2022-02-15 21:01:21', NULL, '', '[]', 'discount_on_product', 1),
(149, 100004, 1, 1, '{\"id\":1,\"added_by\":\"admin\",\"user_id\":1,\"name\":\"Product Name (EN)\",\"slug\":\"product-name-en-B0zH9G\",\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":1},{\\\"id\\\":\\\"2\\\",\\\"position\\\":2},{\\\"id\\\":\\\"3\\\",\\\"position\\\":3}]\",\"brand_id\":1,\"unit\":\"kg\",\"unit_pricing\":0,\"min_qty\":1,\"refundable\":1,\"images\":\"[\\\"2022-02-06-61fffb7d1c4bd.png\\\"]\",\"thumbnail\":\"2022-02-06-61fffb7d1d22b.png\",\"featured\":null,\"flash_deal\":null,\"video_provider\":\"youtube\",\"video_url\":null,\"colors\":\"[]\",\"variant_product\":0,\"attributes\":\"null\",\"choice_options\":\"[]\",\"variation\":\"[]\",\"published\":0,\"unit_price\":1,\"purchase_price\":1,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"flat\",\"current_stock\":1994,\"details\":\"<p>Description (EN)<\\/p>\",\"free_shipping\":0,\"attachment\":null,\"created_at\":\"2022-02-06T19:46:53.000000Z\",\"updated_at\":\"2022-02-15T21:01:21.000000Z\",\"status\":1,\"featured_status\":1,\"meta_title\":\"Meta Title\",\"meta_description\":\"Meta Title\",\"meta_image\":\"2022-02-06-61fffb7d1dcba.png\",\"request_status\":1,\"denied_note\":null,\"reviews_count\":0,\"translations\":[],\"reviews\":[]}', 3, 1, 0, 0, 'pending', 'unpaid', '2022-02-15 21:05:11', '2022-02-15 21:05:11', NULL, '', '[]', 'discount_on_product', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_transactions`
--

DROP TABLE IF EXISTS `order_transactions`;
CREATE TABLE IF NOT EXISTS `order_transactions` (
  `seller_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `order_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `seller_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `admin_commission` decimal(8,2) NOT NULL DEFAULT '0.00',
  `received_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_charge` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `seller_is` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivered_by` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_transactions`
--

INSERT INTO `order_transactions` (`seller_id`, `order_id`, `order_amount`, `seller_amount`, `admin_commission`, `received_by`, `status`, `delivery_charge`, `tax`, `created_at`, `updated_at`, `customer_id`, `seller_is`, `delivered_by`, `payment_method`, `transaction_id`, `id`) VALUES
(32802426, 100004, '2.00', '2.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-07 19:29:00', '2022-02-07 19:29:00', 5, 'seller', 'admin', 'MPESA', '6258-aAjqf-1644262140', 1),
(32802426, 100005, '2.00', '2.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-07 19:29:30', '2022-02-07 19:29:30', 5, 'seller', 'admin', 'MPESA', '2127-ZOjvJ-1644262170', 2),
(32802426, 100006, '2.00', '2.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-07 19:36:35', '2022-02-07 19:36:35', 5, 'seller', 'admin', 'MPESA', '4718-DbDGo-1644262595', 3),
(32802426, 100007, '2.00', '2.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-07 19:37:18', '2022-02-07 19:37:18', 5, 'seller', 'admin', 'MPESA', '2989-ZCVaA-1644262638', 4),
(32802426, 100008, '2.00', '2.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-07 19:37:48', '2022-02-07 19:37:48', 5, 'seller', 'admin', 'MPESA', '5269-mMY94-1644262668', 5),
(1, 100010, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 19:49:09', '2022-02-07 19:49:09', 5, 'admin', 'admin', 'MPESA', '2564-2Bfz8-1644263349', 6),
(1, 100011, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 19:52:29', '2022-02-07 19:52:29', 5, 'admin', 'admin', 'MPESA', '5165-HfpR9-1644263549', 7),
(1, 100012, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 19:55:22', '2022-02-07 19:55:22', 5, 'admin', 'admin', 'MPESA', '8135-HJCKZ-1644263722', 8),
(1, 100013, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 19:58:08', '2022-02-07 19:58:08', 5, 'admin', 'admin', 'MPESA', '6496-4N8yw-1644263888', 9),
(1, 100014, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 19:59:14', '2022-02-07 19:59:14', 5, 'admin', 'admin', 'MPESA', '9903-q9rwL-1644263954', 10),
(1, 100015, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 20:01:37', '2022-02-07 20:01:37', 5, 'admin', 'admin', 'MPESA', '4912-2kO6G-1644264097', 11),
(1, 100016, '1.00', '1.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 20:10:30', '2022-02-07 20:10:30', 5, 'admin', 'admin', 'MPESA', '5289-i4f6I-1644264630', 12),
(1, 100001, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 20:19:02', '2022-02-07 20:19:02', 5, 'admin', 'admin', 'mpesa', '9003-fPLwb-1644265142', 13),
(32802426, 100002, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 20:28:24', '2022-02-07 20:28:24', 5, 'seller', 'admin', 'MPESA', '5402-aLTwI-1644265704', 14),
(1, 100003, '6.00', '6.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 20:32:11', '2022-02-07 20:32:11', 5, 'admin', 'admin', 'mpesa', '9345-jgfZQ-1644265931', 15),
(1, 100004, '3.00', '3.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-07 21:40:03', '2022-02-07 21:40:03', 5, 'admin', 'admin', 'mpesa', '8014-lSpr8-1644270003', 16),
(1, 100007, '6.00', '6.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:22:16', '2022-02-14 15:22:16', 10, 'admin', 'admin', 'MPESA', '8007-qaxXb-1644852136', 17),
(1, 100008, '6.00', '6.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:22:27', '2022-02-14 15:22:27', 10, 'admin', 'admin', 'MPESA', '9094-h3gt0-1644852147', 18),
(1, 100009, '6.00', '6.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:24:42', '2022-02-14 15:24:42', 10, 'admin', 'admin', 'MPESA', '3198-Ph86p-1644852282', 19),
(1, 100010, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:27:32', '2022-02-14 15:27:32', 10, 'admin', 'admin', 'MPESA', '9588-auaxi-1644852452', 20),
(1, 100011, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:31:06', '2022-02-14 15:31:06', 10, 'admin', 'admin', 'MPESA', '8041-vGMBz-1644852666', 21),
(1, 100012, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:31:25', '2022-02-14 15:31:25', 10, 'admin', 'admin', 'MPESA', '7438-sNOnB-1644852685', 22),
(1, 100013, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:31:46', '2022-02-14 15:31:46', 10, 'admin', 'admin', 'MPESA', '6493-UwJtP-1644852706', 23),
(1, 100014, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:32:05', '2022-02-14 15:32:05', 10, 'admin', 'admin', 'MPESA', '3181-ySn2f-1644852725', 24),
(1, 100015, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:32:25', '2022-02-14 15:32:25', 10, 'admin', 'admin', 'MPESA', '3984-eQ6X9-1644852745', 25),
(1, 100016, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:33:07', '2022-02-14 15:33:07', 10, 'admin', 'admin', 'MPESA', '9672-Y4ElV-1644852787', 26),
(1, 100017, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:34:24', '2022-02-14 15:34:24', 10, 'admin', 'admin', 'MPESA', '9932-bCuGJ-1644852864', 27),
(1, 100018, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:35:00', '2022-02-14 15:35:00', 10, 'admin', 'admin', 'MPESA', '5920-qUL81-1644852900', 28),
(1, 100019, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:35:22', '2022-02-14 15:35:22', 10, 'admin', 'admin', 'MPESA', '2020-jM6d9-1644852922', 29),
(1, 100020, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:35:34', '2022-02-14 15:35:34', 10, 'admin', 'admin', 'MPESA', '2832-QUPUm-1644852934', 30),
(1, 100021, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:35:47', '2022-02-14 15:35:47', 10, 'admin', 'admin', 'MPESA', '3195-zt24M-1644852947', 31),
(1, 100022, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:36:09', '2022-02-14 15:36:09', 10, 'admin', 'admin', 'MPESA', '1387-l9Rds-1644852969', 32),
(1, 100023, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:36:37', '2022-02-14 15:36:37', 10, 'admin', 'admin', 'MPESA', '1542-jB4L4-1644852997', 33),
(1, 100024, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:37:27', '2022-02-14 15:37:27', 10, 'admin', 'admin', 'MPESA', '3442-6W6vW-1644853047', 34),
(1, 100025, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:37:49', '2022-02-14 15:37:49', 10, 'admin', 'admin', 'MPESA', '7775-05QQS-1644853069', 35),
(1, 100026, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:38:29', '2022-02-14 15:38:29', 10, 'admin', 'admin', 'MPESA', '7460-jqNGE-1644853109', 36),
(1, 100027, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:39:59', '2022-02-14 15:39:59', 10, 'admin', 'admin', 'MPESA', '1842-zTMUV-1644853199', 37),
(1, 100028, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:40:40', '2022-02-14 15:40:40', 10, 'admin', 'admin', 'MPESA', '3210-KeGeb-1644853240', 38),
(1, 100029, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:41:23', '2022-02-14 15:41:23', 10, 'admin', 'admin', 'MPESA', '9511-jX8yf-1644853283', 39),
(1, 100030, '4.00', '4.00', '0.00', 'admin', 'disburse', '2.00', '0.00', '2022-02-14 15:42:15', '2022-02-15 16:05:15', 10, 'admin', 'admin', 'MPESA', '6037-7h9yW-1644853335', 40),
(1, 100031, '4.00', '4.00', '0.00', 'admin', 'disburse', '2.00', '0.00', '2022-02-14 15:42:24', '2022-02-15 11:23:12', 10, 'admin', 'admin', 'MPESA', '7521-2bFo4-1644853344', 41),
(1, 100032, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:42:32', '2022-02-14 15:42:32', 10, 'admin', 'admin', 'MPESA', '9778-ieft7-1644853352', 42),
(1, 100033, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:42:58', '2022-02-14 15:42:58', 10, 'admin', 'admin', 'MPESA', '9316-nqIFH-1644853378', 43),
(1, 100034, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:44:04', '2022-02-14 15:44:04', 10, 'admin', 'admin', 'MPESA', '5640-V5aQQ-1644853444', 44),
(1, 100035, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:44:33', '2022-02-14 15:44:33', 10, 'admin', 'admin', 'MPESA', '1856-JKDAr-1644853473', 45),
(1, 100036, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:44:42', '2022-02-14 15:44:42', 10, 'admin', 'admin', 'MPESA', '7831-fBIrp-1644853482', 46),
(1, 100037, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:44:55', '2022-02-14 15:44:55', 10, 'admin', 'admin', 'MPESA', '1292-F5IGt-1644853495', 47),
(1, 100038, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:45:12', '2022-02-14 15:45:12', 10, 'admin', 'admin', 'MPESA', '5728-eyVN2-1644853512', 48),
(1, 100039, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:45:44', '2022-02-14 15:45:44', 10, 'admin', 'admin', 'MPESA', '1852-UGbWl-1644853544', 49),
(1, 100040, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:46:00', '2022-02-14 15:46:00', 10, 'admin', 'admin', 'MPESA', '5572-vTlKM-1644853560', 50),
(1, 100041, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:46:32', '2022-02-14 15:46:32', 10, 'admin', 'admin', 'MPESA', '7799-GpwFO-1644853592', 51),
(1, 100042, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:46:51', '2022-02-14 15:46:51', 10, 'admin', 'admin', 'MPESA', '9396-AlxYR-1644853611', 52),
(1, 100043, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:47:39', '2022-02-14 15:47:39', 10, 'admin', 'admin', 'MPESA', '8960-hq814-1644853659', 53),
(1, 100044, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:47:56', '2022-02-14 15:47:56', 10, 'admin', 'admin', 'MPESA', '6695-C81I1-1644853676', 54),
(1, 100045, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 15:49:15', '2022-02-14 15:49:15', 10, 'admin', 'admin', 'MPESA', '4430-ymOsq-1644853755', 55),
(1, 100046, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:02:02', '2022-02-14 17:02:02', 10, 'admin', 'admin', 'MPESA', '8157-vj3QB-1644858122', 56),
(1, 100047, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:02:19', '2022-02-14 17:02:19', 10, 'admin', 'admin', 'MPESA', '8374-ACtS6-1644858139', 57),
(1, 100048, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:02:35', '2022-02-14 17:02:35', 10, 'admin', 'admin', 'MPESA', '8657-iRjoI-1644858155', 58),
(1, 100049, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:04:35', '2022-02-14 17:04:35', 10, 'admin', 'admin', 'MPESA', '5804-8bC1D-1644858275', 59),
(1, 100050, '4.00', '4.00', '0.00', 'admin', 'disburse', '2.00', '0.00', '2022-02-14 17:04:59', '2022-02-15 11:41:17', 10, 'admin', 'admin', 'MPESA', '7362-K6qZm-1644858299', 60),
(1, 100051, '4.00', '4.00', '0.00', 'admin', 'disburse', '2.00', '0.00', '2022-02-14 17:05:39', '2022-02-15 10:25:09', 10, 'admin', 'admin', 'MPESA', '2785-aSZbU-1644858339', 61),
(1, 100052, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:06:10', '2022-02-14 17:06:10', 10, 'admin', 'admin', 'MPESA', '3474-gnK3X-1644858370', 62),
(1, 100053, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:06:30', '2022-02-14 17:06:30', 10, 'admin', 'admin', 'MPESA', '4975-gEIbt-1644858390', 63),
(1, 100054, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:07:49', '2022-02-14 17:07:49', 10, 'admin', 'admin', 'MPESA', '7230-oNV3V-1644858469', 64),
(1, 100055, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:08:43', '2022-02-14 17:08:43', 10, 'admin', 'admin', 'MPESA', '4156-V1QU0-1644858523', 65),
(1, 100056, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:10:18', '2022-02-14 17:10:18', 10, 'admin', 'admin', 'MPESA', '7449-VQZbk-1644858618', 66),
(1, 100057, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:11:29', '2022-02-14 17:11:29', 10, 'admin', 'admin', 'MPESA', '1193-ix5Bi-1644858689', 67),
(1, 100058, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:12:05', '2022-02-14 17:12:05', 10, 'admin', 'admin', 'MPESA', '6291-yzZWh-1644858725', 68),
(1, 100059, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:14:23', '2022-02-14 17:14:23', 10, 'admin', 'admin', 'MPESA', '5436-Ldoyq-1644858863', 69),
(1, 100060, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:14:46', '2022-02-14 17:14:46', 10, 'admin', 'admin', 'MPESA', '1843-9VAKL-1644858886', 70),
(1, 100061, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:15:32', '2022-02-14 17:15:32', 10, 'admin', 'admin', 'MPESA', '1200-iRVnW-1644858932', 71),
(1, 100062, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:17:04', '2022-02-14 17:17:04', 10, 'admin', 'admin', 'MPESA', '7159-5NAZF-1644859024', 72),
(1, 100063, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:17:22', '2022-02-14 17:17:22', 10, 'admin', 'admin', 'MPESA', '6588-MKDh3-1644859042', 73),
(1, 100064, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:17:50', '2022-02-14 17:17:50', 10, 'admin', 'admin', 'MPESA', '3914-tmlnC-1644859070', 74),
(1, 100065, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:18:44', '2022-02-14 17:18:44', 10, 'admin', 'admin', 'MPESA', '7528-wFLOE-1644859124', 75),
(1, 100066, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:19:23', '2022-02-14 17:19:23', 10, 'admin', 'admin', 'MPESA', '5568-XfHjY-1644859163', 76),
(1, 100067, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:23:23', '2022-02-14 17:23:23', 10, 'admin', 'admin', 'MPESA', '7911-RtOry-1644859403', 77),
(1, 100068, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:26:55', '2022-02-14 17:26:55', 10, 'admin', 'admin', 'MPESA', '5701-gL3M7-1644859615', 78),
(1, 100069, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:27:31', '2022-02-14 17:27:31', 10, 'admin', 'admin', 'MPESA', '7189-DdzPc-1644859651', 79),
(1, 100070, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:28:29', '2022-02-14 17:28:29', 10, 'admin', 'admin', 'MPESA', '2889-AS6iT-1644859709', 80),
(1, 100071, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-14 17:33:03', '2022-02-14 17:33:03', 10, 'admin', 'admin', 'MPESA', '7837-RBkGK-1644859983', 81),
(1, 100072, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:08:15', '2022-02-15 05:08:15', 10, 'admin', 'admin', 'MPESA', '7752-GlR3H-1644901695', 82),
(1, 100073, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:08:20', '2022-02-15 05:08:20', 10, 'admin', 'admin', 'MPESA', '4019-ngS55-1644901700', 83),
(1, 100074, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:13:43', '2022-02-15 05:13:43', 10, 'admin', 'admin', 'MPESA', '5581-D3lT9-1644902023', 84),
(1, 100075, '4.00', '4.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:15:16', '2022-02-15 05:15:16', 10, 'admin', 'admin', 'MPESA', '7394-wQEqC-1644902116', 85),
(1, 100001, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:19:16', '2022-02-15 05:19:16', 10, 'admin', 'admin', 'MPESA', '4724-XitnW-1644902356', 86),
(1, 100002, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:19:19', '2022-02-15 05:19:19', 10, 'admin', 'admin', 'MPESA', '8018-0MGTj-1644902359', 87),
(1, 100003, '10.00', '10.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:21:04', '2022-02-15 05:21:04', 10, 'admin', 'admin', 'MPESA', '9906-3M06g-1644902464', 88),
(1, 100004, '7.00', '7.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:23:49', '2022-02-15 05:23:49', 10, 'admin', 'admin', 'MPESA', '1386-35R9H-1644902629', 89),
(1, 100005, '16.00', '16.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:24:35', '2022-02-15 05:24:35', 10, 'admin', 'admin', 'MPESA', '8642-PvwTj-1644902675', 90),
(1, 100006, '14.00', '14.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:25:11', '2022-02-15 05:25:11', 10, 'admin', 'admin', 'MPESA', '7012-UCmNd-1644902711', 91),
(1, 100007, '10.00', '10.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:26:35', '2022-02-15 05:26:35', 10, 'admin', 'admin', 'MPESA', '5587-46zUv-1644902795', 92),
(1, 100008, '10.00', '10.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:28:33', '2022-02-15 05:28:33', 10, 'admin', 'admin', 'MPESA', '8840-aDB8j-1644902913', 93),
(1, 100009, '10.00', '10.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:29:57', '2022-02-15 05:29:57', 10, 'admin', 'admin', 'MPESA', '5960-bkJIf-1644902997', 94),
(1, 100010, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:33:57', '2022-02-15 05:33:57', 10, 'admin', 'admin', 'MPESA', '6600-eaTg3-1644903237', 95),
(1, 100011, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:35:15', '2022-02-15 05:35:15', 10, 'admin', 'admin', 'MPESA', '3952-W4BSA-1644903315', 96),
(1, 100012, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:36:49', '2022-02-15 05:36:49', 10, 'admin', 'admin', 'MPESA', '3856-tvEXh-1644903409', 97),
(1, 100013, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:37:09', '2022-02-15 05:37:09', 10, 'admin', 'admin', 'MPESA', '3371-203Xj-1644903429', 98),
(1, 100014, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:37:25', '2022-02-15 05:37:25', 10, 'admin', 'admin', 'MPESA', '4468-VyLK5-1644903445', 99),
(1, 100015, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:38:01', '2022-02-15 05:38:01', 10, 'admin', 'admin', 'MPESA', '6137-tG4mn-1644903481', 100),
(1, 100016, '9.00', '9.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:38:37', '2022-02-15 05:38:37', 10, 'admin', 'admin', 'MPESA', '5924-RtZVu-1644903517', 101),
(1, 100017, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:38:52', '2022-02-15 05:38:52', 10, 'admin', 'admin', 'MPESA', '9120-td5Aw-1644903532', 102),
(1, 100018, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:40:07', '2022-02-15 05:40:07', 10, 'admin', 'admin', 'MPESA', '3278-BBoL1-1644903607', 103),
(1, 100019, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:41:46', '2022-02-15 05:41:46', 10, 'admin', 'admin', 'MPESA', '1215-Dxtpq-1644903706', 104),
(1, 100020, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:42:10', '2022-02-15 05:42:10', 10, 'admin', 'admin', 'MPESA', '3101-bfXSk-1644903730', 105),
(1, 100021, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:42:23', '2022-02-15 05:42:23', 10, 'admin', 'admin', 'MPESA', '4134-zH3rB-1644903743', 106),
(1, 100022, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 05:46:43', '2022-02-15 05:46:43', 10, 'admin', 'admin', 'MPESA', '4087-IpCiR-1644904003', 107),
(1, 100023, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:00:19', '2022-02-15 06:00:19', 10, 'admin', 'admin', 'MPESA', '1807-gOgOd-1644904819', 108),
(1, 100024, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:02:19', '2022-02-15 06:02:19', 10, 'admin', 'admin', 'MPESA', '6053-D0XUv-1644904939', 109),
(1, 100025, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:04:07', '2022-02-15 06:04:07', 10, 'admin', 'admin', 'MPESA', '4691-7Kb1u-1644905047', 110),
(1, 100026, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:05:31', '2022-02-15 06:05:31', 10, 'admin', 'admin', 'MPESA', '9043-FFDfq-1644905131', 111),
(1, 100027, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:07:25', '2022-02-15 06:07:25', 10, 'admin', 'admin', 'MPESA', '6057-WaNCh-1644905245', 112),
(1, 100028, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:09:02', '2022-02-15 06:09:02', 10, 'admin', 'admin', 'MPESA', '1672-e1iDS-1644905342', 113),
(1, 100029, '8.00', '8.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 06:12:08', '2022-02-15 06:12:08', 10, 'admin', 'admin', 'MPESA', '5775-cD8gO-1644905528', 114),
(32802426, 100030, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 06:19:31', '2022-02-15 06:19:31', 10, 'seller', 'admin', 'MPESA', '5783-1AQwj-1644905971', 115),
(32802426, 100031, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 06:20:00', '2022-02-15 06:20:00', 10, 'seller', 'admin', 'MPESA', '6126-HLs0j-1644906000', 116),
(1, 100032, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 06:45:29', '2022-02-15 06:45:29', 10, 'admin', 'admin', 'MPESA', '3634-YBdaZ-1644907529', 117),
(1, 100033, '5.00', '5.00', '0.00', 'admin', 'hold', '2.00', '0.00', '2022-02-15 07:02:17', '2022-02-15 07:02:17', 10, 'admin', 'admin', 'MPESA', '8459-Mpfjd-1644908537', 118),
(1, 100034, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:23:21', '2022-02-15 08:23:21', 10, 'admin', 'admin', 'MPESA', '2907-VxldJ-1644913401', 119),
(1, 100035, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:32:48', '2022-02-15 08:32:48', 10, 'admin', 'admin', 'MPESA', '8641-7kWSo-1644913968', 120),
(1, 100036, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:36:57', '2022-02-15 08:36:57', 10, 'admin', 'admin', 'MPESA', '9167-avhrN-1644914217', 121),
(1, 100037, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:38:25', '2022-02-15 08:38:25', 10, 'admin', 'admin', 'MPESA', '9697-2JML4-1644914305', 122),
(1, 100038, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:48:27', '2022-02-15 08:48:27', 10, 'admin', 'admin', 'MPESA', '1376-i3w9a-1644914907', 123),
(1, 100039, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:50:19', '2022-02-15 08:50:19', 10, 'admin', 'admin', 'MPESA', '7193-Aw2m6-1644915019', 124),
(1, 100040, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:50:58', '2022-02-15 08:50:58', 10, 'admin', 'admin', 'MPESA', '8453-9lHoI-1644915058', 125),
(1, 100041, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:51:08', '2022-02-15 08:51:08', 10, 'admin', 'admin', 'MPESA', '9586-770Iw-1644915068', 126),
(1, 100042, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:52:27', '2022-02-15 08:52:27', 10, 'admin', 'admin', 'MPESA', '2046-K3Q0k-1644915147', 127),
(1, 100043, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 08:52:31', '2022-02-15 08:52:31', 10, 'admin', 'admin', 'MPESA', '4337-PO40c-1644915151', 128),
(1, 100044, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:08:47', '2022-02-15 09:08:47', 10, 'admin', 'admin', 'MPESA', '2887-7dy1n-1644916127', 129),
(1, 100045, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:09:14', '2022-02-15 09:09:14', 10, 'admin', 'admin', 'MPESA', '3079-MTGiQ-1644916154', 130),
(1, 100046, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:09:32', '2022-02-15 09:09:32', 10, 'admin', 'admin', 'MPESA', '5030-6KlQB-1644916172', 131),
(1, 100047, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:09:51', '2022-02-15 09:09:51', 10, 'admin', 'admin', 'MPESA', '2740-oo2wE-1644916191', 132),
(1, 100048, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:10:06', '2022-02-15 09:10:06', 10, 'admin', 'admin', 'MPESA', '8824-cQqjt-1644916206', 133),
(1, 100049, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:10:25', '2022-02-15 09:10:25', 10, 'admin', 'admin', 'MPESA', '2372-sfA3x-1644916225', 134),
(1, 100050, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:10:39', '2022-02-15 09:10:39', 10, 'admin', 'admin', 'MPESA', '7732-F7cDA-1644916239', 135),
(1, 100051, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 09:11:28', '2022-02-15 09:11:28', 10, 'admin', 'admin', 'MPESA', '2109-iOBSl-1644916288', 136),
(1, 100053, '5.00', '5.00', '0.00', 'admin', 'hold', '1.00', '0.00', '2022-02-15 16:45:46', '2022-02-15 16:45:46', 10, 'admin', 'admin', 'MPESA', '7076-xfK58-1644943546', 137),
(32802426, 100002, '10.00', '10.00', '0.00', 'seller', 'disburse', '1.00', '0.00', '2022-02-15 16:51:36', '2022-02-15 16:51:36', 10, 'seller', 'seller', 'cash_on_delivery', '2886-1B3hF-1644943896', 138),
(32802426, 100002, '10.00', '10.00', '0.00', 'admin', 'disburse', '1.00', '0.00', '2022-02-15 16:59:34', '2022-02-15 16:59:34', 10, 'seller', 'admin', 'cash_on_delivery', '9852-rRuxR-1644944374', 139),
(32802426, 100002, '10.00', '10.00', '0.00', 'admin', 'disburse', '1.00', '0.00', '2022-02-15 17:00:07', '2022-02-15 17:00:07', 10, 'seller', 'admin', 'cash_on_delivery', '6952-ZjjaH-1644944407', 140),
(1, 100001, '10.00', '10.00', '0.00', 'admin', 'disburse', '1.00', '0.00', '2022-02-15 17:01:43', '2022-02-15 17:01:43', 10, 'admin', 'admin', 'cash_on_delivery', '9111-tpUxO-1644944503', 141);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `identity` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`identity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `paytabs_invoices`
--

DROP TABLE IF EXISTS `paytabs_invoices`;
CREATE TABLE IF NOT EXISTS `paytabs_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `result` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `response_code` int(10) UNSIGNED NOT NULL,
  `pt_invoice_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` double(8,2) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` int(10) UNSIGNED DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_first_six_digits` int(10) UNSIGNED DEFAULT NULL,
  `card_last_four_digits` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_or_email_verifications`
--

DROP TABLE IF EXISTS `phone_or_email_verifications`;
CREATE TABLE IF NOT EXISTS `phone_or_email_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `phone_or_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `added_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_ids` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `unit` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_pricing` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_qty` int(11) NOT NULL DEFAULT '1',
  `refundable` tinyint(1) NOT NULL DEFAULT '1',
  `images` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `flash_deal` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_provider` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colors` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `variant_product` tinyint(1) NOT NULL DEFAULT '0',
  `attributes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choice_options` text COLLATE utf8mb4_unicode_ci,
  `variation` text COLLATE utf8mb4_unicode_ci,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `unit_price` double NOT NULL DEFAULT '0',
  `purchase_price` double NOT NULL DEFAULT '0',
  `tax` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `tax_type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `discount_type` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_stock` int(11) DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `free_shipping` tinyint(1) NOT NULL DEFAULT '0',
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `featured_status` tinyint(1) NOT NULL DEFAULT '1',
  `meta_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_status` tinyint(1) NOT NULL DEFAULT '0',
  `denied_note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `added_by`, `user_id`, `name`, `slug`, `category_ids`, `brand_id`, `unit`, `unit_pricing`, `min_qty`, `refundable`, `images`, `thumbnail`, `featured`, `flash_deal`, `video_provider`, `video_url`, `colors`, `variant_product`, `attributes`, `choice_options`, `variation`, `published`, `unit_price`, `purchase_price`, `tax`, `tax_type`, `discount`, `discount_type`, `current_stock`, `details`, `free_shipping`, `attachment`, `created_at`, `updated_at`, `status`, `featured_status`, `meta_title`, `meta_description`, `meta_image`, `request_status`, `denied_note`) VALUES
(1, 'admin', 1, 'Product Name (EN)', 'product-name-en-B0zH9G', '[{\"id\":\"1\",\"position\":1},{\"id\":\"2\",\"position\":2},{\"id\":\"3\",\"position\":3}]', 1, 'kg', '0', 1, 1, '[\"2022-02-06-61fffb7d1c4bd.png\"]', '2022-02-06-61fffb7d1d22b.png', NULL, NULL, 'youtube', NULL, '[]', 0, 'null', '[]', '[]', 0, 1, 1, '0', 'percent', '0', 'flat', 1991, '<p>Description (EN)</p>', 0, NULL, '2022-02-06 19:46:53', '2022-02-15 21:05:11', 1, 1, 'Meta Title', 'Meta Title', '2022-02-06-61fffb7d1dcba.png', 1, NULL),
(3, 'seller', 32802426, 'Name (EN)', 'name-en-ozcDdh', '[{\"id\":\"1\",\"position\":1},{\"id\":\"2\",\"position\":2},{\"id\":\"3\",\"position\":3}]', 1, 'kg', '0', 1, 1, '[\"2022-02-07-62012d8c926c5.png\"]', '2022-02-07-62012d8c93931.png', '0', NULL, 'youtube', NULL, '[]', 0, 'null', '[]', '[]', 0, 1, 1, '0', 'percent', '0', 'percent', 899, '<p>Description (EN)</p>', 0, NULL, '2022-02-07 14:32:44', '2022-02-15 16:50:50', 1, 1, 'Meta title', 'Meta description', '2022-02-07-62012d8c94670.png', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_stocks`
--

DROP TABLE IF EXISTS `product_stocks`;
CREATE TABLE IF NOT EXISTS `product_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `qty` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `comment` mediumtext COLLATE utf8mb4_unicode_ci,
  `attachment` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `search_functions`
--

DROP TABLE IF EXISTS `search_functions`;
CREATE TABLE IF NOT EXISTS `search_functions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visible_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_functions`
--

INSERT INTO `search_functions` (`id`, `key`, `url`, `visible_for`, `created_at`, `updated_at`) VALUES
(1, 'Dashboard', 'admin/dashboard', 'admin', NULL, NULL),
(2, 'Order All', 'admin/orders/list/all', 'admin', NULL, NULL),
(3, 'Order Pending', 'admin/orders/list/pending', 'admin', NULL, NULL),
(4, 'Order Processed', 'admin/orders/list/processed', 'admin', NULL, NULL),
(5, 'Order Delivered', 'admin/orders/list/delivered', 'admin', NULL, NULL),
(6, 'Order Returned', 'admin/orders/list/returned', 'admin', NULL, NULL),
(7, 'Order Failed', 'admin/orders/list/failed', 'admin', NULL, NULL),
(8, 'Brand Add', 'admin/brand/add-new', 'admin', NULL, NULL),
(9, 'Brand List', 'admin/brand/list', 'admin', NULL, NULL),
(10, 'Banner', 'admin/banner/list', 'admin', NULL, NULL),
(11, 'Category', 'admin/category/view', 'admin', NULL, NULL),
(12, 'Sub Category', 'admin/category/sub-category/view', 'admin', NULL, NULL),
(13, 'Sub sub category', 'admin/category/sub-sub-category/view', 'admin', NULL, NULL),
(14, 'Attribute', 'admin/attribute/view', 'admin', NULL, NULL),
(15, 'Product', 'admin/product/list', 'admin', NULL, NULL),
(16, 'Coupon', 'admin/coupon/add-new', 'admin', NULL, NULL),
(17, 'Custom Role', 'admin/custom-role/create', 'admin', NULL, NULL),
(18, 'Employee', 'admin/employee/add-new', 'admin', NULL, NULL),
(19, 'Seller', 'admin/sellers/seller-list', 'admin', NULL, NULL),
(20, 'Contacts', 'admin/contact/list', 'admin', NULL, NULL),
(21, 'Flash Deal', 'admin/deal/flash', 'admin', NULL, NULL),
(22, 'Deal of the day', 'admin/deal/day', 'admin', NULL, NULL),
(23, 'Language', 'admin/business-settings/language', 'admin', NULL, NULL),
(24, 'Mail', 'admin/business-settings/mail', 'admin', NULL, NULL),
(25, 'Shipping method', 'admin/business-settings/shipping-method/add', 'admin', NULL, NULL),
(26, 'Currency', 'admin/currency/view', 'admin', NULL, NULL),
(27, 'Payment method', 'admin/business-settings/payment-method', 'admin', NULL, NULL),
(28, 'SMS Gateway', 'admin/business-settings/sms-gateway', 'admin', NULL, NULL),
(29, 'Support Ticket', 'admin/support-ticket/view', 'admin', NULL, NULL),
(30, 'FAQ', 'admin/helpTopic/list', 'admin', NULL, NULL),
(31, 'About Us', 'admin/business-settings/about-us', 'admin', NULL, NULL),
(32, 'Terms and Conditions', 'admin/business-settings/terms-condition', 'admin', NULL, NULL),
(33, 'Web Config', 'admin/business-settings/web-config', 'admin', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
CREATE TABLE IF NOT EXISTS `sellers` (
  `seller_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `empoyee_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `is_superSeller` tinyint(4) DEFAULT '1',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `branch` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auth_token` text COLLATE utf8mb4_unicode_ci,
  `sales_commission_percentage` double(8,2) DEFAULT NULL,
  `gst` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cm_firebase_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`seller_id`) USING BTREE,
  UNIQUE KEY `sellers_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`seller_id`, `id`, `f_name`, `l_name`, `phone`, `empoyee_number`, `image`, `email`, `password`, `status`, `is_superSeller`, `remember_token`, `bank_name`, `branch`, `account_no`, `holder_name`, `auth_token`, `sales_commission_percentage`, `gst`, `cm_firebase_token`, `created_at`, `updated_at`) VALUES
(1, 32802426, 'Festus', 'Bett', '254722229862', 'fhhf', '2022-02-07-6201275f0ba12.png', 'festusbet@gmail.com', '$2y$10$/cqh88KuxFK24dO1MNcSved0CnzJXCog4aTW3nTUkORLPq6o0fuqC', 'approved', 1, 'cvuYVQVYDVjemGqrXQ77eYtUAdMzPVIGfVTKoVNpHFzX7vOAUwCkcR6D1NY0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 14:06:23', '2022-02-07 14:08:03'),
(2, 32802426, 'Joe', 'Doe', '254720651492', '1492', 'def.png', 'festusbetd@gmail.com', '$2y$10$bRmhU64gaCOqFGspGdBWAeNUDo/P8YCFJfkJyOEgdSODDmTlNJwXm', 'pending', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-02-07 14:22:01', '2022-02-07 14:22:01');

-- --------------------------------------------------------

--
-- Table structure for table `seller_wallets`
--

DROP TABLE IF EXISTS `seller_wallets`;
CREATE TABLE IF NOT EXISTS `seller_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) DEFAULT NULL,
  `total_earning` double NOT NULL DEFAULT '0',
  `withdrawn` double NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `commission_given` double(8,2) NOT NULL DEFAULT '0.00',
  `pending_withdraw` double(8,2) NOT NULL DEFAULT '0.00',
  `delivery_charge_earned` double(8,2) NOT NULL DEFAULT '0.00',
  `collected_cash` double(8,2) NOT NULL DEFAULT '0.00',
  `total_tax_collected` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seller_wallets`
--

INSERT INTO `seller_wallets` (`id`, `seller_id`, `total_earning`, `withdrawn`, `created_at`, `updated_at`, `commission_given`, `pending_withdraw`, `delivery_charge_earned`, `collected_cash`, `total_tax_collected`) VALUES
(1, 1, 0, 0, '2022-02-07 14:06:23', '2022-02-07 14:06:23', 0.00, 0.00, 0.00, 0.00, 0.00),
(2, 32802426, 12, 0, '2022-02-07 14:08:26', '2022-02-15 17:00:07', 0.00, 0.00, 5.00, 6.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `seller_wallet_histories`
--

DROP TABLE IF EXISTS `seller_wallet_histories`;
CREATE TABLE IF NOT EXISTS `seller_wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `payment` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'received',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_addresses`
--

DROP TABLE IF EXISTS `shipping_addresses`;
CREATE TABLE IF NOT EXISTS `shipping_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_billing` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_addresses`
--

INSERT INTO `shipping_addresses` (`id`, `customer_id`, `contact_person_name`, `delivery_date`, `delivery_time`, `address_type`, `address`, `city`, `zip`, `phone`, `created_at`, `updated_at`, `state`, `country`, `latitude`, `longitude`, `is_billing`) VALUES
(4, '10', 'Festus Bett', NULL, NULL, 'home', 'TESTTS', 'SORIK', '5536', '254722229862', '2022-02-14 09:36:46', '2022-02-14 09:36:46', NULL, 'KENYA', '', '', 0),
(5, '10', 'fESTUS', '2022-02-14', '13:37', 'home', 'TEST', 'SORIK', '20302', '254722229862', '2022-02-14 09:38:21', '2022-02-14 09:38:21', NULL, 'KENYA', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `shipping_methods`
--

DROP TABLE IF EXISTS `shipping_methods`;
CREATE TABLE IF NOT EXISTS `shipping_methods` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `creator_id` bigint(20) DEFAULT NULL,
  `creator_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost` decimal(8,2) NOT NULL DEFAULT '0.00',
  `duration` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `shop_openings` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shop_closed_days` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shop_opening_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shop_closing_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_methods`
--

INSERT INTO `shipping_methods` (`id`, `creator_id`, `creator_type`, `title`, `cost`, `duration`, `status`, `shop_openings`, `shop_closed_days`, `shop_opening_time`, `shop_closing_time`, `created_at`, `updated_at`) VALUES
(9, 32802426, 'seller', 'Upper Hills', '1.00', '1-2 Days', 1, NULL, NULL, NULL, NULL, '2022-02-07 19:42:04', '2022-02-07 19:42:04'),
(10, 1, 'admin', 'Langata', '1.00', '2-5 Days(Exclude Sun', 1, 'Monday - Friday', 'Saturday & Sunday ', '9:00', '5:00', '2022-02-07 19:40:34', '2022-02-07 19:40:34'),
(11, 1, 'admin', 'Wetlands', '2.00', '1 Day', 1, 'Monday - Thursday', 'Public Holidays ,Monday & Sunday ', '10:00 AM', '6:00 PM', '2022-02-07 19:40:34', '2022-02-07 19:40:34');

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
CREATE TABLE IF NOT EXISTS `shops` (
  `seller_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `banner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`seller_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`seller_id`, `id`, `name`, `address`, `contact`, `image`, `created_at`, `updated_at`, `banner`) VALUES
(32802426, 32802426, 'Shop Info', 'Shop Info', '254722229862', '2022-02-07-6201275f1a90d.png', '2022-02-07 14:06:23', '2022-02-07 14:06:23', '2022-02-07-6201275f1b2b9.png');

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

DROP TABLE IF EXISTS `social_medias`;
CREATE TABLE IF NOT EXISTS `social_medias` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `social_medias`
--

INSERT INTO `social_medias` (`id`, `name`, `link`, `icon`, `active_status`, `status`, `created_at`, `updated_at`) VALUES
(1, 'twitter', 'https://www.w3schools.com/howto/howto_css_table_responsive.asp', 'fa fa-twitter', 1, 1, '2020-12-31 21:18:03', '2020-12-31 21:18:25'),
(2, 'linkedin', 'https://dev.6amtech.com/', 'fa fa-linkedin', 1, 1, '2021-02-27 16:23:01', '2021-02-27 16:23:05'),
(3, 'google-plus', 'https://dev.6amtech.com/', 'fa fa-google-plus-square', 1, 1, '2021-02-27 16:23:30', '2021-02-27 16:23:33'),
(4, 'pinterest', 'https://dev.6amtech.com/', 'fa fa-pinterest', 1, 1, '2021-02-27 16:24:14', '2021-02-27 16:24:26'),
(5, 'instagram', 'https://dev.6amtech.com/', 'fa fa-instagram', 1, 1, '2021-02-27 16:24:36', '2021-02-27 16:24:41'),
(6, 'facebook', 'facebook.com', 'fa fa-facebook', 1, 1, '2021-02-27 19:19:42', '2021-06-11 17:41:59');

-- --------------------------------------------------------

--
-- Table structure for table `soft_credentials`
--

DROP TABLE IF EXISTS `soft_credentials`;
CREATE TABLE IF NOT EXISTS `soft_credentials` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
CREATE TABLE IF NOT EXISTS `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `subject` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'low',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reply` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_convs`
--

DROP TABLE IF EXISTS `support_ticket_convs`;
CREATE TABLE IF NOT EXISTS `support_ticket_convs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `support_ticket_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `customer_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `payment_for` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payer_id` bigint(20) DEFAULT NULL,
  `payment_receiver_id` bigint(20) DEFAULT NULL,
  `paid_by` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_to` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `amount` double(8,2) NOT NULL DEFAULT '0.00',
  `transaction_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `transactions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
CREATE TABLE IF NOT EXISTS `translations` (
  `translationable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `translationable_id` bigint(20) UNSIGNED NOT NULL,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `translations_translationable_id_index` (`translationable_id`),
  KEY `translations_locale_index` (`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `f_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `l_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'def.png',
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `street_address` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `house_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apartment_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cm_firebase_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `payment_card_last_four` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_card_fawry_token` text COLLATE utf8mb4_unicode_ci,
  `login_medium` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_phone_verified` tinyint(1) NOT NULL DEFAULT '0',
  `temporary_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other_phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `county` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kra_pin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type_category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organic_land_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `f_name`, `l_name`, `phone`, `image`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `street_address`, `country`, `city`, `zip`, `house_no`, `apartment_no`, `cm_firebase_token`, `is_active`, `payment_card_last_four`, `payment_card_brand`, `payment_card_fawry_token`, `login_medium`, `social_id`, `is_phone_verified`, `temporary_token`, `is_email_verified`, `gender`, `other_phone_number`, `user_industry`, `county`, `user_id`, `dob`, `marital_status`, `kra_pin`, `user_type`, `user_type_category`, `user_type_name`, `land_size`, `organic_land_size`) VALUES
(10, NULL, 'Festus', 'Bett', '254722229862', 'def.png', 'festusbet@gmail.com', NULL, '$2y$10$9Smm01jYE5SmUvkrF6CHSuHQZYN2B0javmZasz6.5YOrUk70BXM8G', 'AzWT3yX2oF6C16ZUyqfNsbXUMwo1l1dKIMKygrbIapLSppJJ3J4omEisJtOm', '2022-02-14 04:05:18', '2022-02-14 04:05:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 'Male', NULL, 'Yes', 'Bomet', '32802426', NULL, NULL, NULL, NULL, 'Trader', NULL, NULL, NULL),
(11, NULL, 'Festssuus', 'gggag', '25462662627', 'def.png', 'festusbetdd@gmail.com', NULL, '$2y$10$vxncrTcOG/p643mfMV/3/.HLdgVDsaODrtwg8mpe.mGiQFcBUyg9e', NULL, '2022-02-15 19:17:30', '2022-02-15 19:17:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, 'Male', NULL, 'volvo', 'Baringo', 'gggag', NULL, NULL, NULL, NULL, 'Trader', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE IF NOT EXISTS `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

DROP TABLE IF EXISTS `withdraw_requests`;
CREATE TABLE IF NOT EXISTS `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) DEFAULT NULL,
  `admin_id` bigint(20) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0.00',
  `transaction_note` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
