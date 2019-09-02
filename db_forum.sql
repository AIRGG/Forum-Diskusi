-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2019 at 10:04 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_forum`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id_comment` int(11) NOT NULL,
  `id_question` int(11) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `tgl` varchar(8) NOT NULL,
  `jam` varchar(6) NOT NULL,
  `konten` text NOT NULL,
  `img` text NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id_comment`, `id_question`, `userid`, `tgl`, `jam`, `konten`, `img`, `status`) VALUES
(1, 3, 'qq', '10102009', '104508', 'ini bro jawabannya bener gk??', '', 1),
(2, 3, 'gg', '10102001', '164507', 'coba deh', '', 1),
(3, 1, 'qq', '10102009', '164507', 'cek lagi broo', '', 1),
(5, 1, 'gg', '01081990', '180045', 'lagi ngopi lu ya broo ??', '', 1),
(6, 8, 'gg', '01081990', '180045', 'ya namanya juga makan mau naga', '', 1),
(7, 1, 'gg', '01081990', '180045', 'pada di mana broo ??', '', 1),
(8, 1, 'qq', '20012019', '221528', 'cek ulang broo', '', 1),
(9, 1, 'qq', '20012019', '221534', 'yoi bisa bro ', '', 1),
(10, 3, 'gg', '25032019', '102101', 'Haii', '', 1),
(11, 3, 'gg', '25032019', '114649', 'Bro', 'Mix (4).jpg', 1),
(13, 3, 'gg', '25032019', '103453', 'satu lagi\r\n', 'Mix (1).jpg', 1),
(14, 6, 'gg', '25032019', '132032', 'dibogor', '', 1),
(15, 6, 'gg', '29032019', '094842', 'mantull', 'DSC_0017.JPG', 1),
(16, 12, 'gg', '25032019', '160532', 'Yaelah burung kakak tua doang., nihh gw jualan Tupai.,', 'Mix (6).jpg', 1),
(18, 12, 'rizal', '25032019', '172731', 'saufbasijb faosisuh asiufhijfb idfbsidb fsd', '', 1),
(19, 11, 'tur', '25032019', '172950', 'qoy', '', 1),
(20, 11, 'tur', '25032019', '172956', 'xcuk', '', 1),
(21, 12, 'bahri', '25032019', '212755', 'haii Halooo., haiii', 'Mix (14).jpg', 1),
(22, 14, 'bahri', '25032019', '213321', 'upupupupup', '', 1),
(23, 14, 'tegur', '03042019', '220904', 'saya minat nih gan sama ceweknya brp duit?', '', 1),
(24, 14, 'rizal', '26032019', '103757', 'hai ucupppp', '', 1),
(25, 14, 'rizal', '03042019', '233612', '!@#$%^&*( )\' \" { }[ ]\\|:;?/>.<, _ - + =', '', 1),
(26, 17, 'Amanda29', '10042019', '133635', 'wkwkwk', '', 0),
(27, 10, 'Amanda29', '10042019', '134111', 'huhuh\r\n\r\n', '', 1),
(38, 0, 'gg', '11042019', '191455', 'hgdhaGSHAgshAGS', '', 1),
(39, 0, 'gg', '11042019', '191528', 'gfdgasfdgfsagdfasgdf', '', 1),
(40, 14, 'gg', '11042019', '191638', '!@#$%^&*( )\' \" { }[ ]\\|:;?/>.<, _ - + = \' \' \' \' \'', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id_question` int(11) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `tgl` varchar(8) NOT NULL,
  `jam` varchar(6) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `konten` longtext NOT NULL,
  `img` text NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question`
--

INSERT INTO `question` (`id_question`, `userid`, `tgl`, `jam`, `judul`, `konten`, `img`, `status`) VALUES
(1, 'gg', '12122001', '164507', 'Stasiun dimana bro?', 'jadi stasiun kereta pukul setengah dua gtu., ett dah jadi lagu iwan false kita., kekeke :v', '', 1),
(2, 'gg', '10102009', '190808', 'Apakah kau melihat pohon?', 'jsadhjasgdhasgd', '', 1),
(3, 'gg', '25032019', '131751', 'Mantapp lahhhZZZ', 'ini Konten', 'Mix (3).jpg', 1),
(4, 'gg', '10102009', '190808', 'kocag lu ci', 'eaaa', '', 1),
(5, 'gg', '10102009', '190808', 'agdasgdhasgdh', 'gdhgashdgashdgh', '', 1),
(6, 'gg', '10102009', '190808', 'dimana ?', 'di situ', '', 1),
(7, 'qq', '24032019', '123324', 'lagi di mana ??', '', 'Mix (4).jpg', 1),
(8, 'gg', '25032019', '104324', 'lagi pada ngapain broo ??', 'lagi pada ngopi broo\r\n', 'Gbr (1).jpg', 1),
(9, 'gg', '23032019', '170535', 'Pada mau kemana ??', '123123123123123', '', 1),
(10, 'gg', '24032019', '104355', 'QWERTYUIOPPZZ', 'OIUTRERFGVBNM', '', 1),
(11, 'gg', '24032019', '122151', 'Ini juudpoiuytd', 'qwertyuio', 'Gbr (14).jpg', 1),
(12, 'dtx', '26032019', '142033', 'Jual Burung Kakak Tua', 'Kakatua gigi tinggal dua.,', 'Mix (7).jpg', 1),
(13, 'rizal', '25032019', '194400', 'sedang pada apa??', 'ZZZZZZZZZ', '', 1),
(14, 'bahri', '28032019', '180227', 'Jual Rusa', 'Msh Mulus No Minus', 'Mix (1).jpg', 1),
(15, 'dtx', '29032019', '103148', 'Ini adalah Topic Baru...', 'Inin Detail Baru...', '', 1),
(16, 'dtx', '03042019', '235334', 'Ini adalah Topic Baru2', 'Ini adalah Topic Baru2', '', 1),
(17, 'dtx', '03042019', '235344', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. At, tempore, aperiam, sit amet velit', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. At, tempore, aperiam, sit amet velit assumenda soluta libero eum numquam aut hic voluptatem maxime provident rerum fugiat similique quibusdam exercitationem atque.', '', 0),
(18, 'Amanda29', '10042019', '133803', 'uhuuu', 'huhuhuhuhu', '', 1),
(21, 'Eky', '10042019', '145113', 'Promosi', '*******************************************************************           \r\n           *File provided to you by http://www.fullypcgames.net/    *           \r\n           *******************************************************************     \r\n\r\nWebsite: www.fullypcgames.net \r\nWebsite: www.dadsoft.net\r\n\r\nFacebook:www.facebook.com/fullypcgames.blogspot\r\n\r\n\r\nWORLD Best Site for,Solve your Computer Problems \r\nDownload Free Register Software \r\nDownload Free Register Games\r\nDownload Free Mobile Applications\r\nHow to Make Money Online \r\nWatch Live TV Channals \r\nLearn Complete Computer Softwares \r\nand Computer Tips in Urdu Language with Video.\r\n\r\n\r\n           *******************************************************************           \r\n           *File provided to you by http://www.dadsoft.net/    *           \r\n           *******************************************************************    ', 'WIN_20190408_09_08_03_Pro.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `subcomment`
--

CREATE TABLE `subcomment` (
  `id_subcomment` int(11) NOT NULL,
  `id_comment` int(11) NOT NULL,
  `id_question` int(11) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `tgl` varchar(8) NOT NULL,
  `jam` varchar(6) NOT NULL,
  `konten` text NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subcomment`
--

INSERT INTO `subcomment` (`id_subcomment`, `id_comment`, `id_question`, `userid`, `tgl`, `jam`, `konten`, `status`) VALUES
(1, 1, 3, 'gg', '10102010', '101943', 'ini adalah subcomment', 1),
(2, 1, 3, 'dtx', '25032019', '131730', 'subcomment\n', 1),
(3, 14, 6, 'dtx', '25032019', '132041', 'kocakkocak\n', 1),
(4, 15, 6, 'dtx', '25032019', '132156', 'asdaasidisa', 1),
(5, 15, 6, 'dtx', '25032019', '132221', 'kcoaokcaokcaokcoakca', 1),
(6, 7, 1, 'dtx', '25032019', '151747', 'ASDSFG', 1),
(7, 16, 12, 'dtx', '31032019', '113728', 'wehh Baik broo., hehehe., semangat oke.., :) <br/>\nMantappp', 1),
(8, 18, 12, 'bahri', '25032019', '212902', 'Ehh zal apa kabar???', 1),
(9, 23, 14, 'bahri', '31032019', '115658', 'ceweknya gk di jual broo dia istri gw', 1),
(10, 23, 14, 'tegur', '25032019', '213917', 'ya udah istri lu gw beli ajh sini 500k + kuping kiri', 1),
(11, 23, 14, 'bahri', '25032019', '213958', 'gk mau ah kuping lu banyak congeknya', 1),
(12, 25, 14, 'gg', '03042019', '220736', '!@#$%^&*( )\' \" { }[ ]\\|:;?/>.<, _ - + =', 1),
(13, 26, 17, 'dtx', '10042019', '133653', 'heiii', 0),
(19, 23, 14, 'gg', '11042019', '191152', 'shagdhasgd', 1),
(20, 23, 14, 'gg', '11042019', '191227', 'asgfdgasfdgds', 1);

-- --------------------------------------------------------

--
-- Table structure for table `userprofile`
--

CREATE TABLE `userprofile` (
  `userid` varchar(20) NOT NULL,
  `password` text NOT NULL,
  `nama` varchar(50) NOT NULL,
  `dob` varchar(8) NOT NULL,
  `address` text NOT NULL,
  `image` text NOT NULL,
  `acces` int(1) NOT NULL,
  `role` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userprofile`
--

INSERT INTO `userprofile` (`userid`, `password`, `nama`, `dob`, `address`, `image`, `acces`, `role`) VALUES
('admin', '123', 'Mamank ADMIN', '00000000', 'undefined', '', 1, 1),
('Amanda29', '12345', 'uu', '01042019', 'Bogor', 'ade.jpg', 1, 2),
('bahri', '123', 'Ucup Nirin', '12032019', 'Bojong', 'Mix (11).jpg', 1, 2),
('coba', '123', 'coba', '02042019', 'gg', 'justen.jpg', 1, 2),
('dfghjk', 'fghjk', 'fdghj', '18032019', 'fghjk', 'chris.jpg', 1, 2),
('dtx', '123', 'Angga', '18032019', 'Di RUmah', 'justen.jpg', 1, 2),
('eky', 'ekyganteng', 'Rezkyky', '02043002', 'Big Bojong', 'WIN_20190408_09_08_10_Pro.jpg', 1, 2),
('Eky_BESar', 'ekyganteng', 'Rezky Widira', '02042002', 'Bojong Besar', 'nan.jpg', 1, 2),
('gg', '123', 'GoodGame', '13022009', 'Cibinong', 'steve.jpg', 1, 2),
('qq', '123', 'QueQue', '00000000', 'BGR', '', 1, 2),
('rizal', '123', 'rizal', '06032019', 'bojong', 'Mix (4).jpg', 1, 2),
('tegur', '123', 'Tegar Airlangga', '14032019', 'Kp Pos', 'justen.jpg', 1, 2),
('tur', 'tur', 'tur', '21032019', 'tur', 'nan.jpg', 1, 2),
('zahra28', '123', 'gugu', '22042019', 'sukahati', 'elliot.jpg', 1, 2),
('zahra29', '12345', 'zahra', '30042019', 'bogor', 'elliot.jpg', 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id_comment`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id_question`);

--
-- Indexes for table `subcomment`
--
ALTER TABLE `subcomment`
  ADD PRIMARY KEY (`id_subcomment`);

--
-- Indexes for table `userprofile`
--
ALTER TABLE `userprofile`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id_question` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `subcomment`
--
ALTER TABLE `subcomment`
  MODIFY `id_subcomment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
