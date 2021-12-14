<%@page import="com.amazonaws.services.dynamodbv2.document.PrimaryKey"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec"%>
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

String num = request.getParameter("num");

AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.AP_NORTHEAST_2).build();
DynamoDB dynamoDB = new DynamoDB(client);

Table table = dynamoDB.getTable("shopping");

DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
.withPrimaryKey(new PrimaryKey("menu", "order", "num", num));

table.deleteItem(deleteItemSpec);
response.sendRedirect("orderInfo.jsp");
%>
</body>
</html>