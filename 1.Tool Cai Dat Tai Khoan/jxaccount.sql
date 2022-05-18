/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50515
Source Host           : localhost:3306
Source Database       : jxaccount

Target Server Type    : MYSQL
Target Server Version : 50515
File Encoding         : 65001

Date: 2013-09-17 22:40:42
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `accid` int(11) NOT NULL AUTO_INCREMENT,
  `loginName` varchar(32) NOT NULL,
  `password_hash` varchar(32) NOT NULL,
  `xu` int(6) NOT NULL DEFAULT '0',
  `Coin` int(24) NOT NULL DEFAULT '0',
  `safecode` int(12) DEFAULT NULL,
  `cEMail` char(32) DEFAULT NULL,
  `cRealName` char(32) DEFAULT NULL COMMENT 'CMTND',
  `cQuestion` varchar(50) DEFAULT NULL,
  `cAnswer` varchar(50) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `checkMember` int(1) NOT NULL DEFAULT '1',
  `LockState` int(1) NOT NULL DEFAULT '0',
  `lockpassword` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`accid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- Table structure for `jxsf8_paycoin`
-- ----------------------------
DROP TABLE IF EXISTS `jxsf8_paycoin`;
CREATE TABLE `jxsf8_paycoin` (
  `accid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `jbcoin` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`accid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records of jxsf8_paycoin

-- ----------------------------
-- Table structure for `jxsf8_paylog`
-- ----------------------------
DROP TABLE IF EXISTS `jxsf8_paylog`;
CREATE TABLE `jxsf8_paylog` (
  `accid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `addcoin` int(11) unsigned NOT NULL DEFAULT '0',
  `time` varchar(30) NOT NULL,
  `CoinCardKey` varchar(50) DEFAULT NULL,
  `mathe` varchar(20) DEFAULT NULL,
  `loaithe` varchar(10) DEFAULT NULL,
  `menhgia` int(10) DEFAULT NULL,
  `user` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`accid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gb2312;

