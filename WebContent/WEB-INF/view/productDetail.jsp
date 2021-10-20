<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/basic.css" />  <!-- 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_header.css" /> <!-- header css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_footer.css" /><!-- footer css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/productDetail.css"/>
<%@page import="product_post.vo.ProductPost"%>
<%@page import="product_img.vo.ProductImg"%>
<%@page import="product_option.vo.ProductOption"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src="https://kit.fontawesome.com/616f27e0c4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jquery -->
<title>밥도둑_스토어 상품 상세조회</title>
</head>
<body>
<%
	//To-do : 로그인해야지만 장바구&바로구매 연결
	
	/* User memberLoginInfo = (User)request.getSession().getAttribute("loginInfo");
	String id = null;
	if(memberLoginInfo != null){
		id = memberLoginInfo.getUid();
	}
	*/
	
	ProductPost vo = (ProductPost)request.getAttribute("vo");
	int rno = (int)request.getAttribute("rno"); 
	ArrayList<ProductOption> optionList = (ArrayList<ProductOption>)request.getAttribute("optionList");
	ArrayList<ProductImg> proImgList = (ArrayList<ProductImg>)request.getAttribute("proImgList");

%>
	<%@ include file="riceThief_header.jsp" %>
	<hr>
    <main>
      <div id="contentContainer">
        <div id="detailImgContainer">
            <img src="<%=vo.getPro_img()%>" id="titleImg" alt="상품 대표 사진">
        </div>
        <div id="detailContainer">
        	<div id="detailTitleContainer">
	     	    <h2 id="detailTitle" class="categoryProductTitle"><%=vo.getPro_title()%></h2>
     		</div>
     		<div id="detailPriceContainer">
    	 	    <h3 id="detailPrice" class="categoryProductPrice"><%=vo.getPro_price()%>원</h3>
     	    </div>
            <a href="#" onclick="productShare()" id="shareProduct"><i class="fas fa-share-square"></i></a>
        	
        	<h3 id="deilveryFee">배송비 <%=vo.getPro_delivery_fee()%>원 </h3>
        	
        	<form action="#">
  				<label for="productOption"></label>
  				<select id="option">
  				<% if(optionList != null){
  					for(int i=0; i<optionList.size(); i++){ %>
  				<option>
  					<%=optionList.get(i).getPro_option_content()%>
  				</option>
  				<%} } %>
  				</select>
  			</form>
  			
  			<div id="selectedOption">
  			</div>  			     	 
     	   </div>
     	<hr>
     	<div id="acount">	
        	<p id="allPro">총 상품 금액 : <%=vo.getPro_price()%>원<p>
        	<p id="totalPro">총 합계 금액 : <%=vo.getPro_price() + vo.getPro_delivery_fee() %>원</p>
  		</div>	
  		<div id="proBtn">
       		<button>장바구니 담기</button>
       		<button>바로 구매</button>
       	</div>
       	</div>	
       		
       		
       	<div id="productExplain">
       		<h2 id="expTxt">상품 상세정보</h2>
       		<div id="proExplainImg">
       		<%if(proImgList != null){
	            for(int i=0; i<proImgList.size(); i++){%>
       		<img src="<%=proImgList.get(i).getPro_content_img()%>" id="explainImg" alt="상품 상세설명">
       		<%} } %>
       		</div>
       	</div>
       	
       	<div id="review">
       		<h2>후기</h2>
		</div>       	      	
     </main>
    <%@ include file="riceThief_footer.jsp" %>
</body>
</html>
