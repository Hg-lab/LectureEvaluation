<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
    
<!-- html 5 쓰겠다 -->
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
	if(userID == null) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인을 해주세요.')");
 		script.println("location.href = 'userLogin.jsp';");
 		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if(emailChecked == false) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('이메일 인증을 해주세요.')");
 		script.println("location.href = 'emailSendConfirm.jsp';");
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
	<section class="container"> <!-- container 반응형 -->
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">	
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a> <!-- Modal -->
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
	<div class="card bg-light mt-3">
		<div class="card-header bg-light">
			<div class="row">
				<div class="col-8 text-left">컴퓨터개론&nbsp;<small>한현규</small></div>
				<div class="col-4 text-right">
					종합<span style="color: red;"> A</span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title">
				정말 좋은 강의에요.&nbsp;<small>(2017년 가을학기)</small>
			</h5>
			<p class="card-text">강의가 널널해서 좋은 것 같습니다. </p>
			<div class="row">
				<div class="col-9 text-left">
					내 성적<span style="color: red;"> A</span>
					학점 비율<span style="color: red;"> 채워줌</span>
					강의평<span style="color: red;"> A</span>
					종합<span style="color: red;"> A</span>
					<span style="color: green;">(추천: 15)</span>
				</div>
				<div class="col-3 text-right">
					<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=">추천</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=">삭제</a>
					
				</div>
			</div>
		</div>
	</div>
	</section>


	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6"><!-- 한개 행 12, 6씩 2열 로 나눔 -->
								<label>강의명</label>
								<input type="text" name="lectureName" class="form-control" maxlength="20">
							</div>
							
							<div class="form-group col-sm-6">
								<label>교수</label>
								<input type="text" name="professorName" class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020" selected>2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기" selected>1학기</option>
									<option value="여름학기">여름학기</option>
									<option value="2학기">2학기</option>
									<option value="겨울학기">겨울학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양" >교양</option>
									<option value="기타" >기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
							
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>내 성적</label>
								<select name="myGrade" class="form-control">
									<option value="A+" selected>A+</option>
									<option value="A" >A</option>
									<option value="B+" >B+</option>
									<option value="B" >B</option>
									<option value="C+" >C+</option>
									<option value="C" >C</option>
									<option value="D+" >D+</option>
									<option value="E" >E</option>
									<option value="F" >F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>학점 비율</label>
								<select name="rateGrade" class="form-control">
									<option value="채워줌" >채워줌</option>
									<option value="보통" >보통</option>
									<option value="덜 채워줌" >덜 채워줌</option>
									<option value="절대평가" >절대평가</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>강의평</label>
								<select name="lectureScore" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >D</option>
									<option value="E" >E</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name="totalEvaluation" class="form-control">
									<option value="A" >A</option>
									<option value="B" >B</option>
									<option value="C" >C</option>
									<option value="D" >E</option>
									<option value="E" >E</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">등록하기</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
					
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
							
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px"></textarea>
						</div>
						
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger">신고하기</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
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