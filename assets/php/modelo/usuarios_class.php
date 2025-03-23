<?php
require_once 'bd_class.php';

class Usuario
{
    private $conexion;

    public function __construct()
    {
        $this->conexion = new Conectar();
    }

    public function obtener_email($email)
    {
        $stmt = $this->conexion->getConexion()->prepare("SELECT id_usuario, nombre, email, contraseña FROM usuarios WHERE email = :email");
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function registrar($nombre, $email, $password)
    {
        if ($this->obtener_email($email)) {
            return ['exito' => false, 'message' => 'El usuario ya está registrado'];
        }

        $stmt = $this->conexion->getConexion()->prepare("INSERT INTO usuarios (nombre, email, contraseña) VALUES (:nombre, :email, :password)");
        $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':password', $password, PDO::PARAM_STR);

        if ($stmt->execute()) {
            return ['exito' => true, 'message' => 'Registro exitoso'];
        } else {
            return ['exito' => false, 'message' => 'Error en el registro'];
        }
    }

    public function verificarCredenciales($email, $password)
    {
        $usuario = $this->obtener_email($email);

        if (!$usuario) {
            return ['exito' => false, 'message' => 'Usuario no encontrado'];
        }

        if ($password != $usuario['contraseña']) {
            return ['exito' => false, 'message' => 'Contraseña incorrecta'];
        }

        return [
            'exito' => true,
            'id_usuario' => $usuario['id_usuario'],
            'nombre' => $usuario['nombre']
        ];
    }
}
?>