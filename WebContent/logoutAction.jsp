<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

<title>log out</title>
</head>
<body>
	<% 
		session.invalidate(); // user lose session  
	
	%>
	<script>
		lcation.href ='main.jsp'; // move to login.jsp page  
	</script>

</body>
</html>