-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema comp6000
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema comp6000
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `comp6000` DEFAULT CHARACTER SET utf8 ;
USE `comp6000` ;

-- -----------------------------------------------------
-- Table `comp6000`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`users` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`posts` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(200) NOT NULL,
  `url` VARCHAR(255) NULL,
  `body` LONGTEXT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `userid_idx` (`user_id` ASC),
  CONSTRAINT `userid`
    FOREIGN KEY (`user_id`)
    REFERENCES `comp6000`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`forums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`forums` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`forums` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`forum_posts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`forum_posts` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`forum_posts` (
  `forum_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  PRIMARY KEY (`forum_id`, `post_id`),
  CONSTRAINT `forum_id`
    FOREIGN KEY (`forum_id`)
    REFERENCES `comp6000`.`forums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `post_id`
    FOREIGN KEY (`post_id`)
    REFERENCES `comp6000`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`votes` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`votes` (
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `vote` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`, `post_id`),
  INDEX `post_id_idx` (`post_id` ASC),
  CONSTRAINT `post_vote_id`
    FOREIGN KEY (`post_id`)
    REFERENCES `comp6000`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_vote_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `comp6000`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`comments` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `body` VARCHAR(45) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `comment_post_id_idx` (`post_id` ASC),
  PRIMARY KEY (`comment_id`),
  CONSTRAINT `comment_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `comp6000`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_post_id`
    FOREIGN KEY (`post_id`)
    REFERENCES `comp6000`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comp6000`.`comment_votes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comp6000`.`comment_votes` ;

CREATE TABLE IF NOT EXISTS `comp6000`.`comment_votes` (
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `vote` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`, `comment_id`),
  INDEX `comment_vote_comment_id_idx` (`comment_id` ASC),
  CONSTRAINT `comment_vote_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `comp6000`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment_vote_comment_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comp6000`.`comments` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
