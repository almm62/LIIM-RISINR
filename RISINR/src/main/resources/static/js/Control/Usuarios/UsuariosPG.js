var uriserv = "/RISSERVER";
var host = "http://" + location.host + "/RISSERVER/";


function getTBL(uriServ, nameDivContainer, tablName, columnas) {
    console.log("Llamando a tablaHOLAAA: "+tablName);
    console.log("servicio: "+uriServ);
    return $.ajax({
        url: uriServ,
        type: 'GET', // Tipo de envio 
        dataType: 'json' //Tipo de Respuesta
    }).done(function (data, textStatus, jqXHR) {
        //console.log(data); //los datos llegan como un arreglo de cadenas ordenadas como se presentaran en la tabla
        var resultSet = convertTojsonArray(data);
        //console.log(resultSet);
        //var access_data=JSON.stringify(data);
        //console.log(access_data);
        CreateTableFromJSON(nameDivContainer, tablName, columnas); //parametros referencia div, nombre tabla , arreglo json, cabecera
        UpdateTableRows(tablName, resultSet);
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log(textStatus);
         console.log(jqXHR);
        alert("Error al recuperar informacion " + errorThrown);
        //removerPreloader(servicio);
    }).always(function (jqXHROrData, textStatus, jqXHROrErrorThrown) {
        //removerPreloader(servicio); 
    });
}

function getRestService(uriServ, tipohttp) {
    return $.ajax({
        url: uriServ,
        type: tipohttp, // 'get', // Tipo de envio 
        dataType: 'json' //Tipo de Respuesta
    }).fail(function (jqXHR, textStatus, errorThrown) {
        console.log("Sesion");
        alert("No hay datos" + errorThrown);
    }).always(function (jqXHROrData, textStatus, jqXHROrErrorThrown) {
        //console.log(jqXHROrData);
    });
}


//MPPS: Modality Procedure Performe Step, SCN: Study contnet Notification.

function getval(cel, tablename) {
    var rowId = cel.parentNode.rowIndex; //indice de reglon.
    if (rowId > 0) { //se excluye cabecera de columna
        const cellsOfRow = getRowCells(rowId, tablename);
        switch (tablename) {
            case "tblareas":
                document.querySelector("#AREArowid").value = rowId;
                document.querySelector("#AREAtblid").value = tablename;

                document.getElementById("areaID").innerHTML = cellsOfRow[0].innerHTML;
                //document.getElementById("fechacreacion").innerHTML = cellsOfRow[1].innerHTML;
                document.getElementById("nombrearea").value = cellsOfRow[1].innerHTML;
                document.getElementById("descarea").value = cellsOfRow[2].innerHTML;
                botonguardar = document.getElementById("guardarAREAS");
                botonguardar.style.display = "block";
                //botonguardar.style.visibility = "visible";

                botonagregar = document.getElementById("agregarAREAS");
                botonagregar.style.display = "none";
                var dialogoAreas = document.querySelector(".modalAREAS");
                dialogoAreas.style.display = "block";//activar dialogo modal

                break;

            case "tblroles":

                document.querySelector("#rowid").value = rowId;
                document.querySelector("#tblid").value = tablename;

                document.getElementById("profileid").innerHTML = cellsOfRow[0].innerHTML;
                //document.getElementById("fechacreacion").innerHTML = cellsOfRow[1].innerHTML;
                document.getElementById("nom").value = cellsOfRow[1].innerHTML;
                document.getElementById("desc").value = cellsOfRow[2].innerHTML;

                botonguardar = document.getElementById("guardarPERFILES");
                botonguardar.style.display = "block";
                //botonguardar.style.visibility = "visible";

                botonagregar = document.getElementById("agregarPERFILES");
                botonagregar.style.display = "none";
                //botonagregar.style.visibility = "hidden";
                /*
                 var integertipo = parseInt(cellsOfRow[3].innerHTML, 10);
                 document.getElementsByName("tipo")[integertipo - 1].checked = true;
                 */
                var dialogoPerfiles = document.querySelector(".modalPERFILES");
                dialogoPerfiles.style.display = "block";//activar dialogo modal

                break;
            case "tblusuarios":
                //migrado nueva funcion
                break;
        }
    }
}


function convertTojsonArray(arreglocadena) {
    var resultSet = []; //arreglo de objetos json
    for (var i in arreglocadena) {
        var rowi = eval('(' + arreglocadena[i] + ')'); //conversión de cada renglo (cadena )a objeto json
        resultSet.push(rowi);
    }
    return resultSet;
}

function tableViewFormat(tablName, coledit, coldelete) {
    var tb0 = "<a href='#'><i class='fa fa-pencil' style='font-size:24px; color:black'></i></a>";
    insertColumnK(tablName, coledit, "Modificar", "Editar"); //inserta columna de edicion (columna que no pertenece a los datos)                    
    updateTableColumns(tablName, coledit, tb0);

    var tb1 = "<a href='#'><i class='fa fa-trash' style='font-size:24px; color:black'></i></a>";
    insertColumnK(tablName, coldelete, "Modificar", "Borrar"); //inserta columna de esdicion (columna que no pertenece a los datos)
    updateTableColumns(tablName, coldelete, tb1);
    tableRowColorCellSelection(tablName, coledit, coldelete);
}

function tableRowColorCellSelection(tablName, coledit, coldelete) {
    backGroundColor(tablName, "rgba(88,142,255,.5)", "#000000", "#7F7F7F", "#FFFFFF");
    rowColor(tablName, "#00FFFF", "#000000", "#7F7F7F", "#FFFFFF", "#ffffff", "#000000"); //puntero raton (b,c); pares (b,c); impares (b,c) 
    cellKnSelection(tablName, "getval(this,'" + tablName + "')", coledit); //asignar funcion de seleccion para la celda kn de la tabla
    cellKnSelection(tablName, "deleteRegister(this,'" + tablName + "')", coldelete); //asignar funcion de seleccion para la celda kn de la tabla                 
}

function tableHeaderSelection(tablName, columnas) {
    for (let x = 0; x < columnas.length; x++) {
        cellHeaderSelection(tablName, "sortTable(" + columnas[x] + ",'" + tablName + "');", columnas[x]); //asignar funcion de seleccion para la celda kn de la tabla    
    }
}



//servicio rest para guardar datos
function postRestService(urlser, jsonData) {
    return $.ajax({
        url: urlser,
        type: 'POST', // Tipo de envio 
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(jsonData)
    }).done(function (data, textStatus, jqXHR) {
    console.log("Todo funcionó increíble");    
    console.log(data);
    }).fail(function (jqXHR, textStatus, errorThrown) {
        alert("Error al procesar la respuesta " + errorThrown);
        console.log(jsonData);
    }).always(function (jqXHROrData, textStatus, jqXHROrErrorThrown) {
    });
}

async function postRestServiceFetch(jsonString, servicio,verbo) {
    try {
        console.log("entró al fetch post");
        const response = await fetch(servicio, {
            method: verbo,
            body: jsonString,               // Ya es JSON, no hacer stringify
            credentials: 'include',         // 🔑 envía cookies automáticamente
            headers: {
                'Content-Type': 'application/json'  // Indicamos que enviamos JSON
            }
        });

        if (!response.ok) {
            const mensaje = await response.text();
            console.error('Error:', response.status, mensaje);
            alert(mensaje);
            return null;
        }

        const data = await response.json();   // Parsear respuesta JSON
        console.log(data);
        return data;

    } catch (error) {
        console.error('Fetch falló:', error);
        alert('Ocurrió un error al enviar los datos');
        return null;
    }
}

async function getRestServiceFetch(servicio,verbo) {
    try {
        console.log("entró al fetch get");
        const response = await fetch(servicio, {
            method: verbo,              // Ya es JSON, no hacer stringify
            credentials: 'include',         // 🔑 envía cookies automáticamente
            headers: {
                'Content-Type': 'application/json'  // Indicamos que enviamos JSON
            }
        });

        if (!response.ok) {
            const mensaje = await response.text();
            console.error('Error:', response.status, mensaje);
            alert(mensaje);
            return null;
        }

        const data = await response.json();   // Parsear respuesta JSON
        console.log(data);
        return data;

    } catch (error) {
        console.error('Fetch falló:', error);
        alert('Ocurrió un error al enviar los datos');
        return null;
    }
}


function activamodal(str, form) {
    console.log("Forma: "+form.id);
    console.log("Forma: "+str);
    switch (str) {
        case "Cancelar":
            console.log("Forma: "+form.id);
            var dialogomodal = document.querySelector(".modal" + form.id); //".modalAREAS",".modalPERFILES",".modalUSUARIOS"
            dialogomodal.style.display = "none";
            break;
        case "Guardar":
            var r = confirm("Desea Actualizar el registro ");
            if (r === true){
                switch (form.id) {
                    case "AREAS":
                        var cellsOfRow = getRowCells(form.AREArowid.value, form.AREAtblid.value);

                        cellsOfRow[1].innerHTML = document.getElementById("nombrearea").value;
                        cellsOfRow[2].innerHTML = document.getElementById("descarea").value;

                        var idarea = cellsOfRow[0].innerHTML;
                        var nombrerol = cellsOfRow[1].innerHTML;
                        var descrol = cellsOfRow[2].innerHTML;
                        var jsonData = {"areaId": idarea, "nombre": nombrerol, "descripcion": descrol};
                        postRestService(uriserv + "/AreaEntity/UPDATE", jsonData);
                        //var dialogoAreas = document.querySelector(".modalAREAS");
                        //dialogoAreas.style.display = "none";//activar dialogo modal, cristal transparente                                   
                        break;
                    case "PERFILES":
                        var cellsOfRow = getRowCells(form.rowid.value, form.tblid.value);
                        cellsOfRow[1].innerHTML = document.getElementById("nom").value;
                        cellsOfRow[2].innerHTML = document.getElementById("desc").value;

                        var idrol = cellsOfRow[0].innerHTML;
                        var nombrerol = cellsOfRow[1].innerHTML;
                        var descrol = cellsOfRow[2].innerHTML;
                        var jsonData = {"roleId": idrol, "nombre": nombrerol, "descripcion": descrol};
                        postRestService(uriserv + "/RolEntity/UPDATE", jsonData);
                        break;
                    case "USUARIOS":
                        break;
                }
                alert("Registro actualizado");
                var dialogomodal = document.querySelector(".modal" + form.id);
                dialogomodal.style.display = "none"; //ocultar dialogo                            
            } else {
                //alert("Seleccion Cancelada");
                return;
            }

            break;
        case "Agregar":
            var r = confirm("Desea Agregar el registro ");
            if (r === true) {
                var edit = "<a href='#'><i class='fa fa-pencil' style='font-size:24px ; color:black '></i></a>";
                var del = "<a href='#'><i class='fa fa-trash' style='font-size:24px; color:black'></i></a>";
                var cuerpoedo1 = "";
                var tablavista = "";
                var columnaedit = -1;
                var columnadel = -1;
                switch (form.id) {
                    case "AREAS":
                        var tableref = document.getElementById("tblareas");
                        var numregistro = tableref.rows.length;
                        tablavista = "tblareas";
                        columnaedit = 3;
                        columnadel = 4;
                        var nombre = document.getElementById("nombrearea").value;
                        var descripcion = document.getElementById("descarea").value;
                        cuerpoedo1 = '<tr><td>' + numregistro + '</td><td>' + nombre + '</td><td>' + descripcion + '</td><td>' + "Editar " + edit + '</td><td>' + "Borrar " + del + '</td></tr>';
                        var jsonData = {"nombre": nombre, "descripcion": descripcion};
                        postRestService(uriserv + "/AreaEntity/CREATE", jsonData);
                        break;
                    case "PERFILES":
                        var tableref = document.getElementById("tblroles");
                        var numregistro = tableref.rows.length;
                        tablavista = "tblroles";
                        columnaedit = 3;
                        columnadel = 4;
                        var nombre = document.getElementById("nom").value;
                        var descripcion = document.getElementById("desc").value;
                        //var refregx=getRadioVal("tipo");
                        cuerpoedo1 = '<tr><td>' + numregistro + '</td><td>' + nombre + '</td><td>' + descripcion + '</td><td>' + "Editar " + edit + '</td><td>' + "Borrar " + del + '</td></tr>';
                        var jsonData = {"nombre": nombre, "descripcion": descripcion};
                        postRestService(uriserv + "/RolEntity/CREATE", jsonData);
                        break;
                    case "USUARIOS":
                        break;
                }

                //se agrega el renglon a la tabla de referencia
                $("#" + tablavista).append(cuerpoedo1);
                tableRowColorCellSelection(tablavista, columnaedit, columnadel); //columna de edic´on y borrado
                var dialogomodal = document.querySelector(".modal" + form.id);
                dialogomodal.style.display = "none"; //ocultar dialogo
            } else {
                //alert("Seleccion Cancelada");
                return;
            }
            break;

    }
}

function deleteRegister(cel, tablename) {
    var rowId = cel.parentNode.rowIndex; //indice de reglon.
    //OJO hacer switch para para identificar tabla y armar ej json particular.

    if (rowId > 0) { //se excluye cabecera de columna

        var r = confirm("Desea Borrar el registro ");
        if (r === true) {
            //borrar de la base de datos (inhabilitar "borrado lógico") y despues de la vista                       

            //borrar de la base de datos (inhabilitar "borrado lógico") y despues de la vista   
            const cellsOfRow = getRowCells(rowId, tablename);
            if (tablename === "tblroles") {
                var idrol = cellsOfRow[0].innerHTML;
                var jsonData = {"roleId": idrol};
                var borrarreg = postRestService(uriserv + "/RolEntity/DELETE", jsonData);
                $.when(borrarreg.done(function (data) {
                    //console.log(data);
                    if (data.DELETE === false) {
                        alert("Error al borrar el registro");
                    } else {
                        deleteTableRow(tablename, rowId);
                    }
                }));
            } else if (tablename === "tblusuarios") {
                alert("falta agragar acción en método: deleteRegister");
            }
        } else {
            return;
        }
    }
}

//***********************************


//FUNCIONES PARA INVALIDAR NAVEGACION ENTRE  PAGINAS
function preventBack() {
    window.history.forward();
}

setTimeout("preventBack()", 0);

window.onunload = function () {
    null;
};

function nobackbutton() {
    window.location.hash = "no-back-button";
    window.location.hash = "Again-No-back-button";
    window.onhashchange = function () {
        window.location.hash = "no-back-button";
    };
}
//

function regresar() {
    //invalidar los botones de navegación.
    window.location = host + 'MainPageRes.html';
}

function salir() {
  var tc = 'Normal';

  $.ajax({
    url: '/RISSERVER/access/logout?tipoCierre=' + encodeURIComponent(tc),
    type: 'POST',
    xhrFields: { withCredentials: true }, // enviará la cookie 'token'
    // No body ni headers necesarios
    success: function () {
      // ok, el backend marcó horaFin/tipoCierre y borró cookie
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

function getsession() {
    $.ajax({
        url: uriserv + '/session',
        type: 'GET', // Tipo de envio 
        dataType: 'json' //Tipo de Respuesta
    }).done(function (data, textStatus, jqXHR) {
        console.log(data);
        document.getElementById("usuartioactivonombre").innerHTML = data.nombre + " , " + data.area + " , " + data.perfil;
    }).fail(function (jqXHR, textStatus, errorThrown) {
        //alert("espera");
        window.location = host + 'login.html';
    });
}


function actualizaPerfilSeleccionado(e) {
    var lixboxseltxt = document.getElementById("perf2")[e].innerText;
    document.getElementById("perfil").innerHTML = "Selección: " + lixboxseltxt;
    //perfilupdate.value=lixboxseltxt; //opcion default;
}

window.onload = function () {
    //console.log("ID medico: "+document.getElementById("medID").value);          
    var actualizarol = getRestService("/RISSERVER/rest/USRSesionRST/rol/Admin", "GET");//se actualiza la tabla de sesion
    $.when(actualizarol.done(function (data) {
        document.getElementById("usuartioactivonombre").innerHTML = data.nombre + " , " + data.area + " , " + data.rolActivo;
    }));
    nobackbutton();
};


function SelRadioButtonTablaUSR(){
    html_VisibleElement("btnAdtUsrtbl");
    html_VisibleElement("btnEdtUsrtbl");
}

function CrudUSR(e){
    if(typeof e === "string"){
        accion=e;
    }else{
    var accion=e.target.id;
    }
    switch (accion) {
        case "btnCatUSRtbl":
        //alert("Por implementar");
            html_HideElement("btnEdtUsrtbl")
            var columnaPKUSR = 6; //se toma como llave primaria para busquedas la columna 5 curp
            var coleditarUSR = "Ref";
            var roweditarUSR = "Sel ";
            var tabladatosUSR="tblusuarios";
            //var actionListenerUSR = "SelRadioButtonTablaUSR('" + tabladatosUSR + "'," + columnaPKUSR + ")";
            var actionListenerUSR = "SelRadioButtonTablaUSR()";
            var colsUSR = ["Empleado", "Nombre", "Apellido paterno", "Apellido materno", "Correo Electrónico","Área hospitalaria", "CURP", "Perfil", "Estado"];
            $.ajax({
                url: uriserv + "/user/getAll",
                type: 'GET', // Tipo de envio 
                dataType: 'json' //Tipo de Respuesta
            }).done(function (data, textStatus, jqXHR) {
                
                //Bloque de código para integrar la funcionalidad de JSON Webt Token
                var datosjson = data; // Se guarda la información en la variable datosjson
                //A continuación se realiza un condicional para saber si es correcta la validación
                  console.log('La data es:   ' + data);
                  
                  CreateTableFromJSON("showDataUser", "tblusuarios", colsUSR); //parametros referencia div, nombre tabla , arreglo json, cabecera
                  console.log('La data es:   ' + data);
                  UpdateTableRows("tblusuarios", data);//Se colocan los resultados en la Tabla
                  tableHeaderSelection(tabladatosUSR, [1, 2, 3, 4, 5, 6]);
                  addRadioButtonColumnPKTBL(tabladatosUSR, 9, roweditarUSR, coleditarUSR, actionListenerUSR, columnaPKUSR); //columna 5 PK RFC
                //console.log(data); //los datos llegan como un arreglo de cadenas ordenadas como se presentaran en la tabla
                
            }).fail(function (jqXHR, textStatus, errorThrown) {
                alert("Error al recuperar informacion " + errorThrown);
                //removerPreloader(servicio);
            }).always(function (jqXHROrData, textStatus, jqXHROrErrorThrown) {
                //removerPreloader(servicio); 
            });  
            break;
        case "btnAdtUsrtbl": //Boton de barra de nuevo usuario
            html_HideElement("Activo"); //boton del modal de edición.
            html_HideElement("_Activo"); //boton del modal de edición.
            html_HideElement("Suspendido"); //boton del modal de edición.
            html_HideElement("_Suspendido"); //boton del modal de edición.
            html_HideElement("Bloqueado"); //boton del modal de edición.
            html_HideElement("_Bloqueado"); //boton del modal de edición.
            html_HideElement("Dado_de_baja"); //boton del modal de edición.
            html_HideElement("_Dado_de_baja"); //boton del modal de edición.
            html_HideElement("actualizaUSUARIO"); //boton del modal de edición.
            html_ShowElement("nuevoUSUARIO");
            
            
            html_ShowElement("usrId"); //boton del modal de edición.
            html_ShowElement("_usrId"); //boton del modal de edición.
            html_ShowElement("_curp"); //boton del modal de edición.
            html_ShowElement("curp"); //boton del modal de edición.
            html_ShowElement("numEmpleado"); //boton del modal de edición.
            html_ShowElement("_numEmpleado"); //boton del modal de edición.
            
            html_HideElement("perfilupdate");    //seccion de numero de serie               
            cleanCheckboxValues("perfilapp"); //limpia todas las casilla para evitar previa seleccion 
            
            cambiaEstadoModal(".modalUSUARIOS", true); //true =activaer               
            break;
        case "btnEdtUsrtbl": //Boton de barra de edición de usuario
            html_ShowElement("Activo"); //boton del modal de edición.
            html_ShowElement("_Activo"); //boton del modal de edición.
            html_ShowElement("Suspendido"); //boton del modal de edición.
            html_ShowElement("_Suspendido"); //boton del modal de edición.
            html_ShowElement("Bloqueado"); //boton del modal de edición.
            html_ShowElement("_Bloqueado"); //boton del modal de edición.
            html_ShowElement("Inicial"); //boton del modal de edición.
            html_ShowElement("_Inicial"); //boton del modal de edición.
            html_ShowElement("Dado_de_baja"); //boton del modal de edición.
            html_ShowElement("_Dado_de_baja"); //boton del modal de edición.
            
            html_HideElement("usrId"); //boton del modal de edición.
            html_HideElement("_usrId"); //boton del modal de edición.
            
            html_HideElement("_curp"); //boton del modal de edición.
            html_HideElement("curp"); //boton del modal de edición.
            
            html_HideElement("_numEmpleado"); //boton del modal de edición.
            html_HideElement("numEmpleado"); //boton del modal de edición.
            var tabla = "tblusuarios";
            var valorRadioPK = getRadioValIndice("radio" + tabla) + 1;//valor de 0 a k-1, sumarle 1
            if ((valorRadioPK) > 0) {
                html_ShowElement("actualizaUSUARIO"); //boton del modal de edición.
                html_HideElement("nuevoUSUARIO");
                html_HideElement("perfilupdate");    //seccion de numero de serie                  
                var columnasrow = getRowCells(valorRadioPK, tabla);
                cleanCheckboxValues("perfilapp"); //limpia todas las casilla para evitar previa seleccion 
                var cadperfil = columnasrow[7].innerHTML; //columna del perfil es la 6
                //codigo para activar los push buttons de los perfiles del usuario en la tabla del dialogo modal.
                console.log(cadperfil);
                var arregloroles = cadperfil.split(",");
                console.log(arregloroles)
                let renglones = [];//arreglo de seleccion
                for (var i = 0; i < arregloroles.length; i++) {
                    var rolk = arregloroles[i];
                    var renglonk = compareTableColumns("roles", 1, rolk) - 1; //columna 1 de tabla roles = perfil 
                    renglones.push(renglonk);
                }
                console.log(renglones);
                if(renglones[0]!==-1)
                  setSelectedCheckboxValues("perfilapp", renglones); //activar checkboxes de acuerdo al contenido de la tabla, si no tiene perfil no hay selección   
                document.querySelector("#USRrowid").value = valorRadioPK;
                document.querySelector("#USRtblid").value = tabla;  
                document.getElementById("uname").value = columnasrow[1].innerHTML;
                document.getElementById("apaterno").value = columnasrow[2].innerHTML;
                document.getElementById("amaterno").value = columnasrow[3].innerHTML;
                document.getElementById("correo").value = columnasrow[4].innerHTML;
                setSelectedIndex(document.getElementById("perf2"), columnasrow[5].innerHTML); //poner en  el listbox el dato del englon seleccionado
                document.getElementById("perfil").innerHTML = "CURP: " + columnasrow[6].innerHTML;
                var valor=columnasrow[8].innerHTML;
                document.querySelector(`input[name="estado"][value="${valor}"]`).checked = true;
                cambiaEstadoModal(".modalUSUARIOS", true); //true =activaer     
                //actualizaDialogoModal(".modalUSUARIOS-content", "12%", "1%", "60%", "50%"); //top 12%                
            } else {
                alert("Seleccione un registro de la tabla");
            }           

            break;
        
        case "cancelarUSUARIO":
            document.getElementById("usrId").value="";
            document.getElementById("uname").value = "";
            document.getElementById("apaterno").value = "";
            document.getElementById("amaterno").value = "";
            document.getElementById("correo").value="";
            document.getElementById("numEmpleado").value="";
            document.getElementById("correo").value = "";
            //boton del dialogo modal cancelar dialogo
            cambiaEstadoModal(".modalUSUARIOS", false); //true =activaer     
            break;
        case "nuevoUSUARIO": //Boton del dialogo modal de nuevo usuario
            var r = confirm("Desea Agregar el registro ");
            if (r === true) {
                var tablavista = "tblusuarios";               
                var tableref = document.getElementById(tablavista);
                var usrId = document.getElementById("usrId").value;
                var nombre = document.getElementById("uname").value;
                var apaterno = document.getElementById("apaterno").value;
                var amaterno = document.getElementById("amaterno").value;
                var curp = document.getElementById("curp").value; 
                var correo= document.getElementById("correo").value;
                var numEmpleado=parseInt(document.getElementById("numEmpleado").value);
                var selAPPS = getSelectedCheckboxValues("perfilapp");//perfilapp es el nombre de los checkboxes    
                let valuesRow = "[";
                let valuesCLV = [];
                for (var i = 0; i < selAPPS.length; i++) {
                    var PERFILES = getRowCells(selAPPS[i] + 1, "showDataRol"); //reglon 1 de perfiles
                    valuesRow += '"' + PERFILES[1].innerHTML + '"' + ",";
                    valuesCLV.push(Number(PERFILES[0].innerHTML));
                }
                console.log(valuesCLV);
                var perfil = valuesRow.substring(0, valuesRow.length - 1) + "]";//elimina la coma al final de la cadena
                var refregx = getRadioVal("estado");
                console.log(refregx);
                var lixboxsel = document.getElementById("perf2");
                var areaasignada = lixboxsel[lixboxsel.selectedIndex].innerText; //perfil
                var areaser = lixboxsel[lixboxsel.selectedIndex].value; //pkey table perfil      
                areaser=Number(areaser)
                var Data = {"usuarioID": usrId, "nombre": nombre, "apellidoPaterno": apaterno, "apellidoMaterno": amaterno, 
                                        "correoElectronico":correo, "curp": curp, "numEmpleado":numEmpleado, "area": areaser, "roles": valuesCLV, "estado":refregx};
                console.log(Data);
                
                postRestService(uriserv + "/user/create", Data);  
                cambiaEstadoModal(".modalUSUARIOS", false); //false =ocultar 
            }               
            break;
        case "actualizaUSUARIO":
            var r = confirm("Desea Actualizar el registro ");
            if (r === true){
                var tabla = "tblusuarios";
                var valorRadioPK = getRadioValIndice("radio" + tabla) + 1;//valor de 0 a k-1, sumarle 1
                console.log(valorRadioPK);
                if ((valorRadioPK) > 0) {
                    var cellsOfRow = getRowCells(valorRadioPK, tabla);
                    //var usid = document.querySelector("#USRrowid").value; 
                    var nombre = document.getElementById("uname").value;
                    var apaterno = document.getElementById("apaterno").value;
                    var amaterno = document.getElementById("amaterno").value;
                    var correo=document.getElementById("correo").value;
                    var curp = cellsOfRow[6].innerHTML;
                    var numEmpleado=parseInt(cellsOfRow[0].innerHTML);
                    var selAPPS = getSelectedCheckboxValues("perfilapp");//perfilapp es el nombre de los checkboxes
                    let valuesRow = "[";
                    let valuesCLV = [];
                    for (var i = 0; i < selAPPS.length; i++) {
                        var PERFILES = getRowCells(selAPPS[i] + 1, "showDataRol"); //reglon 1 de perfiles
                        valuesRow += '"' + PERFILES[1].innerHTML + '"' + ",";
                        valuesCLV.push(parseInt(PERFILES[0].innerHTML));
                    }
                    var roles = valuesRow.substring(0, valuesRow.length - 1) + "]";//elimina la coma al final de la cadena
                    var tiposel = getRadioVal("estado");
                    console.log("Selección de estado: "+tiposel);
                    var lixboxsel = document.getElementById("perf2");
                    var areaser = parseInt(lixboxsel[lixboxsel.selectedIndex].value); //pkey table perfil              
                    var refregx = getRadioVal("estado");      
                    console.log(refregx);
                    //guardar en BD.
                    // Se guardan los datos adquiridos de la vista en la variable jsonData
                    var jsonData = {"curp": curp, "numEmpleado": numEmpleado, "nombre": nombre, "apellidoPaterno": apaterno, "apellidoMaterno": amaterno, "correoElectronico":correo, "area": areaser, "roles": valuesCLV, "estado":refregx};
                    console.log(jsonData); 
                    

                    postRestService(uriserv + "/user/update", jsonData);//Se manda el JWT y la llave pública hacia el Backend
                    cambiaEstadoModal(".modalUSUARIOS", false); //false =ocultar 
                } else {
                    alert("Seleccione un registro de la tabla");
                }
            }                        
            break;
    }
}


function getUsrs() {

    var colsArea = ["Referencia", "Área", "Descripción"];
    var llamadaAREA = getTBL(uriserv + "/initial/getAreas", "showDataArea", "tblareas", colsArea);

    var colsRol = ["Referencia", "Perfil", "Descripción"];
    var llamadaPRO = getTBL(uriserv + "/initial/getRoles", "showDataProfile", "tblroles", colsRol);

    $.when( llamadaPRO, llamadaAREA).done(function (ajaxPROResults, ajaxAREAResults) {
        //console.log("Generando listbox");
        //this code is executed when all ajax calls are done
        //
        //TABLA areas
        tableViewFormat("tblareas", 3, 4); //Agregar columnas de edicion y borrado
        //permite ordenar en cabecera
        tableHeaderSelection("tblareas", [1, 2]);
        //Falta llenar el listbox de areas en el dialogo de modal de usuarios
        var resultSetArea = convertTojsonArray(ajaxAREAResults[0]);
        //console.log(resultSetArea);
        UpdateListBox("perf2", resultSetArea, 0, 1);//atributo value = columna[0], atributo innerHTML=columna[4]
        //TABLA roles
        tableViewFormat("tblroles", 3, 4); //Agregar columnas de edicion y borrado
        //permite ordenar en cabecera
        tableHeaderSelection("tblroles", [1, 2]);

        //Tabla roles para el dialogo modal
        CreateTableFromJSON("showDataRol", "roles", colsRol); //parametros regerencia div, nombre tabla , arreglo json, cabecera
        var resultSet = convertTojsonArray(ajaxPROResults[0]);
        UpdateTableRows("roles", resultSet);
        var tbl = "<input type='checkbox' name='perfilapp'>";
        insertColumnK("roles", 3, "Selección", "Opción: "); //inserta columna de esdicion (columna que no pertenece a los datos)                    
        updateTableColumns("roles", 3, tbl);

        backGroundColor("roles", "rgba(88,142,255,.5)", "#000000", "#7F7F7F", "#FFFFFF");
        rowColor("roles", "#00FFFF", "#000000", "#7F7F7F", "#FFFFFF", "#ffffff", "#000000"); //puntero raton (b,c); pares (b,c); impares (b,c)
       
    });
}




$(document).ready(function () {
    $("#includedCatEquipo").load("CatEquipoRIS.html"); // página externa
    $("#includedAgendaADM").load("../../Templates/AgendaRIS.html"); // página externa
    $("#includedUSRADM").load("../../Templates/ModuloUsuarios.html"); // página externa
   getUsrs(); //roles y areas
 
});