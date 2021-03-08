-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 04, 2020 at 07:29 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bakery_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `dessert`
--

CREATE TABLE `dessert` (
  `no` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dessert`
--

INSERT INTO `dessert` (`no`, `name`, `price`, `stock`, `image`, `category`) VALUES
(1, 'Brownie', 25, 15, 'https://storage.googleapis.com/hippodrome/brownie.png', 1),
(2, 'Cheesecake', 50, 10, 'https://storage.googleapis.com/hippodrome/cheesecake.png', 1),
(3, 'Crossaint', 20, 20, 'https://storage.googleapis.com/hippodrome/crossiant.png', 1),
(4, 'Macaron', 30, 25, 'https://storage.googleapis.com/hippodrome/macaron.png', 1),
(5, 'Banana muffin', 20, 16, 'https://storage.googleapis.com/hippodrome/muffin.png', 1),
(6, 'Soft cookie', 35, 5, 'https://storage.googleapis.com/hippodrome/cookie.png', 1),
(7, 'Iced coffee', 45, 15, 'https://storage.googleapis.com/hippodrome/coffee.png', 2),
(8, 'Iced chocolate', 55, 15, 'https://storage.googleapis.com/hippodrome/choco.png', 2),
(9, 'Iced tea', 35, 15, 'https://storage.googleapis.com/hippodrome/tea.png', 2),
(10, 'Iced green tea', 45, 15, 'https://storage.googleapis.com/hippodrome/greentea.png', 2);

-- --------------------------------------------------------

--
-- Table structure for table `p_order`
--

CREATE TABLE `p_order` (
  `no` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `p_order`
--

INSERT INTO `p_order` (`no`, `customer_id`, `product_id`, `quantity`, `total`) VALUES
(1, 1, 1, 1, 25),
(2, 1, 2, 1, 50),
(3, 1, 1, 3, 75),
(4, 1, 2, 1, 50),
(5, 1, 3, 1, 20),
(6, 1, 4, 3, 90),
(7, 1, 1, 1, 25);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `no` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`no`, `username`, `password`) VALUES
(1, 'aomtanaporn', '123456'),
(2, 'singto4me', '456789');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dessert`
--
ALTER TABLE `dessert`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `p_order`
--
ALTER TABLE `p_order`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dessert`
--
ALTER TABLE `dessert`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `p_order`
--
ALTER TABLE `p_order`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
