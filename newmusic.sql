-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2025 at 05:13 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `newmusic`
--

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` int(11) NOT NULL,
  `songName` varchar(255) NOT NULL,
  `artistName` varchar(255) NOT NULL,
  `filePath` varchar(500) NOT NULL,
  `coverImagePath` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `songName`, `artistName`, `filePath`, `coverImagePath`) VALUES
(1, 'chahun mai ya naa', 'arijit singh', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Chahun Main Ya Naa Aashiqui 2.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\no.jpg'),
(2, 'Aur Ho', 'A.R. Rahman', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Aur Ho Rockstar.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\rockstar.jpg'),
(3, 'Chaandaniya', 'Shankar-Eshaan-Loy', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Chaandaniya 2 States.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\2-states.jpg'),
(5, 'Maahi Ve', 'A.R.Rahman', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Maahi Ve Highway.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\highway.jpg'),
(6, 'Pasoori', 'Shae Gill', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Pasoori Shae Gill.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\pasoori.jpg'),
(7, 'Phir Se Udd Chala', 'Mohit Chauhan', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\songs\\Phir Se Ud Chala Rockstar.mp3', 'C:\\Users\\Admin\\OneDrive\\Desktop\\vsc\\sem3-projects\\python\\music player\\cover-image\\rockstar.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'rajvi', '123'),
(2, 'admin', '123');

-- --------------------------------------------------------

--
-- Table structure for table `user_songs`
--

CREATE TABLE `user_songs` (
  `userId` int(11) NOT NULL,
  `songId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_songs`
--

INSERT INTO `user_songs` (`userId`, `songId`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 5),
(1, 6),
(1, 7),
(2, 6),
(2, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_songs`
--
ALTER TABLE `user_songs`
  ADD PRIMARY KEY (`userId`,`songId`),
  ADD KEY `songId` (`songId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_songs`
--
ALTER TABLE `user_songs`
  ADD CONSTRAINT `user_songs_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_songs_ibfk_2` FOREIGN KEY (`songId`) REFERENCES `songs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
