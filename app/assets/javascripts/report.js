$("#reportOption").on('change', function() {
  $("#report").empty();

  var width = 400,
    height = 400,
    radius = Math.min(width, height) / 2;

  var color = d3.scale.category20();

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
    }

  d3.json(reportUrl, function(error, data) {

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
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return (d.data.label + ": " + d.data.amount); });
  });

  $("#reportTitle").text( "Informe " + reportTitle);
});
