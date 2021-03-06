<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출력하고자 할때 사용됨 -->
 
 <%
 	request.setCharacterEncoding("UTF-8"); // 사용자로부터 받는 요청 UTF-8로 받음

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

	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String lectureDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalEvaluation = null;
	String myGrade = null;
	String lectureScore = null;
	String rateGrade = null;
	 
	//스프링 프레임워크 사용시 수작업 안해도 됌
 	if(request.getParameter("lectureName") != null) {
 		lectureName = request.getParameter("lectureName");
 	}
 	if(request.getParameter("professorName") != null) {
 		professorName = request.getParameter("professorName");
 	}
 	if(request.getParameter("lectureYear") != null) { // 사용자로부터 받는 데이터는 String 형이기 때문에 Int형으로 반환하고, 예외처리 해준다.
 		try{
 		lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
 		} catch (Exception e) {
 			System.out.println("강의 연도 데이터 오류");
 		}
	}
 	if(request.getParameter("semesterDivide") != null) {
 		semesterDivide = request.getParameter("semesterDivide");
 	}
 	if(request.getParameter("lectureDivide") != null) {
 		lectureDivide = request.getParameter("lectureDivide");
 	}
 	if(request.getParameter("evaluationTitle") != null) {
 		evaluationTitle = request.getParameter("evaluationTitle");
 	}
 	if(request.getParameter("evaluationContent") != null) {
 		evaluationContent = request.getParameter("evaluationContent");
 	}
 	if(request.getParameter("totalEvaluation") != null) {
 		totalEvaluation = request.getParameter("totalEvaluation");
 	}
 	if(request.getParameter("myGrade") != null) {
 		myGrade = request.getParameter("myGrade");
 	}
 	if(request.getParameter("lectureScore") != null) {
 		lectureScore = request.getParameter("lectureScore");
 	}
 	if(request.getParameter("rateGrade") != null) {
 		rateGrade = request.getParameter("rateGrade");
 	}

 	if(lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null ||
 		lectureDivide == null ||	evaluationTitle == null || evaluationContent == null || totalEvaluation == null ||
 		myGrade == null || lectureScore == null || rateGrade == null ||
 		evaluationTitle.equals("") || evaluationContent.equals("")) {
 		
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력이 안 된 사항이 있습니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	
 	EvaluationDAO evaluationDAO = new EvaluationDAO();
 	int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName,
 			lectureYear, semesterDivide, lectureDivide, evaluationTitle, evaluationContent,
 			totalEvaluation, myGrade, lectureScore, rateGrade, 0));
 	
 	if(result == -1) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('강의 평가 등록 실패했습니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	} else {
 		session.setAttribute("userID", userID); // 회원가입 성공 시 로그인
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("location.href = 'index.jsp';");
 		script.println("</script>");
		script.close();
		return;
 	}

 	
 %>