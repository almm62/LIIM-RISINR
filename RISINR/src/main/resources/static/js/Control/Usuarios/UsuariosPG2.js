var uriserv = "/RISSERVER";
var host = "http://" + location.host + "/RISSERVER/";



async function getTBL(uriServ, nameDivContainer, tablName, columnas) {
    console.log("Hola desde async");
  // (1) Estado de carga opcional (si tienes un spinner)

  try {
    const res = await fetch(uriServ, { method: 'GET', headers: { 'Accept': 'application/json' } });
    if (!res.ok) {
      // Lanza error con detalles HTTP
      const msg = `HTTP ${res.status} ${res.statusText}`;
      throw new Error(msg);
    }

    // (2) Parseo
    let data;
    try {
      data = await res.json();
    } catch {
      throw new Error('Respuesta no es JSON válido');
    }

    // (3) Normalización en caso de ser necesario (En este caso ya lo es
    const resultSet = Array.isArray(data) ? data : convertTojsonArray(data);
    console.log("Array is Array?"+Array.isArray(data));

    // (4) Creacion de tabla
    CreateTableFromJSON(nameDivContainer, tablName, columnas);
    UpdateTableRows(tablName, resultSet);

    return { rows: resultSet, count: resultSet.length };

  } catch (err) {
    console.error('getTBL error:', err);
    alert(`Error al recuperar información: ${err.message}`);
    // Puedes re-lanzar si quieres que el caller maneje el error:
    // throw err;
    return { rows: [], count: 0 };
  }
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





//






function SelRadioButtonTablaUSR(){
    html_VisibleElement("btnEdtUsrtbl");
}

async function CrudUSR(e){
    const btn  = e.target
    var rol    = btn.dataset.rol
    if (rol==="JS"){
        html_HideElement("btnAdtUsrtbl")
    }
    var accion = btn.id; //Botones arriba de la tabla
    if (!accion){
        var accion = btn.dataset.accion //Boton del menú
    }

    var rol    = btn.dataset.rol
    if (rol==="JS"){
        html_HideElement("btnAdtUsrtbl")
    }


    switch (accion) {
        case "btnCatUSRtbl":
            html_HideElement("btnEdtUsrtbl")
            await ConsultaCatalogoUSRS()
            break;
        case "btnAdtUsrtbl": //Boton de barra de nuevo usuario
            //Ocultamos Estados para que solo quede disponible "Inicial"
            html_HideElement("Activo");
            html_HideElement("_Activo");
            html_HideElement("Suspendido");
            html_HideElement("_Suspendido");
            html_HideElement("Bloqueado");
            html_HideElement("_Bloqueado");
            html_HideElement("Dado_de_baja");
            html_HideElement("_Dado_de_baja");

            //Ocultamos Boton de Actualizar y dejamos solo Agregar y Cancelar
            html_HideElement("actualizaUSUARIO");
            html_ShowElement("nuevoUSUARIO");
            
            /*
            html_ShowElement("usrId"); 
            html_ShowElement("_usrId"); 
            html_ShowElement("_curp"); 
            html_ShowElement("curp"); 
            html_ShowElement("numEmpleado"); 
            html_ShowElement("_numEmpleado"); 
            */

            html_HideElement("perfilupdate");            
            cleanCheckboxValues("perfilapp"); //limpia todas las casilla para evitar previa seleccion 
            
            cambiaEstadoModal(".modalUSUARIOS", true); //true =activaer
            actualizaDialogoModal(".modalUSUARIOS-content", "12%", "1%", "60%", "70%");               
            break;
        case "btnEdtUsrtbl": //Boton de barra de edición de usuario
            // Mostramos los demás estados
            html_ShowElement("Activo");
            html_ShowElement("_Activo");
            html_ShowElement("Suspendido");
            html_ShowElement("_Suspendido");
            html_ShowElement("Bloqueado");
            html_ShowElement("_Bloqueado");
            html_ShowElement("Inicial");
            html_ShowElement("_Inicial");
            html_ShowElement("Dado_de_baja");
            html_ShowElement("_Dado_de_baja");
            
            /*
            html_HideElement("usrId");
            html_HideElement("_usrId");
            
            html_HideElement("_curp");
            html_HideElement("curp");
            
            html_HideElement("_numEmpleado");
            html_HideElement("numEmpleado");
            */
            llenaFormulario(rol);

            cambiaEstadoModal(".modalUSUARIOS", true);  
            actualizaDialogoModal(".modalUSUARIOS-content", "12%", "1%", "60%", "50%");   
            break;
        
        case "cancelarUSUARIO": //Boton del modal
            document.getElementById("USUARIOS").reset(); //Borra datos del formulario
            cambiaEstadoModal(".modalUSUARIOS", false); //Desactivamos Modal    
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
                var areaser = lixboxsel[lixboxsel.selectedIndex].value; //pkey table perfil      
                areaser=Number(areaser)
                var Data = {"usuarioID": usrId, "nombre": nombre, "apellidoPaterno": apaterno, "apellidoMaterno": amaterno, 
                                        "correoElectronico":correo, "curp": curp, "numEmpleado":numEmpleado, "area": areaser, "roles": valuesCLV, "estado":refregx};
                try{
                  const data= await getServicio(uriserv + "/user/create","POST", Data) 
                  console.log("Todo funciono increible");
                }catch (err){
                    alert("Error al procesar la respuesta " + err.message);
                } finally{
                    cambiaEstadoModal(".modalUSUARIOS", false);
                    document.getElementById("USUARIOS").reset(); //Borra datos del formulario
                    await CrudUSR('btnCatUSRtbl');
                }
                
            } 
            break;
        case "actualizaUSUARIO":
            var r = confirm("Desea Actualizar el registro ");
            if (r === true){
                var tabla = "tblusuarios";
                var valorRadioPK = getRadioValIndice("radio" + tabla) + 1;//valor de 0 a k-1, sumarle 1
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
                    var lixboxsel = document.getElementById("perf2");
                    var areaser = parseInt(lixboxsel[lixboxsel.selectedIndex].value); //pkey table perfil              
                    var refregx = getRadioVal("estado");      
                    // Se guardan los datos adquiridos del form en jsonData
                    var jsonData = {"curp": curp, "numEmpleado": numEmpleado, "nombre": nombre, "apellidoPaterno": apaterno, "apellidoMaterno": amaterno, "correoElectronico":correo, "area": areaser, "roles": valuesCLV, "estado":refregx};
                    
                    try{
                        const data = getServicio(uriserv + "/user/update","POST",jsonData)
                        console.log("Todo funciono increible")
                    } catch(err){
                        alert("Error al procesar la respuesta " + err.message);                        
                    } finally{
                        cambiaEstadoModal(".modalUSUARIOS", false);
                        document.getElementById("USUARIOS").reset(); //Borra datos del formulario
                        await CrudUSR('btnCatUSRtbl');
                    }
                } else {
                    alert("Seleccione un registro de la tabla");
                }
            }             
            break;
    }
}

async function ConsultaCatalogoUSRS(){
    var columnaPKUSR = 6; //se toma como llave primaria para busquedas la columna 6 curp
    var coleditarUSR = "Ref";
    var roweditarUSR = "Sel ";
    var tabladatosUSR="tblusuarios";
    //var actionListenerUSR = "SelRadioButtonTablaUSR('" + tabladatosUSR + "'," + columnaPKUSR + ")";
    var actionListenerUSR = "SelRadioButtonTablaUSR()";
    var colsUSR = ["Empleado", "Nombre", "Apellido paterno", "Apellido materno", "Correo Electrónico","Área hospitalaria", "CURP", "Perfil", "Estado"];
    try {
        // 1) Llamada GET
        const data = await getServicio(uriserv + "/user/getAll", "GET");
        CreateTableFromJSON("showDataUser", "tblusuarios", colsUSR);      // referencia div, nombre tabla, cabecera
        UpdateTableRows("tblusuarios", data);                              // coloca resultados
        tableHeaderSelection(tabladatosUSR, [1, 2, 3, 4, 5, 6]);
        addRadioButtonColumnPKTBL(
          tabladatosUSR,
          9,
          roweditarUSR,
          coleditarUSR,
          actionListenerUSR,
          columnaPKUSR
        );
        tableRowColorCellSelectionKlib(tabladatosUSR);
    
      } catch (err) {
        alert("Error al recuperar información: " + err.message);
      }
}

function llenaFormulario(rol){
    var tabla = "tblusuarios";
    var valorRadioPK = getRadioValIndice("radio" + tabla) + 1;//valor de 0 a k-1, sumarle 1
    if ((valorRadioPK) > 0) {
        html_ShowElement("actualizaUSUARIO"); //boton del modal de edición.
        html_HideElement("nuevoUSUARIO");
        html_HideElement("perfilupdate");    //seccion de numero de serie 
        html_HideElement("_usrId"); 
        html_HideElement("usrId");                  
        var columnasrow = getRowCells(valorRadioPK, tabla);
        cleanCheckboxValues("perfilapp"); //limpia todas las casilla para evitar previa seleccion 
        var cadperfil = columnasrow[7].innerHTML; //columna del perfil es la 6
        //codigo para activar los push buttons de los perfiles del usuario en la tabla del dialogo modal.
        var arregloroles = cadperfil.split(",");
        let renglones = [];//arreglo de seleccion
        for (var i = 0; i < arregloroles.length; i++) {
            var rolk = arregloroles[i];
            var renglonk = compareTableColumns("roles", 1, rolk) - 1; //columna 1 de tabla roles = perfil 
            renglones.push(renglonk);
        }
        if(renglones[0]!==-1)
          setSelectedCheckboxValues("perfilapp", renglones); //activar checkboxes de acuerdo al contenido de la tabla, si no tiene perfil no hay selección   
        document.querySelector("#USRrowid").value = valorRadioPK;
        document.querySelector("#USRtblid").value = tabla;  
        document.getElementById("numEmpleado").value = columnasrow[0].innerHTML;
        document.getElementById("uname").value = columnasrow[1].innerHTML;
        document.getElementById("apaterno").value = columnasrow[2].innerHTML;
        document.getElementById("amaterno").value = columnasrow[3].innerHTML;
        document.getElementById("correo").value = columnasrow[4].innerHTML;
        setSelectedIndex(document.getElementById("perf2"), columnasrow[5].innerHTML); //poner en  el listbox el dato del englon seleccionado
        document.getElementById("perfil").innerHTML = "CURP: " + columnasrow[6].innerHTML;
        document.getElementById("curp").value = columnasrow[6].innerHTML;
        var valor=columnasrow[8].innerHTML;
        document.querySelector(`input[name="estado"][value="${valor}"]`).checked = true;

        // Ya que se llenó el formulario, Bloqueamos campos dependiendo el rol
        // Empezando por las llaves primarias:
        document.getElementById("usrId").readOnly=true;
        document.getElementById("curp").readOnly=true;
        document.getElementById("numEmpleado").readOnly=true;

        //Si el rol es de Jefe de Servicio (JS)
        if (rol==="JS"){
            html_HideElement("showDataRol");
        }         
    } else {
        alert("Seleccione un registro de la tabla");
    }           
}

async function getUsrs(e) {
    await CrudUSR(e)
    var colsRol = ["Referencia", "Perfil", "Descripción"];
    
    console.log("Primer paso getUsrs getAreas")
    pArea = await getServicio(uriserv + "/initial/getAreas");
    console.log("Segundo paso getUsrs getRoles")
    pRol = await getServicio(uriserv + "/initial/getRoles");
    try {
        const areaObjs = pArea.map(item => JSON.parse(item));
        const rolObjs  = pRol.map(item => JSON.parse(item));
        const nombresAreas = areaObjs.map(a => a.nombreArea);
        const nombresRoles = rolObjs.map(r => r.nombre);
  
        // Llenar select de áreas en modal de usuarios
        UpdateListBox("perf2", areaObjs, 0, 1); 
        // Tabla extra de roles en el diálogo modal
        CreateTableFromJSON("showDataRol", "roles", colsRol);
        UpdateTableRows("roles", rolObjs);
  
        const chkTpl = "<input type='checkbox' name='perfilapp'>";
        insertColumnK("roles", 3, "Selección", "Opción: ");
        updateTableColumns("roles", 3, chkTpl);
  
        backGroundColor("roles", "rgba(88,142,255,.5)", "#000000", "#7F7F7F", "#FFFFFF");
        rowColor("roles", "#00FFFF", "#000000", "#7F7F7F", "#FFFFFF", "#ffffff", "#000000");
  
    } catch (e) {
        console.error("Fallo al cargar tablas:", e);
        alert("No se pudieron cargar las tablas.");
    }
}


function asignaEventosUSRS(e){
    console.log("Entró a asignar Eventos")
    const rol = e.target.dataset.rol;
    const crudButtons = document.querySelectorAll(".crud");
    crudButtons.forEach(btn => {
        btn.dataset.rol = rol;
        btn.addEventListener("click", (event) => {
            CrudUSR(event);
        });
    });
}