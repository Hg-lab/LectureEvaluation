<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출력하고자 할때 사용됨 -->
 
 <%
 	request.setCharacterEncoding("UTF-8"); // 사용자로부터 받는 요청 UTF-8로 받음
 	String userID = null;
 	String userPassword = null;
 	if(request.getParameter("userID") != null) {
 		userID = request.getParameter("userID");
 	}
 	if(request.getParameter("userPassword") != null) {
 		userPassword = request.getParameter("userPassword");
 	}

 	// 수정~?
 	if(userID == "" || userPassword == "") {
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('입력이 안 된 사항이 있습니다.')");
 		script.println("history.back()"); //입력 안됬으니 뒤로가기
 		script.println("</script>");
		script.close();
		return;
 	}
 	
 	UserDAO userDAO = new UserDAO();
 	int result = userDAO.login(userID, userPassword);
 	if(result == 1) { 	// 정상적 로그인
 		session.setAttribute("userID", userID);
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("location.href = 'index.jsp';");
 		script.println("</script>");
		script.close();
		return;
 	} else if (result == 0){ // 비밀번호 틀림
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('비밀번호가 틀렸습니다.')");
 		script.println("history.back();");
 		script.println("</script>");
		script.close();
		return;
 	} else if (result == -1){ // 아이디 틀림
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('존재하지 않는 아이디입니다.')");
 		script.println("history.back();");
 		script.println("</script>");
		script.close();
		return;
 	}  else if (result == -2){ // 데이터베이스 오류
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
 		script.println("alert('데이터베이스 오류입니다.')");
 		script.println("history.back();");
 		script.println("</script>");
		script.close();
		return;
 	}
 %>