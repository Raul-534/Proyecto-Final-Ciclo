<?php
require_once '../modelo/usuarios_class.php';
session_start();

$usuario = new Usuario();

$json = file_get_contents("php://input");
$datos = json_decode($json, true);

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($datos['email']) && isset($datos['password'])) {
    $email = $datos['email'];
    $password = $datos['password'];
    $mensaje = '';

    $respuesta = $usuario->verificarCredenciales($email, $password);

    if (isset($respuesta['exito']) && $respuesta['exito'] == true) {
        $_SESSION['id_usuario'] = $respuesta['id_usuario'];
        $_SESSION['nombre'] = $respuesta['nombre'];
        echo json_encode([
            'exito' => true,
            'message' => 'Inicio de sesión exitoso',
            'id_usuario' => $_SESSION['id_usuario'],
            'nombre' => $_SESSION['nombre']
        ]);
        exit;
    } else {
        echo json_encode([
            'exito' => false,
            'message' => 'Dirección de email o contraseña incorrecta'
        ]);
        exit;
    }
}
?>
