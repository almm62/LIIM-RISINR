var uriserv = "/RISSERVER";
var host = "http://" + location.host + "/RISSERVER/";

//Inicializamos variables para asignar botones y todo lo relacionado a configuracion
var configModal;  //YA
var configBtn;   //YA
var configForm;
var btnEditarEmail;
var btnCambiarPassword;
var btnCancelar;
var btnGuardar;

var emailActual;  //YA
var emailEditFields;
var mailInput;
var mail2Input;

var passwordEditFields;
var pwdInput;
var pwd2Input;

var validationSection;
var passwordActual;

var errorMsg;

// Estado de edición
let editandoEmail;
let editandoPassword;


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
async function activaModalConfig(){
  const data = await getServicio(uriserv + "/user/userSesion");
  emailActual.value=data.correoElectronico;
  console.log(data.estado)
  if(data.estado==="Inicial"){
    cambiarPassword();
    actualizarEstadoFormulario();
  } else{
    resetearEstado();
  }
  configModal.showModal();
  //Evitamos que el modal se cierre con ESC
  configModal.addEventListener("cancel", (e) =>{
    e.preventDefault();
  });
}

function resetearEstado() {
  editandoEmail = false;
  editandoPassword = false;
  
  emailEditFields.style.display = 'none';
  passwordEditFields.style.display = 'none';
  validationSection.style.display = 'none';
  
  mailInput.disabled = true;
  mail2Input.disabled = true;
  pwdInput.disabled = true;
  pwd2Input.disabled = true;
  passwordActual.disabled = true;
  
  mailInput.value = '';
  mail2Input.value = '';
  pwdInput.value = '';
  pwd2Input.value = '';
  passwordActual.value = '';
  
  btnEditarEmail.textContent = '✏️';
  btnEditarEmail.title = 'Editar correo';
  btnCambiarPassword.textContent = 'Cambiar contraseña';
  btnGuardar.disabled = true;
  
  errorMsg.textContent = '';
}

function editarEmail(){
  editandoEmail = !editandoEmail;
  
  if (editandoEmail) {
    emailEditFields.style.display = 'block';
    mailInput.disabled = false;
    mail2Input.disabled = false;
    btnEditarEmail.textContent = '❌';
    btnEditarEmail.title = 'Cancelar edición';
  } else {
    emailEditFields.style.display = 'none';
    mailInput.disabled = true;
    mail2Input.disabled = true;
    mailInput.value = '';
    mail2Input.value = '';
    btnEditarEmail.textContent = '✏️';
    btnEditarEmail.title = 'Editar correo';
  }
  
  actualizarEstadoFormulario();
}


function cambiarPassword(){
  editandoPassword = !editandoPassword;
  
  if (editandoPassword) {
    passwordEditFields.style.display = 'block';
    pwdInput.disabled = false;
    pwd2Input.disabled = false;
    btnCambiarPassword.textContent = 'Cancelar cambio de contraseña';
  } else {
    passwordEditFields.style.display = 'none';
    pwdInput.disabled = true;
    pwd2Input.disabled = true;
    pwdInput.value = '';
    pwd2Input.value = '';
    btnCambiarPassword.textContent = 'Cambiar contraseña';
  }
  
  actualizarEstadoFormulario();
}


function actualizarEstadoFormulario() {
  const hayEdicion = editandoEmail || editandoPassword;
  
  // Mostrar/ocultar sección de validación
  if (hayEdicion) {
    validationSection.style.display = 'block';
    passwordActual.disabled = false;
    btnGuardar.disabled = false;
  } else {
    validationSection.style.display = 'none';
    passwordActual.disabled = true;
    passwordActual.value = '';
    btnGuardar.disabled = true;
  }
  
  errorMsg.textContent = '';
}

// ENVIO DE FORMULARIO
async function enviaFormularioConfig(e){
  e.preventDefault();
  errorMsg.textContent = '';
  if(!passwordActual.value){
    errorMsg.textContent="Debes ingresar tu contraseña actual";
    return;
  }

  //Cambio de correo
  if(editandoEmail){
    //Quitamos espacios al final en caso de agregar accidentalmente
    const nuevoEmail=mailInput.value.trim() 
    const confirmarEmail = mail2Input.value.trim();
    
    if (!nuevoEmail || !confirmarEmail) {
      errorMsg.textContent = 'Completa ambos campos de correo electrónico';
      return;
    }
    
    if (nuevoEmail !== confirmarEmail) {
      errorMsg.textContent = 'Los correos electrónicos no coinciden';
      return;
    }
    
    if (nuevoEmail === emailActual.value) {
      errorMsg.textContent = 'El nuevo correo es igual al actual';
      return;
    }
    const Data ={
      "mail1": nuevoEmail,
      "mail2": confirmarEmail,
      "pswd": passwordActual.value
    }
    try{
      const data= await getServicio(uriserv + "/user/email","POST", Data) 
      console.log("Todo funciono increible");
    }catch (err){
        alert("Error al procesar la respuesta " + err.message);
    }
  }
  
  if(editandoPassword){
    const nuevaPassword=pwdInput.value;
    const confirmarPassword = pwd2Input.value;
    
    if (!nuevaPassword || !confirmarPassword) {
      errorMsg.textContent = 'Completa ambos campos de contraseña';
      return;
    }
    
    if (nuevaPassword !== confirmarPassword) {
      errorMsg.textContent = 'Las contraseñas no coinciden';
      return;
    }
    const Data ={
      "pswd1": nuevaPassword,
      "pswd2": confirmarPassword,
      "pswdActual": passwordActual.value
    }
    try{
      const data= await getServicio(uriserv + "/user/pswd","POST", Data) 
      console.log("Todo funciono increible");
      salir();
    }catch (err){
        alert("Error al procesar la respuesta " + err.message);
    }
  }

  configModal.close();  

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
  const data = await getServicio(uriserv + "/user/userSesion");


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


  // --- Boton Configuracion ---
  // Asignamos elementos
  configBtn = document.getElementById("config");
  configBtn.addEventListener("click", activaModalConfig);
  
  configModal = document.getElementById("configDialog");

  configForm = document.getElementById('configForm');
  configForm.addEventListener("submit", enviaFormularioConfig);
  
  btnEditarEmail = document.getElementById('btnEditarEmail');
  btnEditarEmail.addEventListener("click", editarEmail);

  btnCambiarPassword = document.getElementById('btnCambiarPassword');
  btnCambiarPassword.addEventListener("click", cambiarPassword);

  btnCancelar = document.getElementById('configCancelar');
  btnCancelar.addEventListener('click', () => {
    configDialog.close();
    resetearEstado();
  });

  btnGuardar = document.getElementById('configGuardar');

  emailActual=document.getElementById("emailActual");
  emailEditFields = document.getElementById('emailEditFields');
  mailInput = document.getElementById('mail');
  mail2Input = document.getElementById('mail2');

  passwordEditFields = document.getElementById('passwordEditFields');
  pwdInput = document.getElementById('pwd');
  pwd2Input = document.getElementById('pwd2');

  validationSection = document.getElementById('validationSection');
  passwordActual = document.getElementById('passwordActual');
  
  errorMsg = document.getElementById('errorConfig');

  if (configBtn && configModal){
    configBtn.addEventListener("click", activaModalConfig);
  }
  if (data.estado==="Inicial"){
    this.document.getElementById("configEmail").style.display = 'none'
    html_HideElement("configCancelar");
    html_HideElement("btnCambiarPassword");

    activaModalConfig();
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