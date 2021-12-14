<%@page import="java.text.DecimalFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.utils.ValueMap"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.QueryOutcome"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.spec.QuerySpec"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.Table"%>
<%@page import="com.amazonaws.services.dynamodbv2.document.DynamoDB"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> Login </title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">

<style type="text/css">
	.card{
		float: left;
		margin: 12px 12px 12px 12px;
	}

	.mainImage{
		width: 100%;
	}

	.description p {
		font-weight: bold; color: #990000;
	}

	.log{
		text-align: center;
	}
</style>

<script type="text/javascript">
$( document ).ready( function() {
	$('.admin').click(function(){
		console.log("asd");
		$('.ui.basic.modal').modal('show');
	});

	document.getElementById("login").onclick = function() {
    	document.getElementById("popup").submit();
	}

	document.getElementById("basket").onclick = function() {
    	document.getElementById("basketForm").submit();
	}

	document.getElementById("buy").onclick = function() {
    	document.getElementById("buyForm").submit();
	}

	$('.ui.checkbox').checkbox();
});


</script>

</head>
<body>
<div class="ui left aligned container">

	<div class="mainImage">
		<img src="overview3.png" class="mainImage">
	</div>

	<div class="ui large menu">
	  <div class="header item">카테고리</div>
	  <a class="item" href="index.jsp"><p>전체상품</p></a>
	  <a class="item" href="basket.jsp"><p>장바구니</p></a>
	  <div class="right menu">
	  
	  <%if(session.getAttribute("id") != null) { %>
	  
	  	<a class="item" href="itemInfoInput.jsp">상품 등록</a>
	  	<a class="item" href="orderInfo.jsp">주문 관리</a>
	  <%} if(session.getAttribute("id") == null) { %>
	    <a class="item admin">
	    	<div class="column">
	    		<i class="address card outline icon"></i>
	  			Admin
	    	</div>
	    </a>
	    <% } else{%>
	    
	    <a class="item" href="logout.jsp">
	    	<div class="column">
	    	<i class="power off icon"></i>
	  			로그아웃
	    	</div>
	    </a>
	    
	    <%} %>

	  </div>
	</div>


<%

String name, price, infoPath, imgPath, tag, info;
String num = request.getParameter("id");

System.out.println(num);

AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.AP_NORTHEAST_2).build();
DynamoDB dynamoDB = new DynamoDB(client);

Table table = dynamoDB.getTable("shopping");

QuerySpec spec = new QuerySpec()
    .withKeyConditionExpression("menu = :m_id and num = :n_id")
    .withValueMap(new ValueMap()
        .withString(":m_id", "shoppingItem")
    	.withString(":n_id", num));

ItemCollection<QueryOutcome> items = table.query(spec);

JSONParser jsonParser = new JSONParser();
Iterator<Item> iterator = items.iterator();
Item item = null;
while (iterator.hasNext()) {
    item = iterator.next();
    JSONObject jsonObject = (JSONObject) jsonParser.parse(item.toJSONPretty());
    
    name = (String)jsonObject.get("name");
    price = (String)jsonObject.get("price");
    imgPath = (String)jsonObject.get("filePath");
    tag = (String)jsonObject.get("tag");
    infoPath =  "itemInfo.jsp?id=" + (String)jsonObject.get("num");
    
    DecimalFormat formatter = new DecimalFormat("###,###");
    price = formatter.format(Integer.parseInt(price));
	info = (String)jsonObject.get("info");
%>

<div class="ui raised very padded text container segment">
<div class="ui items">
  <div class="item">
    <div class="image">
      <img src="<%=imgPath%>">
    </div>    
    <div class="content">
      <a class="header"><%=name %></a> 
      <div class="meta">
        <span><%=price%></span>
		
		<% if (tag.equals("new")){%>
        <a class="ui circular mini green label">신규</a>
		<% }
		   if (tag.equals("hot")){
		%>
        <a class="ui circular mini red label">인기</a>
		<% 
		   }
		   if (tag.equals("recommand")){
		%>
        <a class="ui circular mini teal label">추천</a> 
		<% 
			}
		%>
        <br/>
      </div>
      <div class="description">
      <div class="ui basic buttons">
      	<form action="insertBasket.jsp" id="basketForm" method="get">
      		<input type="hidden" name="number" value="<%=num%>">
	  		<div class="ui button" id="basket"><i class="shopping bag icon"></i>장바구니</div>
	  	</form>
	  	<form action="basket.jsp" method="get" id="buyForm">
	  		<input type="hidden" name="number" value="<%=num%>.">
	  		<div class="ui button" id="buy"><i class="shopping basket icon"></i>구매</div>
	  	</form>
  	  </div>

	      <div class="extra">
	        <%=info %>
	      </div>
	    </div>
  	</div>
</div>
</div>
</div>

<% 
}
%>

<form action="login.jsp" method="post" id="popup">
	<div class="ui basic modal">
	  <div class="ui icon header">
	    <i class="user icon"></i>
	    관리자 로그인
	  </div>
	  <div class="content log">
	    <div class="ui input">
	  		<input type="text" placeholder="ID">
		</div>
		<div class="ui input">
	  		<input type="password" placeholder="PASSWORD">
		</div>
	  </div>
	  <div class="actions">
	  	<div class="ui green ok inverted button" id="login">
	      <i class="checkmark icon"></i>
	      로그인
	    </div>
	    <div class="ui red basic cancel inverted button">
	      <i class="remove icon"></i>
	      취소
	    </div>
	  </div>
	</div>
</form>

</body>
</html>