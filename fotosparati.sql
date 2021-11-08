-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 19-04-2021 a las 03:51:53
-- Versión del servidor: 5.7.31
-- Versión de PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fotosparati`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `contrasena` varchar(255) COLLATE utf8_bin NOT NULL,
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `admin`
--

INSERT INTO `admin` (`id`, `nombre`, `email`, `contrasena`, `activo`) VALUES
(1, 'andres', 'adelfriedkhol@fotosparati.com', '123', 1),
(2, 'kony', 'kony@fotosparati.com', '123', 1),
(3, 'admin3', 'admin3@fotosparati.com', '123', 1),
(4, 'admin4', 'admin4@fotosparati.com', '123', 1),
(5, 'admin5', 'admin5@fotosparati.com', '123', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carro_compra`
--

DROP TABLE IF EXISTS `carro_compra`;
CREATE TABLE IF NOT EXISTS `carro_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `foto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_bin NOT NULL,
  `email` varchar(255) COLLATE utf8_bin NOT NULL,
  `contrasena` varchar(255) COLLATE utf8_bin NOT NULL,
  `activo` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombre`, `email`, `contrasena`, `activo`) VALUES
(1, 'andres', 'adelfriedkhol@gmail.com', '123', 1),
(2, 'lucia', 'kony@gmail.com', '123', 1),
(3, 'sofia', 'sofia@gmail.com', '123', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foto`
--

DROP TABLE IF EXISTS `foto`;
CREATE TABLE IF NOT EXISTS `foto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contenido` varchar(255) COLLATE utf8_bin NOT NULL,
  `titulo` varchar(255) COLLATE utf8_bin NOT NULL,
  `activa` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `foto`
--

INSERT INTO `foto` (`id`, `contenido`, `titulo`, `activa`) VALUES
(1, '1.jpg', 'verde', 1),
(2, '2.jpg', 'Olas', 1),
(3, '3.jpg', 'Arboles', 1),
(4, '4.jpg', 'Byn', 1),
(5, '5.jpg', 'Luna', 1),
(6, '6.jpg', 'lucia', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_deseo`
--

DROP TABLE IF EXISTS `lista_deseo`;
CREATE TABLE IF NOT EXISTS `lista_deseo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `foto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `lista_deseo`
--

INSERT INTO `lista_deseo` (`id`, `cliente_id`, `foto_id`) VALUES
(1, 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden`
--

DROP TABLE IF EXISTS `orden`;
CREATE TABLE IF NOT EXISTS `orden` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `orden`
--

INSERT INTO `orden` (`id`, `fecha`, `cliente_id`, `total`) VALUES
(1, '2021-04-17', 1, 2),
(2, '2021-04-18', 2, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_detalle`
--

DROP TABLE IF EXISTS `orden_detalle`;
CREATE TABLE IF NOT EXISTS `orden_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orden_id` int(11) NOT NULL,
  `foto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Volcado de datos para la tabla `orden_detalle`
--

INSERT INTO `orden_detalle` (`id`, `orden_id`, `foto_id`) VALUES
(1, 1, 5),
(2, 1, 6),
(3, 2, 3),
(4, 2, 2),
(5, 2, 4);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
