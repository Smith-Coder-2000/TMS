-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: May 09, 2022 at 10:59 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tms`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(10) NOT NULL,
  `admin_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `role` varchar(25) NOT NULL,
  `phone_number` int(12) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `cust_id` int(10) NOT NULL,
  `cust_name` varchar(25) NOT NULL,
  `cust_age` int(2) NOT NULL,
  `phone_number` int(12) NOT NULL,
  `email` varchar(25) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`cust_id`, `cust_name`, `cust_age`, `phone_number`, `email`, `password`) VALUES
(1000, 'Ashwin', 22, 2147483647, 'ashwinkumar@gmail.com', '{\r\n  iv: \'57ca86c3fef80925da80e58c833f24c3\',\r\n  encryptedData: \'4f9c711ad5b0e661a3198706c3a6459d\'\r\n}'),
(1001, 'Amber', 23, 2147483647, 'amberlinda@gmail.com', ''),
(1002, 'Rapunzel', 20, 2147483647, 'rapunzel12@gmail.com', ''),
(1003, 'Vikash', 24, 2147483647, 'vikashkumar@gmail.com', ''),
(1004, 'Smith', 21, 2147483647, 'smithcdgmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(10) NOT NULL,
  `movie_name` varchar(20) NOT NULL,
  `genre` varchar(10) NOT NULL,
  `release_date` date NOT NULL,
  `movie_poster` varchar(40) NOT NULL,
  `director` varchar(10) NOT NULL,
  `starring` varchar(25) NOT NULL,
  `language` varchar(20) NOT NULL,
  `duration` int(3) NOT NULL,
  `rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `movie_name`, `genre`, `release_date`, `movie_poster`, `director`, `starring`, `language`, `duration`, `rating`) VALUES
(516, 'KGF', 'action', '2022-04-14', 'assets/images/kgf.jpg', 'prasanth n', 'yash', 'all', 180, 5),
(517, 'The Flash', 'action', '2022-04-17', 'assets/images/flash.jpg', 'Greg Berla', 'Grant Gustin', 'english', 160, 5),
(518, 'Doctor Strange: In T', 'action', '2022-05-06', 'assets/images/doctorStran', 'Sam Raimi', 'Benedict Cumberbatch', 'english', 126, 0),
(519, 'Runway 34', 'action', '2022-04-29', 'assets/images/runway34.jp', 'Ajay Devgn', 'Ajay Devgn', 'hindi', 190, 0),
(520, 'RRR', 'action', '2022-03-25', 'assets/images/rrr.jpg', 'S. S. Raja', 'Jr. NTR,Ram Charan', 'all', 182, 5);

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `offer_id` int(10) NOT NULL,
  `movie_id` int(10) NOT NULL,
  `price` float(5,2) NOT NULL,
  `validity` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `screens`
--

CREATE TABLE `screens` (
  `screen_id` int(2) NOT NULL,
  `screen_type` varchar(10) NOT NULL,
  `screen_name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `screens`
--

INSERT INTO `screens` (`screen_id`, `screen_type`, `screen_name`) VALUES
(1, 'IMAX', 'AUDI_1'),
(2, 'GOLD', 'AUDI_2'),
(3, 'CLASSIC', 'AUDI_3'),
(4, 'CLASSIC', 'AUDI_4');

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `seat_id` int(10) NOT NULL,
  `seat_type` varchar(5) NOT NULL,
  `screen_id` int(2) NOT NULL,
  `status` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`seat_id`, `seat_type`, `screen_id`, `status`) VALUES
(1, 'norma', 1, 0),
(2, 'norma', 1, 1),
(3, 'norma', 1, 0),
(4, 'norma', 1, 1),
(5, 'norma', 1, 0),
(6, 'norma', 1, 0),
(7, 'norma', 1, 1),
(8, 'norma', 1, 1),
(9, 'norma', 1, 0),
(10, 'norma', 1, 0),
(11, 'norma', 1, 1),
(12, 'norma', 1, 0),
(13, 'norma', 1, 1),
(14, 'norma', 1, 0),
(15, 'norma', 1, 0),
(16, 'norma', 1, 1),
(17, 'norma', 1, 0),
(18, 'norma', 1, 0),
(19, 'norma', 1, 1),
(20, 'norma', 1, 0),
(21, 'norma', 1, 0),
(22, 'norma', 1, 1),
(23, 'norma', 1, 0),
(24, 'norma', 1, 0),
(25, 'norma', 1, 1),
(26, 'norma', 1, 0),
(27, 'norma', 1, 1),
(28, 'norma', 1, 0),
(29, 'norma', 1, 1),
(30, 'norma', 1, 0),
(31, 'premi', 1, 0),
(32, 'premi', 1, 1),
(33, 'premi', 1, 0),
(34, 'premi', 1, 1),
(35, 'premi', 1, 0),
(36, 'premi', 1, 1),
(37, 'premi', 1, 1),
(38, 'premi', 1, 0),
(39, 'premi', 1, 1),
(40, 'premi', 1, 0),
(41, 'premi', 1, 1),
(42, 'premi', 1, 0),
(43, 'premi', 1, 1),
(44, 'premi', 1, 0),
(45, 'premi', 1, 1),
(46, 'premi', 1, 0),
(47, 'premi', 1, 1),
(48, 'premi', 1, 0),
(49, 'premi', 1, 0),
(50, 'premi', 1, 1),
(51, 'norma', 2, 0),
(52, 'norma', 2, 1),
(53, 'norma', 2, 0),
(54, 'norma', 2, 0),
(55, 'norma', 2, 0),
(56, 'norma', 2, 1),
(57, 'norma', 2, 0),
(58, 'norma', 2, 1),
(59, 'norma', 2, 0),
(60, 'norma', 2, 0),
(61, 'norma', 2, 1),
(62, 'norma', 2, 0),
(63, 'norma', 2, 0),
(64, 'norma', 2, 1),
(65, 'norma', 2, 1),
(66, 'norma', 2, 0),
(67, 'norma', 2, 1),
(68, 'norma', 2, 1),
(69, 'norma', 2, 1),
(70, 'norma', 2, 1),
(71, 'norma', 2, 1),
(72, 'norma', 2, 1),
(73, 'norma', 2, 0),
(74, 'norma', 2, 0),
(75, 'norma', 2, 1),
(76, 'norma', 2, 1),
(77, 'norma', 2, 0),
(78, 'norma', 2, 1),
(79, 'norma', 2, 1),
(80, 'norma', 2, 1),
(81, 'premi', 2, 0),
(82, 'premi', 2, 1),
(83, 'premi', 2, 0),
(84, 'premi', 2, 1),
(85, 'premi', 2, 0),
(86, 'premi', 2, 1),
(87, 'premi', 2, 0),
(88, 'premi', 2, 1),
(89, 'premi', 2, 0),
(90, 'premi', 2, 0),
(91, 'premi', 2, 0),
(92, 'premi', 2, 0),
(93, 'premi', 2, 0),
(95, 'premi', 2, 1),
(96, 'premi', 2, 0),
(97, 'premi', 2, 1),
(98, 'premi', 2, 0),
(99, 'premi', 2, 1),
(200, 'premi', 2, 1),
(201, 'norma', 3, 0),
(202, 'norma', 3, 1),
(203, 'norma', 3, 0),
(204, 'norma', 3, 1),
(205, 'norma', 3, 0),
(206, 'norma', 3, 0),
(207, 'norma', 3, 1),
(208, 'norma', 3, 0),
(209, 'norma', 3, 1),
(210, 'norma', 3, 0),
(211, 'norma', 3, 1),
(212, 'norma', 3, 0),
(213, 'norma', 3, 1),
(214, 'norma', 3, 0),
(215, 'norma', 3, 0),
(216, 'norma', 3, 1),
(217, 'norma', 3, 1),
(218, 'norma', 3, 0),
(219, 'norma', 3, 1),
(220, 'norma', 3, 0),
(221, 'norma', 3, 1),
(222, 'norma', 3, 0),
(223, 'norma', 3, 1),
(224, 'norma', 3, 1),
(225, 'norma', 3, 0),
(226, 'norma', 3, 1),
(227, 'norma', 3, 1),
(228, 'norma', 3, 1),
(229, 'norma', 3, 0),
(230, 'norma', 3, 1),
(231, 'premi', 3, 1),
(232, 'premi', 3, 0),
(233, 'premi', 3, 1),
(234, 'premi', 3, 1),
(235, 'premi', 3, 0),
(236, 'premi', 3, 1),
(237, 'premi', 3, 0),
(238, 'premi', 3, 1),
(239, 'premi', 3, 0),
(240, 'premi', 3, 0),
(241, 'premi', 3, 0),
(242, 'premi', 3, 1),
(243, 'premi', 3, 0),
(244, 'premi', 3, 0),
(245, 'premi', 3, 0),
(246, 'premi', 3, 1),
(247, 'premi', 3, 0),
(248, 'premi', 3, 1),
(249, 'premi', 3, 0),
(250, 'premi', 3, 1),
(251, 'norma', 4, 1),
(252, 'norma', 4, 0),
(253, 'norma', 4, 1),
(254, 'norma', 4, 0),
(255, 'norma', 4, 1),
(256, 'norma', 4, 1),
(257, 'norma', 4, 0),
(258, 'norma', 4, 1),
(259, 'norma', 4, 1),
(260, 'norma', 4, 0),
(261, 'norma', 4, 1),
(262, 'norma', 4, 1),
(263, 'norma', 4, 1),
(264, 'norma', 4, 1),
(265, 'norma', 4, 0),
(266, 'norma', 4, 1),
(267, 'norma', 4, 0),
(268, 'norma', 4, 1),
(269, 'norma', 4, 0),
(270, 'norma', 4, 1),
(271, 'norma', 4, 1),
(272, 'norma', 4, 0),
(273, 'norma', 4, 0),
(274, 'norma', 4, 1),
(275, 'norma', 4, 0),
(276, 'norma', 4, 1),
(277, 'norma', 4, 0),
(278, 'norma', 4, 0),
(279, 'norma', 4, 1),
(280, 'norma', 4, 0),
(281, 'premi', 4, 0),
(282, 'premi', 4, 0),
(283, 'premi', 4, 1),
(284, 'premi', 4, 1),
(285, 'premi', 4, 0),
(286, 'premi', 4, 0),
(287, 'premi', 4, 0),
(288, 'premi', 4, 0),
(289, 'premi', 4, 0),
(290, 'premi', 4, 1),
(291, 'premi', 4, 0),
(292, 'premi', 4, 1),
(293, 'premi', 4, 0),
(294, 'premi', 4, 1),
(295, 'premi', 4, 0),
(296, 'premi', 4, 1),
(297, 'premi', 4, 0),
(298, 'premi', 4, 1),
(299, 'premi', 4, 0),
(300, 'premi', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shows`
--

CREATE TABLE `shows` (
  `show_id` int(10) NOT NULL,
  `start_time` time(5) NOT NULL,
  `end_time` time(5) NOT NULL,
  `date` date NOT NULL,
  `screen_id` int(2) NOT NULL,
  `movie_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shows`
--

INSERT INTO `shows` (`show_id`, `start_time`, `end_time`, `date`, `screen_id`, `movie_id`) VALUES
(1006, '20:25:00.00000', '24:00:00.00000', '2022-05-08', 1, 516),
(1007, '09:00:00.00000', '11:00:00.00000', '2022-05-09', 4, 516);

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `ticket_id` int(10) NOT NULL,
  `no_seats` int(10) NOT NULL,
  `price` float(5,2) NOT NULL,
  `show_id` int(10) NOT NULL,
  `cust_id` int(10) NOT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_details`
--

CREATE TABLE `ticket_details` (
  `seat_id` int(10) NOT NULL,
  `ticket_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(10) NOT NULL,
  `date` date NOT NULL,
  `payment_type` varchar(6) NOT NULL,
  `status` varchar(10) NOT NULL,
  `total_pay` float(5,2) DEFAULT NULL,
  `ticket_id` int(10) NOT NULL,
  `offer_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`cust_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`offer_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `screens`
--
ALTER TABLE `screens`
  ADD PRIMARY KEY (`screen_id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`seat_id`),
  ADD KEY `screen_id` (`screen_id`);

--
-- Indexes for table `shows`
--
ALTER TABLE `shows`
  ADD PRIMARY KEY (`show_id`),
  ADD KEY `screen_id` (`screen_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `show_id` (`show_id`),
  ADD KEY `cust_id` (`cust_id`);

--
-- Indexes for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD KEY `seat_id` (`seat_id`),
  ADD KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `offer_id` (`offer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `cust_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1005;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `movie_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=521;

--
-- AUTO_INCREMENT for table `shows`
--
ALTER TABLE `shows`
  MODIFY `show_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1008;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`screen_id`) REFERENCES `screens` (`screen_id`);

--
-- Constraints for table `shows`
--
ALTER TABLE `shows`
  ADD CONSTRAINT `shows_ibfk_1` FOREIGN KEY (`screen_id`) REFERENCES `screens` (`screen_id`),
  ADD CONSTRAINT `shows_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`show_id`) REFERENCES `shows` (`show_id`),
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`cust_id`);

--
-- Constraints for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD CONSTRAINT `ticket_details_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`seat_id`),
  ADD CONSTRAINT `ticket_details_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`offer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
