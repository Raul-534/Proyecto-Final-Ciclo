-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 10-04-2025 a las 15:02:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id_ejercicio` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `equipamiento` varchar(50) DEFAULT NULL,
  `dificultad` enum('Básico','Intermedio','Avanzado') NOT NULL DEFAULT 'Básico',
  `id_grupo_muscular` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ejercicios`
--

INSERT INTO `ejercicios` (`id_ejercicio`, `nombre`, `descripcion`, `equipamiento`, `dificultad`, `id_grupo_muscular`) VALUES
(1, 'Press de banca', 'Ejercicio de pecho con barra en banco plano.', 'Barra y banco', 'Básico', 1),
(2, 'Sentadilla', 'Ejercicio compuesto para piernas.', 'Barra', 'Básico', 2),
(3, 'Dominadas', 'Ejercicio de espalda con el propio peso corporal.', 'Barra de dominadas', 'Básico', 3),
(4, 'Curl de bíceps', 'Ejercicio de aislamiento para los bíceps.', 'Mancuernas', 'Básico', 4),
(5, 'Press militar', 'Ejercicio de hombros con barra o mancuernas.', 'Barra o mancuernas', 'Intermedio', 5),
(6, 'Crunch abdominal', 'Ejercicio clásico para fortalecer el core.', 'Ninguno', 'Básico', 6),
(7, 'Aperturas con mancuernas', 'Ejercicio para trabajar la apertura del pecho.', 'Mancuernas', 'Básico', 1),
(8, 'Press inclinado con barra', 'Ejercicio para enfatizar la parte superior del pecho.', 'Barra y banco inclinado', 'Intermedio', 1),
(9, 'Fondos en paralelas', 'Ejercicio de peso corporal para pecho y tríceps.', 'Barras paralelas', 'Avanzado', 1),
(10, 'Pullover con mancuerna', 'Ejercicio para la expansión torácica y activación del pectoral.', 'Mancuerna y banco', 'Intermedio', 1),
(11, 'Prensa de piernas', 'Ejercicio guiado para trabajar los músculos de las piernas.', 'Máquina de prensa', 'Básico', 2),
(12, 'Peso muerto rumano', 'Ejercicio para fortalecer los isquiotibiales y glúteos.', 'Barra o mancuernas', 'Intermedio', 2),
(13, 'Extensión de piernas', 'Ejercicio de aislamiento para los cuádriceps.', 'Máquina de extensión', 'Intermedio', 2),
(14, 'Remo con barra', 'Ejercicio clave para la parte media de la espalda.', 'Barra y discos', 'Intermedio', 3),
(15, 'Jalón al pecho', 'Ejercicio en polea para desarrollar la espalda ancha.', 'Máquina de poleas', 'Básico', 3),
(16, 'Remo con mancuerna', 'Ejercicio unilateral para desarrollar la espalda.', 'Mancuerna', 'Intermedio', 3),
(17, 'Face pull', 'Ejercicio en polea para fortalecer la parte superior de la espalda.', 'Cuerda en polea', 'Avanzado', 3),
(18, 'Curl martillo', 'Ejercicio para trabajar el braquiorradial y bíceps.', 'Mancuernas', 'Básico', 4),
(19, 'Curl con barra Z', 'Ejercicio para reducir tensión en muñecas y aislar el bíceps.', 'Barra Z', 'Intermedio', 4),
(20, 'Curl concentrado', 'Ejercicio para trabajar la cabeza larga del bíceps.', 'Mancuerna', 'Básico', 4),
(21, 'Curl en banco Scott', 'Ejercicio guiado para máxima activación del bíceps.', 'Banco Scott y barra Z', 'Intermedio', 4),
(22, 'Elevaciones laterales', 'Ejercicio para trabajar el deltoides medio.', 'Mancuernas', 'Básico', 5),
(23, 'Press Arnold', 'Variación del press para activar todas las cabezas del deltoides.', 'Mancuernas', 'Intermedio', 5),
(24, 'Pájaros con mancuernas', 'Ejercicio para el deltoides posterior.', 'Mancuernas', 'Básico', 5),
(25, 'Encogimientos con barra', 'Ejercicio para fortalecer los trapecios.', 'Barra', 'Intermedio', 5),
(26, 'Plancha abdominal', 'Ejercicio isométrico para fortalecer el core.', 'Ninguno', 'Básico', 6),
(27, 'Crunch con cable', 'Ejercicio para sobrecargar los abdominales.', 'Máquina de poleas', 'Intermedio', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos_musculares`
--

CREATE TABLE `grupos_musculares` (
  `id_grupo_muscular` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `rutinas` (
  `id_rutina` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `objetivo` enum('fuerza','hipertrofia','resistencia') NOT NULL,
  `nivel` enum('principiante','intermedio','avanzado') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `rutina_ejercicios` (
  `id_rutina_ejercicio` int(11) NOT NULL,
  `id_rutina` int(11) NOT NULL,
  `id_ejercicio` int(11) NOT NULL,
  `series` int(11) NOT NULL,
  `repeticiones` int(11) NOT NULL,
  `descanso` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `contraseña`, `fecha_registro`) VALUES
(1, 'Admin', 'admin@gimnasio.com', 'admin123', '2025-03-15 16:12:34'),
(2, 'Raul', 'raul@gimnasio.com', '123456789', '2025-03-20 06:34:55');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id_ejercicio`),
  ADD KEY `fk_grupo_muscular` (`id_grupo_muscular`);

--
-- Indices de la tabla `grupos_musculares`
--
ALTER TABLE `grupos_musculares`
  ADD PRIMARY KEY (`id_grupo_muscular`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `rutinas`
--
ALTER TABLE `rutinas`
  ADD PRIMARY KEY (`id_rutina`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `rutina_ejercicios`
--
ALTER TABLE `rutina_ejercicios`
  ADD PRIMARY KEY (`id_rutina_ejercicio`),
  ADD KEY `id_rutina` (`id_rutina`),
  ADD KEY `id_ejercicio` (`id_ejercicio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id_ejercicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `grupos_musculares`
--
ALTER TABLE `grupos_musculares`
  MODIFY `id_grupo_muscular` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `rutinas`
--
ALTER TABLE `rutinas`
  MODIFY `id_rutina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `rutina_ejercicios`
--
ALTER TABLE `rutina_ejercicios`
  MODIFY `id_rutina_ejercicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
