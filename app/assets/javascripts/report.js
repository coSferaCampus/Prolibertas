$("#showReport").on('click', function() {
  $("#report").empty();

  var width = 600,
    height = 600,
    radius = Math.min(width, height) / 2;

  var color = d3.scale.category10();

  var arc = d3.svg.arc()
      .outerRadius(radius - 10)
      .innerRadius(0);

  var pie = d3.layout.pie()
      .sort(null)
      .value(function(d) { return d.amount; });

  var svg = d3.select("#report").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  reportUrl ="", reportTitle= "";

  switch( $("#reportOption").val() ) {
    case "0":
      reportUrl = "/reports/spanish.json";
      reportTitle = "Españoles/Extranjeros";
      break;
    case "1":
      reportUrl = "/reports/genre.json";
      reportTitle = "Hombres/Mujeres";
      break;
    case "2":
      reportUrl = "/reports/documentation.json";
      reportTitle = "Indocumentado/Regularizado/Irregular";
      break;
    case "3":
      reportUrl = "/reports/assistance.json";
      reportTitle = "Primera vez/Habitual/Reincidente";
      break;
    case "4":
      reportUrl = "/reports/residence.json";
      reportTitle = "De Paso/Residente";
      break;
    case "5":
      reportUrl = "/reports/origin.json";
      reportTitle = "País de origen";
      break;
    case "6":
      reportUrl = "/reports/city.json";
      reportTitle = "Cantidad de Españoles por ciudad";
      break;
    case "7":
      reportUrl = "/reports/people.json";
      reportTitle = "Personas en la plataforma";
      break;
    case "8":
      reportUrl = "/reports/services_year.json";
      reportTitle = "Servicios";
      break;
    case "9":
      reportUrl = "/reports/sandwiches.json";
      reportTitle = "Bocadillos";
      break;
    case "10":
      reportUrl = "/reports/inv.json";
      reportTitle = "Inventario";
      break;
    }

  url = reportUrl + '?selected_year=' + $("#SelectedYear").val();

  d3.json(url, function(error, data) {

    data.forEach(function(d) {
      d.amount = +d.amount;
    });

    var g = svg.selectAll(".arc")
      .data(pie(data))
      .enter().append("g")
      .attr("class", "arc");

    g.append("path")
      .attr("d", arc)
      .style("fill", function(d) { return color(d.data.label); });

    g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dx", 12)
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.label + ": " + d.data.amount; });
  });

  $("#reportTitle").text( "Informe " + reportTitle);
});
