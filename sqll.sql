/*
SQLyog Community Edition- MySQL GUI v8.03 
MySQL - 5.6.12-log : Database - kisan_project
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`kisan_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `kisan_project`;

/*Table structure for table `allocate` */

DROP TABLE IF EXISTS `allocate`;

CREATE TABLE `allocate` (
  `S.No` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`S.No`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `allocate` */

insert  into `allocate`(`S.No`,`request_id`,`employee_id`,`type`,`status`,`date`) values (1,4,1,'soil','free','2022-04-07'),(2,2,1,'soil','free','2022-04-20'),(3,3,4,'product','pending','2022-04-20'),(4,6,1,'soil','free','2022-04-20'),(7,8,4,'product','free','2022-04-22'),(8,9,5,'product','free','2022-04-22');

/*Table structure for table `bank` */

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
  `bank_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `account_no` int(11) DEFAULT NULL,
  `ifsc` varchar(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

/*Data for the table `bank` */

insert  into `bank`(`bank_id`,`person_id`,`account_no`,`ifsc`,`amount`,`type`) values (1,0,45,'',7200,'admin'),(2,2,5678,'509sbi',1500,'employee'),(3,3,8765,'999',100,'employee'),(4,2,78965,'768sbi',825,'user'),(5,3,123,'123',10808,'seller'),(6,4,45678,'45irty',3500,'user'),(7,4,2147483647,'fed243445',3500,'employee'),(9,5,633260810,'0810sbiirit',2200,'user'),(10,5,345678,'678sbi',2529,'user'),(11,6,2147483647,'922sbi',4600,'seller'),(12,5,670230104,'fed104',5000,'employee'),(13,7,12345678,'c09',10000,'employee');

/*Table structure for table `booking` */

DROP TABLE IF EXISTS `booking`;

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `master_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `u_quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `booking` */

insert  into `booking`(`booking_id`,`master_id`,`product_id`,`u_quantity`) values (1,1,1,10),(2,1,2,10);

/*Table structure for table `booking_master` */

DROP TABLE IF EXISTS `booking_master`;

CREATE TABLE `booking_master` (
  `master_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `booking_master` */

insert  into `booking_master`(`master_id`,`user_id`,`amount`,`date`,`status`) values (1,5,'0','2022-04-24','paid');

/*Table structure for table `complaint` */

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `compaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint` varchar(230) DEFAULT NULL,
  `complaint_date` varchar(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `reply` varchar(100) DEFAULT NULL,
  `reply_date` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`compaint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `complaint` */

insert  into `complaint`(`compaint_id`,`complaint`,`complaint_date`,`user_id`,`reply`,`reply_date`,`type`) values (1,'im not satisfied','2022-04-07',2,'we will  try our best','2022-04-07','user'),(2,'its not good','2022-04-07',3,'sorry for the inconvenience','2022-04-07','seller'),(3,'some issue occured!!!','2022-04-21',5,'we will check !!\r\n thanku for connect us','2022-04-21','user');

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employee_id` int(100) NOT NULL AUTO_INCREMENT,
  `name` varchar(230) DEFAULT NULL,
  `street` varchar(230) DEFAULT NULL,
  `locality` varchar(230) DEFAULT NULL,
  `district` varchar(230) DEFAULT NULL,
  `phone_no` int(100) DEFAULT NULL,
  `email` varchar(230) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `employee` */

insert  into `employee`(`employee_id`,`name`,`street`,`locality`,`district`,`phone_no`,`email`) values (4,'alan','iritty','peratta','Kannur',2147483647,'alan5555@gmail.com'),(5,'tony','lulu ','iritty','Thrissur',2147483647,'tony@gmail.com'),(7,'seena','kannur','skannur','Kannur',2147483647,'kal@gmail.com');

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `feedback` varchar(1000) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `feedback` */

insert  into `feedback`(`feedback_id`,`feedback`,`user_id`,`date`,`time`) values (1,'it is very useful',2,'2022-04-07','14:47:36'),(2,'wonderful service.',2,'2022-04-20','10:48:44'),(3,'not change product quantity after buy product',5,'2022-04-21','22:29:34');

/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `item` */

insert  into `item`(`item_id`,`name`) values (3,'brinjal'),(4,'carrot'),(5,'tomato'),(6,'onion');

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `user_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `login` */

insert  into `login`(`login_id`,`user_name`,`password`,`user_type`) values (1,'admin','admin','admin'),(2,'anu123@gmail.com','123','user'),(3,'akhil@gmail.com','345','seller'),(4,'jo_mol@gmail.com','453','user'),(5,'albin34@gmail.com','633','user'),(6,'ammu@gmail.com','908','seller');

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `not_id` int(11) NOT NULL AUTO_INCREMENT,
  `notification` varchar(300) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`not_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `notification` */

insert  into `notification`(`not_id`,`notification`,`date`,`time`) values (1,'Welcome To Kisan Trade','2022-04-07','14:43:13'),(2,'haloo','2022-04-21','22:01:52');

/*Table structure for table `pro_quantity` */

DROP TABLE IF EXISTS `pro_quantity`;

CREATE TABLE `pro_quantity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(30) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `admin_price` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `pro_quantity` */

insert  into `pro_quantity`(`id`,`item_id`,`quantity`,`admin_price`) values (1,4,40,100),(2,3,20,120);

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `Product_id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) DEFAULT NULL,
  `item_id` int(100) DEFAULT NULL,
  `Quantity` varchar(11) DEFAULT NULL,
  `details` varchar(100) DEFAULT NULL,
  `seller_price` float DEFAULT NULL,
  `admin_price` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

/*Data for the table `product` */

insert  into `product`(`Product_id`,`seller_id`,`item_id`,`Quantity`,`details`,`seller_price`,`admin_price`,`date`,`status`) values (3,3,0,'45','its good for health',21,35,'2022-04-07','pending'),(5,6,0,'30','good and healthy',20,22,'2022-04-20','accepted'),(6,6,0,'10','good',25,27,'2022-04-20','accepted'),(7,5,0,'50','green apple',10,0,'2022-04-21','pending'),(8,3,4,'20','asdfsdfs',20,0,'2022-04-22','accepted'),(9,3,4,'20','qweqwe',15,NULL,'2022-04-23','accepted');

/*Table structure for table `query` */

DROP TABLE IF EXISTS `query`;

CREATE TABLE `query` (
  `q_id` int(100) NOT NULL AUTO_INCREMENT,
  `query` varchar(250) DEFAULT NULL,
  `user_id` int(100) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `reply` varchar(250) DEFAULT NULL,
  `reply_date` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`q_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `query` */

/*Table structure for table `rating` */

DROP TABLE IF EXISTS `rating`;

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` varchar(100) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`rating_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `rating` */

insert  into `rating`(`rating_id`,`rating`,`user_id`) values (1,'wow!!!!',2);

/*Table structure for table `seller` */

DROP TABLE IF EXISTS `seller`;

CREATE TABLE `seller` (
  `seller_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `phoneno` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `seller` */

insert  into `seller`(`seller_id`,`name`,`street`,`locality`,`district`,`phoneno`,`email`) values (3,'akhil','kolikkadavu','payam','Kannur','6789556489','akhil@gmail.com'),(6,'ammu','neeleswaram','neeleswaram','Kasargod','9089776545','ammu@gmail.com');

/*Table structure for table `soil_report` */

DROP TABLE IF EXISTS `soil_report`;

CREATE TABLE `soil_report` (
  `soilreport_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `date` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`soilreport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `soil_report` */

insert  into `soil_report`(`soilreport_id`,`user_id`,`amount`,`date`,`status`) values (2,2,500,'2022-04-07','booked'),(3,3,500,'2022-04-07','pending'),(4,3,500,'2022-04-07','/static/kisan/20220407152922.pdf'),(5,2,500,'2022-04-07','booked'),(6,2,500,'2022-04-20','/static/kisan/20220420143826.pdf'),(7,6,500,'2022-04-20','booked'),(8,5,500,'2022-04-21','/static/kisan/20220421223451.pdf');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) DEFAULT NULL,
  `street` varchar(1000) DEFAULT NULL,
  `phone_number` varchar(11) DEFAULT NULL,
  `gender` varchar(1000) DEFAULT NULL,
  `locality` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `profile_photo` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

insert  into `user`(`user_id`,`user_name`,`street`,`phone_number`,`gender`,`locality`,`district`,`profile_photo`,`email`) values (2,'Anu','valora','4567345675','female','chavassery','Kasargod','static/images/220407-144533.jpg','anu123@gmail.com'),(4,'jomol','kacherikkadavu','1234567890','female','koottupuzha','Kannur','static/images/220407-162201.jpg','jo_mol@gmail.com'),(5,'Albin','pala','6789456734','male','iritty','Kasargod','static/images/220420-150353.jpg','albin34@gmail.com');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
