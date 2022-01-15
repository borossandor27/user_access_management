-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2022. Jan 15. 21:11
-- Kiszolgáló verziója: 10.4.21-MariaDB
-- PHP verzió: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `access_levels`
--
CREATE DATABASE IF NOT EXISTS `access_levels` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `access_levels`;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `employees`
--

CREATE TABLE `employees` (
  `user_id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL COMMENT 'password_hash() függvénnyel kódolva',
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `employees`
--

INSERT INTO `employees` (`user_id`, `name`, `password`, `role_id`) VALUES
(9, 'sanyi', '$2y$10$PIv5YgT03cbHHrxeKM1wzeGKDEdJB6FWdN1Slta95S4VjhdNrar9S', 4),
(10, 'Jozsi', '$2y$10$PIv5YgT03cbHHrxeKM1wzeGKDEdJB6FWdN1Slta95S4VjhdNrar9S', 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `pizza`
--

CREATE TABLE `pizza` (
  `pazon` int(3) NOT NULL DEFAULT 0,
  `pnev` varchar(15) NOT NULL DEFAULT '',
  `par` int(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `pizza`
--

INSERT INTO `pizza` (`pazon`, `pnev`, `par`) VALUES
(1, 'Capricciosa', 1050),
(2, 'Frutti di Mare', 1350),
(3, 'Hawaii', 850),
(4, 'Vesuvio', 900),
(5, 'Sorrento', 1050);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `rendeles`
--

CREATE TABLE `rendeles` (
  `razon` int(11) NOT NULL DEFAULT 0,
  `vazon` int(11) NOT NULL DEFAULT 0,
  `pazon` int(11) NOT NULL,
  `idopont` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `role_mask` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `role_mask`) VALUES
(1, 'ACCESS_USER', 163),
(2, 'ACCESS_GUEST', 177),
(3, 'ACCESS_GOODS_UPLODER', 97),
(4, 'ACCESS_ADMIN', 237);

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `users`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `users` (
`vazon` int(11)
,`vnev` varchar(200)
,`password` varchar(200)
,`role_name` varchar(100)
,`role_mask` int(11)
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `vevo`
--

CREATE TABLE `vevo` (
  `vazon` int(6) NOT NULL DEFAULT 0,
  `vnev` varchar(100) NOT NULL DEFAULT '',
  `password` char(60) NOT NULL,
  `vcim` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `vevo`
--

INSERT INTO `vevo` (`vazon`, `vnev`, `password`, `vcim`) VALUES
(1, 'Hapci', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 1. ágy'),
(2, 'Vidor', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 2. ágy'),
(3, 'Tudor', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 3. ágy'),
(4, 'Kuka', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 4. ágy'),
(5, 'Szende', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 5. ágy'),
(6, 'Szundi', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 6. ágy'),
(7, 'Morgó', '$2y$10$titSEuYYtwuMc1PpepG1WuqOAku21Gicgy/.Hz7T08okD5umsmo/G', 'Kerek erdő Kis ház I. emelet 7. ágy');

-- --------------------------------------------------------

--
-- Nézet szerkezete `users`
--
DROP TABLE IF EXISTS `users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `users`  AS SELECT `vevo`.`vazon` AS `vazon`, `vevo`.`vnev` AS `vnev`, `vevo`.`password` AS `password`, 'ACCESS_USER' AS `role_name`, `role`.`role_mask` AS `role_mask` FROM (`vevo` join `role`) WHERE `role`.`role_name` = 'ACCESS_USER' ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`pazon`);

--
-- A tábla indexei `rendeles`
--
ALTER TABLE `rendeles`
  ADD PRIMARY KEY (`razon`),
  ADD KEY `fk_vazon` (`vazon`),
  ADD KEY `fk_pizza_rendeles` (`pazon`);

--
-- A tábla indexei `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- A tábla indexei `vevo`
--
ALTER TABLE `vevo`
  ADD PRIMARY KEY (`vazon`),
  ADD UNIQUE KEY `vnev` (`vnev`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `employees`
--
ALTER TABLE `employees`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_role_users` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);

--
-- Megkötések a táblához `rendeles`
--
ALTER TABLE `rendeles`
  ADD CONSTRAINT `fk_pizza_rendeles` FOREIGN KEY (`pazon`) REFERENCES `pizza` (`pazon`),
  ADD CONSTRAINT `fk_vevo_rendeles` FOREIGN KEY (`vazon`) REFERENCES `vevo` (`vazon`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
