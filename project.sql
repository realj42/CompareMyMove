-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE TABLE "company_matching_settings" --------------------
CREATE TABLE `company_matching_settings`( 
	`id` Int( 255 ) AUTO_INCREMENT NOT NULL,
	`company_id` Int( 255 ) NOT NULL,
	`postcodes` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`bedrooms` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`type` VarChar( 25 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	CONSTRAINT `unique_id` UNIQUE( `id` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB
AUTO_INCREMENT = 31;
-- -------------------------------------------------------------


-- CREATE TABLE "companies" ------------------------------------
CREATE TABLE `companies`( 
	`id` Int( 255 ) AUTO_INCREMENT NOT NULL,
	`active` TinyInt( 1 ) NOT NULL,
	`name` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`credits` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '\'\'\'0\'\'\'',
	`description` Text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`email` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`phone` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	`website` VarChar( 255 ) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
	CONSTRAINT `unique_id` UNIQUE( `id` ),
	CONSTRAINT `unique_name` UNIQUE( `name` ) )
CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci
ENGINE = InnoDB
AUTO_INCREMENT = 11;
-- -------------------------------------------------------------


-- Dump data of "company_matching_settings" ----------------
BEGIN;

INSERT INTO `company_matching_settings`(`id`,`company_id`,`postcodes`,`bedrooms`,`type`) VALUES 
( '1', '1', '["CF"]', '["1","2","3","4","5"]', 'building' ),
( '2', '2', '["CF"]', '["2","3","4"]', 'building' ),
( '3', '3', '["CF"]', '["3","4","5"]', 'building' ),
( '4', '4', '["CF"]', '["2","3","4","5"]', 'building' ),
( '5', '1', '["CF"]', '["1","2","3","4","5"]', 'homebuyer' ),
( '6', '2', '["CF"]', '["2","3","4"]', 'homebuyer' ),
( '7', '3', '["CF"]', '["3","4","5"]', 'homebuyer' ),
( '8', '4', '["CF"]', '["2","3","4","5"]', 'homebuyer' ),
( '9', '1', '["CF"]', '["1","2","3","4","5"]', 'valuation' ),
( '10', '2', '["CF"]', '["2","3","4"]', 'valuation' ),
( '11', '3', '["CF"]', '["3","4","5"]', 'valuation' ),
( '12', '4', '["CF"]', '["2","3","4","5"]', 'valuation' ),
( '13', '9', '["CF"]', '["1"]', 'building' ),
( '14', '9', '["CF"]', '["1"]', 'homebuyer' ),
( '15', '9', '["CF"]', '["1"]', 'valuation' ),
( '16', '5', '["B"]', '["1","2","3","4","5"]', 'building' ),
( '17', '6', '["BS"]', '["2","3"]', 'building' ),
( '18', '7', '["B"]', '["2","3","4","5"]', 'building' ),
( '19', '8', '["B"]', '["3","4","5"]', 'building' ),
( '20', '5', '["BS"]', '["3","4","5"]', 'homebuyer' ),
( '21', '6', '["B"]', '["2","3","4","5"]', 'homebuyer' ),
( '22', '7', '["B"]', '["2","3"]', 'homebuyer' ),
( '23', '8', '["BS"]', '["1","2","3","4","5"]', 'homebuyer' ),
( '24', '5', '["BS"]', '["2","3"]', 'valuation' ),
( '25', '6', '["B"]', '["3","4","5"]', 'valuation' ),
( '26', '7', '["B"]', '["1","2","3","4","5"]', 'valuation' ),
( '27', '8', '["B"]', '["2","3","4","5"]', 'valuation' ),
( '28', '10', '["B"]', '["3","4"]', 'building' ),
( '29', '10', '["B"]', '["3","4"]', 'homebuyer' ),
( '30', '10', '["B"]', '["3","4"]', 'valuation' );
COMMIT;
-- ---------------------------------------------------------


-- Dump data of "companies" --------------------------------
BEGIN;

INSERT INTO `companies`(`id`,`active`,`name`,`credits`,`description`,`email`,`phone`,`website`) VALUES 
( '1', '1', 'Tacos or Death Surveyors', '2', 'Give me tacos, or give me death. 50 cent tacos! I’ll take 30.  This will be 5 times this week and it’s only Tuesday.', 'tacotaco@tacosordeath.com', '01234 567890', 'https://www.taconsordeath.com' ),
( '2', '1', 'Barbacoa Surveyors', '13', 'BARBACOA!! Shrimp tacos are tasty tacos! BARBACOA!! Tacos dorados called flautas, or taquitos, for which the tortillas are filled with pre-cooked shredded chicken, beef or barbacoa, rolled into an elongated cylinder and deep-fried until crisp. ', 'flautas@barbacoa-surveys.com', '01234 567890', 'https://www.barbacoa-surveys.com' ),
( '3', '1', 'Tasty Carnitas Surveys', '3', 'Make it a double there pal. It’s raining tacos, from out of the sky, tacos, don’t even ask why. CARNITAS!! Fish tacos: lettuce or cabbage, pico de gallo, avocado and a sour cream or citrus/mayonnaise sauce, all placed on top of a corn or flour tortilla. Does guac cost extra?', 'tasty@carnitas-surveys.com', '01234 567890', 'https://www.carnitas-surveys.com' ),
( '4', '1', 'El Pollo Diablo Surveys', '19', 'Ooh, with diced onions and a pinch of cilantro. Add in a few el Pastor with guac and diced onions. These tacos are lit ', 'bokbok@diablo-surveyors.com', '01234 567890', 'https://diablo-surveyors.com' ),
( '5', '1', 'De Adobada Surveys', '6', 'How do you feel about hard shelled tacos? It’s long been rumored that the chupacabra is really just a crazed man who’s local taco shop went out of business. Tacos, again? This will be 5 times this week and it’s only Tuesday.', 'deadobada@deadobada.com', '01234 567890', 'https://www.deadobada.com' ),
( '6', '1', 'Al Pastor Surveys', '5', 'Every day is taco ipsum tuesday. CARNITAS!! TACOS!! Josh’s taco shack is the best taco shack. Give me all your tacos. Tacos Al pastor/De Adobada are made of thin pork steaks seasoned with adobo seasoning, then skewered and overlapped on one another on a vertical rotisserie cooked and flame-broiled as it spins. ', 'al@pastor-surveys.com', '01234 567890', 'https://www.pastor-surveys.com' ),
( '7', '1', 'Cholula Surveyors', '18', 'Um, Tabasco? No thanks, do you have any Cholula? BARBACOA!! Say taco one more time. BARBACOA!! Burritos are very tasty. ', 'lit@cholula-surveyors.com', '01234 567890', 'https://www.cholula-surveyors.com' ),
( '8', '1', 'Carne Asada Surveys', '1', 'Tacos dorados called flautas, or taquitos, for which the tortillas are filled with pre-cooked shredded chicken, beef or barbacoa, rolled into an elongated cylinder and deep-fried until crisp. I’d have to say, those tacos are on fleek. ', 'crispy@carne-asada-surveyors.com', '01234 567890', 'https://www.carne-asada-surveyors.com' ),
( '9', '0', 'Josh\'s Taco Shack', '0', 'Josh’s taco shack is the best taco shack.', 'josh@tacoshack.com', '01234 567890', 'https://www.tacoshack.com' ),
( '10', '0', 'Buuuu Riiii Tooo Surveys', '99', 'I’ve been following that taco truck around all day. If you were a taco, would you eat yourself?', 'ri@burritosurveys.com', '01234 567890', 'https://www.burritosurveys.com' );
COMMIT;
-- ---------------------------------------------------------


-- CREATE INDEX "lnk_companies_company_postcode_choices" -------
CREATE INDEX `lnk_companies_company_postcode_choices` USING BTREE ON `company_matching_settings`( `company_id` );
-- -------------------------------------------------------------


-- CREATE LINK "lnk_companies_company_postcode_choices" --------
ALTER TABLE `company_matching_settings`
	ADD CONSTRAINT `lnk_companies_company_postcode_choices` FOREIGN KEY ( `company_id` )
	REFERENCES `companies`( `id` )
	ON DELETE Cascade
	ON UPDATE Cascade;
-- -------------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


