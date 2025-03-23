<?php
class Rutinas extends Conexion{
    public function crearRutina($nombre, $objetivo, $nivel, $id_usuario) {
        $sql = "INSERT INTO rutinas (nombre, objetivo, nivel, id_usuario) VALUES (?, ?, ?, ?)";
        $stmt = $this->getConexion()->prepare($sql);
        $stmt->execute([$nombre, $objetivo, $nivel, $id_usuario]);
        return $this->getConexion()->lastInsertId();
    }
}
?>