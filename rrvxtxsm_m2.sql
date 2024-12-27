-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 11 2024 г., 02:16
-- Версия сервера: 5.7.33-0ubuntu0.16.04.1
-- Версия PHP: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `rrvxtxsm_m2`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Auto`
--

CREATE TABLE `Auto` (
  `id` int(11) NOT NULL,
  `MarkId` int(11) NOT NULL,
  `ModelId` int(11) NOT NULL,
  `Number` varchar(12) NOT NULL,
  `VinNumber` varchar(17) NOT NULL,
  `Ownerld` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Auto`
--

INSERT INTO `Auto` (`id`, `MarkId`, `ModelId`, `Number`, `VinNumber`, `Ownerld`) VALUES
(1, 1, 1, 'св555о', 'авапкаьргбл', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `Client`
--

CREATE TABLE `Client` (
  `id` int(11) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `Middlename` varchar(50) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Mail` varchar(50) NOT NULL,
  `Login` varchar(50) NOT NULL,
  `Pass_hash` varchar(100) NOT NULL,
  `Permission` tinyint(1) NOT NULL DEFAULT '0',
  `RegDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `LogDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Client`
--

INSERT INTO `Client` (`id`, `LastName`, `FirstName`, `Middlename`, `PhoneNumber`, `Mail`, `Login`, `Pass_hash`, `Permission`, `RegDate`, `LogDate`) VALUES
(1, 'safdsadas', 'dadsada', 'dsada', '86503342255', '374374', '43434', '344', 0, '2024-12-06 01:53:11', '2024-12-06 01:53:11'),
(2, 'Doe', 'John', 'Middle', '1234567890', 'john.doe@example.com', 'johndoe', '$2y$10$9uT4GA8nVG30xurw6YCb3uLKjbxXA3HuOfKtx8ZvJ7gWHTIhFW6Bi', 0, '2024-12-06 02:39:50', '2024-12-06 02:39:50');

-- --------------------------------------------------------

--
-- Структура таблицы `Marks`
--

CREATE TABLE `Marks` (
  `id` int(11) NOT NULL,
  `Mark` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Marks`
--

INSERT INTO `Marks` (`id`, `Mark`) VALUES
(1, 'mazda');

-- --------------------------------------------------------

--
-- Структура таблицы `Models`
--

CREATE TABLE `Models` (
  `id` int(11) NOT NULL,
  `Model` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Models`
--

INSERT INTO `Models` (`id`, `Model`) VALUES
(1, 'rx 7');

-- --------------------------------------------------------

--
-- Структура таблицы `Request`
--

CREATE TABLE `Request` (
  `id` int(11) NOT NULL,
  `StatusId` int(11) NOT NULL,
  `AutoId` int(11) NOT NULL,
  `SubDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `Description` text NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Request`
--

INSERT INTO `Request` (`id`, `StatusId`, `AutoId`, `SubDate`, `EndDate`, `Description`, `Price`) VALUES
(1, 1, 1, '2024-12-06 03:00:45', '2024-12-06 03:00:45', 'шина бабах\r\n', 666),
(2, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000),
(3, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000),
(4, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000),
(5, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000),
(6, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000),
(7, 1, 1, '2023-10-01 00:00:00', '2023-10-10 00:00:00', 'Шина бабах', 1000);

-- --------------------------------------------------------

--
-- Структура таблицы `Status`
--

CREATE TABLE `Status` (
  `id` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `Status`
--

INSERT INTO `Status` (`id`, `status`) VALUES
(1, 'Принят в работу');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Auto`
--
ALTER TABLE `Auto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `MarkId` (`MarkId`),
  ADD KEY `ModelId` (`ModelId`),
  ADD KEY `Ownerld` (`Ownerld`);

--
-- Индексы таблицы `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Marks`
--
ALTER TABLE `Marks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Models`
--
ALTER TABLE `Models`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Request`
--
ALTER TABLE `Request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `AutoId` (`AutoId`),
  ADD KEY `StatusId` (`StatusId`);

--
-- Индексы таблицы `Status`
--
ALTER TABLE `Status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Auto`
--
ALTER TABLE `Auto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `Client`
--
ALTER TABLE `Client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `Marks`
--
ALTER TABLE `Marks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `Models`
--
ALTER TABLE `Models`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `Request`
--
ALTER TABLE `Request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `Status`
--
ALTER TABLE `Status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Auto`
--
ALTER TABLE `Auto`
  ADD CONSTRAINT `Auto_ibfk_1` FOREIGN KEY (`MarkId`) REFERENCES `Marks` (`id`),
  ADD CONSTRAINT `Auto_ibfk_2` FOREIGN KEY (`ModelId`) REFERENCES `Models` (`id`),
  ADD CONSTRAINT `Auto_ibfk_3` FOREIGN KEY (`Ownerld`) REFERENCES `Client` (`id`);

--
-- Ограничения внешнего ключа таблицы `Request`
--
ALTER TABLE `Request`
  ADD CONSTRAINT `Request_ibfk_1` FOREIGN KEY (`AutoId`) REFERENCES `Auto` (`id`),
  ADD CONSTRAINT `Request_ibfk_2` FOREIGN KEY (`StatusId`) REFERENCES `Status` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
