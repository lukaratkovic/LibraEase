/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 8.0.28 : Database - libraease
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`libraease` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `libraease`;

/*Table structure for table `author` */

DROP TABLE IF EXISTS `author`;

CREATE TABLE `author` (
  `idAuthor` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Surname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAuthor`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

/*Data for the table `author` */

insert  into `author`(`idAuthor`,`Name`,`Surname`) values 
(1,'Robert','Jordan'),
(2,'Brandon','Sanderson'),
(4,'Pierce','Brown'),
(5,'Scott','Lynch');

/*Table structure for table `book` */

DROP TABLE IF EXISTS `book`;

CREATE TABLE `book` (
  `ISBN` varchar(13) NOT NULL,
  `Title` varchar(45) DEFAULT NULL,
  `Pages` int DEFAULT NULL,
  `Genre_idGenre` int NOT NULL,
  `Author_idAuthor` int NOT NULL,
  `Publisher_idPublisher` int NOT NULL,
  `description` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `coverURL` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`ISBN`),
  KEY `fk_Book_Genre_idx` (`Genre_idGenre`),
  KEY `fk_Book_Author1_idx` (`Author_idAuthor`),
  KEY `fk_Book_Publisher1_idx` (`Publisher_idPublisher`),
  CONSTRAINT `fk_Book_Author1` FOREIGN KEY (`Author_idAuthor`) REFERENCES `author` (`idAuthor`),
  CONSTRAINT `fk_Book_Genre` FOREIGN KEY (`Genre_idGenre`) REFERENCES `genre` (`idGenre`),
  CONSTRAINT `fk_Book_Publisher1` FOREIGN KEY (`Publisher_idPublisher`) REFERENCES `publisher` (`idPublisher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `book` */

insert  into `book`(`ISBN`,`Title`,`Pages`,`Genre_idGenre`,`Author_idAuthor`,`Publisher_idPublisher`,`description`,`coverURL`) values 
('9780356503820','Eye of the World',804,1,1,1,'The Wheel of Time turns and Ages come and pass, leaving memories that become legend. Legend fades to myth and even myth is long forgotten when the Age that gave it birth returns again. But one truth remains, and what mortal men forget, the Aes Sedai do not ...What was, what will be, and what is, may yet fall under the shadow.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1401349440i/22369377.jpg'),
('9780575079755','The Lies of Locke Lamora',530,1,5,5,'An orphan’s life is harsh—and often short—in the mysterious island city of Camorr. But young Locke Lamora dodges death and slavery, becoming a thief under the tutelage of a gifted con artist. As leader of the band of light-fingered brothers known as the Gentleman Bastards, Locke is soon infamous, fooling even the underworld’s most feared ruler. But in the shadows lurks someone still more ambitious and deadly. Faced with a bloody coup that threatens to destroy everyone and everything that holds meaning in his mercenary life, Locke vows to beat the enemy at his own brutal game—or die trying.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1327866164i/865293.jpg'),
('9781444758993','Red Rising',382,6,4,6,'Darrow is a Red, a member of the lowest caste in the color-coded society of the future. Like his fellow Reds, he works all day, believing that he and his people are making the surface of Mars livable for future generations.\n\nYet he spends his life willingly, knowing that his blood and sweat will one day result in a better world for his children.\n\nBut Darrow and his kind have been betrayed. Soon he discovers that humanity already reached the surface generations ago. Vast cities and sprawling parks spread across the planet. Darrow—and Reds like him—are nothing more than slaves to a decadent ruling class.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1461354651i/15839976.jpg'),
('9781444759037','Golden Son',442,6,4,6,'As a Red, Darrow grew up working the mines deep beneath the surface of Mars, enduring backbreaking labor while dreaming of the better future he was building for his descendants. But the Society he faithfully served was built on lies. Darrow’s kind have been betrayed and denied by their elitist masters, the Golds—and their only path to liberation is revolution. And so Darrow sacrifices himself in the name of the greater good for which Eo, his true love and inspiration, laid down her own life. He becomes a Gold, infiltrating their privileged realm so that he can destroy it from within.\n\nA lamb among wolves in a cruel world, Darrow finds friendship, respect, and even love—but also the wrath of powerful rivals. To wage and win the war that will change humankind’s destiny, Darrow must confront the treachery arrayed against him, overcome his all-too-human desire for retribution—and strive not for violent revolt but a hopeful rebirth. Though the road ahead is fraught with danger and deceit, Darrow must choose to follow Eo’s principles of love and justice to free his people.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1429217902i/25372230.jpg'),
('9781473217850','Skyward',513,6,2,5,'Defeated, crushed, and driven almost to extinction, the remnants of the human race are trapped on a planet that is constantly attacked by mysterious alien starfighters. Spensa, a teenage girl living among them, longs to be a pilot. When she discovers the wreckage of an ancient ship, she realizes this dream might be possible—assuming she can repair the ship, navigate flight school, and (perhaps most importantly) persuade the strange machine to help her. Because this ship, uniquely, appears to have a soul.','https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1531845177i/36642458.jpg');

/*Table structure for table `genre` */

DROP TABLE IF EXISTS `genre`;

CREATE TABLE `genre` (
  `idGenre` int NOT NULL AUTO_INCREMENT,
  `Genre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGenre`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;

/*Data for the table `genre` */

insert  into `genre`(`idGenre`,`Genre`) values 
(1,'Fantasy'),
(6,'SciFi'),
(7,'Romance'),
(10,'Biographies & Autobiographies'),
(11,'History'),
(12,'Self-Help');

/*Table structure for table `library` */

DROP TABLE IF EXISTS `library`;

CREATE TABLE `library` (
  `User_idUser` int NOT NULL,
  `Book_ISBN` varchar(13) NOT NULL,
  `Progress` int DEFAULT NULL,
  `status` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`User_idUser`,`Book_ISBN`),
  KEY `fk_User_has_Book_Book1_idx` (`Book_ISBN`),
  KEY `fk_User_has_Book_User1_idx` (`User_idUser`),
  CONSTRAINT `fk_User_has_Book_Book1` FOREIGN KEY (`Book_ISBN`) REFERENCES `book` (`ISBN`),
  CONSTRAINT `fk_User_has_Book_User1` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `library` */

insert  into `library`(`User_idUser`,`Book_ISBN`,`Progress`,`status`) values 
(2,'9780356503820',84,'reading'),
(2,'9780575079755',0,'inactive'),
(2,'9781444758993',382,'reading'),
(2,'9781444759037',126,'reading'),
(2,'9781473217850',0,'inactive'),
(4,'9780356503820',120,'reading'),
(4,'9780575079755',0,'inactive'),
(4,'9781444758993',382,'reading'),
(4,'9781444759037',120,'inactive'),
(4,'9781473217850',150,'reading');

/*Table structure for table `publisher` */

DROP TABLE IF EXISTS `publisher`;

CREATE TABLE `publisher` (
  `idPublisher` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPublisher`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

/*Data for the table `publisher` */

insert  into `publisher`(`idPublisher`,`Name`) values 
(1,'Orbit Books'),
(3,'Tor Books'),
(5,'Gollancz'),
(6,'Hodder & Stoughton');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `Password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `salt` varchar(172) DEFAULT NULL,
  `level` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

/*Data for the table `user` */

insert  into `user`(`idUser`,`Password`,`salt`,`level`,`email`,`username`) values 
(2,'741c68539f8842a4c8e95a6363f19b4911ae07ab6e17613a028957ba6e986390a508b7d61b1b53ad1cb4e0b97fdfac424312f1819ee19d5d7b4973a49b2093e9','6ZLqgZnPiWBHj7nAEE4qHcjbN8+DjMCul9E0oQlLhuJVJkk2XBYaagqh3Rg5Ggwe2F2jMsDo35Jei4Z8LaCoemrn+a4niMVED5gSKz0SJbF0DHHZP4DVyvXBXUpxQFFK5QTYnn3cnNKcTEFu30lHLDS+eOP3mgllKnijM41LogA=',1,'admin@libraease.hr','admin'),
(4,'f53b2ed3f58bfdbf242ee3648dd44ece0820607663f24ca0b3518b8226b63822301680dd115ca1eb0618a48a6cf97f5e806c6e2bd55e5b3553f953f0a33e9ad8','kmgZF4kJICxnGvuzzSBP029V/ZKYNwklrNEoGlbIHocEoOT14tsQ67j1aNUja+4UovmzEvsBWua+IVQa69dKhua/GsODbn3trLbZNHd2+1CENrNlDIxphMaWvr+w6446fjO1WhUHrXZr1pJ36lOFB46McxtPFfoYUlpVRAist38=',2,'lratkovic@tvz.hr','lukaratkovic');

/* Procedure structure for procedure `DeleteBook` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteBook` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBook`(IN i_ISBN VARCHAR(13))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
	END;

	START TRANSACTION;
		DELETE FROM library WHERE Book_ISBN = i_ISBN;
		DELETE FROM book WHERE ISBN = i_ISBN;
	COMMIT;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteUser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser`(IN i_idUser INT)
begin
	declare exit handler for sqlexception
	begin
		rollback;
	end;

	start transaction;
		delete from library where User_idUser = i_idUser;
		DELETE FROM user WHERE idUser = i_idUser;
	COMMIT;
end */$$
DELIMITER ;

/*Table structure for table `libraryentry` */

DROP TABLE IF EXISTS `libraryentry`;

/*!50001 DROP VIEW IF EXISTS `libraryentry` */;
/*!50001 DROP TABLE IF EXISTS `libraryentry` */;

/*!50001 CREATE TABLE  `libraryentry`(
 `User_idUser` int ,
 `Book_ISBN` varchar(13) ,
 `Progress` int ,
 `status` varchar(8) ,
 `Title` varchar(45) ,
 `Pages` int ,
 `coverURL` varchar(2048) ,
 `AuthorName` varchar(45) ,
 `AuthorSurname` varchar(45) 
)*/;

/*View structure for view libraryentry */

/*!50001 DROP TABLE IF EXISTS `libraryentry` */;
/*!50001 DROP VIEW IF EXISTS `libraryentry` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `libraryentry` AS select `library`.`User_idUser` AS `User_idUser`,`library`.`Book_ISBN` AS `Book_ISBN`,`library`.`Progress` AS `Progress`,`library`.`status` AS `status`,`book`.`Title` AS `Title`,`book`.`Pages` AS `Pages`,`book`.`coverURL` AS `coverURL`,`author`.`Name` AS `AuthorName`,`author`.`Surname` AS `AuthorSurname` from ((`library` join `book` on((`library`.`Book_ISBN` = `book`.`ISBN`))) join `author` on((`book`.`Author_idAuthor` = `author`.`idAuthor`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
