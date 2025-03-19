<?php
session_start();
require_once "../modelo/bd_class.php"; 

header("Content-Type: application/json");

$conexion=new Conexion();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $contraseña = $_POST['contraseña'] ?? '';

    if (empty($email) || empty($contraseña)) {
        echo json_encode(["success" => false, "message" => "Todos los campos son obligatorios"]);
        exit();
    }

    $usuarioId = $prueba->verificarUsuario($email, $contraseña);

    if ($usuarioId) {
        $_SESSION['usuario_id'] = $usuarioId;
        echo json_encode(["success" => true, "redirect" => "../vista/tareas.html"]);
    } else {
        echo json_encode(["success" => false, "message" => "Credenciales incorrectas"]);
    }
    exit();
}
?>
