<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>

<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>

<%@ page import="java.util.Properties" %>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출력하고자 할때 사용됨 -->
 
 <%
 	UserDAO userDAO = new UserDAO();
 	String userID = null;
 	if(session.getAttribute("userID") != null){
 		userID = (String) session.getAttribute("userID");
 	}
 	if(userID == null) { //사용자가 로그인하지 않은 상태
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인을 해주세요.')");
 		script.println("location.href = 'userLogin.jsp'"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	boolean emailChecked = userDAO.getUserEmailChecked(userID);
 	if(emailChecked == true) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('이미 인증된 회원입니다.')");
 		script.println("location.href = 'index.jsp'"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	//이메일 인증, 구글  smtp가 기본적으로 제공하는 양식 사용
 	String host = "http://localhost:8080/Lecture_Evaluation/";
 	String from = "siregy1222@gmail.com";
 	String to = userDAO.getUserEmail(userID);
 	String subject = "강의평가를 위한 인증 메일입니다.";
 	String content = "다음 링크에 접속하여 이메일 인증을 진행하세요." + 
 					"<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) + "'><br>이메일 인증하기</a>";
 	
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
		
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('오류가 발생했습니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;	
	}
 %>

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
		<div class="alert alert-success mt-4" role="alert">
			이메일 주소 인증 메일이 전송되었습니다.<br>
			회원가입시 입력했던 이메일로 인증해주세요.
		</div>
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