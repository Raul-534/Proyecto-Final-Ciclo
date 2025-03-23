<?php
class Rutinas_ejercicios extends Conexion {
    public function agregarEjercicioARutina($id_rutina, $id_ejercicio, $series, $repeticiones, $descanso) {
        $sql = "INSERT INTO rutinas_ejercicios (id_rutina, id_ejercicio, series, repeticiones, descanso) VALUES (?, ?, ?, ?, ?)";
        $stmt = $this->getConexion()->prepare($sql);
        $stmt->execute([$id_rutina, $id_ejercicio, $series, $repeticiones, $descanso]);
    }
}

?>