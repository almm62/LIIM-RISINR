var uriserv= "/RISSERVER";


async function getServiciosAgenda(e) {
    const estudios = await getServicio(uriserv + "/citas/getStudies");
    UpdateListBox("consultaestudio", estudios, 0, 1);

    const salas = await getServicio(uriserv + "/citas/getSala");
    //UpdateListBox("consultasala", salas, 0, 0);
    await ConsultaCatalogoCitas(e);
    try{
      var vacio = await getServicio(uriserv + "/citas/consultorio", "POST");
    }catch(err){
    }

}

async function muestraSolicitudes() {
    await consultaCatlalogoSolicitudes();
    document.getElementById("modalSOLICITUDES").showModal();
}

async function consultaCatlalogoSolicitudes() {
    //Filtros
    var id = document.getElementById("noregistro_2").value;
    var nombre = document.getElementById("nombrepaciente_2").value;
    var apellidoPaterno = document.getElementById("apellidopaternopaciente_2").value;
    var dataForm = {"id": id, "nombre": nombre, "apellido": apellidoPaterno};

    var tablaDatosSolicitudes="tblSolicitudes";
    var colsSolicitudes = ["ID Paciente", "Nombre Paciente", "No Empleado", "CURP", "Medico",
                           "Fecha Sol. PK", "Fecha Sol.", "Proxima Cita", "Procedencia", "Diagnostico",
                           "Observaciones"];
    var colocultas = [2,3,5,9,10]; //columnas ocultas por default
    try {
        // 1) Llamada GET
        const data = await getServicio(uriserv + "/citas/getStudyOrders", "POST", dataForm);
        CreateTableFromJSON("showDataSolicitudes", tablaDatosSolicitudes, colsSolicitudes);
        UpdateTableRows(tablaDatosSolicitudes, data);
        tableRowColorCellSelectionKlib(tablaDatosSolicitudes);
        hideTableColumns(tablaDatosSolicitudes, colocultas); 
        insertColumnK(tablaDatosSolicitudes, colsSolicitudes.length, "Agendar", "");
        updateTableColumns(tablaDatosSolicitudes, colsSolicitudes.length, "<button onclick='miFuncion()'><i class='fa fa-calendar' style='font-size:24px; color:black'></i></button>");    
      } catch (err) {
        alert("Error al recuperar información: " + err.message);
      }
}

function asignaEventosAGENDA(e){
    const rol = e.target.dataset.rol;
    const crudButtons = document.querySelectorAll(".crud");
    crudButtons.forEach(btn => {
        btn.dataset.rol = rol;
        btn.addEventListener("click", (event) => {
            CRUDconsultaCitas(event);
        });
    });
}
async function CRUDconsultaCitas(e) {
    const btn  = e.target
    var accion = btn.id;
    if (!accion){
      var accion = btn.dataset.accion //Boton del menú
    }
    switch (accion) {
      case "consultaAGENDA":
        await ConsultaCatalogoCitas();
        break;
      case "consultarSOLICITUDES":
        await muestraSolicitudes();
        break;
      case "consultaSOLICITUD":
        await consultaCatlalogoSolicitudes();
        break;
    }
}

async function ConsultaCatalogoCitas() {
    //Variables del formulario:
    var id = document.getElementById("noregistro").value;
    var nombre = document.getElementById("nombrepaciente").value;
    var apellidoPaterno = document.getElementById("apellidopaternopaciente").value;
    var dataForm = {"id": id, "nombre": nombre, "apellido": apellidoPaterno};
    

    var tablaDatosCitas="tblCitas";
    var colsCitas = ["Estudio", "Fecha", "Paciente", "Turno", "Sala", "Horario", "Estado"];
    
    var colsCitas = ["ID Paciente", "Nombre Paciente", "Domicilio Paciente", "Estudio", "ID Estudio", 
                    "ID Equipo", "Sala", "ID Area", "Area", "Turno", 
                    "Nombre Médico", "Fecha Solicitud", "Próxima Cita", "No. Empleado Médico", "Área Procedencia", 
                    "Diagnostico Médico", "Observaciones Médico", "CURP Recepcionista", "No. Empleado Recepcionista", "Fecha PK CE",
                    "CURP Médico", "Estado Cita"];
    var colocultas = [2,4,5,7,9,10,14,15,16,]; 
    try {
        // 1) Llamada GET
        const data = await getServicio(uriserv + "/citas/getAll", "POST",dataForm);
        CreateTableFromJSON("showDataAgendar", "tblCitas", colsCitas);
        UpdateTableRows(tablaDatosCitas, data);
        tableRowColorCellSelectionKlib(tablaDatosCitas);
        hideTableColumns(tablaDatosCitas, colocultas); 
    
      } catch (err) {
        alert("Error al recuperar información: " + err.message);
      }
    
}