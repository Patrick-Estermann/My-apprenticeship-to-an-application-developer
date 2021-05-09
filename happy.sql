-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Mai 2021 um 20:02
-- Server-Version: 10.4.16-MariaDB
-- PHP-Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `happy`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `artikel`
--

CREATE TABLE `artikel` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(25) NOT NULL,
  `preis` decimal(38,2) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `artikel`
--

INSERT INTO `artikel` (`id`, `bezeichnung`, `preis`, `image_path`) VALUES
(1, 'Etui', '9.90', 'etui.jpg'),
(2, 'Holzschachtel', '11.90', 'holzschachtel.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellte_konfiguration`
--

CREATE TABLE `bestellte_konfiguration` (
  `bestellPos_id` int(11) NOT NULL,
  `inhalt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellung`
--

CREATE TABLE `bestellung` (
  `id` int(11) NOT NULL,
  `kunde_id` int(11) NOT NULL,
  `datum` date NOT NULL,
  `bemerkungen` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestell_position`
--

CREATE TABLE `bestell_position` (
  `id` int(11) NOT NULL,
  `artikel_id` int(11) NOT NULL,
  `bestell_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `eo_pk_table`
--

CREATE TABLE `eo_pk_table` (
  `name` char(40) NOT NULL,
  `PK` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `eo_pk_table`
--

INSERT INTO `eo_pk_table` (`name`, `PK`) VALUES
('Artikel', 3),
('bestellung', 4),
('bestell_position', 10),
('inhalt', 9),
('kunde', 4);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `inhalt`
--

CREATE TABLE `inhalt` (
  `id` int(11) NOT NULL,
  `bezeichnung` varchar(16) NOT NULL,
  `preis` decimal(38,2) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `inhalt`
--

INSERT INTO `inhalt` (`id`, `bezeichnung`, `preis`, `image_path`) VALUES
(1, 'Bleistift', '0.90', 'bleistift.jpg'),
(2, 'Schere', '3.50', 'schere.jpg'),
(3, 'Radiergummi', '0.90', 'gummi.jpg'),
(4, 'Spitzer', '5.00', 'spitzer.jpg'),
(5, 'Filzstift', '1.50', 'filzstift.jpg'),
(6, 'Zirkel', '7.90', 'zirkel.jpg'),
(7, 'Lineal', '2.50', 'lineal.jpg'),
(8, 'Kugelschreiber', '0.90', 'kugelschreiber.jpg');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `konfiguration`
--

CREATE TABLE `konfiguration` (
  `artikel_id` int(11) NOT NULL,
  `inhalt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `konfiguration`
--

INSERT INTO `konfiguration` (`artikel_id`, `inhalt_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 8),
(2, 1),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kunde`
--

CREATE TABLE `kunde` (
  `id` int(11) NOT NULL,
  `vorname` varchar(50) NOT NULL,
  `nachname` varchar(50) NOT NULL,
  `strasse` varchar(20) NOT NULL,
  `plz` varchar(10) NOT NULL,
  `ort` varchar(16) NOT NULL,
  `tel` varchar(16) NOT NULL,
  `kunde_seit` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `kunde`
--

INSERT INTO `kunde` (`id`, `vorname`, `nachname`, `strasse`, `plz`, `ort`, `tel`, `kunde_seit`) VALUES
(1, 'Patrick', 'Estermann', 'Moosburgstrasse 25', '8307', 'Effretikon', '+41 79 863 81 18', '2020-12-11');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `artikel`
--
ALTER TABLE `artikel`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `bestellte_konfiguration`
--
ALTER TABLE `bestellte_konfiguration`
  ADD PRIMARY KEY (`bestellPos_id`,`inhalt_id`),
  ADD KEY `fk_bestkonf_inhalt` (`inhalt_id`);

--
-- Indizes für die Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bestellung_kunde` (`kunde_id`);

--
-- Indizes für die Tabelle `bestell_position`
--
ALTER TABLE `bestell_position`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bestpos_artikel` (`artikel_id`),
  ADD KEY `fk_bestpos_bestellung` (`bestell_id`);

--
-- Indizes für die Tabelle `eo_pk_table`
--
ALTER TABLE `eo_pk_table`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `inhalt`
--
ALTER TABLE `inhalt`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `konfiguration`
--
ALTER TABLE `konfiguration`
  ADD PRIMARY KEY (`artikel_id`,`inhalt_id`),
  ADD KEY `fk_konfig_inhalt` (`inhalt_id`);

--
-- Indizes für die Tabelle `kunde`
--
ALTER TABLE `kunde`
  ADD PRIMARY KEY (`id`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `bestellte_konfiguration`
--
ALTER TABLE `bestellte_konfiguration`
  ADD CONSTRAINT `fk_bestkonf_bestell_pos` FOREIGN KEY (`bestellPos_id`) REFERENCES `bestell_position` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bestkonf_inhalt` FOREIGN KEY (`inhalt_id`) REFERENCES `inhalt` (`id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD CONSTRAINT `fk_bestellung_kunde` FOREIGN KEY (`kunde_id`) REFERENCES `kunde` (`id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `bestell_position`
--
ALTER TABLE `bestell_position`
  ADD CONSTRAINT `fk_bestpos_artikel` FOREIGN KEY (`artikel_id`) REFERENCES `artikel` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bestpos_bestellung` FOREIGN KEY (`bestell_id`) REFERENCES `bestellung` (`id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `konfiguration`
--
ALTER TABLE `konfiguration`
  ADD CONSTRAINT `fk_konfig_artikel` FOREIGN KEY (`artikel_id`) REFERENCES `artikel` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_konfig_inhalt` FOREIGN KEY (`inhalt_id`) REFERENCES `inhalt` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
