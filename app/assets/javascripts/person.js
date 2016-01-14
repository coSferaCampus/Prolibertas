(function() {
  var app = angular.module('prolibertas-person', ['ui.router']);

  // Controllers
  app.controller('PeopleController', ['$filter', '$http', '$timeout', '$state', '$rootScope',
    function($filter, $http, $timeout, $state, $rootScope) {
    var scope = this;

    scope.sandwiches;
    scope.totalResources = 0;
    scope.page           = 1;
    scope.person         = {};
    scope.selected_day   = $filter('date')(new Date(), 'dd/MM/yyyy');
    scope.day            = $filter('date')(new Date(), 'dd/MM/yyyy');
    scope.loading        = true;
    scope.alertaCreado   = $state.params.alertaCreado;
    scope.alertaBorrado  = $state.params.alertaBorrado;
    scope.alertaGuardado = $state.params.alertaGuardado;
    scope.people         = [];
    scope.services       = [];

    $rootScope.prolibertas = "Lista de Personas"

    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaCreado   = false; }, 1000);
    $timeout(function() { scope.alertaBorrado  = false; }, 1000);
    $timeout(function() { scope.alertaGuardado = false; }, 1000);

    $('.datepicker').datetimepicker({locale: 'es', format: 'DD/MM/YYYY'});

    // Lista las personas y las filtra
    scope.getPeople = function() {
      scope.page = 1;
      params = "";
      if ( scope.filtro_surname    ) { params += '&surname='    + scope.filtro_surname;    }
      if ( scope.filtro_origin     ) { params += '&origin='     + scope.filtro_origin;     }
      if ( scope.filtro_identifier ) { params += '&identifier=' + scope.filtro_identifier; }
      if ( scope.filtro_spanish    ) { params += '&spanish='    + scope.filtro_spanish;    }

      scope.loading = true;
      $http.get('/people.json?page=' + scope.page + '&selected_day=' + scope.selected_day + params)
      .success(function(data) {
        scope.people  = data.people;
        scope.loading = false;

        if (data.people && data.people[0]) {
          scope.totalResources = data.people[0].total_people;
          scope.max_pages      = data.people[0].max_pages;
        }
      });
    };
    scope.getPeople();

    scope.paginate = function() {
      if( scope.loading )
        return
      if( scope.page > scope.max_pages )
        return

      scope.page = scope.page + 1;
      params = "";
      if ( scope.filtro_surname    ) { params += '&surname='    + scope.filtro_surname;    }
      if ( scope.filtro_origin     ) { params += '&origin='     + scope.filtro_origin;     }
      if ( scope.filtro_identifier ) { params += '&identifier=' + scope.filtro_identifier; }
      if ( scope.filtro_spanish    ) { params += '&spanish='    + scope.filtro_spanish;    }

      scope.loading = true;
      $http.get('/people.json?page=' + scope.page + '&selected_day=' + scope.selected_day + params)
      .success(function(data) {
        data.people.forEach(function(person) {
          scope.people.push(person);
        });
        scope.loading = false;
      });
    };

    $http.get('/services.json').success(function(data) { scope.services = data.services; });

    scope.changeDay = function() {
      scope.selected_day = $("#InputSelected_day").val();
      scope.day = $("#InputSelected_day").val();
      scope.getPeople();
    };

    //función para calcular la edad a partir de la fecha de nacimiento
    scope.anos = function (birth) {
      if (birth === null ) {
        return "";
      } else {
        var e = birth.split("-");
        var ano = e[0];
        var mes = e[1];
        var dia = e[2];

        fecha_hoy = new Date();
        ahora_ano = fecha_hoy.getYear();
        ahora_mes = fecha_hoy.getMonth();
        ahora_dia = fecha_hoy.getDate();
        edad      = (ahora_ano + 1900) - ano;

        if ( ahora_mes < (mes - 1) )                          { edad--;       }
        if ( ( (mes - 1) == ahora_mes) && (ahora_dia < dia) ) { edad--;       }
        if (edad > 1900)                                      { edad -= 1900; }

        return edad;
      }
    }

    scope.isTrue = function(value) { if (value) { return "Sí"; } };

    scope.genero = function(genero) {
      if (genero === "man") {
        return 'H';
      } else if (genero === "woman") {
        return 'M';
      }
    };

// ---------------------------------------- Servicios ---------------------------------------------

    scope.createUsedService = function(person, service) {
      $http.post('/used_services.json', {
        used_service: { person_id: person.id, service_id: service.id, created_at: scope.day }
      }).success(function(data) {
        person.used_services_of_selected_day_id[service.name] = data.used_service.id;
      });
    };

    scope.deleteUsedService = function(person, service) {
      $http.delete('/used_services/' + person.used_services_of_selected_day_id[service.name] + '.json')
        .success(function(data) {
          person.used_services_of_selected_day_id[service.name] = null;
        })
    };

    // Método que cambia a check si está desmarcado y viceversa
    scope.changeCheckbox = function(person, service) {
      if(person.used_services_of_selected_day_id[service.name])
        scope.deleteUsedService(person, service);
      else
      scope.createUsedService(person, service)
    };

    scope.getService = function(name) {
      var result = $.grep(scope.services, function(e) { return e.name == name; });
      return result[0];
    };
// -------------------------------------- FIN Servicios -------------------------------------------

    scope.alertClass = function(person) {
      if (person && person.pending_alerts && person.pending_alerts.length > 0) {
        if (person.pending_alerts[0].type == 'punishment') {
          return 'danger';
        }
        else if (person.pending_alerts[0].type == 'warning') {
          return 'warning';
        }
        else if (person.pending_alerts[0].type == 'advice') {
          return 'success';
        }
        else {
          return '';
        }
      }
    };

    scope.todayDate = function() {
      var today = new Date();
      var dd = today.getDate();
      var mm = today.getMonth()+1; //January is 0!

      var yyyy = today.getFullYear();
      if(dd<10){
        dd='0'+dd
      }
      if(mm<10){
        mm='0'+mm
      }
      var today = dd+'/'+mm+'/'+yyyy;

      return today;
    };

    scope.guardarSandwiches = function() {

      $http.post('/sandwiches.json', {amount: scope.sandwiches, created_at: scope.selected_day})
        .success( function(data) {
          $state.go("personas", { alertaGuardado: 'true' })
        }).error( function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };
  }]);

  app.controller('PersonController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.person = {};

    $http.get('/people/' + $state.params.id + '.json')
    .success(function(data) {
      scope.person = data.person;
      $rootScope.prolibertas = scope.person.name + ' ' + scope.person.surname;

      // Tipo de identificador
      if (scope.person.id_type === "Otro") {
        scope.id_type = "Identificador";
      } else {
        scope.id_type = scope.person.id_type;
      }
    });

    scope.genero = function(genero){
      if (genero == "man") {
        return 'Hombre';
      }
      else if (genero == "woman") {
        return 'Mujer';
      }
    };

    scope.asistencia = function(value) {
      if (value === 0) { return 'Primera vez'; }
      else if(value === 1) { return 'Habitual'; }
      else if(value === 2) { return 'Reincidente'; }
    };

    scope.documentacion = function(value) {
      if (value === 0) { return 'Indocumentado'; }
      else if(value === 1) { return 'Regularizado'; }
      else if(value === 2) { return 'Sin Regularizar'; }
    };

    scope.vivienda = function(value ) {
      if (value === 0) { return 'Sin vivienda'; }
      else if(value === 1) { return 'Vivienda'; }
      else if(value === 2) { return 'Infravivienda'; }
    };

    scope.si_o_no = function(value) {
      if (value === 0) { return 'No'; }
      else if(value === 1) { return 'Si'; }
    };

    scope.residencia = function(value) {
      if (value === 0) { return 'De paso'; }
      else if(value === 1) { return 'Residente'; }
    };

    scope.destroyPerson = function(person) {
      var confirmed = confirm('¿Desea borrar a ' + person.name + ' ' + person.surname + '?');
      if (confirmed) {
        $http.delete('/people/' + person.id + '.json').success(function(data) {
          $state.go("personas", { alertaBorrado: 'true' })
        });
      }
    };

  }]);

  app.controller('PersonFormController', ['$http', '$filter', '$state', '$rootScope',function($http, $filter, $state, $rootScope) {
    var scope = this;
    // Formulario
    scope.personForm = {};

    // Fecha de entrada a día de hoy
    scope.personForm.entry =  $filter('date')(new Date(), 'dd/MM/yyyy');

    // Errores
    scope.errors = {};

    // Paises del mundo
    scope.countries = ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"];

    // ZTS Zonas de Trabajo Social
    scope.zonas = ["Norte-Sierra", "Levante", "Sureste (Fuensanta)", "Centro (La Ribera)", "Sur",
      "Poniente Sur", "Poniente Norte (La Foggara) ", "Noroeste", "Periferia-Alcolea",
      "Periferia-Villarrubia", "Periferia-Santa Cruz", "Periferia-Cerro Muriano",
      "Periferia-El Higuerón", "Periferia-Trassierra", "ETF 1", "ETF 2", "ETF 3", "ETF 4", ""];

    // Tipos de documento de identidad
    scope.id_types = ["NIF", "NIE", "Pasaporte", "Otro"];

    $('.datepicker').datetimepicker({locale: 'es', format: 'DD/MM/YYYY'});

    scope.change = function(field) {
      if(scope.errors[field.toLowerCase()]) {
        $("#Input" + field).tooltip('destroy');
        scope.errors[field.toLowerCase()] = false
      }
    };

    scope.formDates = function() {
      scope.personForm.birth  = $( '#InputBirth'  ).val();
      scope.personForm.entry  = $( '#InputEntry'  ).val();
      scope.personForm.output = $( '#InputOutput' ).val();
    };

    scope.guardarPersona = function() {
      scope.formDates();

      if(scope.personForm.city)
        scope.personForm.city.toUpperCase();

      $http.post('/people.json', {person: scope.personForm})
        .success(function(data) {
          $state.go('personas', { alertaCreado: 'true' });
          scope.errors = {};
        })
        .error(function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.actualizarPersona = function() {
      scope.formDates();

      if(scope.personForm.city)
        scope.personForm.city.toUpperCase();

      $http.put("/people/" + $state.params.id + ".json",{person: scope.personForm})
        .success(function() {
          $state.go("persona", {id: $state.params.id});
          scope.errors = {};
        })
        .error(function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.actionForm = scope.guardarPersona;

    if ($state.params.id != undefined) {
      scope.actionForm = scope.actualizarPersona;
      $http.get('/people/' + $state.params.id + '.json')
      .success(function(data) {
        scope.personForm        = data.person;
        $rootScope.prolibertas  = "Editar expediente " + scope.personForm.exp;
        scope.personForm.birth  = data.person.birth.split("-").reverse().join("/");
        scope.personForm.entry  = data.person.entry.split("-").reverse().join("/");
        scope.personForm.output = data.person.output.split("-").reverse().join("/");
      });
    }
    else {
      scope.actionForm = scope.guardarPersona;
      $rootScope.prolibertas = "Nuevo Expediente"
    }
  }]);

  app.controller('PersonReportController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.services = {};
    scope.person = {};

    $http.get('/people/' + $state.params.id + '.json')
    .success(function(data){
      scope.person = data.person;
    });

    $http.get('/people/' + $state.params.id + '/individual_report.json')
    .success(function(data){
      scope.services = data;
    });

  }]);

  app.controller('PersonFilesController',  ['$http', '$timeout', '$state', '$rootScope', '$upload', function($http, $timeout, $state, $rootScope, $upload ) {
    var scope = this;
    scope.person = {};
    scope.person.attachments = [];
    scope.person.attachment = {};

    $http.get('/people/' + $state.params.id + '.json')
    .success(function(data){
      scope.person = data.person;
    });

    $http.get('/people/' + $state.params.id + '/attachments.json')
    .success(function(data){
      scope.person.attachments = data.attachments;
    });

    scope.adjuntar = function(add) {

      $upload.upload({
        url: "/people/" + $state.params.id + "/attachments.json",
        method: "POST",
        fields: scope.person.attachment,
        file: scope.person.attachment.file,
        fileFormDataName: "attachment[file]",
        formDataAppender: function(fd, key, val){
          fd.append('attachment[' + key + ']', val || '');
        }
      })
      .success(function(data) {
          scope.person.attachments.push(data.attachment);
          scope.errors = {};
        })
        .error(function(data) {
          scope.errors = data.errors;

          for(var error in scope.errors) {
            if(scope.errors[error]) {
              $("#Input" + $rootScope.capitalize(error))
                .tooltip({trigger: 'manual', title: scope.errors[error].join(', ')}).tooltip('show');
            }
          }
        });
    };

    scope.removeAttachment = function(attachment) {
      var confirmed = confirm("¿Desea borrar el archivo?");

      if (confirmed) {
        scope.person.attachment = attachment;

        $http.delete('/attachments/' + attachment.id + '.json')
          .success(function(data) {
            var index = scope.person.attachments.indexOf(attachment);
            if (index > -1) {
              scope.person.attachments.splice(index, 1);
            }
        });
      }
    };
  }]);
})();
