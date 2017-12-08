/*
Navicat MySQL Data Transfer

Source Server         : mysal_scg
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : marketing_db

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-12-08 18:12:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for db_transaction
-- ----------------------------
DROP TABLE IF EXISTS `db_transaction`;
CREATE TABLE `db_transaction` (
  `dt_id int` int(11) NOT NULL AUTO_INCREMENT,
  `dt_clientNo` varchar(50) NOT NULL,
  `dt_money` int(11) NOT NULL,
  `dt_Datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`dt_id int`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of db_transaction
-- ----------------------------
INSERT INTO `db_transaction` VALUES ('1', 'u001', '10', '2017-12-01 00:00:01');
INSERT INTO `db_transaction` VALUES ('2', 'u002', '20', '2017-12-02 00:00:02');
INSERT INTO `db_transaction` VALUES ('3', 'u003', '15', '2017-12-03 00:00:05');
INSERT INTO `db_transaction` VALUES ('4', 'u004', '25', '2017-12-04 00:00:07');
INSERT INTO `db_transaction` VALUES ('5', 'u005', '15', '2017-12-05 15:31:59');
INSERT INTO `db_transaction` VALUES ('6', 'u006', '13', '2017-12-06 15:32:31');
INSERT INTO `db_transaction` VALUES ('7', 'u007', '19', '2017-12-07 15:32:44');
INSERT INTO `db_transaction` VALUES ('8', 'u008', '17', '2017-12-08 15:33:01');


CREATE DEFINER=`root`@`localhost` PROCEDURE `eport_Details`(IN YEAR INT, IN MONTH INT)
    COMMENT '报表详情'
BEGIN
	/**   获取这个月的天数**/
SET @DayOfMonth =DAYOFMONTH(LAST_DAY(CONCAT(CONVERT(2016,CHAR),'-',CONVERT(12,CHAR),'-01')));

SET @SQL = 'SELECT dt_clientNo ';
SET @I = 1;

WHILE @I <=@DayOfMonth DO
SET @SQL = CONCAT(
	@SQL,
	',[ ',
	CONVERT (@I, CHAR(10)),
	']=0 '
);
SET @I =@I + 1;
END
WHILE;
SELECT @SQL;

SET @SQL = CONCAT(
	@SQL,
	' INTO Tmp3  FROM  (SELECT   DISTINCT   NO   FROM   TEST)  X '
);
	
		SELECT @SQL;

PREPARE stm FROM @QSL;#预处理需要执行的动态SQL，其中stmt是一个变量
EXECUTE stm;#执行SQL语句   生成表结构并初试化为０
DEALLOCATE PREPARE stm;#释放掉预处理段

SET @SQL = ' ';
SET @I = 1;

WHILE @I <=@DayOfMonth DO
SET @SQL =CONCAT(@SQL,'UPDATE Tmp3 SET [ ',CAST(@I AS CHAR(10)),']=a.[Money] FROM  db_Transaction a,Tmp3  b  WHERE a.dt_clientNo=b.dt_clientNo AND  DAY(a.[dt_DateTime])= ',CAST(@I AS CHAR(10)));

SET @I =@I + 1;
END
WHILE;/**赋值**/

PREPARE stm FROM @QSL;#预处理需要执行的动态SQL，其中stm是一个变量
EXECUTE stm;#执行SQL语句  
DEALLOCATE PREPARE stm;#释放掉预处理段

		SELECT @SQL;

select * from Tmp3;

END
