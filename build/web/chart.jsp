<%-- 
    Document   : chart
    Created on : Jul 19, 2022, 12:18:01 PM
    Author     : 5555
--%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
      <!--Load the AJAX API-->
      <script type="text/javascript" src="https://www.google.com/jsapi"></script>
      <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});
      google.setOnLoadCallback(drawPieChart);
      google.setOnLoadCallback(drawBarChart);

      function drawPieChart() {
        // Create the data table.
        var data = new google.visualization.DataTable();
        // Create columns for the DataTable
        data.addColumn('string');
        data.addColumn('number', 'Price');
        // Create Rows with data
        data.addRows([
        <c:forEach items="${requestScope.products}" var="p">
          ['${p.name}', ${p.price}],
        </c:forEach>
        ]);
		//Create option for chart
        var options = {
          title: 'Most expensive video games',
          'width': 800,
          'height': 600
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart_div'));
        chart.draw(data, options);
      }
      
      
      function drawBarChart() {
        var randomColor = Math.floor(Math.random()*16777215).toString(16);
        // Create the data table.
        var data = new google.visualization.DataTable();
        // Create columns for the DataTable
        data.addColumn('string');
        data.addColumn('number', 'Rating');
        // Create Rows with data
        data.addRows([
        <c:forEach items="${requestScope.products2}" var="p">
          ['${p.name}', ${p.rating}],
        </c:forEach>
        ]);
		//Create option for chart
        var options = {
          title: 'Highest rated video games',
          'width': 800,
          'height': 600
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('barchart_div'));
        chart.draw(data, options);
      }
      
    </script>
    

  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <table>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a class="btn btn-primary" href="/PRJ301/home" role="button">Back to Home</a>
        <tr>
            <td><div id="piechart_div"></div></td>
            <td><div id="barchart_div" style="width: 800px; height: 300px;"></div></td>
        <tr/>
    </table>
  </body>
</html>
