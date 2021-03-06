<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/basic.css" />
<!-- 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/riceThief_header.css" />
<!-- header css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/riceThief_footer.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/updateUser.css" />
<%@page import="user.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User user=(User)request.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="./js/mypage.js"></script> 
<title>회원 정보 수정</title>
</head>
<body>
	<header>
		<%@ include file="riceThief_header.jsp"%>
		<hr>
	</header>
	<section>
		<br>
		<h1 class="line">회원 정보 수정</h1>
		<br>
		<div id="frmCon">
			<form method="post" action="updateuser">
				<table class="line">
					<tr>
						<td>아이디</td>
						<td><input type="text" name="uid" value="<%=user.getUid() %>" readonly></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pw" value="<%=user.getPw() %>"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<td><input type="password" name="repw"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="uname" value="<%=user.getUname() %>"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type="text" name="nickname" value="<%=user.getNickname() %>"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" name="email" value="<%=user.getEmail() %>"></td>
					</tr>
					<tr>
						<td>핸드폰 번호</td>
						<td><input type="text" name="phone" value="<%=user.getPhone() %>"></td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="text" name="address" value="<%=user.getAddress() %>"></td>
					</tr>
			
					<tr>
						<td>나이</td>
						<td><input type="number" id="agenum" name="age" class="in" min="12" max="99" step="1" name="age" value="<%=user.getAge() %>"></td>
					</tr>
				</table>
				<button type="submit" id="updateuserbtn" class="line">수정확인</button>
				<button onclick="deleteAlert()">회원탈퇴</button>
			</form>
		</div>
	</section>

	<footer>
		<hr>
		<%@ include file="riceThief_footer.jsp"%>
	</footer>
	<script>
	/* $("#updateuserbtn").click(updatebtn);
	function updatebtn(){
		var result = "${result}";
		if(result == 1){
			alert("정보가 수정되었습니다.");
			location.href="main";
		}else {
			alert("정보가 수정되지 못했습니다. 다시 시도해 주세요.");
			location.href="updateuser";
		} 
	}; */
	function deleteAlert(){
		if (confirm("정말 탈퇴하시겠습니까?") == true){
			location.href = "userout";
			return true;
		}else{   
			alert("회원탈퇴를 취소하였습니다.")
			return false;
		}
	}
	</script>
</body>
</html>