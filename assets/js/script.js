$(document).ready(function () {
  $(".crear_cuenta").click(function () {
    $(".registro").show();
    $(".login").hide();
  });

  $(".sesion").click(function () {
    $(".registro").hide();
    $(".login").show();
  });

  $("#inicio_sesion").submit(function (e) {
    e.preventDefault();
    if (!validarInicio()) return;

    let email = $("#email").val();
    let contraseña = $("#password").val();
    envioDatosInicio(email, contraseña);
  });

  $("#registro").submit(function (e) {
    e.preventDefault();
    if (!validarRegistro()) return;

    let usuario = $("#nombre").val();
    let email = $("#email_registro").val();
    let contraseña = $("#password_registro").val();
    envioDatosRegistro(usuario, email, contraseña);

    cargarEjercicios();

    document.getElementById("ejercicios").addEventListener("change", datosEjercicios());
  });
});

function validarInicio() {
  let valido = true;
  let email = $("#email");
  let contraseña = $("#password");

  let regexEmail = /^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/;
  let regexContraseña = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;

  limpiarErrores(email, contraseña);

  if (!regexEmail.test(email.val())) {
    mostrarError(email, "Formato de email incorrecto");
    valido = false;
  }

  if (!regexContraseña.test(contraseña.val())) {
    mostrarError(contraseña, "La contraseña debe tener entre 8 y 16 caracteres");
    valido = false;
  }

  return valido;
}

function validarRegistro() {
  let valido = true;
  let usuario = $("#nombre");
  let email = $("#email_registro");
  let contraseña = $("#password_registro");
  let repetirContraseña = $("#password_repetir");

  let regexUsuario = /^[a-zA-Z0-9_-]{3,16}$/;
  let regexContraseña = /^[A-Za-z\d]{8,16}$/
  let regexEmail = /^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$/;

  limpiarErrores(usuario, email, contraseña, repetirContraseña);

  if (!regexUsuario.test(usuario.val())) {
    mostrarError(usuario, "El usuario debe tener entre 3 y 16 caracteres y no incluir espacios");
    valido = false;
  }

  if (!regexEmail.test(email.val())) {
    mostrarError(email, "Formato de email incorrecto");
    valido = false;
  }

  if (!regexContraseña.test(contraseña.val())) {
    mostrarError(contraseña, "La contraseña debe tener entre 8 y 16 caracteres");
    valido = false;
  }

  if (contraseña.val() !== repetirContraseña.val()) {
    mostrarError(repetirContraseña, "Las contraseñas no coinciden");
    valido = false;
  }

  return valido;
}

function mostrarError(elemento, mensaje) {
  let errorSpan = elemento.siblings(".error");
  if (errorSpan.length == 0) {
    elemento.after(`<span class="error" style="color:red;">${mensaje}</span>`);
  } else {
    errorSpan.text(mensaje);
  }
}

function limpiarErrores(...elementos) {
  elementos.forEach(el => el.siblings(".error").remove());
}

async function envioDatosInicio(email, contraseña) {
  try {
    let datos = JSON.stringify({ email: email, password: contraseña });
    let url = new URL(
      "assets/php/controlador/controlador_inicio_sesion.php",
      window.location.href
    );
    let opciones = {
      method: "POST",
      body: datos,
      headers: {
        "Content-type": "application/json",
      },
    };

    let response = await fetch(url, opciones);

    if (!response.ok) {
      throw new Error(
        `Error en la solicitud: ${response.status} - ${response.statusText}`
      );
    }

    const data = await response.json();

    if (data.exito) {
      window.location.href = "index.html";
    } else {
      alert(data.message);
    }
  } catch (error) {
    console.error("Hubo un problema con la solicitud:", error);
  }
}




async function envioDatosRegistro(usuario, email, contraseña) {
  try {
      let datos = JSON.stringify({ nombre: usuario, email: email, password: contraseña });
      let url = new URL("assets/php/controlador/controlador_registro.php", window.location.href);
      let opciones = {
          method: "POST",
          body: datos,
          headers: {
              "Content-type": "application/json",
          },
      };

      let response = await fetch(url, opciones);
      if(!response.ok){throw new Error("No se ha encontrado el archivo")}
      let data = await response.json();

      if (data.exito) {
          window.location.href = "index.html";
      } else {
          alert(data.message); 
      }
  } catch (error) {
      console.error("Error en el registro:", error);
      alert("Ocurrió un error al registrarse. Inténtalo de nuevo.");
  }
}




function datosEjercicios(){
  let selectedOptions = this.selectedOptions;
  let mensajeAdvertencia = '';

  for (let option of selectedOptions) {
      let dificultad = option.getAttribute("data-dificultad");
      if (dificultad == "intermedio" || dificultad == "avanzado") {
          mensajeAdvertencia += `<p><strong>Advertencia:</strong> El ejercicio <em>${option.getAttribute("data-nombre")}</em> es ${dificultad}. Si eres principiante, asegúrate de realizar la técnica correctamente para evitar lesiones.</p>`;
      }
  }

  document.getElementById("advertencias").innerHTML = mensajeAdvertencia;
}


async function cargarEjercicios() {
  try {
      let url=new URL("assets/php/controlador/controlador_rutina.php",window.location.href)

      let response= await fetch(url)
      if(!response.ok){throw new Error("No se ha encontrado el archivo")}

      console.log(response)
      let data=await response.json()
      console.log(data)
  } catch (error) {
      console.error("Error al cargar los ejercicios:", error);
  }
}




function datosEjercicios(){
  let selectedOptions = this.selectedOptions;
    let repeticionesSeriesHTML = '';
  
    for (let option of selectedOptions) {
        let ejercicioNombre = option.getAttribute("data-nombre");
        repeticionesSeriesHTML += `
            <div class="input-group" id="ejercicio-${option.value}">
                <label for="series-${option.value}">Series para ${ejercicioNombre}:</label>
                <input type="number" id="series-${option.value}" name="series[${option.value}]" value="3" required />
            </div>
            <div class="input-group" id="ejercicio-${option.value}">
                <label for="repeticiones-${option.value}">Repeticiones para ${ejercicioNombre}:</label>
                <input type="number" id="repeticiones-${option.value}" name="repeticiones[${option.value}]" value="10" required />
            </div>
        `;
    }
  
    document.getElementById("repeticiones-series").innerHTML = repeticionesSeriesHTML;
}
