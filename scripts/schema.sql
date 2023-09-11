-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chsdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chsdb` DEFAULT CHARACTER SET utf8 ;
USE `chsdb` ;

-- -----------------------------------------------------
-- Table `chsdb`.`Documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`Documents` (
  `id` INT NOT NULL,
  `file` LONGTEXT NOT NULL,
  `fileType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chsdb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`Status` (
  `id` INT NOT NULL,
  `statusName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chsdb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`Users` (
  `userId` INT NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `number` INT NULL,
  `password` VARCHAR(128) NULL,
  `qrcode` TEXT NULL,
  `remarks` VARCHAR(200) NULL,
  `updatedAt` DATETIME NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedBy` INT NULL,
  `bloodGroup` VARCHAR(5) NULL,
  `address` VARCHAR(200) NULL,
  `documentId` INT NULL,
  `statusId` INT NOT NULL,
  `salt` VARCHAR(32) NULL,
  PRIMARY KEY (`userId`),
  INDEX `fk_Users_Documents_idx` (`documentId` ASC) VISIBLE,
  INDEX `fk_Users_Status1_idx` (`statusId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Documents`
    FOREIGN KEY (`documentId`)
    REFERENCES `chsdb`.`Documents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_Status1`
    FOREIGN KEY (`statusId`)
    REFERENCES `chsdb`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chsdb`.`Prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`Prescription` (
  `id` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  `patientId` INT NOT NULL,
  `doctorId` INT NOT NULL,
  `details` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prescription_Users1_idx` (`patientId` ASC) VISIBLE,
  INDEX `fk_Prescription_Users2_idx` (`doctorId` ASC) VISIBLE,
  CONSTRAINT `fk_Prescription_Users1`
    FOREIGN KEY (`patientId`)
    REFERENCES `chsdb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescription_Users2`
    FOREIGN KEY (`doctorId`)
    REFERENCES `chsdb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chsdb`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`Roles` (
  `id` INT NOT NULL,
  `roleName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chsdb`.`UserRoleMapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chsdb`.`UserRoleMapping` (
  `id` INT NOT NULL,
  `userId` INT NOT NULL,
  `roleId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Users_has_Roles_Roles1_idx` (`roleId` ASC) VISIBLE,
  INDEX `fk_Users_has_Roles_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_Users_has_Roles_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `chsdb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_has_Roles_Roles1`
    FOREIGN KEY (`roleId`)
    REFERENCES `chsdb`.`Roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
