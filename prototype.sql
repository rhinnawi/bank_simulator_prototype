-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Contact_Info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contact_Info` (
  `cont_id` INT NOT NULL,
  `street_address` VARCHAR(100) NOT NULL,
  `apt_num` VARCHAR(4) NULL,
  `city` VARCHAR(85) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `postal_num` CHAR(5) NOT NULL,
  `phone_num` CHAR(10) NOT NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`cont_id`),
  UNIQUE INDEX `idAddress_UNIQUE` (`cont_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transaction` (
  `tr_num` INT NOT NULL,
  `date` DATE NULL,
  `type` VARCHAR(45) NULL,
  `amount` DECIMAL(10,2) NULL,
  PRIMARY KEY (`tr_num`),
  UNIQUE INDEX `tr_num_UNIQUE` (`tr_num` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`account` (
  `acc_num` INT NOT NULL,
  `balance` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `type` VARCHAR(10) NOT NULL,
  `transaction_num` INT NOT NULL,
  PRIMARY KEY (`acc_num`),
  UNIQUE INDEX `account_num_UNIQUE` (`acc_num` ASC) VISIBLE,
  INDEX `fk_account_transaction1_idx` (`transaction_num` ASC) VISIBLE,
  CONSTRAINT `fk_account_transaction1`
    FOREIGN KEY (`transaction_num`)
    REFERENCES `mydb`.`transaction` (`tr_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `SSN` CHAR(11) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `annual_income` INT NULL,
  `us_citizen` BINARY(1) NOT NULL DEFAULT true,
  `password` VARCHAR(20) NOT NULL,
  `Contact_Info_id` INT NOT NULL,
  `account_num` INT NOT NULL,
  PRIMARY KEY (`SSN`),
  UNIQUE INDEX `SSN_UNIQUE` (`SSN` ASC) VISIBLE,
  INDEX `fk_Customer_Contact_Info_idx` (`Contact_Info_id` ASC) VISIBLE,
  INDEX `fk_Customer_account1_idx` (`account_num` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Contact_Info`
    FOREIGN KEY (`Contact_Info_id`)
    REFERENCES `mydb`.`Contact_Info` (`cont_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_account1`
    FOREIGN KEY (`account_num`)
    REFERENCES `mydb`.`account` (`acc_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
