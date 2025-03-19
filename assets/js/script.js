$(document).ready(function () {
    $(".crear_cuenta").click(function () {
      $(".registro").show();
      $(".login").hide();
    });
  
    $(".sesion").click(function () {
      $(".registro").hide();
      $(".login").show();
    });
  
    $("#form_inicio").submit(function (e) {
      e.preventDefault();
      validarInicio();
  
      if (validarInicio()) {
        let email = document.getElementById("email").value;
        let contraseña = document.getElementById("contraseña").value;
        envioDatosInicio(email, contraseña);
      }
    });
  
    $("#form_registro").submit(function (e) {
      e.preventDefault();
      validarRegistro();
  
      if (validarRegistro()) {
        let usuario = document.getElementById("usuario").value;
        let nombre_apellidos = document.getElementById("nombre_apellidos").value;
        let email = document.getElementById("email_registro").value;
        let contraseña = document.getElementById("contrasena_registro").value;
        envioDatosRegistro(usuario, nombre_apellidos, email, contraseña);
      }
    });
  });
  
  function validarInicio() {
    let valido = true;
  
    let email = $("#email");
    let contraseña = $("#contrasena");
  
    let regexEmail = /^\w{1,}@\w{1,}.\w{1,}$/;
    let regexContraseña = /^\w{8,16}$/;
  
    limpiarErrores(email, contraseña);
  
    if (!regexEmail.test(email.val())) {
      mostrarError(email, "Formato de email incorrecto");
      valido = false;
    }
  
    if (!regexContraseña.test(contraseña.val())) {
      mostrarError(contraseña, "Formato de contraseña incorrecto");
      valido = false;
    }
  
    return valido;
  }
  
  function validarRegistro() {
    let valido = true;
  
    let usuario = $("#usuario");
    let nombre_apellidos = $("#nombre_apellidos");
    let email = $("#email_registro");
    let contraseña = $("#contrasena_registro");
  
    let regexEmail = /^\w{1,}@\w{1,}.\w{1,}$/;
    let regexContraseña = /^\w{8,16}$/;
    let regexUsuario = /^\w{8,16}$/;
    let regexNombreApellidos = /^\w{2,12}\s\w{4,12}\s\w{4,12}$/;
  
    limpiarErrores(usuario, nombre_apellidos, email, contraseña);
  
    if (!regexUsuario.test(usuario.val())) {
      mostrarError(usuario, "Formato de usuario incorrecto");
      valido = false;
    }
  
    if (!regexNombreApellidos.test(nombre_apellidos.val())) {
      mostrarError(nombre_apellidos, "Formato de nombre y apellidos incorrecto");
      valido = false;
    }
  
    if (!regexEmail.test(email.val())) {
      mostrarError(email, "Formato de email incorrecto");
      valido = false;
    }
  
    if (!regexContraseña.test(contraseña.val())) {
      mostrarError(contraseña, "Formato de contraseña incorrecto");
      valido = false;
    }
  
    return valido;
  }
  
  function mostrarError(elemento, mensaje) {
    elemento.siblings(".error").text(mensaje).css("color", "red");
  }
  
  function limpiarErrores(...elementos) {
    elementos.forEach((el) => el.siblings(".error").text(""));
  }