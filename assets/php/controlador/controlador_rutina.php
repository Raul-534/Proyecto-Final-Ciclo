<?php
include("../modelo/conexion.php");
include("../modelo/ejercicios.php");
include("../modelo/rutinas.php");
include("../modelo/rutinas_ejercicios.php");

class ControladorRutina {
    private $db;

    public function __construct() {
        $conexion = new Conectar();
        $this->db = $conexion->getConexion();
    }

    public function obtenerEjercicios() {
        $ejercicios = new Ejercicios();
        return $ejercicios->obtenerEjercicios();
    }

    public function crearRutina($nombre_rutina, $objetivo, $nivel, $id_usuario, $ejercicios_seleccionados, $series, $repeticiones) {
        $rutina = new Rutinas();
        $rutina_id = $rutina->crearRutina($nombre_rutina, $objetivo, $nivel, $id_usuario);

        // Agregar los ejercicios a la rutina
        $rutinas_ejercicios = new Rutinas_ejercicios();
        foreach ($ejercicios_seleccionados as $id_ejercicio) {
            $serie = $series[$id_ejercicio];
            $repeticion = $repeticiones[$id_ejercicio];
            $descanso = 60; // El descanso es un valor fijo por ahora
            $rutinas_ejercicios->agregarEjercicioARutina($rutina_id, $id_ejercicio, $serie, $repeticion, $descanso);
        }

        return $rutina_id;
    }
}

// Instancia del controlador
$controlador = new ControladorRutina();
?>
