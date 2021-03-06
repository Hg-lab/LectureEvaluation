<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
			<!-- 반응형 웹을 위해 모바일 화면 설정 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>강의평가 웹 사이트</title>
	<!-- 부트스트랩 css추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인이 된 상태입니다.')");
 		script.println("location.href = 'index.jsp';");
 		script.println("</script>");
		script.close();
		return;
	}
%>
	<!-- 부트스트랩이 제공해주는 nav 클래스, 백그라운드light 넣으면  밝은 네비게이션 바 -->
	<!-- nav 태그는 html 5부터 쓸 수 있다. -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
			<!-- 버튼을 누르면 navbar라는 아이디를 가진 요소가 보였다가 보이지 않았다가. -->
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<!-- 작대기가 세개 그어져 있는 아이콘 -->
		<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<!-- ui(목록)내부적으로 li(리스트)태그를 가지고있다 -->
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"> <!-- 현재 위치한 페이지, index에 넣어줌 -->
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
						회원관리 <!-- 버튼에 들어가는 내용 -->
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else {
%>

						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0"> <!-- 검색창 -->
				<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button> <!-- 검색, 전송의 버튼 -->
			</form>
		</div>
	</nav>
	<!-- 섹션, 본문내용 -->
	
	<section class="container mt-3" style="max-width: 560px"> <!-- container 반응형 -->
		<form method="post" action="./userLoginAction.jsp">
			<div class="form-group">
				<label>ID</label>
				<input type="text" name="userID" class="form-control">
			</div>
			<div class="form-group">
				<label>Password</label>
				<input type="password" name="userPassword" class="form-control">
			</div>
			<button type="submit" class="btn btn-primary">로그인</button>
		</form>
	</section>


	
	<footer class="bg-dark mt-4 p-5 text text-center" style="color: #FFFFFF;">
		Copyright &copy; 2020 Hyunkyu Han All Right Reserved.
	</footer>
	<!-- 제이쿼리 자바스크립트 추가하기, 일반적으로 바디 아래쪽 추가함 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기, 일반적으로 바디 아래쪽 추가함 -->
	<script src="./js/popper.min.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기, 일반적으로 바디 아래쪽 추가함 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>