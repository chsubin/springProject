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
	
 	function fCheck(idx){
 		let memo= $("#memo").val();
 		
 		$.ajax({
			type:"post",
			url:"${ctp}/admin/joins/adminJoinsMemoUpdate",
			data:{idx:idx,memo:memo},
			success:function(){alert("상담결과를 등록하였습니다.");location.reload();},
			error:function(){}
 		});
 	}
 		
 		$(function(){
 			$("#joinSw").change(function(){
 				let joinSw= $("#joinSw").val();
 				alert(joinSw);
 				location.href="adminJoinsApply?joinSw="+joinSw;
 			});
 		});
 		
      function fSearch(part){
    	  let startDate= myform.startDate.value;
    	  let lastDate= myform.lastDate.value;
    	  
    	  let search ="";
    	  if(part=="level"){
    		  search =  myform.level.value;
    	  }
    	  else{
    		  search = myform.gender.value;
    	  }
    	  
    	  location.href="adminAnalize?startDate="+startDate+"&lastDate="+lastDate+"&part="+part+"&search="+search;
      }
 		
 </script>
</head>
<body class="bg-light">
<div class="row p-0 m-0 border shadow" style="background-color:#fff;border:1px solid gray">
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>주문 통계</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid  p-3">
	<div class="border mt-3 bg-white shadow" style="width:100%;">
	  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	  <script type="text/javascript">
	    google.charts.load("current", {packages:["corechart"]});
	    google.charts.setOnLoadCallback(drawChart);
	    google.charts.setOnLoadCallback(drawChart2);
	    google.charts.setOnLoadCallback(drawChart3);
	    google.charts.setOnLoadCallback(drawChart4);
	    google.charts.setOnLoadCallback(drawBasic);
	    
	    function drawChart() {
	      var data = google.visualization.arrayToDataTable([
	        ['RNnfd', 'Speakers (in millions)'],
	    	  <c:forEach var="vo" items="${cateVos}">
	        ['${vo.smallName}',  ${vo.cnt}],
	        </c:forEach>
	      ]);
	
	    var options = {
	      legend: 'none',
	      pieSliceText: 'label',
	      title: '카테고리별 판매량',
	      pieStartAngle: 100,
	      width: 420,
	      height: 400
	    };
	
	      var chart = new google.visualization.PieChart(document.getElementById('piechart'));
	      chart.draw(data, options);
	    }
	    
      function drawChart2() {

          // Create the data table.
          var data2 = new google.visualization.DataTable();
          data2.addColumn('string', 'Topping');
          data2.addColumn('number', '판매수익');
          data2.addRows([
	    	  <c:forEach var="vo" items="${cateVos}">
		        ['${vo.smallName}',  ${vo.price}],
		        </c:forEach>
          ]);

          // Set chart options
          var options2 = {'title':'카테고리별 판매수익',
                         'width':420,
                         'height':400};

          // Instantiate and draw our chart, passing in some options.
          var chart2 = new google.visualization.BarChart(document.getElementById('chart_div2'));
          chart2.draw(data2, options2);
        }

	      function drawChart3() {

	          var data3 = google.visualization.arrayToDataTable([
	              ['날짜','총 매출액', '단품상품','구독상품'],
		    	 			<c:forEach var="vo" items="${sellVos}">
	  	      		  ['${vo.date}',${vo.price1+vo.price2}, ${vo.price1},${vo.price2}],
	  	       		</c:forEach>
	            ]);

	            var options3 = {
	              title: '매출',
	              hAxis: {title: 'Date',  titleTextStyle: {color: '#333'}},
	              vAxis: {minValue: 0},
	              vAxis: {minValue: 0},
	              'width':800,
	              'height':500
	            };

	            var chart3 = new google.visualization.AreaChart(document.getElementById('chart_div3'));
	            chart3.draw(data3, options3);
	        }
	      function drawChart4() {
	          var data4 = google.visualization.arrayToDataTable([
	            ["Element", "Density", { role: "style" } ],
	            ['${productVos[0].name}',${productVos[0].sellCnt}, "#b87333"],
	            ['${productVos[1].name}',${productVos[1].sellCnt}, "silver"],
	            ["${productVos[2].name}", ${productVos[2].sellCnt}, "red"],
	            ["${productVos[3].name}", ${productVos[3].sellCnt}, "blue"],
	            ["${productVos[4].name}", ${productVos[4].sellCnt}, "gold"],
	            ["${productVos[5].name}", ${productVos[5].sellCnt}, "color: #e5e4e2"],
	            ["${productVos[6].name}", ${productVos[6].sellCnt}, "magenta"]
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
	            width: 420,
	            height: 400,
	            bar: {groupWidth: "95%"},
	            legend: { position: "none" },
	          };
	          var chart4 = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
	          chart4.draw(view4, options4);
	      }
	      
	      function drawBasic() {
	          var data4 = google.visualization.arrayToDataTable([
		            ["Element", "Density",{ role: "style" }],
					 			<c:forEach var="vo" items="${sellVos}">
					      	['${vo.date}',${vo.cnt},"darkblue"],
					      </c:forEach>
		          ]);

	          var view4 = new google.visualization.DataView(data4);
	          view4.setColumns([0, 1,
	                           { calc: "stringify",
	                             sourceColumn: 1,
	                             type: "string",
	                             role: "annotation" },
	                           2]);

		          var options4 = {
		            title: "구독 수",
		            width: 800,
		            height: 500,
		            hAxis: {title: '구독 시작일'},
		            bar: {groupWidth: "95%"},
		            legend: { position: "none" },
		          };
		          var chart4 = new google.visualization.ColumnChart(document.getElementById("chart_div4"));
		          chart4.draw(view4, options4);
	        }
	  </script>
	  <div class="p-3" style="width:100%" class="text-left">
	  	<form name="myform">
	  		<table class="table table-borderless">
	  			<tr>
	  				<td width="30%"></td>
	  				<td>
					  	<input type="date" name="startDate" class="form-control" value="${startDate}"/>
					  <td>
					  <td>
					   - 
					   </td>
					   <td>
				  		<input type="date"  name="lastDate" class="form-control" value="${lastDate}"/>
		  			</td>
				   <td width="10%"></td>
		  			<td>
					  	<select name="level" class="form-control">
					  		<option value="99">선택</option>
					  		<option value="3" ${search=='3'?'selected':''}>기업회원</option>
					  		<option value="0" ${search=='0'?'selected':''}>개인회원</option>
					  	</select>
		 		 		</td>
		 			 	<td width="10%">
		  				<input type="button" class="btn btn-success" onclick="fSearch('level')" value="조회" />
		  			</td>
			  		<td>
					  	<select name="gender" class="form-control">
					  		<option value="99" >선택</option>
					  		<option value="남자" ${search=='남자'?'selected':''}>남자</option>
					  		<option value="여자" ${search=='여자'?'selected':''}>여자</option>
					  	</select>
				  	</td>
				  	<td width="10%">
					  	<input type="button" class="btn btn-success" onclick="fSearch('gender')" value="조회" />
				  	</td>
			  	</tr>
		  	</table>
	  	</form>
	  </div>
    <div class="row text-center pl-5 pr-5">
    	<div class="col-md-4">
	    	<div id="piechart" class=" p-3" style="width:100%;margin:0 auto"></div>
	    </div>
    	<div class="col-md-4">
	    	<div id="chart_div2" class=" p-3" style="width:100%;margin:0 auto"></div>
	    </div>
    	<div class="col-md-4">
	    	<div id="columnchart_values" class=" p-3" style="width:100%;margin:0 auto"></div>
	    </div>
    </div>
    <div class="row text-center pl-5 pr-5">
    	<div class="col-md-6">
  			<div id="chart_div3" class=" p-3" style="width:100%;margin:0 auto"></div>
  		</div>
    	<div class="col-md-6">
  			<div id="chart_div4" class=" p-3" style="width:100%;margin:0 auto"></div>
  		</div>
  	</div>
	</div>
</div>
</body>
</html>