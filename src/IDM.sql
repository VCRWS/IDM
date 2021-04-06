-- MySQL dump 10.13  Distrib 5.7.32, for Linux (x86_64)
--
-- Host: localhost    Database: vcrws_db
-- ------------------------------------------------------
-- Server version	5.7.32-log

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `VariableID` smallint(5) NOT NULL,
  `DataValue` double NOT NULL,
  `CategoryDescription` text NOT NULL,
  KEY `VariableID` (`VariableID`),
  CONSTRAINT `FK_Categories_Variables` FOREIGN KEY (`VariableID`) REFERENCES `variables` (`VariableID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `censorcodecv`
--

DROP TABLE IF EXISTS `censorcodecv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `censorcodecv` (
  `CensorCodeID` tinyint(1) NOT NULL,
  `Term` varchar(3) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`CensorCodeID`) USING BTREE,
  UNIQUE KEY `UC_CensorTerm` (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datalogs`
--

DROP TABLE IF EXISTS `datalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datalogs` (
  `LogID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `LocalDateTime` datetime NOT NULL,
  `Username` varchar(25) NOT NULL,
  `EventType` varchar(50) NOT NULL,
  `ODMDataInfo` text,
  `IsRemoved` tinyint(1) NOT NULL DEFAULT '0',
  `RemovedDate` datetime DEFAULT NULL,
  `RemovedUser` varchar(25) DEFAULT NULL,
  `NumValues` int(11) DEFAULT NULL,
  `NumFiles` tinyint(1) NOT NULL DEFAULT '0',
  `Status` varchar(25) NOT NULL DEFAULT 'Incomplete Upload',
  PRIMARY KEY (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datatypecv`
--

DROP TABLE IF EXISTS `datatypecv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datatypecv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datavalues`
--

DROP TABLE IF EXISTS `datavalues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datavalues` (
  `ValueID` int(11) NOT NULL AUTO_INCREMENT,
  `DataValue` double NOT NULL,
  `LocalDateTime` datetime NOT NULL,
  `UTCOffset` tinyint(1) NOT NULL,
  `SourceID` tinyint(1) NOT NULL,
  `SiteID` smallint(5) NOT NULL,
  `VariableID` smallint(5) NOT NULL,
  `MethodID` smallint(5) NOT NULL DEFAULT '1',
  `QualityControlLevelID` smallint(5) NOT NULL DEFAULT '0',
  `LogID` mediumint(8) NOT NULL DEFAULT '1',
  `EventTypeID` smallint(5) NOT NULL DEFAULT '1',
  `SampleTypeID` tinyint(1) NOT NULL DEFAULT '1',
  `DetectionLimit` double DEFAULT NULL,
  `CensorCodeID` tinyint(1) NOT NULL DEFAULT '0',
  `SampleLocationID` smallint(5) NOT NULL,
  PRIMARY KEY (`ValueID`),
  KEY `FK_DataValues_Sites` (`SiteID`),
  KEY `FK_DataValues_Sources` (`SourceID`),
  KEY `FK_DataValues_Variables` (`VariableID`),
  KEY `FK_DataValues_eventtypeid` (`EventTypeID`),
  KEY `FK_DataValues_logid` (`LogID`),
  KEY `FK_DataValues_methods` (`MethodID`),
  KEY `FK_DataValues_qualitycontrollevels` (`QualityControlLevelID`),
  KEY `FK_DataValues_samplelocationid` (`SampleLocationID`),
  KEY `FK_DataValues_sampletypeid` (`SampleTypeID`),
  KEY `CensorCodeID` (`CensorCodeID`),
  CONSTRAINT `FK_DataValues_Sites` FOREIGN KEY (`SiteID`) REFERENCES `sites` (`SiteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_Sources` FOREIGN KEY (`SourceID`) REFERENCES `sources` (`SourceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_Variables` FOREIGN KEY (`VariableID`) REFERENCES `variables` (`VariableID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_censorcodeid` FOREIGN KEY (`CensorCodeID`) REFERENCES `censorcodecv` (`CensorCodeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_eventtypeid` FOREIGN KEY (`EventTypeID`) REFERENCES `eventtype` (`EventTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_logid` FOREIGN KEY (`LogID`) REFERENCES `datalogs` (`LogID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_methods` FOREIGN KEY (`MethodID`) REFERENCES `methods` (`MethodID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_qualitycontrollevels` FOREIGN KEY (`QualityControlLevelID`) REFERENCES `qualitycontrollevels` (`QualityControlLevelID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_samplelocationid` FOREIGN KEY (`SampleLocationID`) REFERENCES `samplelocation` (`SampleLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_DataValues_sampletypeid` FOREIGN KEY (`SampleTypeID`) REFERENCES `sampletype` (`SampleTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=138339820 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eventtype`
--

DROP TABLE IF EXISTS `eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventtype` (
  `EventTypeID` smallint(5) NOT NULL AUTO_INCREMENT,
  `EventTypeCode` varchar(3) NOT NULL,
  `EventTypeName` varchar(25) NOT NULL,
  `Definition` varchar(255) NOT NULL,
  PRIMARY KEY (`EventTypeID`),
  UNIQUE KEY `UC_EventTypeCode` (`EventTypeCode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `FeedbackID` int(6) NOT NULL AUTO_INCREMENT,
  `LocalDateTime` datetime NOT NULL,
  `FeedbackText` text NOT NULL,
  PRIMARY KEY (`FeedbackID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fileuploads`
--

DROP TABLE IF EXISTS `fileuploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileuploads` (
  `FileID` int(11) NOT NULL AUTO_INCREMENT,
  `LogID` mediumint(8) NOT NULL,
  `FileDirectory` varchar(255) NOT NULL,
  `FileName` varchar(255) NOT NULL,
  `FileSize` double NOT NULL,
  `IsRemoved` tinyint(1) NOT NULL DEFAULT '0',
  `RemovedDate` datetime DEFAULT NULL,
  `RemovedUser` varchar(25) DEFAULT NULL,
  `LocalDateTime` datetime NOT NULL DEFAULT '2019-05-05 00:00:00',
  `Username` varchar(25) NOT NULL DEFAULT 'his_admin',
  PRIMARY KEY (`FileID`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `generalcategorycv`
--

DROP TABLE IF EXISTS `generalcategorycv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `generalcategorycv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `isometadata`
--

DROP TABLE IF EXISTS `isometadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `isometadata` (
  `MetadataID` tinyint(1) NOT NULL AUTO_INCREMENT,
  `TopicCategory` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Title` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Abstract` text NOT NULL,
  `ProfileVersion` varchar(255) NOT NULL DEFAULT 'Unknown',
  `MetadataLink` text,
  PRIMARY KEY (`MetadataID`),
  KEY `TopicCategory` (`TopicCategory`),
  CONSTRAINT `FK_isometadata_topiccategorycv` FOREIGN KEY (`TopicCategory`) REFERENCES `topiccategorycv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locationvariables`
--

DROP TABLE IF EXISTS `locationvariables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locationvariables` (
  `LocationVarID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `SampleLocationID` smallint(5) NOT NULL,
  `VariableID` smallint(5) NOT NULL,
  `NumLogs` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`LocationVarID`),
  UNIQUE KEY `UN_SampID_VarID` (`SampleLocationID`,`VariableID`),
  KEY `FK_LocationVariables_VariableID` (`VariableID`),
  CONSTRAINT `FK_LocationVariables_SampleLocationID` FOREIGN KEY (`SampleLocationID`) REFERENCES `samplelocation` (`SampleLocationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_LocationVariables_VariableID` FOREIGN KEY (`VariableID`) REFERENCES `variables` (`VariableID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1729 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `methods`
--

DROP TABLE IF EXISTS `methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `methods` (
  `MethodID` smallint(5) NOT NULL AUTO_INCREMENT,
  `MethodDescription` varchar(50) NOT NULL,
  `MethodLink` text,
  `MethodCode` varchar(50) NOT NULL,
  PRIMARY KEY (`MethodID`),
  UNIQUE KEY `UC_MethodCode` (`MethodCode`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moss_users`
--

DROP TABLE IF EXISTS `moss_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moss_users` (
  `UserID` smallint(5) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL,
  `authority` enum('admin','restricted','unrestricted','coordinator','superadmin') NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `UserID` (`UserID`),
  UNIQUE KEY `UC_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `NoteID` int(11) NOT NULL AUTO_INCREMENT,
  `LogID` mediumint(8) NOT NULL,
  `LocalDateTime` datetime NOT NULL,
  `Username` varchar(25) NOT NULL,
  `NoteText` varchar(2000) NOT NULL,
  `IsEditable` tinyint(1) NOT NULL DEFAULT '0',
  `UserEdited` tinyint(1) NOT NULL DEFAULT '0',
  `EditLocalDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`NoteID`),
  KEY `FK_Notes_logid` (`LogID`),
  CONSTRAINT `FK_Notes_logid` FOREIGN KEY (`LogID`) REFERENCES `datalogs` (`LogID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offsettypes`
--

DROP TABLE IF EXISTS `offsettypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offsettypes` (
  `OffsetTypeID` smallint(5) NOT NULL AUTO_INCREMENT,
  `OffsetunitsID` smallint(5) NOT NULL,
  `OffsetDescription` text NOT NULL,
  `OffsetTypeCode` varchar(50) NOT NULL,
  PRIMARY KEY (`OffsetTypeID`),
  UNIQUE KEY `UC_Code` (`OffsetTypeCode`),
  KEY `OffsetunitsID` (`OffsetunitsID`),
  CONSTRAINT `FK_OffsetTypes_units` FOREIGN KEY (`OffsetunitsID`) REFERENCES `units` (`unitsID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qualitycontrollevels`
--

DROP TABLE IF EXISTS `qualitycontrollevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qualitycontrollevels` (
  `QualityControlLevelID` smallint(5) NOT NULL,
  `QualityControlLevelCode` varchar(50) NOT NULL,
  `Definition` varchar(255) NOT NULL,
  `Explanation` text NOT NULL,
  PRIMARY KEY (`QualityControlLevelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `samplelocation`
--

DROP TABLE IF EXISTS `samplelocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `samplelocation` (
  `SampleLocationID` smallint(5) NOT NULL AUTO_INCREMENT,
  `SiteID` smallint(5) NOT NULL,
  `SiteCode` varchar(25) NOT NULL,
  `SampleLocationCode` varchar(25) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `SampleMedium` varchar(50) NOT NULL DEFAULT 'Unknown',
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  PRIMARY KEY (`SampleLocationID`),
  UNIQUE KEY `UC_SampleLocationCode` (`SampleLocationCode`),
  KEY `FK_SampleLocationSiteID_siteid` (`SiteID`),
  CONSTRAINT `FK_SampleLocationSiteID_siteid` FOREIGN KEY (`SiteID`) REFERENCES `sites` (`SiteID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `samplemediumcv`
--

DROP TABLE IF EXISTS `samplemediumcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `samplemediumcv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sampletype`
--

DROP TABLE IF EXISTS `sampletype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sampletype` (
  `SampleTypeID` tinyint(1) NOT NULL AUTO_INCREMENT,
  `SampleTypeCode` varchar(25) NOT NULL,
  `SampleTypeName` varchar(25) NOT NULL,
  `Definition` varchar(255) NOT NULL,
  PRIMARY KEY (`SampleTypeID`),
  UNIQUE KEY `UC_SampleTypeCode` (`SampleTypeCode`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sharing`
--

DROP TABLE IF EXISTS `sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sharing` (
  `SharingPermissionID` smallint(5) NOT NULL AUTO_INCREMENT,
  `UserID` smallint(5) NOT NULL,
  `GrantedByUsername` varchar(256) NOT NULL,
  `Sites` text NOT NULL,
  `SampleLocations` text NOT NULL,
  `Variables` text NOT NULL,
  `DateStart` datetime NOT NULL,
  `DateEnd` datetime NOT NULL,
  `Expires` tinyint(1) NOT NULL,
  `ExpirationDate` datetime DEFAULT NULL,
  PRIMARY KEY (`SharingPermissionID`),
  UNIQUE KEY `UserID` (`UserID`),
  KEY `FK_GrantedByUserID` (`GrantedByUsername`),
  CONSTRAINT `FK_GrantedByUserID` FOREIGN KEY (`GrantedByUsername`) REFERENCES `moss_users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserID` FOREIGN KEY (`UserID`) REFERENCES `moss_users` (`UserID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitepic`
--

DROP TABLE IF EXISTS `sitepic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitepic` (
  `siteid` varchar(50) CHARACTER SET utf8 NOT NULL,
  `picname` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`siteid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores different picture for various sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `SiteID` smallint(5) NOT NULL AUTO_INCREMENT,
  `SiteCode` varchar(50) NOT NULL,
  `SiteName` varchar(255) NOT NULL,
  `Latitude` double NOT NULL,
  `Longitude` double NOT NULL,
  `LatLongDatumID` int(11) NOT NULL DEFAULT '0',
  `SiteType` varchar(255) DEFAULT NULL,
  `Elevation_m` double DEFAULT NULL,
  `VerticalDatum` varchar(255) DEFAULT NULL,
  `LocalX` double DEFAULT NULL,
  `LocalY` double DEFAULT NULL,
  `LocalProjectionID` int(11) DEFAULT NULL,
  `PosAccuracy_m` double DEFAULT NULL,
  `State` varchar(255) DEFAULT NULL,
  `County` varchar(255) DEFAULT NULL,
  `Comments` text,
  `SourceID` tinyint(1) NOT NULL DEFAULT '2',
  PRIMARY KEY (`SiteID`),
  UNIQUE KEY `AK_Sites_SiteCode` (`SiteCode`),
  KEY `VerticalDatum` (`VerticalDatum`),
  KEY `LatLongDatumID` (`LatLongDatumID`),
  KEY `LocalProjectionID` (`LocalProjectionID`),
  KEY `SiteType` (`SiteType`),
  KEY `FK_Sites_source` (`SourceID`),
  CONSTRAINT `FK_Sites_sitetypecv` FOREIGN KEY (`SiteType`) REFERENCES `sitetypecv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sites_source` FOREIGN KEY (`SourceID`) REFERENCES `sources` (`SourceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sites_spatialreferences` FOREIGN KEY (`LatLongDatumID`) REFERENCES `spatialreferences` (`SpatialReferenceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sites_spatialreferences1` FOREIGN KEY (`LocalProjectionID`) REFERENCES `spatialreferences` (`SpatialReferenceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sites_verticaldatumcv` FOREIGN KEY (`VerticalDatum`) REFERENCES `verticaldatumcv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitetypecv`
--

DROP TABLE IF EXISTS `sitetypecv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitetypecv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sources`
--

DROP TABLE IF EXISTS `sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sources` (
  `SourceID` tinyint(1) NOT NULL AUTO_INCREMENT,
  `Organization` varchar(255) NOT NULL,
  `SourceDescription` text NOT NULL,
  `SourceLink` text,
  `ContactName` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Phone` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Email` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Address` varchar(255) NOT NULL DEFAULT 'Unknown',
  `City` varchar(255) NOT NULL DEFAULT 'Unknown',
  `State` varchar(255) NOT NULL DEFAULT 'Unknown',
  `ZipCode` varchar(255) NOT NULL DEFAULT 'Unknown',
  `Citation` text NOT NULL,
  `MetadataID` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SourceID`),
  KEY `MetadataID` (`MetadataID`),
  CONSTRAINT `FK_Sources_ISOMetaData` FOREIGN KEY (`MetadataID`) REFERENCES `isometadata` (`MetadataID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spatialreferences`
--

DROP TABLE IF EXISTS `spatialreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spatialreferences` (
  `SpatialReferenceID` int(11) NOT NULL,
  `SRSID` int(11) DEFAULT NULL,
  `SRSName` varchar(255) NOT NULL,
  `IsGeographic` tinyint(1) DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`SpatialReferenceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `speciationcv`
--

DROP TABLE IF EXISTS `speciationcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `speciationcv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `topiccategorycv`
--

DROP TABLE IF EXISTS `topiccategorycv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topiccategorycv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `unitsID` smallint(5) NOT NULL AUTO_INCREMENT,
  `unitsName` varchar(255) NOT NULL,
  `unitsType` varchar(255) NOT NULL,
  `unitsAbbreviation` varchar(25) NOT NULL,
  PRIMARY KEY (`unitsID`)
) ENGINE=InnoDB AUTO_INCREMENT=410 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `valuetypecv`
--

DROP TABLE IF EXISTS `valuetypecv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuetypecv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variablenamecv`
--

DROP TABLE IF EXISTS `variablenamecv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variablenamecv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variables` (
  `VariableID` smallint(5) NOT NULL AUTO_INCREMENT,
  `VariableCode` varchar(50) NOT NULL,
  `VariableName` varchar(255) NOT NULL,
  `Speciation` varchar(255) NOT NULL DEFAULT 'Not Applicable',
  `VariableunitsID` smallint(5) NOT NULL,
  `SampleMedium` varchar(255) NOT NULL DEFAULT 'Unknown',
  `ValueType` varchar(255) NOT NULL DEFAULT 'Unknown',
  `IsRegular` tinyint(1) NOT NULL DEFAULT '0',
  `TimeSupport` double NOT NULL DEFAULT '0',
  `TimeunitsID` smallint(5) NOT NULL DEFAULT '0',
  `DataType` varchar(255) NOT NULL DEFAULT 'Unknown',
  `GeneralCategory` varchar(255) NOT NULL DEFAULT 'Unknown',
  `NoDataValue` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`VariableID`),
  UNIQUE KEY `AK_Variables_VariableCode` (`VariableCode`),
  KEY `VariableunitsID` (`VariableunitsID`),
  KEY `TimeunitsID` (`TimeunitsID`),
  KEY `DataType` (`DataType`),
  KEY `GeneralCategory` (`GeneralCategory`),
  KEY `SampleMedium` (`SampleMedium`),
  KEY `ValueType` (`ValueType`),
  KEY `VariableName` (`VariableName`),
  KEY `Speciation` (`Speciation`),
  CONSTRAINT `FK_Variables_GeneralCategoryCV` FOREIGN KEY (`GeneralCategory`) REFERENCES `generalcategorycv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_datatypecv` FOREIGN KEY (`DataType`) REFERENCES `datatypecv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_samplemediumcv` FOREIGN KEY (`SampleMedium`) REFERENCES `samplemediumcv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_speciationcv` FOREIGN KEY (`Speciation`) REFERENCES `speciationcv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_units` FOREIGN KEY (`VariableunitsID`) REFERENCES `units` (`unitsID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_Variables_unitsTime` FOREIGN KEY (`TimeunitsID`) REFERENCES `units` (`unitsID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_valuetypecv` FOREIGN KEY (`ValueType`) REFERENCES `valuetypecv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_Variables_variablenamecv` FOREIGN KEY (`VariableName`) REFERENCES `variablenamecv` (`Term`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `varmeth`
--

DROP TABLE IF EXISTS `varmeth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `varmeth` (
  `VariableID` varchar(50) NOT NULL,
  `VariableCode` varchar(25) NOT NULL,
  `VariableName` varchar(50) NOT NULL,
  `DataType` varchar(50) NOT NULL,
  `MethodID` varchar(50) DEFAULT NULL,
  UNIQUE KEY `UC_VariableID` (`VariableID`),
  KEY `VariableID` (`VariableID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Index to connect variables to specific methods for narrowing';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verticaldatumcv`
--

DROP TABLE IF EXISTS `verticaldatumcv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verticaldatumcv` (
  `Term` varchar(255) NOT NULL,
  `Definition` text,
  PRIMARY KEY (`Term`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-06 15:52:39
