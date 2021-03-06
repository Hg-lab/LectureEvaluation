<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출력하고자 할때 사용됨 -->
 
 <%
 	request.setCharacterEncoding("UTF-8"); // 사용자로부터 받는 요청 UTF-8로 받음
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
 	String userPassword = null;
 	String userEmail = null;
 	if(request.getParameter("userID") != null) {
 		userID = request.getParameter("userID");
 	}
 	if(request.getParameter("userPassword") != null) {
 		userPassword = request.getParameter("userPassword");
 	}
 	if(request.getParameter("userEmail") != null) {
 		userEmail = request.getParameter("userEmail");
 	}


 	// 수정~?
 	if(userID == "" || userPassword == "" || userEmail == "") {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력이 안 된 사항이 있습니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	
 	UserDAO userDAO = new UserDAO();
 	int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
 	
 	if(result == -1) {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('이미 존재하는 아이디입니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	} else {
 		session.setAttribute("userID", userID); // 회원가입 성공 시 로그인
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("location.href = 'emailSendAction.jsp';");
 		script.println("</script>");
		script.close();
		return;
 	}
 %>