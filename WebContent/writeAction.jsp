<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter"%>
<%@ request.setCharacterEncoding("UTF-8"); %> <!-- receiving data type = UTF8 -->
<jsp:useBean id="user" class="bbs.Bbs" scope=page" />  <!-- scope=page ==> bean is only used  in this page  -->
<jsp:setProperty name ="bbs" property="bbsTItle " />  <!-- get userID from join.jsp  page  -->
<jsp:setProperty name ="bbs" property="bbsContent" /> <!-- get userPassword  from join.jsp  page  -->



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
	
		//when user haven't login yet
		if (userID == null){ // to prevent user that already login cannot login again
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('please log in')"); 
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else{ 
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {  // check if all required information is not blank  
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('fill the blanck')"); 
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if (result == -1) {  // when user id is already exist 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('failed')"); 
					script.println("history.back()");
					script.println("</script>");
			} else { // join successful 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'bbs.jsp' "); /* move to previous(login)  page*/ 
				script.println("</script>");
			}
			
			
		}
		
	}
%>


</body>
</html>