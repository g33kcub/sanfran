-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 12, 2019 at 05:35 PM
-- Server version: 10.3.12-MariaDB-1:10.3.12+maria~stretch-log
-- PHP Version: 7.0.33-0+deb9u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inception`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `dijAddPath` (IN `pFromNodeName` VARCHAR(128), IN `pToNodeName` VARCHAR(128), IN `pCost` INT, IN `pType` VARCHAR(40))  BEGIN
  DECLARE vFromNodeID, vToNodeID, vPathID INT;
  SET vFromNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeName = pFromNodeName );
  IF vFromNodeID IS NULL THEN
    BEGIN
      INSERT INTO `entity_entities` (NodeName,Calculated) VALUES (pFromNodeName,0);
      SET vFromNodeID = LAST_INSERT_ID();
    END;
  END IF;
  SET vToNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeName = pToNodeName );
  IF vToNodeID IS NULL THEN
    BEGIN
      INSERT INTO `entity_entities`(NodeName, Calculated)  
      VALUES(pToNodeName,0);
      SET vToNodeID = LAST_INSERT_ID();
    END;
  END IF;
  SET vPathID = ( SELECT PathID FROM `entity_relationships`  
                  WHERE FromNodeID = vFromNodeID AND ToNodeID = vToNodeID AND PathType = pType
                );
  IF vPathID IS NULL THEN
    INSERT INTO `entity_relationships`(FromNodeID,ToNodeID,Cost,PathType)  
    VALUES(vFromNodeID,vToNodeID,pCost,pType);
  ELSE
    UPDATE `entity_relationships` SET Cost = pCost
    WHERE FromNodeID = vFromNodeID AND ToNodeID = vToNodeID AND PathType = pType;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dijResolve` (IN `pFromNodeVarID` VARCHAR(128), IN `pToNodeVarID` VARCHAR(128), IN `pTypes` VARCHAR(255))  BEGIN
  DECLARE vFromNodeID, vToNodeID, vNodeID, vCost, vPathID INT;
  DECLARE vFromNodeVarID, vToNodeVarID VARCHAR(128);
    UPDATE `entity_entities` SET PathID = NULL,Cost = NULL,Calculated = 0;
    SET vFromNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeID = pFromNodeVarID );
  IF vFromNodeID IS NULL THEN
    SELECT CONCAT('From node ID ', pFromNodeVarID, ' not found.' );  
  ELSE
    BEGIN
            SET vNodeID = vFromNodeID;
      SET vToNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeID = pToNodeVarID );
      IF vToNodeID IS NULL THEN
        SELECT CONCAT('From node ID ', pToNodeVarID, ' not found.' );
      ELSE
        BEGIN
                    UPDATE `entity_entities` SET Cost=0 WHERE NodeID = vFromNodeID;
          WHILE vNodeID IS NOT NULL DO
            BEGIN
              UPDATE  
                `entity_entities` AS src
                JOIN `entity_relationships` AS Paths ON Paths.FromNodeID = src.NodeID AND FIND_IN_SET(Paths.PathType, pTypes) > 0
                JOIN `entity_entities` AS dest ON dest.NodeID = Paths.ToNodeID
              SET dest.Cost = CASE
                                WHEN dest.Cost IS NULL THEN src.Cost + Paths.Cost
                                WHEN src.Cost + Paths.Cost < dest.Cost THEN src.Cost + Paths.Cost
                                ELSE dest.Cost
                              END,
                  dest.PathID = Paths.PathID
              WHERE  
                src.NodeID = vNodeID
                AND (dest.Cost IS NULL OR src.Cost + Paths.Cost < dest.Cost)
                AND dest.Calculated = 0;
       
              UPDATE `entity_entities` SET Calculated = 1 WHERE NodeID = vNodeID;
 
              SET vNodeID = ( SELECT nodeID FROM `entity_entities`
                              WHERE Calculated = 0 AND Cost IS NOT NULL
                              ORDER BY Cost LIMIT 1
                            );
            END;
          END WHILE;
        END;
      END IF;
    END;
  END IF;
  IF EXISTS( SELECT 1 FROM `entity_entities` WHERE NodeID = vToNodeID AND Cost IS NULL ) THEN
        SELECT CONCAT( 'Node ',vNodeID, ' missed.' );
  ELSE
    BEGIN
            DROP TEMPORARY TABLE IF EXISTS Map;
      CREATE TEMPORARY TABLE Map (
        RowID INT PRIMARY KEY AUTO_INCREMENT,
        FromNodeVarID VARCHAR(128),
        ToNodeVarID VARCHAR(128),
        Cost INT
      ) ENGINE=MEMORY;
      WHILE vFromNodeID <> vToNodeID DO
        BEGIN
          SELECT  
            src.NodeID,dest.NodeID,dest.Cost,dest.PathID
            INTO vFromNodeVarID, vToNodeVarID, vCost, vPathID
          FROM  
            `entity_entities` AS dest
            JOIN `entity_relationships` AS Paths ON Paths.PathID = dest.PathID AND FIND_IN_SET(Paths.PathType, pTypes)
            JOIN `entity_entities` AS src ON src.NodeID = Paths.FromNodeID
          WHERE dest.NodeID = vToNodeID;
           
          INSERT INTO Map(FromNodeVarID,ToNodeVarID,Cost) VALUES(vFromNodeVarID,vToNodeVarID,vCost);
           
          SET vToNodeID = (SELECT FromNodeID FROM `entity_relationships` WHERE PathID = vPathID AND FIND_IN_SET(PathType, pTypes) > 0);
        END;
      END WHILE;
      SELECT FromNodeVarID,ToNodeVarID,Cost FROM Map ORDER BY RowID DESC;
      DROP TEMPORARY TABLE Map;
    END;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dijResolveByName` (IN `pFromNodeName` VARCHAR(128), IN `pToNodeName` VARCHAR(128), IN `pTypes` VARCHAR(255))  BEGIN
  DECLARE vFromNodeID, vToNodeID, vNodeID, vCost, vPathID INT;
  DECLARE vFromNodeName, vToNodeName VARCHAR(128);
    UPDATE `entity_entities` SET PathID = NULL,Cost = NULL,Calculated = 0;
    SET vFromNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeName = pFromNodeName );
  IF vFromNodeID IS NULL THEN
    SELECT CONCAT('From node name ', pFromNodeName, ' not found.' );  
  ELSE
    BEGIN
            SET vNodeID = vFromNodeID;
      SET vToNodeID = ( SELECT NodeID FROM `entity_entities` WHERE NodeName = pToNodeName );
      IF vToNodeID IS NULL THEN
        SELECT CONCAT('From node name ', pToNodeName, ' not found.' );
      ELSE
        BEGIN
                    UPDATE `entity_entities` SET Cost=0 WHERE NodeID = vFromNodeID;
          WHILE vNodeID IS NOT NULL DO
            BEGIN
              UPDATE  
                `entity_entities` AS src
                JOIN `entity_relationships` AS Paths ON Paths.FromNodeID = src.NodeID AND FIND_IN_SET(Paths.PathType, pTypes) > 0
                JOIN `entity_entities` AS dest ON dest.NodeID = Paths.ToNodeID
              SET dest.Cost = CASE
                                WHEN dest.Cost IS NULL THEN src.Cost + Paths.Cost
                                WHEN src.Cost + Paths.Cost < dest.Cost THEN src.Cost + Paths.Cost
                                ELSE dest.Cost
                              END,
                  dest.PathID = Paths.PathID
              WHERE  
                src.NodeID = vNodeID
                AND (dest.Cost IS NULL OR src.Cost + Paths.Cost < dest.Cost)
                AND dest.Calculated = 0;
       
              UPDATE `entity_entities` SET Calculated = 1 WHERE NodeID = vNodeID;
 
              SET vNodeID = ( SELECT nodeID FROM `entity_entities`
                              WHERE Calculated = 0 AND Cost IS NOT NULL
                              ORDER BY Cost LIMIT 1
                            );
            END;
          END WHILE;
        END;
      END IF;
    END;
  END IF;
  IF EXISTS( SELECT 1 FROM `entity_entities` WHERE NodeID = vToNodeID AND Cost IS NULL ) THEN
        SELECT CONCAT( 'Node ',vNodeID, ' missed.' );
  ELSE
    BEGIN
            DROP TEMPORARY TABLE IF EXISTS Map;
      CREATE TEMPORARY TABLE Map (
        RowID INT PRIMARY KEY AUTO_INCREMENT,
        FromNodeName VARCHAR(128),
        ToNodeName VARCHAR(128),
        Cost INT
      ) ENGINE=MEMORY;
      WHILE vFromNodeID <> vToNodeID DO
        BEGIN
          SELECT  
            src.NodeName,dest.NodeName,dest.Cost,dest.PathID
            INTO vFromNodeName, vToNodeName, vCost, vPathID
          FROM  
            `entity_entities` AS dest
            JOIN `entity_relationships` AS Paths ON Paths.PathID = dest.PathID AND FIND_IN_SET(Paths.PathType, pTypes)
            JOIN `entity_entities` AS src ON src.NodeID = Paths.FromNodeID
          WHERE dest.NodeID = vToNodeID;
           
          INSERT INTO Map(FromNodeName,ToNodeName,Cost) VALUES(vFromNodeName,vToNodeName,vCost);
           
          SET vToNodeID = (SELECT FromNodeID FROM `entity_relationships` WHERE PathID = vPathID AND FIND_IN_SET(PathType, pTypes) > 0);
        END;
      END WHILE;
      SELECT FromNodeName,ToNodeName,Cost FROM Map ORDER BY RowID DESC;
      DROP TEMPORARY TABLE Map;
    END;
  END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReached` (IN `root` INT, IN `pTypes` VARCHAR(40))  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0  DO
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `ToNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS p ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = ROW_COUNT();
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `FromNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.ToNodeID = `p`.NodeID AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = `rows` + ROW_COUNT();
  END WHILE;
  SELECT `entity_reached`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`;
  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepth` (IN `root` INT, IN `pTypes` VARCHAR(40), IN `depthMax` INT)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > 0 DO
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `ToNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = ROW_COUNT();
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `FromNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = `rows` + ROW_COUNT();
    SET `depthMax` = `depthMax` - 1;
  END WHILE;
  SELECT `entity_reached`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`;
  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthIn` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > 0 DO
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `FromNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = ROW_COUNT();
    SET `depthMax` = `depthMax` - 1;
  END WHILE;
  SELECT `entity_reached`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`;
  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthInPage` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `numbers` BOOLEAN)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = `end`-`start`;
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > `depth` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `FromNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := 0;
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName`,FOUND_ROWS() as total,(FOUND_ROWS() - (@rownum := @rownum + 1) + 1) as `row` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`  ORDER BY `depth`,`row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`  ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthInPageWith2Arguments` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `filtercolumn` VARCHAR(40), IN `value` VARCHAR(40), IN `filtercolumn2` VARCHAR(40), IN `value2` VARCHAR(40), IN `numbers` BOOLEAN)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = IF((`end`-`start`) < 0, 0, (`end`-`start`));
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depth` < `depthMax` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `FromNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := 0;
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName`,FOUND_ROWS() as total,(FOUND_ROWS() - (@rownum := @rownum + 1) + 1) as `row` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn2`)=`value2` ORDER BY `depth`,`row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn2`)=`value2` ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthInPageWithArguments` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `filtercolumn` VARCHAR(40), IN `value` VARCHAR(40), IN `numbers` BOOLEAN)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = `end`-`start`;
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > `depth` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `FromNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := 0;
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName`,FOUND_ROWS() as total,(FOUND_ROWS() - (@rownum := @rownum + 1) + 1) as `row` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` ORDER BY `depth`,`row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthOut` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > 0 DO
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `ToNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = ROW_COUNT();
    SET `depthMax` = `depthMax` - 1;
  END WHILE;
  SELECT `entity_reached`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`;
  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthOutPage` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `numbers` INT)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = `end`-`start`;
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > `depth` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `ToNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := 0;
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName`,FOUND_ROWS() as total,(FOUND_ROWS() - (@rownum := @rownum + 1) + 1) as `row` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`  ORDER BY `depth`,`row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`  ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthOutPageWith2Arguments` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `filtercolumn` VARCHAR(40), IN `value` VARCHAR(40), IN `filtercolumn2` VARCHAR(40), IN `value2` VARCHAR(40), IN `numbers` BOOLEAN)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = `end`-`start`;
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > `depth` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `ToNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := 0;
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName`,FOUND_ROWS() as total,(FOUND_ROWS() - (@rownum := @rownum + 1) + 1) as `row` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn2`)=`value2` ORDER BY `depth`,`row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn2`)=`value2`  ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthOutPageWithArguments` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT, IN `filtercolumn` VARCHAR(40), IN `value` VARCHAR(40), IN `numbers` BOOLEAN)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  DECLARE `limit` int default 0;
  DECLARE `depth` int default 0;
  SET `uid` = UUID();
  SET `limit` = `end`-`start`;
  CREATE TABLE IF NOT EXISTS `entity_reached2` (
    `NodeID` int,
    `uuid` varchar(36),
    `depth` int,
    primary key (`NodeID`, `uuid`),
    INDEX(`depth`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached2` VALUES (`root`, `uid`,`depth`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > `depth` DO
    INSERT IGNORE INTO `entity_reached2`
      SELECT DISTINCT `ToNodeID`, `uid`,`depth`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached2` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`) AND `uid`=`p`.uuid;
    SET `rows` = ROW_COUNT();
    SET `depth` = `depth` + 1;
  END WHILE;
  IF `numbers` = 1 THEN
    SET @rownum := -1;
    SET @rowcount := (SELECT COUNT(*) FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` ORDER BY `depth`);
    SELECT *, @rowcount as `total`,(@rowcount - (@rownum := @rownum + 1)) as `row` FROM (SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` ORDER BY `depth`) as `inner` GROUP BY `NodeID` ORDER BY `row` DESC LIMIT `limit` OFFSET `start`;
  ELSE
    SELECT `entity_reached2`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached2` INNER JOIN `entity_entities` ON `entity_reached2`.`NodeID` = `entity_entities`.`NodeID` LEFT JOIN `entity_attributesjson` as `attributes` ON `entity_entities`.`NodeID`=`attributes`.`NodeID` WHERE `uuid` = `uid` AND JSON_EXTRACT(`attributes`.`Contents`,`filtercolumn`)=`value` ORDER BY `depth` LIMIT `limit` OFFSET `start`;
  END IF;
  DELETE FROM `entity_reached2` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedDepthPage` (IN `root` INT, IN `pTypes` VARCHAR(255), IN `depthMax` INT, IN `start` INT, IN `end` INT)  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();
  WHILE `rows` > 0 AND `depthMax` > 0 DO
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `ToNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = ROW_COUNT();
    INSERT IGNORE INTO `entity_reached`
      SELECT DISTINCT `FromNodeID`, `uid`
      FROM `entity_relationships` AS `e`
      INNER JOIN `entity_reached` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
    SET `rows` = `rows` + ROW_COUNT();
    SET `depthMax` = `depthMax` - 1;
  END WHILE;
  SELECT `RowTable`.`NodeID`,`RowTable`.`NodeName` FROM (
  SELECT (ROW_NUMBER() OVER ( ORDER BY `entity_entities`.`NodeID` ))-1 AS RowNum,`entity_reached`.`NodeID`,`entity_entities`.`NodeName` FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` WHERE `uuid` = `uid`) AS `RowTable` WHERE `RowTable`.`RowNum`>=`start` AND `RowTable`.`RowNum`<`end` ORDER BY `RowTable`.`RowNum`;
  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ListReachedMassInsert` (IN `SelectionDirection` VARCHAR(10), IN `InsertDirection` VARCHAR(10), IN `ConnectingNode` INT, IN `ConnectingType` VARCHAR(40), IN `root` INT, IN `pTypes` VARCHAR(255))  BEGIN
  DECLARE `rows` int DEFAULT 0;
  DECLARE `uid` varchar(36);
  SET `uid` = UUID();
  CREATE TABLE IF NOT EXISTS `entity_reached` (
    `NodeID` int,
    `uuid` varchar(36),
    primary key (`NodeID`, `uuid`)
  ) ENGINE=HEAP;
  INSERT INTO `entity_reached` VALUES (`root`, `uid`);
  SET `rows` = ROW_COUNT();

  IF `SelectionDirection` = "Forward"
  THEN
	  WHILE `rows` > 0 DO
	    INSERT IGNORE INTO `entity_reached`
	      SELECT DISTINCT `ToNodeID`, `uid`
	      FROM `entity_relationships` AS `e`
	      INNER JOIN `entity_reached` AS `p` ON `e`.`FromNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
	    SET `rows` = ROW_COUNT();
	  END WHILE;
  ELSE
	  WHILE `rows` > 0 DO
	    INSERT IGNORE INTO `entity_reached`
	      SELECT DISTINCT `FromNodeID`, `uid`
	      FROM `entity_relationships` AS `e`
	      INNER JOIN `entity_reached` AS `p` ON `e`.`ToNodeID` = `p`.`NodeID` AND FIND_IN_SET(`e`.`PathType`, `pTypes`);
	    SET `rows` = ROW_COUNT();
	  END WHILE;
  END IF;

  IF `InsertDirection` = "Forward"
  THEN
    INSERT IGNORE INTO `entity_relationships` (`FromNodeID`, `ToNodeID`, `PathType`)
    SELECT `ConnectingNode`, `entity_reached`.`NodeID`, `ConnectingType` 
    FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` 
    WHERE `uuid` = `uid`;
  ELSE
    INSERT IGNORE INTO `entity_relationships` (`FromNodeID`, `ToNodeID`, `PathType`)
    SELECT `entity_reached`.`NodeID`, `ConnectingNode`, `ConnectingType` 
    FROM `entity_reached` INNER JOIN `entity_entities` ON `entity_reached`.`NodeID` = `entity_entities`.`NodeID` 
    WHERE `uuid` = `uid`;
  END IF;

  DELETE FROM `entity_reached` WHERE `uuid` = `uid`;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `entity_attributesjson`
--

CREATE TABLE `entity_attributesjson` (
  `NodeID` int(11) NOT NULL,
  `Contents` text NOT NULL DEFAULT '\'\\\'{}\\\'\'',
  `x` int(11) GENERATED ALWAYS AS (json_unquote(json_extract(`Contents`,'$.edspace.x'))) STORED,
  `y` int(11) GENERATED ALWAYS AS (json_unquote(json_extract(`Contents`,'$.edspace.y'))) STORED,
  `z` int(11) GENERATED ALWAYS AS (json_unquote(json_extract(`Contents`,'$.edspace.z'))) STORED,
  `region` varchar(40) GENERATED ALWAYS AS (json_unquote(json_extract(`Contents`,'$.edspace.region'))) STORED
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entity_entities`
--

CREATE TABLE `entity_entities` (
  `NodeID` int(11) NOT NULL,
  `NodeName` varchar(128) NOT NULL,
  `Cost` int(11) DEFAULT NULL,
  `PathID` int(11) DEFAULT NULL,
  `Calculated` tinyint(4) DEFAULT NULL,
  `Type` varchar(40) NOT NULL,
  `Description` text DEFAULT NULL,
  `Objid` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entity_reached`
--

CREATE TABLE `entity_reached` (
  `NodeID` int(11) NOT NULL DEFAULT 0,
  `uuid` varchar(36) NOT NULL DEFAULT ''
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entity_reached2`
--

CREATE TABLE `entity_reached2` (
  `NodeID` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `depth` int(11) DEFAULT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entity_relationships`
--

CREATE TABLE `entity_relationships` (
  `PathID` int(11) NOT NULL,
  `FromNodeID` int(11) NOT NULL,
  `ToNodeID` int(11) NOT NULL,
  `Cost` int(11) NOT NULL DEFAULT 1,
  `PathType` varchar(40) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entity_relationship_attributesjson`
--

CREATE TABLE `entity_relationship_attributesjson` (
  `PathID` int(11) NOT NULL,
  `Contents` text NOT NULL DEFAULT '\'\\\'{}\\\'\''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `Event Listing`
-- (See below for the actual view)
--
CREATE TABLE `Event Listing` (
`NodeId` int(11)
,`NodeName` varchar(128)
,`Description` text
,`Contents` text
);

-- --------------------------------------------------------

--
-- Table structure for table `reached`
--

CREATE TABLE `reached` (
  `NodeID` int(11) NOT NULL,
  `uuid` varchar(36) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Stand-in structure for view `Scene List`
-- (See below for the actual view)
--
CREATE TABLE `Scene List` (
`NodeID` int(11)
,`NodeName` varchar(128)
,`Description` text
,`Contents` text
,`Creator` varchar(128)
);

-- --------------------------------------------------------

--
-- Structure for view `Event Listing`
--
DROP TABLE IF EXISTS `Event Listing`;

CREATE ALGORITHM=UNDEFINED DEFINER=`inception`@`%` SQL SECURITY INVOKER VIEW `Event Listing`  AS  select `entity_entities`.`NodeID` AS `NodeId`,`entity_entities`.`NodeName` AS `NodeName`,`entity_entities`.`Description` AS `Description`,json_extract(`entity_attributesjson`.`Contents`,'$.scene') AS `Contents` from (`entity_entities` join `entity_attributesjson` on(`entity_entities`.`NodeID` = `entity_attributesjson`.`NodeID`)) where `entity_entities`.`Type` = 'scene' and json_extract(`entity_attributesjson`.`Contents`,'$.scene.date') is not null ;

-- --------------------------------------------------------

--
-- Structure for view `Scene List`
--
DROP TABLE IF EXISTS `Scene List`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `Scene List`  AS  select `entity_entities`.`NodeID` AS `NodeID`,`entity_entities`.`NodeName` AS `NodeName`,`entity_entities`.`Description` AS `Description`,json_extract(`entity_attributesjson`.`Contents`,'$.scene') AS `Contents`,`ent2`.`NodeName` AS `Creator` from ((`entity_entities` join `entity_attributesjson` on(`entity_entities`.`NodeID` = `entity_attributesjson`.`NodeID`)) join `entity_entities` `ent2` on(cast(json_extract(`entity_attributesjson`.`Contents`,'$.scene.createdby') as unsigned) = `ent2`.`NodeID`)) where `entity_entities`.`Type` = 'scene' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `entity_attributesjson`
--
ALTER TABLE `entity_attributesjson`
  ADD PRIMARY KEY (`NodeID`),
  ADD UNIQUE KEY `Location` (`x`,`y`,`z`,`region`),
  ADD KEY `Area` (`x`,`y`,`region`),
  ADD KEY `Row` (`y`,`region`),
  ADD KEY `Column` (`x`,`region`);
ALTER TABLE `entity_attributesjson` ADD FULLTEXT KEY `Contents` (`Contents`);

--
-- Indexes for table `entity_entities`
--
ALTER TABLE `entity_entities`
  ADD PRIMARY KEY (`NodeID`),
  ADD UNIQUE KEY `EntityName` (`Type`,`NodeName`) USING BTREE,
  ADD KEY `Objid` (`Objid`),
  ADD KEY `Name_Objid` (`NodeName`,`Objid`),
  ADD KEY `Types` (`Type`);

--
-- Indexes for table `entity_reached`
--
ALTER TABLE `entity_reached`
  ADD PRIMARY KEY (`NodeID`,`uuid`),
  ADD KEY `NodeID` (`NodeID`),
  ADD KEY `UUID` (`uuid`);

--
-- Indexes for table `entity_reached2`
--
ALTER TABLE `entity_reached2`
  ADD PRIMARY KEY (`NodeID`,`uuid`),
  ADD KEY `NodeID` (`NodeID`),
  ADD KEY `UUID` (`uuid`);

--
-- Indexes for table `entity_relationships`
--
ALTER TABLE `entity_relationships`
  ADD PRIMARY KEY (`PathID`),
  ADD UNIQUE KEY `relationshipTypes_Cul` (`FromNodeID`,`ToNodeID`,`PathType`),
  ADD KEY `ToNodeID` (`ToNodeID`);

--
-- Indexes for table `entity_relationship_attributesjson`
--
ALTER TABLE `entity_relationship_attributesjson`
  ADD PRIMARY KEY (`PathID`) USING BTREE;
ALTER TABLE `entity_relationship_attributesjson` ADD FULLTEXT KEY `Contents` (`Contents`);

--
-- Indexes for table `reached`
--
ALTER TABLE `reached`
  ADD PRIMARY KEY (`NodeID`,`uuid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entity_entities`
--
ALTER TABLE `entity_entities`
  MODIFY `NodeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19208;
--
-- AUTO_INCREMENT for table `entity_relationships`
--
ALTER TABLE `entity_relationships`
  MODIFY `PathID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2560;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `entity_attributesjson`
--
ALTER TABLE `entity_attributesjson`
  ADD CONSTRAINT `attributes_ibfk_1` FOREIGN KEY (`NodeID`) REFERENCES `entity_entities` (`NodeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `entity_relationships`
--
ALTER TABLE `entity_relationships`
  ADD CONSTRAINT `entity_relationships_ibfk_1` FOREIGN KEY (`FromNodeID`) REFERENCES `entity_entities` (`NodeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `entity_relationships_ibfk_2` FOREIGN KEY (`ToNodeID`) REFERENCES `entity_entities` (`NodeID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `entity_relationship_attributesjson`
--
ALTER TABLE `entity_relationship_attributesjson`
  ADD CONSTRAINT `PathID` FOREIGN KEY (`PathID`) REFERENCES `entity_relationships` (`PathID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
