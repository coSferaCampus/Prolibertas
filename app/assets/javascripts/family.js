(function() {
  var app = angular.module('prolibertas-family', ['ui.router']);

  // Controllers
  app.controller('FamiliesController', ['$http', '$filter', '$timeout','$rootScope', '$state', function($http, $filter, $timeout, $rootScope, $state) {
    var scope = this;
    scope.families = [];
    scope.familyForm = {};
    scope.errors = {};

    // Fecha de entrada a día de hoy
    scope.familyForm.from =  $filter('date')(new Date(), 'dd/MM/yyyy');

    // Fecha de salida dentro de 15 días
    var dateIn15Days = new Date(+new Date() + (86400000 * 15));
    scope.familyForm.to =  $filter('date')(dateIn15Days, 'dd/MM/yyyy');

    // Paises del mundo
    scope.countries = ["España","Marruecos","Rumanía","Afganistán","Islas Äland","Albania","Algeria","Samoa Americana","Andorra","Angola","Anguila","Antártida","Antigua y Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbayán","Bahamas","Bahrein","Bangladesh","Barbados","Bielorrusia","Bélgica","Belice","Benín","Islas Bermudas","Bhután","Bolivia, Estado plurinacional de","Islas BES (Caribe Neerlandés)","Bosnia y Herzegovina","Botsuana","Isla Bouvet","Brasil","Británico del Océano Índico, Territorio","Brunei Darussalam","Bulgaria","Burquina Faso","Burundi","Camboya","Camerún","Canadá","Cabo Verde","Islas Caimán","República Centro-africana","Chad","Chile","China","Isla de Navidad","Islas Cocos (Keeling)","Colombia","Comores, Islas","Congo","Islas Cook","Costa Rica","Costa de Marfíl","Croacia","Cuba","Curasao","Chipre","República Checa","Dinamarca","Yibuti","Dominica","República Dominicana","Ecuador","Egipto","El Salvador","Guinea Ecuatorial","Eritrea","Estonia","Etiopía","Islas Falkland (Malvinas)","Islas Feroe","Fiyi","Finlandia","Francia","Guayana Francesa","Polinesia Francesa","Territorios Franceses del Sur","Gabón","Gambia","Georgia","Alemania","Ghana","Gibraltar","Grecia","Groenlandia","Granada","Guadalupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haití","Islas Heard e Islas McDonald","Santa Sede (Ciudad Estado del Vaticano)","Honduras","Hong Kong","Hungría","Islandia","India","Indonesia","Irán, República islámica de","Irak","Irlanda","Isla de Man","Israel","Italia","Jamaica","Japón","Jersey","Jordania","Kazajistán","Kenia","Kiribati","Corea","Kuwait","Kirgizstán","Lao","Letonia","Líbano","Lesoto","Liberia","Libia","Liechtenstein","Lituania","Luxemburgo","Macao","Macedonia","Madagascar","Malawi","Malasia","Islas Maldivas","Mali","Malta","Islas Marshall","Martinica","Mauritania","Mauricio","Mayotte","México","Micronesia","Moldavia","Mónaco","Mongolia","Montenegro","Montserrat","Mozambique","Birmania","Namibia","Nauru","Nepal","Países Bajos","Nueva Caledonia","Nueva Zelanda","Nicaragua","Niger","Nigeria","Niue","Isla Norfolk","Islas Marianas del Norte","Noruega","Omán","Pakistán","Palau","Palestina","Panamá","Papúa Nueva Guinea","Paraguay","Perú","Filipinas","Pitcairn","Polonia","Portugal","Puerto Rico","Qatar","Reunión","Federación Rusa","Ruanda","San Bartolomé","Santa Elena, Ascensión y Tristán de Acuña","San Cristobo y Nevis","Santa Lucía","San Martín (zona francesa)","San Pedro y Miquelon","San Vicente y las Granadinas","Samoa","San Marino","Santo Tomé y Príncipe","Arabia Saudí","Senegal","Serbia","Seychelles","Sierra Leona","Singapur","Isla de San Martín (zona holandesa)","Eslovaquia","Eslovenia","Islas Salomón","Somalia","Suráfrica","Georgia del Sur e Islas Sandwitch del Sur","Sri Lanka","Sudán","Surinám","Sudán del Sur","Svalbard y Jan Mayen","Swazilandia","Suecia","Suiza","República árabe de Siria","Taiwán","Tadjikistán","Tanzania","Tailandia","Timor Oriental","Togo","Tokelau","Tonga","Trinidad y Tobago","Tunez","Turquía","Turkmenistán","Turks y Caicos, Islas","Tuvalu","Uganda","Ucrania","Emiratos Árabes Unidos","Reino Unido","Estados Unidos","Islas menores exteriores de Estados Unidos","Uruguay","Uzbekistán","Vanuatu","Venezuela, República Bolivariana de","Vietnam","Islas Vírgenes, Británicas","Islas Vírgenes, de EEUU","Wallis y Futuna","Sahara Occidental","Yemen","Zambia","Zimbabue"];

    // ZTS Zonas de Trabajo Social
    scope.zonas = ["Norte-Sierra", "Levante", "Sureste (Fuensanta)", "Centro (La Ribera)", "Sur",
      "Poniente Sur", "Poniente Norte (La Foggara) ", "Noroeste", "Periferia-Alcolea",
      "Periferia-Villarrubia", "Periferia-Santa Cruz", "Periferia-Cerro Muriano",
      "Periferia-El Higuerón", "Periferia-Trassierra", "ETF 1", "ETF 2", "ETF 3", "ETF 4"];

    // Tipos de documento de identidad
    scope.id_types = ["", "NIF", "NIE", "Pasaporte", "Otro"];

    scope.alertaCreado = $state.params.alertaCreado;

    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaCreado = false; }, 5000);

    scope.alertaBorrado = $state.params.alertaBorrado;
    // La alerta se oculta después de 5 segundos
    $timeout(function() { scope.alertaBorrado = false; }, 5000);
    $rootScope.prolibertas = "Lista de Familias";

    $http.get('/families.json')
      .success(function(data) {
        scope.families = data.families;
      });

    scope.change = function( field ) {
      if( scope.errors[ field.toLowerCase() ] ) {
        $( "#Input" + field ).tooltip( 'destroy' );
        scope.errors[ field.toLowerCase() ] = false
      }
    };

// ------------------------------------- Fechas y horas -------------------------------------------
    $( '.datepicker'     ).datetimepicker({ locale: 'es', format: 'DD/MM/YYYY' });
    $( '.datetimepicker' ).datetimepicker({ locale: 'es', format: 'HH:mm'      });

    scope.formDates = function() {
      scope.familyForm.from        = $( '#InputFrom'        ).val();
      scope.familyForm.to          = $( '#InputTo'          ).val();
      scope.familyForm.ropero_date = $( '#InputRopero_date' ).val();
      scope.familyForm.ropero_time = $( '#InputRopero_time' ).val();
    };
// ------------------------------------------------------------------------------------------------

    scope.guardarFamilia = function() {
      scope.formDates();

      $http.post('/families.json', { family: scope.familyForm })
        .success(function(data){
          $state.go('familias', { alertaCreado: 'true' });
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

    scope.actualizarFamilia = function() {
      scope.formDates();

      $http.put( "/families/" + $state.params.id + ".json",{ family: scope.familyForm } )
        .success(function() {
          $state.go( "familia", { id: $state.params.id } );
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

    scope.actionForm = scope.guardarFamilia;

    if ($state.params.id != undefined) {

      scope.actionForm = scope.actualizarFamilia;

      $rootScope.prolibertas = "Editar Familia";

      $http.get('/families/' + $state.params.id + '.json')
        .success( function(data ) {
          scope.familyForm = data.family;
      });
    }
    else {
        scope.actionForm = scope.guardarFamilia;
      $rootScope.prolibertas = "Familia Nueva";
    }

  }]);

  app.controller('FamilyController',  ['$http', '$timeout', '$state', '$rootScope', function($http, $timeout, $state, $rootScope ) {
    var scope = this;
    scope.family = {};

    $http.get('/families/' + $state.params.id + '.json')
    .success(function(data){
      scope.family = data.family;
      $rootScope.prolibertas = scope.family.name + ' ' + scope.family.surname;

      // Tipo de identificador
      if (scope.family.id_type === "Otro") {
        scope.id_type = "Identificador";
      } else {
        scope.id_type = scope.family.id_type;
      }
    });

    scope.destroyFamily = function( family ) {
      var confirmed = confirm('¿Desea borrar a ' + family.name + ' ' + family.surname + '?');
      if ( confirmed ) {
        $http.delete('/families/' + family.id + '.json').success( function( data ) {
          $state.go( "familias", { alertaBorrado: 'true' } )
        });
      }
    };


    scope.genero = function( genero ) {
      if ( genero == "man" ) {
        return 'H';
      }
      else if ( genero == "woman" ) {
        return 'M';
      }
    };

    scope.asistencia = function(value) {
      if (value === 0) { return 'Primera vez'; }
      else if(value === 1) { return 'Habitual'; }
      else if(value === 2) { return 'Reincidente'; }
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
  }]);
})();
