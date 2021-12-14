<%@ page language="java" 
    contentType="text/html;"
    pageEncoding="UTF-8"
    import="java.sql.*"
    %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% 
	String value = "";
	
	String num = request.getParameter("number");

	String cook = request.getHeader("Cookie");
	
	Cookie[] cookies = request.getCookies();
	
	for(Cookie c:cookies){
		if(c.getName().equals("item")){
			value = c.getValue();
			Cookie cookie = new Cookie("item", value + num + ".");
			response.addCookie(cookie);
		}else{
			Cookie cookie = new Cookie("item", num + ".");
			response.addCookie(cookie);
		}
	}
	
	String item[] = value.split("\\.");
	
	System.out.println("length:" + item.length);
	for(int i = 0; i<item.length; i++){
		System.out.println("item:" + item[i]);
	}
	
	System.out.println("value:" + value);
	
	response.sendRedirect("index.jsp"); 
	
	
%>



</body>
</html>