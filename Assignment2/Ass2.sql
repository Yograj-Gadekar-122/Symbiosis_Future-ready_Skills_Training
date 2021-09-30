-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university_system` DEFAULT CHARACTER SET utf8 ;
USE `university_system` ;

-- -----------------------------------------------------
-- Table `university_system`.`UNIVERSITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`UNIVERSITY` (
  `uni_id` INT NOT NULL,
  `uni_name` VARCHAR(100) NOT NULL,
  `uni_code` VARCHAR(30) NOT NULL,
  `uni_place` VARCHAR(100) NOT NULL,
  `fac_id` INT NOT NULL,
  `camp_id` INT NOT NULL,
  PRIMARY KEY (`uni_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`CLUB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`CLUB` (
  `club_id` INT NOT NULL,
  `club_name` VARCHAR(45) NOT NULL,
  `club_place` VARCHAR(100) NOT NULL,
  `club_contact_no` INT NOT NULL,
  `club_sport` VARCHAR(50) NOT NULL,
  `camp_id` INT NOT NULL,
  PRIMARY KEY (`club_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`CAMPUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`CAMPUS` (
  `camp_id` INT NOT NULL,
  `camp_name` VARCHAR(100) NOT NULL,
  `camp_address` VARCHAR(100) NOT NULL,
  `camp_distance` INT NOT NULL,
  `club_id` INT NOT NULL,
  `uni_id` INT NOT NULL,
  PRIMARY KEY (`camp_id`),
  INDEX `club_id_idx` (`club_id` ASC) VISIBLE,
  INDEX `uni_id_idx` (`uni_id` ASC) VISIBLE,
  CONSTRAINT `club_id`
    FOREIGN KEY (`club_id`)
    REFERENCES `university_system`.`CLUB` (`club_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `uni_id`
    FOREIGN KEY (`uni_id`)
    REFERENCES `university_system`.`UNIVERSITY` (`uni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`SCHOOL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`SCHOOL` (
  `school_id` INT NOT NULL,
  `school_name` VARCHAR(50) NOT NULL,
  `school_building_place` VARCHAR(50) NOT NULL,
  `fac_id` INT NOT NULL,
  `camp_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  `prog_id` INT NOT NULL,
  PRIMARY KEY (`school_id`),
  INDEX `camp_id_idx` (`camp_id` ASC) VISIBLE,
  CONSTRAINT `camp_id`
    FOREIGN KEY (`camp_id`)
    REFERENCES `university_system`.`CAMPUS` (`camp_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`FACULTY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`FACULTY` (
  `fac_id` INT NOT NULL,
  `fac_name` VARCHAR(50) NOT NULL,
  `fac_dean` VARCHAR(50) NOT NULL,
  `fac_building_place` VARCHAR(50) NOT NULL,
  `school_id` INT NOT NULL,
  `commity_id` INT NOT NULL,
  `uni_id` INT NOT NULL,
  PRIMARY KEY (`fac_id`),
  INDEX `fac_id_idx` (`uni_id` ASC) VISIBLE,
  INDEX `school_id_idx` (`school_id` ASC) VISIBLE,
  CONSTRAINT `fac_id`
    FOREIGN KEY (`uni_id`)
    REFERENCES `university_system`.`UNIVERSITY` (`uni_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `school_id`
    FOREIGN KEY (`school_id`)
    REFERENCES `university_system`.`SCHOOL` (`school_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`STUDENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`STUDENTS` (
  `stud_id` INT NOT NULL,
  `stud_name` VARCHAR(50) NOT NULL,
  `stud_birthdate` DATE NOT NULL,
  `cours_yearofcourse` INT NOT NULL,
  `prog_id` INT NOT NULL,
  `cours_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`stud_id`),
  INDEX `prog_id_idx` (`prog_id` ASC) VISIBLE,
  CONSTRAINT `prog_id`
    FOREIGN KEY (`prog_id`)
    REFERENCES `university_system`.`PROGRAMS` (`prog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`COURSES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`COURSES` (
  `cours_id` INT NOT NULL,
  `cours_title` VARCHAR(50) NOT NULL,
  `cours_yearofcourse` DATE NOT NULL,
  `prog_id` INT NOT NULL,
  `stud_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`cours_id`),
  INDEX `stud_id_idx` (`stud_id` ASC) VISIBLE,
  CONSTRAINT `stud_id`
    FOREIGN KEY (`stud_id`)
    REFERENCES `university_system`.`STUDENTS` (`stud_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`PROGRAMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`PROGRAMS` (
  `prog_id` INT NOT NULL,
  `prog_title` VARCHAR(100) NOT NULL,
  `prog_time` DATE NOT NULL,
  `school_id` INT NOT NULL,
  `cours_id` INT NOT NULL,
  PRIMARY KEY (`prog_id`),
  INDEX `school_id_idx` (`school_id` ASC) VISIBLE,
  INDEX `cours_id_idx` (`cours_id` ASC) VISIBLE,
  CONSTRAINT `school_id`
    FOREIGN KEY (`school_id`)
    REFERENCES `university_system`.`SCHOOL` (`school_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cours_id`
    FOREIGN KEY (`cours_id`)
    REFERENCES `university_system`.`COURSES` (`cours_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`COMMITTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`COMMITTES` (
  `commity_id` INT NOT NULL,
  `commity_name` VARCHAR(50) NOT NULL,
  `fac_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`commity_id`),
  INDEX `staff_id_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fac_id_idx` (`fac_id` ASC) VISIBLE,
  CONSTRAINT `staff_id`
    FOREIGN KEY (`staff_id`)
    REFERENCES `university_system`.`STAFF` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fac_id`
    FOREIGN KEY (`fac_id`)
    REFERENCES `university_system`.`FACULTY` (`fac_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university_system`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`STAFF` (
  `staff_id` INT NOT NULL,
  `staff_name` VARCHAR(50) NOT NULL,
  `staff_office_name` VARCHAR(50) NOT NULL,
  `stud_id` INT NOT NULL,
  `school_id` INT NOT NULL,
  `cours_id` INT NOT NULL,
  `commity_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `commity_id_idx` (`commity_id` ASC) VISIBLE,
  INDEX `school_id_idx` (`school_id` ASC) VISIBLE,
  INDEX `stud_id_idx` (`stud_id` ASC) VISIBLE,
  INDEX `cours_id_idx` (`cours_id` ASC) VISIBLE,
  CONSTRAINT `commity_id`
    FOREIGN KEY (`commity_id`)
    REFERENCES `university_system`.`COMMITTES` (`commity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `school_id`
    FOREIGN KEY (`school_id`)
    REFERENCES `university_system`.`SCHOOL` (`school_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `stud_id`
    FOREIGN KEY (`stud_id`)
    REFERENCES `university_system`.`STUDENTS` (`stud_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cours_id`
    FOREIGN KEY (`cours_id`)
    REFERENCES `university_system`.`COURSES` (`cours_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
