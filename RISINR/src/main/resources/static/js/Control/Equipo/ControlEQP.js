//var uriserv = "/RISSERVER/rest/USRSesionRST";
var uriserv = "/RISSERVER";
function activaBotonesEQP(table, bandera) {
    //bandera: [true,false]
    document.getElementById("btnAdd" + table).disabled = !bandera;
    document.getElementById("btnEdt" + table).disabled = bandera;
    document.getElementById("btnDel" + table).disabled = bandera;
}


function evaluaRadioButtonTablaPK0(tabla, colPK) {
    html_VisibleElement("btnEdtEqptbl");
}

function barraBotonesEQP(e) {
    const btn  = e.target;
    var rol    = btn.dataset.rol;
    if (rol==="JS"){
        html_HideElement("btnAddEqptbl");
    }
    var accion = e.target.id;
    if (!accion){
        var accion = btn.dataset.accion //Boton del menú
    }

    switch (accion) {
        case 'btnCatEqptbl':
            html_HideElement("btnEdtEqptbl");
            readTblsEQP();
            break;
        case 'btnAddEqptbl':
            var tablaref = "Eqptbl";
            //activaBotonesEQP(tablaref, true);
            html_HideElement("updateEQPRIS"); //boton del modal de edición.
            html_ShowElement("agregarEQPRIS");
            html_ShowElement("secSerie"); //seccion de numero de serie
            //document.getElementById("nserEQP").disabled = false; //número de serie (activo al geenrar uno nuevo)
            limpiarCampos();
            cambiaEstadoModal(".modalEquipoRIS", true); //true =activaer
            actualizaDialogoModal(".modalEquipoRIS-content", "12%", "1%", "60%", "50%"); //top 12%
            

            break;
        case 'btnEdtEqptbl':
            html_ShowElement("updateEQPRIS"); //boton del modal de edición.
            html_HideElement("agregarEQPRIS");
            html_HideElement("secSerie");    //seccion de numero de serie        
            //document.getElementById("nserEQP").disabled = true; //número de serie (inhabilitado por ser PK)
            var tabla = "Eqptbl";
            var valorRadioPK = getRadioValIndice("radio" + tabla) + 1;//valor de 0 a k-1, sumarle 1
            console.log(valorRadioPK);
            if ((valorRadioPK) > 0) {
                //console.log("llave primaria renglon: "+valorRadioPK);
                //var tablerowref = findDatainTable(tabla, colPK, valorRadioPK);
                clearRadioSelNumber("radio" + tabla, valorRadioPK - 1); //limpiar renglon seleccionado
                preparaModal(rol, tabla, valorRadioPK);
                cambiaEstadoModal(".modalEquipoRIS", true); //true =activaer 
                actualizaDialogoModal(".modalEquipoRIS-content", "12%", "1%", "60%", "50%"); //top 12%                
            } else {
                alert("Seleccione un registro de la tabla");
            }
            break;
        case 'btnDelEqptbl':
            //borrar registro seleccioando
            break;

    }

}

function preparaModal(rol, tabla, valorRadioPK){
    //Llena inputs con valores de la tabla
    var columnasrow = getRowCells(valorRadioPK, tabla);
    document.getElementById("nserEQP").value = columnasrow[0].innerText;
    document.getElementById("nomEQP").value = columnasrow[1].innerText;
    document.getElementById("marcaEQP").value = columnasrow[2].innerText;
    document.getElementById("modeloEQP").value = columnasrow[3].innerText;
    document.getElementById("modalEQP").value = columnasrow[4].innerText;
    document.getElementById("areEqp").value = columnasrow[5].innerText;
    document.getElementById("idarea").value = columnasrow[6].innerText;
    document.getElementById("edoEqp").value = columnasrow[7].innerText;
    if (rol==="JS"){
        //Escondemos los Select
        html_HideElement("modalEQP")
        html_HideElement("_modalEQP")

        html_HideElement("areEqp")
        html_HideElement("_areEqp")
        //Bloqueamos todos los campos excepto estado
        document.getElementById("nserEQP").readOnly=true
        document.getElementById("nomEQP").readOnly=true
        document.getElementById("marcaEQP").readOnly=true
        document.getElementById("modeloEQP").readOnly=true
        document.getElementById("modalEQP").readOnly=true
        document.getElementById("areEqp").readOnly=true
        document.getElementById("idarea").readOnly=true
    }
}



//funcion para listboxes al cambiar actualizar campos
function updatePKSEqp(e) {
    var sellist = e.target.id;
    console.log(sellist);
    switch (sellist) {
        case 'modalEqp':
            var modalidad = document.getElementById("modalEqp").value;
            document.getElementById("idmod").value = modalidad;
            break;
        case 'areEqp':
            var area = document.getElementById("areEqp").value;
            document.getElementById("idarea").value = area;
            break;
        case 'edoEqp':
            var estado = document.getElementById("edoEqp").value;
            document.getElementById("idedo").value = estado;
            break;
    }
}

function readTblsEQP() {
    var divtable = "showDataEQP";
    var tabladatos = "Eqptbl";
    var columnaedicion = 9;
    var columnaPK = 0; //se toma como llave primaria para busquedas la columna 0
    var coleditar = "Ref";
    var roweditar = "Sel ";
    var actionListener = "evaluaRadioButtonTablaPK0('" + tabladatos + "'," + columnaPK + ")";
    //var actionListener = null;
    //var colocultas=[0,5];//se oculta la columna 0 y 5
    //AreaDeServicio: idArea,Nombre,Descripcion
    //EQUIPO: NSerie, AreaDeServicio_idArea ,Ubicacion 
    //EquipoImagenologia: NSerie,AreaDeServicio_idArea,Nombre,Marca,Modelo,Modalidad,FechaInstalacion,Estado

    var colocultas = [5]; //se oculta id area
    var cabecerapac = ["Serie", "Nombre", "Marca", "Modelo", "Modalidad", "Id_area", "Área", "Estado","Fecha Instalación"];
    CreateTableFromJSON(divtable, tabladatos, cabecerapac); //parametros referencia div, nombre tabla , cabecera
    //var getEquipoimg = postRestService(uriserv + "/EquipoImagenologia/requestALL", jsonData);
     //var getEquipoimg = postRestServiceFetch(jsonData, uriserv + "/EquipoImagenologia/requestALL");
    var getEquipoimg;
    getEquipoimg = getServicio(uriserv +"/EquipoImagenologia/requestALL"); 
    console.log("SALIO DEL POST");
     
     
    getEquipoimg.then(function(data) {
    console.log(data);
    // Actualizar la tabla con los datos recibidos
    UpdateTableRows(tabladatos, data);
    tableRowColorCellSelectionKlib(tabladatos);
    hideTableColumns(tabladatos, colocultas); // Ocultar columnas
    addRadioButtonColumnPKTBL(
        tabladatos, columnaedicion, coleditar, roweditar,
        actionListener, columnaPK
      );
  })
  .catch(function(error) {
      console.error("Error al obtener datos:", error);
      alert("Ocurrió un error al obtener los datos del servidor");
  });
}

function convertTojsonArray(arreglocadena) {
    var resultSet = []; //arreglo de objetos json
    for (var i in arreglocadena) {
        //var rowi = eval('(' + arreglocadena[i] + ')'); //conversión de cada renglo (cadena )a objeto json
        var rowi = JSON.parse(arreglocadena[i]);
        resultSet.push(rowi);
    }
    return resultSet;
}

function listenermodalEQPRIS(e,rol) {
    var opc = e.target.id;
    if (opc === 'updateEQPRISJEFE'){
        opc = 'updateEQPRIS';
    }
    
    switch (opc) {
        case 'cancelarEQPRIS':
            html_HideElement("btnEdtEqptbl"); //boton del modal de edición.
            html_HideElement("btnDelEqptbl"); //boton del modal de edición.            
            cambiaEstadoModal(".modalEquipoRIS", false); //true =activaer            
            break;
        case 'updateEQPRIS':
            var formData = getFormData("UpdateEqp", "formEquipoRIS"); 
            var datosJson = getDatos("formEquipoRIS");
            // Usamos getServicio, que ya usa fetch
            getServicio(uriserv + "/EquipoImagenologia/editEquipo", 'POST', datosJson)
                .then(function(data) {
                    console.log(data);
                    var resp = data;
                    console.log(resp);
                    if (resp[0] === '1') {
                        alert("Se actualizó el registro con éxito");
                        // Actualizar la lista nuevamente                        
                        readTblsEQP(rol);
                        html_HideElement("btnEdtEqptbl"); // Botón del modal de edición.
                        html_HideElement("btnDelEqptbl"); // Botón del modal de edición.
                    } else {
                        alert("Error al actualizar el registro");
                    }
                })
                .catch(function(error) {
                    console.error("Error al realizar la solicitud:", error);
                    alert("Ocurrió un error al actualizar el registro");
                });

            cambiaEstadoModal(".modalEquipoRIS", false); // true = activar
            break;
        case 'agregarEQPRIS':
            var formData = getFormData("CreateEqp", "formEquipoRIS");
            var datosJson = getDatos("formEquipoRIS");
            console.log("Datos antes de la petición:", datosJson);

            // Usamos getServicio con fetch para enviar los datos
            getServicio(uriserv + "/EquipoImagenologia/addEquipo", 'POST', datosJson)
                .then(function(data) {
                    console.log(data);
                    alert("Se agregó el registro con éxito");
                    readTblsEQP(rol);
                    // Procesar la respuesta si es necesario
                })
                .catch(function(error) {
                    console.error("Error al agregar el registro:", error);
                    alert("Ocurrió un error al agregar el registro");
                });

            cambiaEstadoModal(".modalEquipoRIS", false); // false = desactivar
            break;  

}
}

function getFormData(crud, formname) {
    //var form = document.forms.namedItem("formEquipoRIS");
    var form = document.forms.namedItem(formname);
    var formData = new FormData(form); //campos con referencia de name
    //formData.append('Operation', 'Create'); //agregar campo para CRUD, webservce contra parte
    formData.append('Operation', crud); //agregar campo para CRUD, webservce contra parte
    return formData;
    
    
}


//Botones 
function asignaEventosEQP(e){
    console.log("Entró a asignar Eventos")
    const rol = e.target.dataset.rol;
    const crudButtons = document.querySelectorAll(".crud");
    crudButtons.forEach(btn => {
        btn.dataset.rol = rol;
        btn.addEventListener("click", (event) => {
            barraBotonesEQP(event);
        });
    });
    barraBotonesEQP(e);
}

// María de Jesús Rebolledo Bustillo
function getDatos(formname){
    
    var formulario = document.forms.namedItem(formname);
    
    var datosJson = {
        
        nSerie : formulario.elements["nserEQP"].value,
        nombreEquipo: formulario.elements["nomEQP"].value,
        marca:formulario.elements["marcaEQP"].value,
        modelo: formulario.elements["modeloEQP"].value,
        modalidad: formulario.elements["modalEQP"].value,
        idArea: formulario.elements["areEqp"].value,
        estado: formulario.elements["edoEqp"].value,
        fechaInstalacion: null
    };
    
    console.log(datosJson);

    return datosJson; 
    
}

function limpiarCampos() {
    document.getElementById("nserEQP").value = "";
    document.getElementById("nomEQP").value = "";
    document.getElementById("marcaEQP").value = "";
    document.getElementById("modeloEQP").value = "";
    document.getElementById("modalEQP").value = "0";
    document.getElementById("areEqp").value = "0";
    document.getElementById("idarea").value = "";
    document.getElementById("edoEqp").value = "0";
}



function getCookie(name) {
  return document.cookie.split('; ')
    .find(row => row.startsWith(name + '='))
    ?.split('=')[1];
}


/*
//Consulta equipo
$(document).on('click', '#btnCatEqptbl', function (e) {
  barraBotonesEQP(e);
});

$(document).on('click', '#btnCatEqpAreatbl', function (e) {
  barraBotonesEQP(e);
});

//Editar botón en barra 
$(document).on('click', '#btnEdtEqptbl', function (e) {
  barraBotonesEQP(e);
});

//Agregar barra
$(document).on('click', '#btnAddEqptbl', function (e) {
  barraBotonesEQP(e);
});
*/


// Botón editar modal

$(document).on('click', '#updateEQPRIS', function (e) {
  listenermodalEQPRIS(e,1);
});

$(document).on('click', '#updateEQPRISJEFE', function (e) {
  listenermodalEQPRIS(e,2);
});


//Cancelar modal
$(document).on('click', '#cancelarEQPRIS', function (e) {
  listenermodalEQPRIS(e);
});

//Agregar modal
$(document).on('click', '#agregarEQPRIS', function (e) {
  listenermodalEQPRIS(e,1);
});


$(document).on('change', '#edoEqp', function (e) {
   updatePKSEqp(e);
});

$(document).on('change', '#areEqp', function (e) {
   updatePKSEqp(e);
});


