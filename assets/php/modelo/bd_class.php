<?php
class Conectar {
    private $host;
    private $dbname;
    private $usuario;
    private $password;
    private $conexion = null;

    public function __construct($host = "localhost", $dbname = "gimnasio", $usuario = "root", $password = "") {
        $this->host = $host;
        $this->dbname = $dbname;
        $this->usuario = $usuario;
        $this->password = $password;

        try {
            $this->conexion = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->dbname, $this->usuario, $this->password);
            $this->conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
    }

    public function getConexion() {
        return $this->conexion;
    }
}
?>
