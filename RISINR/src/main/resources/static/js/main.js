var uriserv = "/RISSERVER";
var host = "http://" + location.host + "/RISSERVER/";
var configModal;

// JavaScript encargado de cargar el header, menú, boton de salir del sistema y  footer

// --- Función de logout ---
function salir() {
  var tc = 'Normal';

  $.ajax({
    url: '/RISSERVER/access/logout?tipoCierre=' + encodeURIComponent(tc),
    type: 'POST',
    success: function () {
      console.log('Logout correcto en el backend');
    },
    statusCode: {
      401: function () { console.warn('Logout 401: no autenticado'); },
      404: function () { console.warn('Logout 404: sesión no encontrada'); }
    },
    error: function (xhr) {
      console.error('Error en logout', xhr.status);
    },
    complete: function () {
      // Limpieza del lado cliente, pase lo que pase
      document.cookie = 'token=; Max-Age=0; Path=/; SameSite=Lax';
      sessionStorage.removeItem('token');
      window.location = host + 'login.html';
    }
  });
}
// --- Funcion de config (Activa y limpia modal) ---
function activaModalConfig(){
  configModal.showModal();
  pwd.value = '';
  pwd2.value = '';
  pwd.focus();
  //Evitamos que el modal se cierre con ESC
  configModal.addEventListener("cancel", (e) =>{
    e.preventDefault();
  })
  // Comportamiento para tipos de cierre
  configModal.addEventListener('close', () => {
    if (configModal.returnValue === 'aceptar') {
      console.log('Aceptar');
    } else if (configModal.returnValue === 'cancelar') {
      console.log('Cancelar');
    }
	});
}

// --- Funcion al presionar botones en formulario de configuracion ---
function formCongif(e){
  const submitter = e.submitter?.value;
  if (submitter === 'aceptar') {
    if (!form.reportValidity()) {
      e.preventDefault();
      return;
    }
    if (pwd.value !== pwd2.value) {
      e.preventDefault(); // evita que se cierre
      errorEl.textContent = 'Las contraseñas no coinciden.';
    } else {
      errorEl.textContent = '';
    }
  }
}
// --- Cargar templates HTML ---
async function loadHTML(id, url) {
  const resp = await fetch(url);
  const html = await resp.text();
  document.getElementById(id).innerHTML = html;
}

// --- Insertar botones del <template id="menuButtons"> en #header .tab ---
function insertMenuButtonsFromTemplate() {
  const template = document.getElementById('menuButtons');     // vive en index.html
  const tabDiv   = document.querySelector('#header .tab');      // viene de headerYmenu.html

  if (!template) {
    console.warn('No se encontró <template id="menuButtons"> en esta página.');
    return;
  }
  if (!tabDiv) {
    console.warn('No se encontró #header .tab (¿se cargó headerYmenu.html?).');
    return;
  }

  // Evitar duplicados si se recarga/llama dos veces
  if (tabDiv.dataset.initialized === 'true') {
    return;
  }

  const fragment = template.content.cloneNode(true);
  tabDiv.appendChild(fragment);
  tabDiv.dataset.initialized = 'true';
  console.log('Botones del menú insertados desde el template.');
}

// --- Evitar regresar con botón atrás ---
function nobackbutton() {
  history.pushState(null, null, location.href);
  window.onpopstate = function () {
    history.pushState(null, null, location.href);
  };
}

// Método que carga plantillas y ejecuta lo inicial
async function inicial(e){
  var tabName = e.target.dataset.tab;
  console.log(tabName)
  switch(tabName){
    case "USUARIOSTAB":
      console.log("Entro a USUARIOSTAB");
      await loadHTML("includeTBL", "../../Templates/ModuloUsuarios.html");
      await getUsrs(e);
      asignaEventosUSRS(e);
      break;
    
    case "EQUIPOTAB":
      console.log("Entro a EQUIPOTAB");
      await loadHTML("includeTBL", "../../Templates/CatEquipoRIS.html");
      asignaEventosEQP(e);
      break;
    
    default:
      alert("Boton sin implementacion")
  }
}
// --- Cuando la página cargue ---
window.onload = async function () {
  nobackbutton();  // Bloquea botón atrás en esta vista

  // Espera a que header y footer se inserten
  await loadHTML("header", "../../shared/headerYmenu.html");
  await loadHTML("footer", "../../shared/footer.html");

  // Boton Salir
  const salirBtn = document.getElementById("salir");
  if (salirBtn) {
    salirBtn.addEventListener("click", salir);
    console.log("Evento salir asignado al botón");
  } else {
    console.warn("No se encontró el botón #salir en el header");
  }
  // Boton Configuracion
  configModal = document.getElementById("configDialog")
  const configBtn = document.getElementById("config");
  if (configBtn && configModal){
    configBtn.addEventListener("click", activaModalConfig);
  }
  // Insertar los botones definidos en index.html (template) hacia el header
  insertMenuButtonsFromTemplate();

  // Botones Menú (class="taablinks")
  const tabButtons = document.querySelectorAll(".tablinks");

  // A cada botón se le asigna un addEventListener
  tabButtons.forEach(btn => {
      btn.addEventListener("click", (event) => {
          inicial(event);       // llama a función inicial del tab correspondiente
      });
  });
};