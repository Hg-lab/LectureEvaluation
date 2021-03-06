<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출력하고자 할때 사용됨 -->
 
 <%
 	request.setCharacterEncoding("UTF-8"); // 사용자로부터 받는 요청 UTF-8로 받음
 	String code = null;
 	if(request.getParameter("code") != null) {
 		code = request.getParameter("code");
 	}
 	UserDAO userDAO = new UserDAO();
 	String userID = null;
 	if(session.getAttribute("userID") != null) {
 		userID = (String) session.getAttribute("userID"); // object type을 String으로 형 변환해주어야함
 	}
 	if(userID == null) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('로그인을 해주세요.')");
 		script.println("location.href = 'userLogin.jsp';"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	String userEmail = userDAO.getUserEmail(userID);
 	boolean isRight = (new SHA256().getSHA256(userEmail).equals(code)) ? true : false;
 	if(isRight == true) {

 	 	userDAO.setUserEmailChecked(userID);
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('인증에 성공했습니다.')");
 		script.println("location.href = 'index.jsp';"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	} else {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('유효하지 않은 코드입니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}

 %>