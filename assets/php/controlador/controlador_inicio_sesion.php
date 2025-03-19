<?php
header('Content-Type: application/json');
require_once 'Usuario.php';
session_start();

$usuario = new Usuario();


if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['registro'])) {
    $nombre = $_POST['nombre'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    $respuesta = $usuario->registrar($nombre, $email, $password);
    echo json_encode($respuesta);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $respuesta = $usuario->verificarCredenciales($email, $password);

    if (isset($respuesta['success'])) {
        $_SESSION['id_usuario'] = $respuesta['id_usuario'];
        $_SESSION['nombre'] = $respuesta['nombre'];
    }

    echo json_encode($respuesta);
    exit;
}
?>
