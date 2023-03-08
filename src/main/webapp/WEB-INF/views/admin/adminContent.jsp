<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>ordersMain.jsp</title>
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
		
		.circle{
		color:white;display:inline-block;border-radius:50px
		}
		.tit{
			font-size:1.5em;
			font-family: 'ChosunNm';
			font-weight:bold;
		}
	 </style>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	'use strict';
	
	function logout(){
  	parent.location.href = "${ctp}/member/memberLogout";
	}
</script>
<body class="bg-light" >
<div class="row p-0 m-0 border bg-white shadow" >
	<div class="col"><h2 class="pl-3" style="font-family:'ChosunNm', sans-serif;"><b>메인화면</b></h2></div>
	<div class="col">
		<jsp:include page="/WEB-INF/views/admin/adminHead.jsp"></jsp:include>
	</div>
</div>
<div class="container-fluid p-3">
	<div class="row ">
		<div class="col-md-3 ">
			<div class="border shadow-sm p-3" style="width:100%;height:250px;background-color:lavender;">
				<h1 class="p-3 circle" style="background-color:MediumPurple;" ><i class='bx bx-user' ></i>&nbsp;&nbsp;${s1Cnt}</h1>
				<span class="tit">구독</span>
				<table class="table table-bordered text-center mt-3">
					<tr class="bg-light">
						<th>구독중</th>
						<th>구독정지</th>
					</tr>
					<tr class="bg-white">
						<td>${s1Cnt}</td>
						<td>${sNCnt}</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="col-md-3 ">
			<div class="border shadow-sm p-3"  style="width:100%;height:250px;background-color:LavenderBlush">
				<h1 class="p-3 circle" style="background-color:Plum;" ><i class='bx bx-cart'></i>&nbsp;&nbsp;${oCnt}</h1>
				<span class="tit">진행중인 주문</span>
				<table class="table table-bordered text-center  mt-3">
					<tr class="bg-light">
						<th>결제완료</th>
						<th>입금확인</th>
						<th>배송준비중</th>
						<th>배송중</th>
					</tr>
					<tr class="bg-white">
						<td>${o1Cnt}</td>
						<td>${o2Cnt}</td>
						<td>${o3Cnt}</td>
						<td>${o4Cnt}</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="col-md-3">
			<div class="border shadow-sm p-3"  style="width:100%;height:250px;background-color:lemonchiffon">
				<h1 class="p-3 circle" style="background-color:Tan;" ><i class='bx bx-message-dots'></i>&nbsp;&nbsp;${qCnt}</h1>
				<span class="tit">미확인 문의메시지</span>
				<div class="bg-light border" style="height:120px;overflow:auto">
					<table class="table table-borderless ">
						<c:forEach var="qVo" items="${qVos}">
							<tr>
								<td>${qVo.questionId}</td>
								<td>${qVo.questionDate}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="border shadow-sm p-3"  style="width:100%;height:250px;background-color:lightblue">
				<h1 class="p-3 circle" style="background-color:LightSeaGreen;" ><i class='bx bx-notepad'></i>&nbsp;&nbsp;${jwCnt}</h1>
				<span class="tit">제휴신청서</span>
				<table class="table table-bordered text-center mt-3">
					<tr class="bg-light">
						<th>제휴중</th>
						<th>미제휴</th>
					</tr>
					<tr class="bg-white">
						<td>${jiCnt}</td>
						<td>${jnCnt}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="border mt-3 bg-white shadow" style="width:100%;">
	    <script type="text/javascript">

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', '판매량');
        data.addRows([
          ['${productVos[0].name}', ${productVos[0].sellCnt}],
          ['${productVos[1].name}', ${productVos[1].sellCnt}],
          ['${productVos[2].name}', ${productVos[2].sellCnt}],
          ['${productVos[3].name}', ${productVos[3].sellCnt}],
          ['${productVos[4].name}', ${productVos[4].sellCnt}],
          ['${productVos[5].name}', ${productVos[5].sellCnt}],
          ['${productVos[6].name}', ${productVos[6].sellCnt}],
        ]);

        // Set chart options
        var options = {'title':'Best 상품 (${dates[0]}~${dates[6]})',
                       'width':750,
                       'height':700};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
      function drawChart2() {

          var data2 = google.visualization.arrayToDataTable([
              ['날짜', '매출'],
              ['${dates[0]}',${prices[0]}],
              ['${dates[1]}',${prices[1]}],
              ['${dates[2]}',${prices[2]}],
              ['${dates[3]}',${prices[3]}],
              ['${dates[4]}',${prices[4]}],
              ['${dates[5]}',${prices[5]}],
              ['${dates[6]}',${prices[6]}],
            ]);

            var options2 = {
              title: '매출 (${dates[0]}~${dates[6]})',
              hAxis: {title: 'Date',  titleTextStyle: {color: '#333'}},
              vAxis: {minValue: 0},
              vAxis: {minValue: 0},
              'width':750,
              'height':700
            };

            var chart2 = new google.visualization.AreaChart(document.getElementById('chart_div2'));
            chart2.draw(data2, options2);
      }
    </script>
    <div class="row text-center pl-5 pr-5">
    	<div class="col-md-6 pl-5">
	    	<div id="chart_div" class=" p-3" style="width:100%;margin:0 auto"></div>
	    </div>
    	<div class="col-md-6  pr-5">
	    	<div id="chart_div2" class=" p-3" style="width:100%;margin:0 auto"></div>
	    </div>
    </div>
		<h3 class="text-right pl-5 pr-5 pb-3 "> <div class="btn btn-lg btn-light border" onclick="location.href='${ctp}/admin/extra/adminAnalize'">자세히 보기 ></div> </h3>
	</div>
</div>
</body>
</html>