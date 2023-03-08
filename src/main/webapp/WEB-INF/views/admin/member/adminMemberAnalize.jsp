<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>adminInputProduct.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
 	<jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
 	<style>
	  @font-face {
    font-family: 'ChosunNm';
    font-weight: normal;
    font-style: normal;
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot');
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.eot?#iefix') format('embedded-opentype'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff2') format('woff2'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.woff') format('woff'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/ChosunNm/ChosunNm.ttf') format("truetype");
    font-display: swap;
		}
	 </style>
 <script>
 	'use strict';
    function fSearch(){
  	  let startDate= myform.startDate.value;
  	  let lastDate= myform.lastDate.value;
  	  location.href="adminMemberAnalize?startDate="+startDate+"&lastDate="+lastDate;
    }
 	
 	
 </script>
</head>
<body class="bg-light">
<form name="myform">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>회원 통계</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="container-fluid p-5 mb-3 border shadow-sm" style="background-color:#fff">
		<div style="width:100%" class="text-right">
	  	<input type="date" name="startDate" value="${startDate}"/> - 
	  	<input type="date"  name="lastDate" value="${lastDate}"/>
	  	<input type="button" class="btn btn-success" onclick="fSearch()" value="조회" />
	  	<div class="row">
	  		<div class="col-md-6">
					<div id="chart_div" class=" p-3" style="width:100%;margin:0 auto"></div>
				</div>
	  		<div class="col-md-6">
					<div id="chart_div4" class=" p-3" style="width:100%;margin:0 auto"></div>
				</div>
			</div>
	  	<div class="row">
				<div id="chart_div3" class=" p-3" style="width:100%;margin:0 auto"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
		google.charts.load("current", {packages:["corechart"]});
 	  google.charts.setOnLoadCallback(drawChart3);
 	  google.charts.setOnLoadCallback(drawChart4);
 	  google.charts.setOnLoadCallback(drawVisualization);
	
    function drawChart3() {

        var data3 = google.visualization.arrayToDataTable([
            ['날짜','가입자수'],
	    	 			<c:forEach var="vo" items="${sellVos3}">
	      		  ['${vo.date}',${vo.cnt}],
	       		</c:forEach>
          ]);

          var options3 = {
            title: '가입자수',
            hAxis: {title: 'Date',  titleTextStyle: {color: '#333'}},
            vAxis: {minValue: 0},
            vAxis: {minValue: 0},
            'width':800,
            'height':500
          };

          var chart3 = new google.visualization.AreaChart(document.getElementById('chart_div'));
          chart3.draw(data3, options3);
      }
    function drawChart4() {
        var data4 = google.visualization.arrayToDataTable([
          ["Element", "Density", { role: "style" } ],
          ['${sellVos2[0].mid}',${sellVos2[0].cnt}, "#b87333"],
          ['${sellVos2[1].mid}',${sellVos2[1].cnt}, "silver"],
          ["${sellVos2[2].mid}", ${sellVos2[2].cnt}, "red"],
          ["${sellVos2[3].mid}", ${sellVos2[3].cnt}, "blue"],
          ["${sellVos2[4].mid}", ${sellVos2[4].cnt}, "gold"],
          ["${sellVos2[5].mid}", ${sellVos2[5].cnt}, "color: #e5e4e2"],
          ["${sellVos2[6].mid}", ${sellVos2[6].cnt}, "magenta"]
        ]);

        var view4 = new google.visualization.DataView(data4);
        view4.setColumns([0, 1,
                         { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options4 = {
          title: "Best7",
          'width':800,
          'height':500,
          bar: {groupWidth: "95%"},
          legend: { position: "none" },
        };
        var chart4 = new google.visualization.ColumnChart(document.getElementById("chart_div4"));
        chart4.draw(view4, options4);
    }
    function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['날짜','가입자수', '남자','여자','기업회원'],
					<c:forEach var="vo" items="${sellVos}">
					  ['${vo.date}',${vo.cnt1+vo.cnt2+vo.cnt}, ${vo.cnt1},${vo.cnt2},${vo.cnt}],
					</c:forEach>
        ]);

        var options = {
          title : '누적 가입자 수',
          'width':1600,
          'height':500,
          vAxis: {title: 'Cups'},
          hAxis: {title: 'Month'},
          seriesType: 'bars',
          series: {5: {type: 'line'}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div3'));
        chart.draw(data, options);
      }
	
	</script>
</div>
</form>
</body>
</html>