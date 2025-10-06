var uriserv = "/RISSERVER";
var host = "http://" + location.host + "/RISSERVER/";

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

function avisoBtn(e, tabName){
  alert(`Boton ${tabName}`)
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
  
  // Insertar los botones definidos en index.html (template) hacia el header
  insertMenuButtonsFromTemplate();

  // Botones Menú (class="taablinks")
  const tabButtons = document.querySelectorAll(".tablinks");

  // A cada botón se le asigna un addEventListener
  tabButtons.forEach(btn => {
      btn.addEventListener("click", (event) => {
          const tabName = btn.dataset.tab; // lee el atributo data-tab del botón
          activeTab(event, tabName);       // llama a tu función pasando el tab correspondiente
      });
  });
};