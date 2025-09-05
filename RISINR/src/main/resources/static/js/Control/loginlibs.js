//http://localhost:8080/RESTSERVER/rest/USRSesionRST/login
window._loginCache = null;
var host = "http://" + location.host+"/RISSERVER/";
var FSM2;
var contador_intentos=0;


function agregarPreloader(servicio) {
    $('#loader' + servicio).show();
    $('#fade' + servicio).show();
}

function removerPreloader(servicio) {
    $('#loader' + servicio).hide();
    $('#fade' + servicio).hide();
} 
//mover a clase de vista general (paquete vista)
function nobackbutton() {
    window.location.hash = "no-back-button";
    window.location.hash = "Again-No-back-button";
    window.onhashchange = function () {
        window.location.hash = "no-back-button";
    };
}

//mover a clase de servicios ajax (paquete controlador)
function getServicio(uriServ,tipohttp) {
    return $.ajax({
        url: uriServ,
        type: tipohttp,// 'get', // Tipo de envio 
        dataType: 'json' //Tipo de Respuesta

    }).fail(function (jqXHR, textStatus, errorThrown) {
        alert("No hay datos" + errorThrown);
    }).always(function (jqXHROrData, textStatus, jqXHROrErrorThrown) {
        //console.log(jqXHROrData);
    });
}  

//MISAAAA
function onModalIngresarClick(e) {
  e.preventDefault();

  var rolNombre = $('#perf2').val();
  if (!rolNombre || rolNombre === '0') {
    alert('Selecciona un rol');
    return;
  }
  if (!window._loginCache || !window._loginCache.usuarioId || !Array.isArray(window._loginCache.roles)) {
    alert('No hay datos de login en memoria. Intenta iniciar sesión de nuevo.');
    return;
  }

  // Buscar idRol por nombre
  var elegido = window._loginCache.roles.find(function (r) { return r && r.nombre === rolNombre; });
  if (!elegido) {
    alert('Rol inválido');
    return;
  }

  agregarPreloader('login');

  $.ajax({
    url: '/RISSERVER/access/seleccionar-rol',
    type: 'POST',
    contentType: 'application/json',
    dataType: 'json',
    data: JSON.stringify({
      usuarioId: window._loginCache.usuarioId,
      idRol: elegido.idRol
    }),
    success: function (data) {
      // Guardar token
      if (data && data.tokenJWT) {
        sessionStorage.setItem('token', data.tokenJWT);
      } else {
        alert('No se recibió token al seleccionar rol.');
        return;
      }

      // Cerrar modal
      $('.modalUSUARIOS').hide();

      // Cargar FSM del rol elegido y redirigir
      var llamadaFSM = getServicio("/RISSERVER/RISFSM/fsm2/" + encodeURIComponent(rolNombre), "GET");
      $.when(llamadaFSM.done(function (ajaxFSMResults) {
        FSM2 = new FSM(ajaxFSMResults);
        var estado = FSM2.getFSMStateById('INGRESAR'); // ajusta si tu estado inicial es otro
        if (!estado || !estado.estado || !estado.estado.length) {
          alert('FSM sin estado de entrada válido.');
          return;
        }
        var vista = estado.estado[0].vista;
        var host = "http://" + location.host + "/RISSERVER/";
        window.location = host + "vistas/perfiles/" + encodeURIComponent(rolNombre) + "/" + vista;
      })).fail(function () {
        alert("No se pudo cargar la FSM del rol");
      });
    },
    statusCode: {
      403: function () { alert('El usuario no tiene ese rol'); },
      409: function () { alert('Conflicto al seleccionar rol'); }
    },
    error: function (xhr) {
      console.error('Error seleccionar-rol', xhr);
      alert('Error al seleccionar rol (' + xhr.status + ').');
    },
    complete: function () {
      removerPreloader('login');
    }
  });
}

//MISAA
function onModalCancelarClick(e) {
  e.preventDefault();
  $('.modalUSUARIOS').hide();
  $('#formulario')[0].reset();
  // Si quieres forzar regresar a login limpio:
  // window.location = "http://" + location.host + "/RISSERVER/login.html";
}

//funcion para insertar opciones de selección en un listbox
function UpdateListBox(ref,jsonarray){
    var listbox = document.getElementById(ref);
    //var listbox = document.createElement(ref);
    listbox.options.length=1; //borra contenido del listbox
    for (var i = 0; i < jsonarray.length; i++) {
          var optionelem = document.createElement('option');
          optionelem.setAttribute('value', jsonarray[i]); //Definicion de valor para tabla dinamica
          optionelem.innerHTML=jsonarray[i];
          listbox.appendChild(optionelem);
    } 
}

//funcion para obtener la opción seleccionada de un listbox
function getSelectedIndex(refselid) {
    for (var i = 0; i < refselid.options.length; i++) {
        if (refselid.options[i].selected === true) {
            return refselid.options[i].value;
        }
    }
}

//metodo para controlar la opción de ingreso al sistema (boton Ingresar)
function logIn(estado, e) {
  if (e && e.preventDefault) e.preventDefault();
  agregarPreloader("login");

  var usuarioId = $('#uname').val().trim();
  var passwd    = $('#psw').val(); // no hagas trim a passwd

  if (!usuarioId || !passwd) {
    removerPreloader("login");
    alert("Ingresa usuario y contraseña");
    return;
  }

  $.ajax({
    url: '/RISSERVER/access/login',
    type: 'POST',
    contentType: 'application/json',
    dataType: 'json',
    data: JSON.stringify({ usuarioId: usuarioId, passwd: passwd }),
    success: function (data) {
      // data es tu LoginResponseDTO
      if (data.requiereSeleccionRol) {
        // MULTI-ROL: llenar el <select id="perf2"> con los NOMBRES de rol
        var $select = $('#perf2');
        $select.find('option:not([value="0"])').remove(); // conserva placeholder
        (data.roles || []).forEach(function (r) {
          $('<option>').val(r.nombre).text(r.nombre).appendTo($select);
        });

        // Saludo
        var u = data.usuario;
        $('#usuarioactivo').text('Bienvenido: ' + u.nombre + ' ' + u.apellidoPaterno + ' ' + u.apellidoMaterno);

        // Guardar para /seleccionar-rol
        window._loginCache = {
          usuarioId: usuarioId,
          roles: data.roles // [{idRol, nombre, descripcion}, ...]
        };

        // Mostrar modal
        $('.modalUSUARIOS').show();

      } else {
        // ROL ÚNICO: ya viene token
        if (data.tokenJWT) {
          sessionStorage.setItem('token', data.tokenJWT);
        }

        // Cargar FSM del rol elegido automáticamente (el único en data.roles[0])
        var rolUnico = (data.roles && data.roles.length) ? data.roles[0].nombre : null;
        if (rolUnico) {
          var llamadaFSM = getServicio("/RISSERVER/RISFSM/fsm2/" + encodeURIComponent(rolUnico), "GET");
          $.when(llamadaFSM.done(function (ajaxFSMResults) {
            FSM2 = new FSM(ajaxFSMResults);
            var edokparticular = FSM2.getFSMStateById('INGRESAR'); // ajusta si tu estado inicial tiene otro id
            var vista = edokparticular.estado[0].vista;
            // redirección a la vista para ese rol
            window.location = "http://" + location.host + "/RISSERVER/vistas/perfiles/" + encodeURIComponent(rolUnico) + "/" + vista;
          })).fail(function () {
            alert("No se pudo cargar la FSM del rol");
          });
        } else {
          alert("Login exitoso, pero no se recibió el rol. Verifica la respuesta del backend.");
        }
      }
    },
    statusCode: {
      401: function () { alert('Credenciales invalidas ññññ'); },
      403: function () { alert('Acceso denegado: usuario sin roles'); },
      423: function () { alert('Cuenta bloqueada. Acude a administracion')}
    },
    error: function (xhr) {
      console.error('Error login', xhr);
      alert('Error al autenticar');
    },
    complete: function () {
      removerPreloader("login");
      $('#formulario')[0].reset();
    }
  });
}

$(document).ready(function () {
    var llamadaFSM=getServicio("/RISSERVER/RISFSM/fsm2/General","GET");// cargar FSM general..
    $.when(llamadaFSM.done(function (ajaxFSMResults) {
        FSM2= new  FSM(ajaxFSMResults);//creación de objeto FSM con el json proveniente del back-end
        //console.log(FSM2);
    })); 
});




//MISA
// Evita handlers duplicados si el archivo se carga más de una vez
$(document).off('click', '#btnLogin');
$(document).off('click', '#guardarUSUARIOS');
$(document).off('click', '#cancelarUSUARIOS');

// Click en botón "Ingresar"
$(document).on('click', '#btnLogin', function (e) {
  e.preventDefault();
  // Llama a tu función existente de login
  logIn('login', e);
});

// (Opcional) Permitir Enter en el formulario para disparar el mismo flujo
$(document).off('submit', '#formulario');
$(document).on('submit', '#formulario', function (e) {
  e.preventDefault();
  logIn('login', e);
});

//Clicks en botones del modal
$(document).on('click', '#guardarUSUARIOS', onModalIngresarClick);
$(document).on('click', '#cancelarUSUARIOS', onModalCancelarClick);