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


async function getServicio(url, tipohttp = 'GET', body = null) {
  const headers = { 'Accept': 'application/json' };
  if (body) headers['Content-Type'] = 'application/json';

  const res = await fetch(url, {
    method: tipohttp,
    headers,
    body: body ? JSON.stringify(body) : undefined,
    credentials: 'include' // quita si no usas cookies
  });

  if (!res.ok) {
    throw new Error(`HTTP ${res.status}`);
  }

  return res.json();
}

/*mover a clase de servicios ajax (paquete controlador)
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
}  */

//MISAAAA
async function onModalIngresarClick(e) {
  if (e && e.preventDefault) e.preventDefault();

  const rolNombre = $('#perf2').val();
  if (!rolNombre || rolNombre === '0') {
    alert('Selecciona un rol');
    return;
  }

  const cache = window._loginCache;
  if (!cache || !cache.usuarioId || !Array.isArray(cache.roles)) {
    alert('No hay datos de login en memoria. Intenta iniciar sesión de nuevo.');
    return;
  }

  // Buscar idRol por nombre
  const elegido = cache.roles.find(r => r && r.nombre === rolNombre);
  if (!elegido) {
    alert('Rol inválido');
    return;
  }

  agregarPreloader('login');

  try {
    // 1) Notificar rol seleccionado (cookie de sesión ya se envía sola por credentials: 'include')
    await getServicio('/RISSERVER/access/seleccionar-rol', 'POST', {
      usuarioId: cache.usuarioId,
      idRol: elegido.idRol
    });

    // 2) Cerrar modal
    $('.modalUSUARIOS').hide();

    // 3) Cargar FSM del rol y redirigir
    const fsmJson = await getServicio(`/RISSERVER/RISFSM/fsm2/${encodeURIComponent(rolNombre)}`, 'GET');
    const FSM2 = new FSM(fsmJson);

    const estado = FSM2.getFSMStateById('INGRESAR'); // ajusta el id si tu estado inicial es otro
    const vista = estado?.estado?.[0]?.vista;

    if (!vista) {
      alert('FSM sin estado de entrada válido.');
      return;
    }

    window.location.href = `${location.origin}/RISSERVER/vistas/perfiles/${encodeURIComponent(rolNombre)}/${vista}`;

  } catch (err) {
    console.error('Error seleccionar-rol:', err);

    // Mapear códigos sin helper (el mensaje viene como "HTTP 403", etc.)
    const msg = String(err?.message || '');
    if (msg.includes('403')) {
      alert('El usuario no tiene ese rol');
    } else if (msg.includes('409')) {
      alert('Conflicto al seleccionar rol');
    } else {
      alert('Error al seleccionar rol');
    }

  } finally {
    removerPreloader('login');
  }
}

//MISAA
function onModalCancelarClick(e) {
  e.preventDefault();
  $('.modalUSUARIOS').hide();
  $('#formulario')[0].reset();
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
async function logIn(e) {
    if (e && e.preventDefault) e.preventDefault();
    agregarPreloader("login");
    try {
        var usuarioId = $('#uname').val().trim();
        var passwd    = $('#psw').val(); // no hagas trim a passwd

        if (!usuarioId || !passwd) {
          removerPreloader("login");
          alert("Ingresa usuario y contraseña");
          return;
        }
        // LOGIN
        const data = await getServicio('/RISSERVER/access/login', 'POST', { usuarioId, passwd });
        if (data?.requiereSeleccionRol) {
          // MULTI-ROL
          const $select = $('#perf2');
          $select.find('option:not([value="0"])').remove();
          (data.roles || []).forEach(r => {
            $('<option>').val(r.nombre).text(r.nombre).appendTo($select);
          });

          const u = data.usuario || {};
          $('#usuarioactivo').text(`Bienvenido: ${u.nombre || ''} ${u.apellidoPaterno || ''} ${u.apellidoMaterno || ''}`);

          window._loginCache = { usuarioId, roles: data.roles || [] };
          $('.modalUSUARIOS').show();
          return;
        }
        const rolUnico = data?.roles?.[0]?.nombre ?? null;
        const fsmJson = await getServicio(`/RISSERVER/RISFSM/fsm2/${encodeURIComponent(rolUnico)}`, 'GET');
        const FSM2 = new FSM(fsmJson);
        const estadoIngresar = FSM2.getFSMStateById('INGRESAR');
        const vista = estadoIngresar?.estado?.[0]?.vista;
        if (!vista) {
          alert("No se encontró la vista para el estado 'INGRESAR'. Revisa la FSM.");
          return;
        }
        window.location.href =
          `${location.origin}/RISSERVER/vistas/perfiles/${encodeURIComponent(rolUnico)}/${vista}`;

  } catch (err) {
    console.error('Error login:', err.message);
    // Manejo básico de errores por código
    if (err.message.includes('401')) {
      alert('Credenciales inválidas');
    } else if (err.message.includes('403')) {
      alert('Acceso denegado: usuario sin roles');
    } else if (err.message.includes('423')) {
      alert('Cuenta bloqueada. Acude a administración');
    } else {
      alert('Error al autenticar');
    }

  } finally {
    removerPreloader("login");
    const form = $('#formulario')[0];
    if (form) form.reset();
  }
}



/*
function logIn(e) {
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
}*/

$(async function () {
  try {
    const ajaxFSMResults = await getServicio("/RISSERVER/RISFSM/fsm2/General", "GET");
    if (!ajaxFSMResults) return; // manejo suave si getServicio devolvió null tras alert
    FSM2 = new FSM(ajaxFSMResults);
  } catch (err) {
    console.error("Error cargando FSM:", err);
  }
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
  logIn(e);
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