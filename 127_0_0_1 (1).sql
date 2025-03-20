-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 20-03-2025 a las 14:28:38
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gimnasio`
--
CREATE DATABASE IF NOT EXISTS `gimnasio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `gimnasio`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicios`
--

DROP TABLE IF EXISTS `ejercicios`;
CREATE TABLE IF NOT EXISTS `ejercicios` (
  `id_ejercicio` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `equipamiento` varchar(50) DEFAULT NULL,
  `dificultad` enum('Básico','Intermedio','Avanzado') NOT NULL DEFAULT 'Básico',
  `id_grupo_muscular` int DEFAULT NULL,
  PRIMARY KEY (`id_ejercicio`),
  KEY `fk_grupo_muscular` (`id_grupo_muscular`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ejercicios`
--

INSERT INTO `ejercicios` (`id_ejercicio`, `nombre`, `descripcion`, `equipamiento`, `dificultad`, `id_grupo_muscular`) VALUES
(1, 'Press de banca', 'Ejercicio de pecho con barra en banco plano.', 'Barra y banco', 'Básico', 1),
(2, 'Sentadilla', 'Ejercicio compuesto para piernas.', 'Barra', 'Básico', 2),
(3, 'Dominadas', 'Ejercicio de espalda con el propio peso corporal.', 'Barra de dominadas', 'Básico', 3),
(4, 'Curl de bíceps', 'Ejercicio de aislamiento para los bíceps.', 'Mancuernas', 'Básico', 4),
(5, 'Press militar', 'Ejercicio de hombros con barra o mancuernas.', 'Barra o mancuernas', 'Intermedio', 5),
(6, 'Crunch abdominal', 'Ejercicio clásico para fortalecer el core.', 'Ninguno', 'Básico', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_musculares`
--

DROP TABLE IF EXISTS `grupos_musculares`;
CREATE TABLE IF NOT EXISTS `grupos_musculares` (
  `id_grupo_muscular` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_grupo_muscular`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `grupos_musculares`
--

INSERT INTO `grupos_musculares` (`id_grupo_muscular`, `nombre`) VALUES
(1, 'Pecho'),
(2, 'Piernas'),
(3, 'Espalda'),
(4, 'Brazos'),
(5, 'Hombros'),
(6, 'Abdominales');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutinas`
--

DROP TABLE IF EXISTS `rutinas`;
CREATE TABLE IF NOT EXISTS `rutinas` (
  `id_rutina` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `objetivo` enum('fuerza','hipertrofia','resistencia') NOT NULL,
  `nivel` enum('principiante','intermedio','avanzado') NOT NULL,
  PRIMARY KEY (`id_rutina`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rutinas`
--

INSERT INTO `rutinas` (`id_rutina`, `id_usuario`, `nombre`, `objetivo`, `nivel`) VALUES
(1, NULL, 'Rutina de Fuerza Principiante', 'fuerza', 'principiante'),
(2, NULL, 'Rutina de Hipertrofia Intermedio', 'hipertrofia', 'intermedio'),
(3, NULL, 'Rutina de Resistencia Avanzado', 'resistencia', 'avanzado'),
(4, 1, 'Rutina de Fuerza Personalizada', 'fuerza', 'intermedio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rutina_ejercicios`
--

DROP TABLE IF EXISTS `rutina_ejercicios`;
CREATE TABLE IF NOT EXISTS `rutina_ejercicios` (
  `id_rutina_ejercicio` int NOT NULL AUTO_INCREMENT,
  `id_rutina` int NOT NULL,
  `id_ejercicio` int NOT NULL,
  `series` int NOT NULL,
  `repeticiones` int NOT NULL,
  `descanso` int NOT NULL,
  PRIMARY KEY (`id_rutina_ejercicio`),
  KEY `id_rutina` (`id_rutina`),
  KEY `id_ejercicio` (`id_ejercicio`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `rutina_ejercicios`
--

INSERT INTO `rutina_ejercicios` (`id_rutina_ejercicio`, `id_rutina`, `id_ejercicio`, `series`, `repeticiones`, `descanso`) VALUES
(1, 1, 1, 4, 5, 120),
(2, 1, 2, 4, 5, 120),
(3, 2, 3, 3, 8, 90),
(4, 3, 4, 3, 15, 60),
(5, 4, 1, 4, 6, 120),
(6, 4, 2, 4, 6, 120);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `contraseña`, `fecha_registro`) VALUES
(1, 'Admin', 'admin@gimnasio.com', 'admin123', '2025-03-15 17:12:34'),
(2, 'Raul', 'raul@gimnasio.com', '123456789', '2025-03-20 07:34:55');
--
-- Base de datos: `prueba`
--
CREATE DATABASE IF NOT EXISTS `prueba` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `prueba`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

DROP TABLE IF EXISTS `tareas`;
CREATE TABLE IF NOT EXISTS `tareas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id`, `nombre`, `id_usuario`) VALUES
(1, 'Tarea prueba', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellidos` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `nombre`, `apellidos`, `email`, `contraseña`) VALUES
(1, 'admin', 'raul', 'garcia arnaiz', 'raulejemplo@gmail.com', '123456');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
