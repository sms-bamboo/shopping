<%@page import="com.amazonaws.services.dynamodbv2.document.PutItemOutcome"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.QueryOutcome"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.utils.ValueMap"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.spec.QuerySpec"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.DynamoDB"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Table"%>
<%@page import="com.amazonaws.regions.Regions"%>
<%@page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder"%>
<%@page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDB"%>
<%@page import="com.oreilly.servlet.*"%>
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
ServletContext context = getServletContext();
String uploads=context.getRealPath("image");
String saveFile = "";

MultipartRequest multi=new MultipartRequest(request,uploads,5*1024*1024,"UTF-8",new DefaultFileRenamePolicy());

String name = multi.getParameter("name");
String strPrice = multi.getParameter("price");
String tag = multi.getParameter("tag");
String info = multi.getParameter("info");

String strNumber;
long number = System.currentTimeMillis();

strNumber = String.valueOf(number);

Enumeration files = multi.getFileNames();

while (files.hasMoreElements())

{
 String filesName = (String)files.nextElement();
 saveFile = (String)multi.getFilesystemName (filesName);
}

saveFile = "image/" + saveFile;

System.out.println(name);
System.out.println(strPrice);
System.out.println(tag);
System.out.println(info);
System.out.println(number);
System.out.println(saveFile);


AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.AP_NORTHEAST_2).build();
DynamoDB dynamoDB = new DynamoDB(client);

Table table = dynamoDB.getTable("shopping");

Item item = new Item().withPrimaryKey("menu","shoppingItem")
.withString("num", strNumber)
.withString("name",name)
.withString("price",strPrice)
.withString("tag", tag)
.withString("info", info)
.withString("filePath", saveFile);

PutItemOutcome outcome = table.putItem(item);
response.sendRedirect("index.jsp");

%>
</body>
</html>