<%@page import="getProLike.vo.GetProLikeVo"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/basic.css" />  <!-- 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_header.css" /> <!-- header css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/riceThief_footer.css" /><!-- footer css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css"/>
<%@page import="product_post.vo.ProductPost"%>
<%@page import="recipe.model.vo.Recipe"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src="https://kit.fontawesome.com/616f27e0c4.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="./js/mypage.js"></script> 
<title>밥도둑_메인</title>
<% String msg = (String)request.getAttribute("msg");%>
<script type="text/javascript">
    <%if(msg != null){%>
    	alert("<%=msg%>");
    <%}%>
</script>
</head>
<body>
<%
	ArrayList<Recipe> recommendList = (ArrayList<Recipe>)request.getAttribute("recommendList");
	ArrayList<Recipe> popularRecipe = (ArrayList<Recipe>)request.getAttribute("popularRecipe");
	ArrayList<GetProLikeVo> popularProduct = (ArrayList<GetProLikeVo>)request.getAttribute("popularProduct");
	session.getAttribute("sessionID");
	session.getAttribute("sessionNickname");
%>
	<%@ include file="riceThief_header.jsp" %>
	<hr>
	<main>
        <div class="slideContainer">
			<div class="mySlides fade">
			  <img src="./css/001.png" class="slideImg" alt="slide show">
			</div>
			<div class="mySlides fade">
			  <img src="./css/002.png" class="slideImg" alt="slide show">
			</div>
			<div class="mySlides fade">
			  <img src="./css/003.png" class="slideImg" alt="slide show">
			</div>
			<div class="mySlides fade">
			  <img src="./css/004.png" class="slideImg" alt="slide show">
			</div>
			<a class="prev" onclick="plusSlides(-1)"><i class="fas fa-chevron-left"></i></a>
			<a class="next" onclick="plusSlides(1)"><i class="fas fa-chevron-right"></i></a>
		</div>
		<br>
		<div style="text-align:center">
		  <span class="dot" onclick="currentSlide(1)"></span> 
		  <span class="dot" onclick="currentSlide(2)"></span> 
		  <span class="dot" onclick="currentSlide(3)"></span> 
		  <span class="dot" onclick="currentSlide(4)"></span> 
		</div>
		
        <div class="ctMargin">
            <h2 class="title-font">추천 레시피</h2>
            <div id="recommendRecipe">
                <% int recCnt = 0;
                for(;recCnt<recommendList.size(); recCnt++){ %>
                <div class="recommendImgWrap">
                	<img src="<%=recommendList.get(recCnt).getRec_img()%>" class="recommendImg" alt="추천 레시피">
                	<div class="recommendImgContent">
	                	<p><a href="selectrecipe?rno=<%=recommendList.get(recCnt).getRecipe_no()%>"><%=recommendList.get(recCnt).getRec_title()%></a></p>
	                	<i class="fas fa-comment"></i> <%=recommendList.get(recCnt).getLikeCnt()%>
                	</div>
                </div>
                <%} %>
            </div>
        </div>
        <div id="popularRecipeContainer" class="ctMargin">
            <h2 class="title-font">인기 레시피</h2>
            <div id="popularRecipe">
             <% int recPCnt = 0;
             for(;recPCnt<popularRecipe.size(); recPCnt++){ %>
                <a href="selectrecipe?rno=<%=popularRecipe.get(recPCnt).getRecipe_no()%>"><img src="<%=popularRecipe.get(recPCnt).getRec_img()%>" class="popularImg" alt="추천 레시피"></a>
                <div class="prInfo">
                	<p><%=recPCnt+1%></p>
                	<p class="prTitle"><a href="selectrecipe?rno=<%=popularRecipe.get(recPCnt).getRecipe_no()%>"><%=popularRecipe.get(recPCnt).getRec_title()%></a></p>
                	<p><i class="fas fa-heart"></i> <%=popularRecipe.get(recPCnt).getLikeCnt()%></p>
                </div>
            <%} %>
            </div>
        </div>
        <div class="ctMargin">
            <h2 class="title-font">인기 상품</h2>
            <div id="popularProduct">
	            <div id="leftContent">
	            	<a href="selectproduct?rno=<%=popularProduct.get(0).getPro_no()%>"><img id="leftImg" src="<%=popularProduct.get(0).getPro_img()%>" alt="인기 상품"></a>
	            	<p class="proTitle"><a href="selectproduct?rno=<%=popularProduct.get(0).getPro_no()%>">1. <%=popularProduct.get(0).getPro_title()%></a></p>
	            	<p><i class="fas fa-heart"></i> <%=popularProduct.get(0).getCnt()%></p>
	            </div>
	            <%for(int proCnt = 1; proCnt<popularProduct.size(); proCnt++){ %>
	            <div class="rightContent">
	            	<a href="selectproduct?rno=<%=popularProduct.get(proCnt).getPro_no()%>" class="rightContainer"><img class="rightImg" src="<%=popularProduct.get(proCnt).getPro_img()%>" alt="인기 상품"></a>
	            	<p class="proTitle"><a href="selectproduct?rno=<%=popularProduct.get(proCnt).getPro_no()%>"><%=proCnt+1%>. <%=popularProduct.get(0).getPro_title()%></a></p>
	            	<p><i class="fas fa-heart"></i> <%=popularProduct.get(proCnt).getCnt()%></p>
	            </div>
	            <%} %>
            </div>
        </div>
    </main>
    <hr>

	<%@ include file="riceThief_footer.jsp" %>
	
	<script>
	var slideIndex = 1;
	showSlides(slideIndex);
	
	function plusSlides(n) {
	  showSlides(slideIndex += n);
	}
	
	function currentSlide(n) {
	  showSlides(slideIndex = n);
	}
	
	function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("dot");
	  if (n > slides.length) {slideIndex = 1}    
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
	      slides[i].style.display = "none";  
	  }
	  for (i = 0; i < dots.length; i++) {
	      dots[i].className = dots[i].className.replace(" active", "");
	  }
	  slides[slideIndex-1].style.display = "block";  
	  dots[slideIndex-1].className += " active";
	}
	</script>
</body>
</html>
