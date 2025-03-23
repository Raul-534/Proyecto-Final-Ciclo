<?php
class Ejercicios extends Conexion {
    public function obtenerEjercicios() {
        $sql = "SELECT * FROM ejercicios";
        $stmt = $this->getConexion()->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>
