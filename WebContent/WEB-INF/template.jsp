<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/basic.css" />  <!-- 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_header.css" /> <!-- header css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_footer.css" /><!-- footer css -->

<!-- jquey -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- title -->
<title>Insert title here</title>
</head>
<body>
	<%@ include file="riceThief_header.jsp" %>
	
	<!-- 여기에 입력 -->
	
	<%@ include file=riceThief_footer.jsp" %>
</body>
</html>