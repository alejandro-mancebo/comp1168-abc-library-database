-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projschema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projschema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projschema` DEFAULT CHARACTER SET utf8 ;
USE `projschema` ;

-- -----------------------------------------------------
-- Table `projschema`.`creator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`creator` (
  `CreatorID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CreatorID`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`membership_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`membership_type` (
  `MembershipType` VARCHAR(45) NOT NULL,
  `ItemLimit` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`MembershipType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`customers` (
  `CustomerID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `ItemsBorrowed` VARCHAR(45) NULL DEFAULT NULL,
  `BalanceDue` DECIMAL(10,0) NULL DEFAULT NULL,
  `StreetNameNumber` VARCHAR(45) NOT NULL,
  `Apartment` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NOT NULL,
  `PostalCode` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  `Membership_MembershipType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_Customers_Membership1_idx` (`Membership_MembershipType` ASC) VISIBLE,
  CONSTRAINT `fk_Customers_Membership1`
    FOREIGN KEY (`Membership_MembershipType`)
    REFERENCES `projschema`.`membership_type` (`MembershipType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 100020
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`employees` (
  `EmployeeID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NULL DEFAULT NULL,
  `Salary` DECIMAL(10,0) NOT NULL,
  `StreetNumber` INT(11) NULL DEFAULT NULL,
  `StreetName` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NOT NULL,
  `PostalCode` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`producttype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`producttype` (
  `ProductType` VARCHAR(45) NOT NULL,
  `BorrowTimeLimit` INT(11) NOT NULL,
  PRIMARY KEY (`ProductType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`publishingcompany`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`publishingcompany` (
  `PublisherName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PublisherName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`librarycollection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`librarycollection` (
  `Index_Number` INT(11) NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `Edition` VARCHAR(45) NOT NULL,
  `CopiesAvailable` INT(11) NOT NULL,
  `TotalCopies` INT(11) NOT NULL,
  `Date_Released` DATE NULL DEFAULT NULL,
  `Publisher_PublisherName` VARCHAR(45) NOT NULL,
  `ProductType_ProductType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Index_Number`),
  INDEX `fk_LibraryCollection_Publisher1_idx` (`Publisher_PublisherName` ASC) VISIBLE,
  INDEX `fk_LibraryCollection_ProductType1_idx` (`ProductType_ProductType` ASC) VISIBLE,
  CONSTRAINT `fk_LibraryCollection_ProductType1`
    FOREIGN KEY (`ProductType_ProductType`)
    REFERENCES `projschema`.`producttype` (`ProductType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LibraryCollection_Publisher1`
    FOREIGN KEY (`Publisher_PublisherName`)
    REFERENCES `projschema`.`publishingcompany` (`PublisherName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 100000029
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`individual_items_in_collection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`individual_items_in_collection` (
  `Barcode` INT(11) NOT NULL,
  `LibraryCollection_Index_Number` INT(11) NOT NULL,
  PRIMARY KEY (`Barcode`),
  INDEX `fk_LoanableItems_IndividualItems_idx` (`LibraryCollection_Index_Number` ASC) VISIBLE,
  CONSTRAINT `fk_LoanableItems_IndividualItems`
    FOREIGN KEY (`LibraryCollection_Index_Number`)
    REFERENCES `projschema`.`librarycollection` (`Index_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`librarycollection_has_creator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`librarycollection_has_creator` (
  `LibraryCollection_IndexNumber` INT(11) NOT NULL,
  `Creator_CreatorID` INT(11) NOT NULL,
  PRIMARY KEY (`LibraryCollection_IndexNumber`, `Creator_CreatorID`),
  INDEX `fk_LibraryCollection_has_Author_Author1_idx` (`Creator_CreatorID` ASC) VISIBLE,
  INDEX `fk_LibraryCollection_has_Author_LibraryCollection1_idx` (`LibraryCollection_IndexNumber` ASC) VISIBLE,
  CONSTRAINT `fk_LibraryCollection_has_Author_Author1`
    FOREIGN KEY (`Creator_CreatorID`)
    REFERENCES `projschema`.`creator` (`CreatorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LibraryCollection_has_Author_LibraryCollection1`
    FOREIGN KEY (`LibraryCollection_IndexNumber`)
    REFERENCES `projschema`.`librarycollection` (`Index_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`subject` (
  `SubjectName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SubjectName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`librarycollection_has_subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`librarycollection_has_subject` (
  `LibraryCollection_IndexNumber` INT(11) NOT NULL,
  `Subject_SubjectName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Subject_SubjectName`, `LibraryCollection_IndexNumber`),
  INDEX `fk_LibraryCollection_has_Subject_Subject1_idx` (`Subject_SubjectName` ASC) VISIBLE,
  INDEX `fk_LibraryCollection_has_Subject_LibraryCollection1_idx` (`LibraryCollection_IndexNumber` ASC) VISIBLE,
  CONSTRAINT `fk_LibraryCollection_has_Subject_LibraryCollection1`
    FOREIGN KEY (`LibraryCollection_IndexNumber`)
    REFERENCES `projschema`.`librarycollection` (`Index_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LibraryCollection_has_Subject_Subject1`
    FOREIGN KEY (`Subject_SubjectName`)
    REFERENCES `projschema`.`subject` (`SubjectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `projschema`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projschema`.`orders` (
  `OrderID` INT(11) NOT NULL AUTO_INCREMENT,
  `LoanDate` DATE NOT NULL,
  `DueDate` DATE NOT NULL,
  `ReturnDate` DATE NULL DEFAULT NULL,
  `Customers_CustomerID` INT(11) NOT NULL,
  `Employees_EmployeeID` INT(11) NOT NULL,
  `Individual_Items_In_Collection_Barcode` INT(11) NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Customers1_idx` (`Customers_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Employees1_idx` (`Employees_EmployeeID` ASC) VISIBLE,
  INDEX `fk_Orders_Items1_idx` (`Individual_Items_In_Collection_Barcode` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`Customers_CustomerID`)
    REFERENCES `projschema`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employees1`
    FOREIGN KEY (`Employees_EmployeeID`)
    REFERENCES `projschema`.`employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Items1`
    FOREIGN KEY (`Individual_Items_In_Collection_Barcode`)
    REFERENCES `projschema`.`individual_items_in_collection` (`Barcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 111121
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
