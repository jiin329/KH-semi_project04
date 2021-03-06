<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/basic.css" />
<!-- 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/riceThief_header.css" />
<!-- header css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/riceThief_footer.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/adminSal.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/userlist.css" />
<%@page import="java.util.ArrayList"%>
<%@page import="admin.sal.vo.*"%>
<%@page import="admin.sal.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<%
	ArrayList<sale> volist = (ArrayList<sale>) request.getAttribute("salList");
	ArrayList<sale> volist1 = (ArrayList<sale>) request.getAttribute("salCal");
	int startPage = (int) request.getAttribute("startPage");
	int endPage = (int) request.getAttribute("endPage");
	int pageCount = (int) request.getAttribute("pageCount");
	int bCount = (int) request.getAttribute("bCount");
	
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src="https://kit.fontawesome.com/616f27e0c4.js"
	crossorigin="anonymous"></script>



<title>매출</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		buildCalendar();
	});

	var today = new Date(); // @param 전역 변수, 오늘 날짜 / 내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
	var date = new Date(); // @param 전역 변수, today의 Date를 세어주는 역할

	/**
	 * @brief   이전달 버튼 클릭
	 */
	function prevCalendar() {
		this.today = new Date(today.getFullYear(), today.getMonth() - 1, today
				.getDate());
		buildCalendar(); // @param 전월 캘린더 출력 요청
	}

	/**
	 * @brief   다음달 버튼 클릭
	 */
	function nextCalendar() {
		this.today = new Date(today.getFullYear(), today.getMonth() + 1, today
				.getDate());
		buildCalendar(); // @param 명월 캘린더 출력 요청
	}

	/**
	 * @brief   캘린더 오픈
	 * @details 날짜 값을 받아 캘린더 폼을 생성하고, 날짜값을 채워넣는다.
	 */
	function buildCalendar() {

		let doMonth = new Date(today.getFullYear(), today.getMonth(), 1);
		let lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0);

		let tbCalendar = document.querySelector(".scriptCalendar > tbody");
		document.getElementById("calYear").innerText = today.getFullYear(); // @param YYYY월
		document.getElementById("calMonth").innerText = autoLeftPad((today
				.getMonth() + 1), 2); // @param MM월

		// @details 이전 캘린더의 출력결과가 남아있다면, 이전 캘린더를 삭제한다.
		while (tbCalendar.rows.length > 0) {
			tbCalendar.deleteRow(tbCalendar.rows.length - 1);
		}

		// @param 첫번째 개행
		let row = tbCalendar.insertRow();

		// @param 날짜가 표기될 열의 증가값
		let dom = 1;

		// @details 시작일의 요일값( doMonth.getDay() ) + 해당월의 전체일( lastDate.getDate())을  더해준 값에서
		//               7로 나눈값을 올림( Math.ceil() )하고 다시 시작일의 요일값( doMonth.getDay() )을 빼준다.
		let daysLength = (Math
				.ceil((doMonth.getDay() + lastDate.getDate()) / 7) * 7)
				- doMonth.getDay();

		// @param 달력 출력
		// @details 시작값은 1일을 직접 지정하고 요일값( doMonth.getDay() )를 빼서 마이너스( - )로 for문을 시작한다.
		for (let day = 1 - doMonth.getDay(); daysLength >= day; day++) {

			let column = row.insertCell();

			// @param 평일( 전월일과 익월일의 데이터 제외 )
			if (Math.sign(day) == 1 && lastDate.getDate() >= day) {

				// @param 평일 날짜 데이터 삽입

				column.innerText = autoLeftPad(day, 2);

				// @param 일요일인 경우
				if (dom % 7 == 1) {
					column.style.color = "#FF4D4D";
				}

				// @param 토요일인 경우
				if (dom % 7 == 0) {
					column.style.color = "#4D4DFF";
					row = tbCalendar.insertRow(); // @param 토요일이 지나면 다시 가로 행을 한줄 추가한다.
				}

			}

			// @param 평일 전월일과 익월일의 데이터 날짜변경
			else {
				let exceptDay = new Date(doMonth.getFullYear(), doMonth
						.getMonth(), day);
				column.innerText = autoLeftPad(exceptDay.getDate(), 2);
				column.style.color = "#A9A9A9";
			}

			// @brief   전월, 명월 음영처리
			// @details 현재년과 선택 년도가 같은경우
			if (today.getFullYear() == date.getFullYear()) {

				// @details 현재월과 선택월이 같은경우
				if (today.getMonth() == date.getMonth()) {

					// @details 현재일보다 이전인 경우이면서 현재월에 포함되는 일인경우
					if (date.getDate() > day && Math.sign(day) == 1) {
						//column.style.backgroundColor = "#E5E5E5";
						column.style.cursor = "pointer";
						column.onclick = function() {
							calendarChoiceDay(this);
							console.log("이전");
							
							var year= date.getFullYear();
							var month=date.getMonth()+1
							var asd = year+"/"+month+"/"+day;
							
							// 선택날짜 yy-mm-dd 형식 문자열
							var chooseDay=asd.substr(2,9);
							var chooseMonth=asd.substr(2,5);
							var chooseyear=year-2000;
							console.log(chooseDay);
							console.log(chooseMonth);
							console.log(chooseyear);
							var dayPrice = 0;
							var monthPrice = 0;
							var yearPrice = 0;
							var totalPrice = 0;
							<% 
							if(volist1 != null){
								for (sale vo : volist1){
									
							%>
							var dbDay="<%=vo.getOrder_date()%>";
							if(dbDay==chooseDay){
								dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							}
						
							var dbMonth = dbDay.substr(0,5);
							console.log(">>>>>>>>>>>>"+dbMonth)
							if(dbMonth ==chooseMonth)
								monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
							var dbYear = dbMonth.substr(0,2);
							console.log(dbYear);
							console.log("클릭 연도" + chooseyear);
							if(dbYear ==chooseyear)
								yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
								
							
							if(dbDay!=null){
								totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
							}
							
							<%
								}}
							%>
							//$("#daySale").append(chooseDay);
							document.getElementById("year").innerHTML=year;
							document.getElementById("month").innerHTML=month;
							document.getElementById("date").innerHTML=chooseDay;
							
							document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
							document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
							document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
							document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
						}
					}

					// @details 현재일보다 이후이면서 현재월에 포함되는 일인경우
					else if (date.getDate() < day && lastDate.getDate() >= day) {
						column.style.backgroundColor = "#FFFFFF";
						column.style.cursor = "pointer";
						column.onclick = function() {
							calendarChoiceDay(this);
							console.log("이후");
							var year= date.getFullYear();
							var month=date.getMonth()+1
							var asd = year+"/"+month+"/"+day;
							
							// 선택날짜 yy-mm-dd 형식 문자열
							var chooseDay=asd.substr(2,9);
							var chooseMonth=asd.substr(2,5);
							var chooseyear=year-2000;
							console.log(chooseDay);
							console.log(chooseMonth);
							console.log(chooseyear);
							var dayPrice = 0;
							var monthPrice = 0;
							var yearPrice = 0;
							var totalPrice = 0;
							<% 
							if(volist1 != null){
								for (sale vo : volist1){
									
							%>
							var dbDay="<%=vo.getOrder_date()%>";
							if(dbDay==chooseDay){
								dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							}
						
							var dbMonth = dbDay.substr(0,5);
							if(dbMonth ==chooseMonth)
								monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
							var dbYear = dbMonth.substr(0,2);
							console.log(dbYear);
							console.log("클릭 연도" + chooseyear);
							if(dbYear ==chooseyear)
								yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
								
							
							if(dbDay!=null){
								totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
							}
							
							<%
								}}
							%>
							//$("#daySale").append(chooseDay);
							document.getElementById("year").innerHTML=year;
							document.getElementById("month").innerHTML=month;
							document.getElementById("date").innerHTML=chooseDay;
							
							document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
							document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
							document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
							document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
						}
					}

					// @details 현재일인 경우
					else if (date.getDate() == day) {
						column.style.backgroundColor = "#FFFFE6";
						column.style.cursor = "pointer";
						column.onclick = function() {
							calendarChoiceDay(this);
							console.log("현재");
							console.log(date.getFullYear());
							console.log(date.getMonth()+1);
							console.log(date.getDate());
							var year= date.getFullYear();
							var month=date.getMonth()+1;
							var day = date.getDate();
							console.log(year-2000);
							
							var asd = year+"/"+month+"/"+day;
							console.log(asd);
							
							// 선택날짜 yy-mm-dd 형식 문자열
							var chooseDay=asd.substr(2,9);
							var chooseMonth=asd.substr(2,5);
							var chooseyear=year-2000;
							console.log(chooseDay);
							console.log(chooseMonth);
							console.log(chooseyear);
							var dayPrice = 0;
							var monthPrice = 0;
							var yearPrice = 0;
							var totalPrice = 0;
							<% 
							if(volist1 != null){
								for (sale vo : volist1){
									
							%>
							var dbDay="<%=vo.getOrder_date()%>";
							if(dbDay==chooseDay){
								dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							}
						
							var dbMonth = dbDay.substr(0,5);
							if(dbMonth ==chooseMonth)
								monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
							var dbYear = dbMonth.substr(0,2);
							console.log(dbYear);
							console.log("클릭 연도" + chooseyear);
							if(dbYear ==chooseyear)
								yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
								
							
							if(dbDay!=null){
								totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
							}
							
							<%
								}}
							%>
							//$("#daySale").append(chooseDay);
							document.getElementById("year").innerHTML=year;
							document.getElementById("month").innerHTML=month;
							document.getElementById("date").innerHTML=chooseDay;
							
							document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
							document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
							document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
							document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
						}
					}

					// @details 현재월보다 이전인경우
				} else if (today.getMonth() < date.getMonth()) {
					if (Math.sign(day) == 1 && day <= lastDate.getDate()) {
						//column.style.backgroundColor = "#E5E5E5";
						column.style.cursor = "pointer";
						column.onclick = function() {
							calendarChoiceDay(this);
							
							var year= date.getFullYear();
							var month=today.getMonth()+1
							var asd = year+"/"+month+"/"+day;
							// 선택날짜 yy-mm-dd 형식 문자열
							var chooseDay=asd.substr(2,9);
							var chooseMonth=asd.substr(2,5);
							var chooseyear=year-2000;
							console.log(chooseDay);
							console.log(chooseMonth);
							console.log(chooseyear);
							var dayPrice = 0;
							var monthPrice = 0;
							var yearPrice = 0;
							var totalPrice = 0;
							<% 
							if(volist1 != null){
								for (sale vo : volist1){
									
							%>
							var dbDay="<%=vo.getOrder_date()%>";
							if(dbDay==chooseDay){
								dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							}
						
							var dbMonth = dbDay.substr(0,5);
							if(dbMonth ==chooseMonth)
								monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
							var dbYear = dbMonth.substr(0,2);
							console.log(dbYear);
							console.log("클릭 연도" + chooseyear);
							if(dbYear ==chooseyear)
								yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
								
							
							if(dbDay!=null){
								totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
							}
							
							<%
								}}
							%>
							//$("#daySale").append(chooseDay);
							document.getElementById("year").innerHTML=year;
							document.getElementById("month").innerHTML=month;
							document.getElementById("date").innerHTML=chooseDay;
							
							document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
							document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
							document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
							document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
						}
					}
				}

				// @details 현재월보다 이후인경우
				else {
					if (Math.sign(day) == 1 && day <= lastDate.getDate()) {
						column.style.backgroundColor = "#FFFFFF";
						column.style.cursor = "pointer";
						column.onclick = function() {
							calendarChoiceDay(this);
							var year= date.getFullYear();
							var month=today.getMonth()+1
							var asd = year+"/"+month+"/"+day;
							
							// 선택날짜 yy-mm-dd 형식 문자열
							var chooseDay=asd.substr(2,9);
							var chooseMonth=asd.substr(2,5);
							var chooseyear=year-2000;
							console.log(chooseDay);
							console.log(chooseMonth);
							console.log(chooseyear);
							var dayPrice = 0;
							var monthPrice = 0;
							var yearPrice = 0;
							var totalPrice = 0;
							<% 
							if(volist1 != null){
								for (sale vo : volist1){
									
							%>
							var dbDay="<%=vo.getOrder_date()%>";
							if(dbDay==chooseDay){
								dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							}
						
							var dbMonth = dbDay.substr(0,5);
							console.log(">>>>>>>>>>>>"+dbMonth)
							if(dbMonth ==chooseMonth)
								monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
							var dbYear = dbMonth.substr(0,2);
							console.log(dbYear);
							console.log("클릭 연도" + chooseyear);
							if(dbYear ==chooseyear)
								yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
								
							
							if(dbDay!=null){
								totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
							}
							
							<%
								}}
							%>
							//$("#daySale").append(chooseDay);
							document.getElementById("year").innerHTML=year;
							document.getElementById("month").innerHTML=month;
							document.getElementById("date").innerHTML=chooseDay;
							
							document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
							document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
							document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
							document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
						}
						
					}
				}
			}

			// @details 선택한년도가 현재년도보다 작은경우
			else if (today.getFullYear() < date.getFullYear()) {
				if (Math.sign(day) == 1 && day <= lastDate.getDate()) {
					column.style.backgroundColor = "#FFFFFF";
					column.style.cursor = "pointer";
					column.onclick = function() {
						calendarChoiceDay(this);
						var year= today.getFullYear();
						var month=today.getMonth()+1
						var asd = year+"/"+month+"/"+day;
						
						// 선택날짜 yy-mm-dd 형식 문자열
						var chooseDay=asd.substr(2,9);
						var chooseMonth=asd.substr(2,5);
						var chooseyear=year-2000;
						console.log(chooseDay);
						console.log(chooseMonth);
						console.log(chooseyear);
						var dayPrice = 0;
						var monthPrice = 0;
						var yearPrice = 0;
						var totalPrice = 0;
						<% 
						if(volist1 != null){
							for (sale vo : volist1){
								
						%>
						var dbDay="<%=vo.getOrder_date()%>";
						if(dbDay==chooseDay){
							dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
						}
					
						var dbMonth = dbDay.substr(0,5);
						console.log(">>>>>>>>>>>>"+dbMonth)
						if(dbMonth ==chooseMonth)
							monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
						
						var dbYear = dbMonth.substr(0,2);
						console.log(dbYear);
						console.log("클릭 연도" + chooseyear);
						if(dbYear ==chooseyear)
							yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
						
						if(dbDay!=null){
							totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
						}
						
						<%
							}}
						%>
						//$("#daySale").append(chooseDay);
						document.getElementById("year").innerHTML=year;
						document.getElementById("month").innerHTML=month;
						document.getElementById("date").innerHTML=chooseDay;
						
						document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
						document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
						document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
						document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
					}
				}
			}

			// @details 선택한년도가 현재년도보다 큰경우
			else {
				if (Math.sign(day) == 1 && day <= lastDate.getDate()) {
					column.style.backgroundColor = "#FFFFFF";
					column.style.cursor = "pointer";
					column.onclick = function() {
						calendarChoiceDay(this);
						var year= today.getFullYear();
						var month=today.getMonth()+1
						var asd = year+"/"+month+"/"+day;
						
						// 선택날짜 yy-mm-dd 형식 문자열
						var chooseDay=asd.substr(2,9);
						var chooseMonth=asd.substr(2,5);
						var chooseyear=year-2000;
						console.log(chooseDay);
						console.log(chooseMonth);
						console.log(chooseyear);
						var dayPrice = 0;
						var monthPrice = 0;
						var yearPrice = 0;
						var totalPrice = 0;
						<% 
						if(volist1 != null){
							for (sale vo : volist1){
								
						%>
						var dbDay="<%=vo.getOrder_date()%>";
						if(dbDay==chooseDay){
							dayPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
						}
					
						var dbMonth = dbDay.substr(0,5);
						console.log(">>>>>>>>>>>>"+dbMonth)
						if(dbMonth ==chooseMonth)
							monthPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
						
						var dbYear = dbMonth.substr(0,2);
						console.log(dbYear);
						console.log("클릭 연도" + chooseyear);
						if(dbYear ==chooseyear)
							yearPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;
							
						
						if(dbDay!=null){
							totalPrice += <%=(vo.getPro_price()*vo.getOrder_count())%>;	
						}
						
						<%
							}}
						%>
						//$("#daySale").append(chooseDay);
						document.getElementById("year").innerHTML=year;
						document.getElementById("month").innerHTML=month;
						document.getElementById("date").innerHTML=chooseDay;
						
						document.getElementById("daySale").innerHTML="<label>일 매출 : <label><input type='text' value='"+dayPrice+'원'+"'>";
						document.getElementById("monthSale").innerHTML="<label>월 매출 : <label><input type='text' value='"+monthPrice+'원'+"'>";
						document.getElementById("yearSale").innerHTML="<label>년 매출 : <label><input type='text' value='"+yearPrice+'원'+"'>";
						document.getElementById("totalSale").innerHTML="<label>총 매출 : <label><input type='text' value='"+totalPrice+'원'+"'>";
					}
				}
			}

			dom++;

		}
	}

	/**
	 * @brief   날짜 선택
	 * @details 사용자가 선택한 날짜에 체크표시를 남긴다.
	 */
	function calendarChoiceDay(column) {

		// @param 기존 선택일이 존재하는 경우 기존 선택일의 표시형식을 초기화 한다.
		if (document.getElementsByClassName("choiceDay")[0]) {
			document.getElementsByClassName("choiceDay")[0].style.backgroundColor = "#FFFFFF";
			document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");
		}
		// @param 선택일 체크 표시
		column.style.backgroundColor = "#FF9999";
		// @param 선택일 클래스명 변경
		column.classList.add("choiceDay");
	}
	function autoLeftPad(num, digit) {
		if (String(num).length < digit) {
			num = new Array(digit - String(num).length + 1).join("0") + num;
		}
		return num;
	}
</script>
</head>
<body>

	<%@ include file="riceThief_adminHeader.jsp"%>
	<hr>
	<main>
	<h2>매출 관리</h2>
	<div class="parent">
		<div class="calendar">
		<div class="table">
			<table class="scriptCalendar">
				<thead>
					<tr>
						<td onClick="prevCalendar();" style="cursor: pointer;">&#60;&#60;</td>
						<td colspan="5">
						<span id="calYear">YYYY</span>년 <span id="calMonth">MM</span>월</td>
						<td onClick="nextCalendar();" style="cursor: pointer;">&#62;&#62;</td>
					</tr>
					<tr>
						<td>일</td>
						<td>월</td>
						<td>화</td>
						<td>수</td>
						<td>목</td>
						<td>금</td>
						<td>토</td>
					</tr>
				</thead>
				<tbody></tbody>
				
			</table>
			</div>
		</div>
		
		<div class="sal">
			<h3>매출조회</h3>
			
			<div id="year"></div>
			<div id="month"></div>
			<div id="date"></div><br>
			
			
			<div id="daySale"></div>
			<!-- <input type="text"  id="daySale" readonly><br>  --> 
			<div id="monthSale"></div>
			<div id="yearSale"></div>
			<div id="totalSale"></div>
		</div>
		
	</div>
	<h2>주문 승인 목록</h2>
	<div class="board_list_wrap">
	<form method="get" action="UpdateSalsServlet" >
			<table class="board_list">
				<thead>
					<tr>
						<th>날짜</th>
						<th>판매 상품</th>
						<th>구매자 아이디</th>
						<th>가격</th>
						<th>승인처리상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<% 
						if(volist != null){
							for (sale vo : volist){
						%>
						<td><%=vo.getOrder_date() %></td>
						<td><%=vo.getPro_no() %></td>
						<td><%=vo.getId()%></td>
						<td><%=vo.getPro_price()*vo.getOrder_count() %></td>
						<!-- <td><%=vo.getOrder_status()%></td> -->
						<!-- <input type="hidden" > -->
						<td>[[ <%=vo.getOrder_detail_no()%> ]]
						<button type="submit" class="info_btn"name="order_no" value="<%=vo.getOrder_detail_no()%>" ><%=vo.getOrder_status()%></button></td>
						
					</tr>
					<%} } %>
				</tbody>
			</table>
			</form>
			<div class="paging">
				
				<%
					if (startPage > 1) {
				%>
				<a href="./SelectUserServlet?pagenum=<%=startPage - 1%>" class="num">이전</a>
				<%
					}
				%>
				<%
					for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="./selectsals?pagenum=<%=i%>" class="num"><%=i%></a>
				<%
					}
				%>
				<%
					if (endPage < pageCount) {
				%>
				<a href="./SelectUserServlet?pagenum=<%=endPage + 1%>" class="num">다음</a>
				<%
					}
				%>
				
			</div>
		</div>
	</main>
	<%@ include file="riceThief_footer.jsp" %>
</body>
</html>