-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 15, 2018 at 05:12 PM
-- Server version: 5.5.58-0+deb8u1
-- PHP Version: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wm`
--

-- --------------------------------------------------------

--
-- Table structure for table `allg_info`
--

CREATE TABLE IF NOT EXISTS `allg_info` (
`id` int(10) NOT NULL,
  `routerid` varchar(30) NOT NULL,
  `interface` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `allg_info`
--

INSERT INTO `allg_info` (`id`, `routerid`, `interface`) VALUES
(1, '4400', 'eth0.16'),
(2, '4400', 'eth0.5'),
(3, '4400', 'eth0.4'),
(4, '4400', 'eth0.6'),
(5, '4409', 'eth0.5'),
(6, '4409', 'eth0.4'),
(7, '4400', 'eth0.7'),
(8, '4782', 'eth0.101'),
(9, '4398', 'redgw'),
(10, '4757', 'vm2fffgwcd1'),
(11, '5119', 'fffgwaquarius'),
(12, '4837', 'vm2fffgwcd1');

-- --------------------------------------------------------

--
-- Table structure for table `bytes_data`
--

CREATE TABLE IF NOT EXISTS `bytes_data` (
`id` int(10) NOT NULL,
  `id_allg_info` int(10) NOT NULL,
  `time` int(16) NOT NULL,
  `rx_bytes` bigint(32) NOT NULL,
  `tx_bytes` bigint(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2530 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bytes_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `traffic_data`
--

CREATE TABLE IF NOT EXISTS `traffic_data` (
`id` int(10) NOT NULL,
  `id_allg_info` int(10) NOT NULL,
  `rx_traffic` int(32) NOT NULL,
  `tx_traffic` int(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `traffic_data`
--

INSERT INTO `traffic_data` (`id`, `id_allg_info`, `rx_traffic`, `tx_traffic`) VALUES
(4, 1, 277808, 6639200),
(5, 2, 6449496, 1857256),
(6, 3, 1609904, 53360),
(7, 4, 6848, 6264),
(8, 5, 26136, 1065112),
(9, 6, 2424320, 126008),
(10, 7, 8, 6520),
(11, 8, 75408, 153128),
(12, 9, 2561776, 119208),
(13, 10, 8569856, 2204472),
(14, 11, 25536, 303144),
(15, 12, 7448, 8360);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allg_info`
--
ALTER TABLE `allg_info`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bytes_data`
--
ALTER TABLE `bytes_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `traffic_data`
--
ALTER TABLE `traffic_data`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allg_info`
--
ALTER TABLE `allg_info`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `bytes_data`
--
ALTER TABLE `bytes_data`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2530;
--
-- AUTO_INCREMENT for table `traffic_data`
--
ALTER TABLE `traffic_data`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

