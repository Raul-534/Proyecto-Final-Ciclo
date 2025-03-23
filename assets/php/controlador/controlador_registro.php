<?php
require_once '../modelo/usuarios_class.php';

$usuario = new Usuario();
$jsonData = file_get_contents("php://input");
$datos = json_decode($jsonData, true);

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($datos['nombre']) && isset($datos['email']) && isset($datos['password'])) {
    $nombre = $datos['nombre'];
    $email = $datos['email'];
    $password = $datos['password'];

    $respuesta = $usuario->registrar($nombre, $email, $password);

    echo json_encode($respuesta);
    exit;
} else {
    echo json_encode([
        'exito' => false,
        'message' => 'Solicitud inválida'
    ]);
    exit;
}
?>
