<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="java.io.PrintWriter"%>
<%@ request.setCharacterEncoding("UTF-8"); %> <!-- receiving data type = UTF8 -->


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
		}
		
		int bbsID =0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('invalid post')"); 
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}

		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter(); 
			script.println("<script>");
			script.println("alert('no authorization to access')"); 
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else{ 
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") 
					|| request.getParameter("bbsContent").equals("")) {  // check if all required information is not blank  
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('fill the blanck')"); 
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if (result == -1) {  // when user id is already exist 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('update  failed')"); 
					script.println("history.back()");
					script.println("</script>");
			} 
				else { // join successful 
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