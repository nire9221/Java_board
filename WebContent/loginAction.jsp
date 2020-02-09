<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter"%>
<%@ request.setCharacterEncoding("UTF-8"); %> <!-- receiving data type = UTF8 -->
<jsp:useBean id="user" class="user.User" scope=page" />  <!-- scope=page ==> bean is only used  in this page  -->
<jsp:setProperty name ="user" property="userID " />  <!-- get userID from login.jsp  page  -->
<jsp:setProperty name ="user" property="userPassword " /> <!-- get userPassword  from login.jsp  page  -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>JSP Board</title>
</head>
<body>
	<% 
	
	String userID = null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID"); // make userID to get sessio n
	}
	if (userID != null){ // to prevent user that already login cannot login again
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('already logged in')"); 
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	}
	
	
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(),user.getUserPassword()); /* get the input data from login.jsp page and execute */
		
		if (result == 1) {
			session.setAttribute ("userID", user.getUserID());// when login is successful, user take a session to keep login status  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'"); /* move to main.jsp if login is successful */
			script.println("</script>");
		}
		
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('password is incrroect')"); 
			script.println("history.back()"); /* move to previous(login)  page*/ 
			script.println("</script>");
		}
		
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID does not exist')"); 
			script.println("history.back()");
			script.println("</script>");
		}
		
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('database error')"); 
			script.println("history.back()"); 
			script.println("</script>");
		}
	%>


</body>
</html>