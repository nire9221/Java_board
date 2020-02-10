<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import ="java.io.PrintWriter"%>
<%@ request.setCharacterEncoding("UTF-8"); %> <!-- receiving data type = UTF8 -->
<jsp:useBean id="user" class="user.User" scope=page" />  <!-- scope=page ==> bean is only used  in this page  -->
<jsp:setProperty name ="user" property="userID " />  <!-- get userID from join.jsp  page  -->
<jsp:setProperty name ="user" property="userPassword " /> <!-- get userPassword  from join.jsp  page  -->
<jsp:setProperty name ="user" property="userName " />  <!-- get userName from join.jsp  page  -->
<jsp:setProperty name ="user" property="userGender " /> <!-- get userGender  from join.jsp  page  -->
<jsp:setProperty name ="user" property="userEmail " />  <!-- get userEmail from join.jsp  page  -->


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
		userID = (String) session.getAttribute("userID"); // make userID to get session
	}
	if (userID != null){ // to prevent user that already login cannot login again
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('already logged in')"); 
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
	} 
	// ------ prevent to access to join in page user who already log  in 
	
	 
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null 
		|| user.getUserEmail( ) == null){  // check if all required information is not blank  
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('fill the blanck')"); 
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user); /* excute user variable in join method (user is made based on each information  */
			
			if (result == -1) {  // when user id is already exist 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('User ID already exist')"); 
				script.println("history.back()");
				script.println("</script>");
			}
			
			else { // join successful 
				session.setAttribute ("userID", user.getUserID()); // when login is successful, user take a session to keep login status 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('password is incrroect')"); 
				script.println("location.href = 'main.jsp' "); /* move to previous(login)  page*/ 
				script.println("</script>");
			}
			
			
		}
	
	%>


</body>
</html>