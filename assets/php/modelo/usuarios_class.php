<?php
require_once 'Conexion.php';

class Usuario
{
    private $conexion;

    public function __construct()
    {
        $this->conexion = new Conectar();
    }

    public function get_email($email)
    {
        $stmt = $this->conexion->getConexion()->prepare("SELECT * FROM usuarios WHERE email = :email");
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function registrar($nombre, $email, $password)
    {
        if ($this->get_email($email)) {
            return "El usuario ya está registrado";
        }

        $contraseña_segura = password_hash($password, PASSWORD_BCRYPT);

        $stmt = $this->conexion->getConexion()->prepare("INSERT INTO usuarios (nombre, email, contraseña) VALUES (:nombre, :email, :password)");
        $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':password', $contraseña_segura, PDO::PARAM_STR);

        if ($stmt->execute()) {
            return "Registro exitoso";
        } else {
            return "Error en el registro";
        }
    }

    public function verificarCredenciales($email, $password)
    {
        $usuario = $this->get_email($email);

        if (!$usuario) {
            return "Usuario no encontrado";
        }

        if (!password_verify($password, $usuario['contraseña'])) {
            return "Contraseña incorrecta";
        }

        return "Inicio de sesión exitoso";
    }
}
?>
