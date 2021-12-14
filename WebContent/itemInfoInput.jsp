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

	.content{
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

	document.getElementById("submit").onclick = function() {
    	document.getElementById("infoForm").submit();
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

	<form class="ui form" id="infoForm" method="post" action="insertItem.jsp" enctype="multipart/form-data">
	  <h4 class="ui dividing header">Shipping Information</h4>
	  <div class="field">
	    
	    <div class="two fields">
	      <div class="field">
	      	<label>상품명</label>
	        <input type="text" name="name" placeholder="상품명">
	      </div>
	      <div class="field">
	      	<label>상품 가격</label>
	        <input type="text" name="price" placeholder="상품 가격">
	      </div>
	    </div>
	  </div>

		<div class="two fields">
			<div class="field">
				<label>태그</label>
			    <select multiple class="ui dropdown" name="tag">
			      <option value="new">신규</option>
			      <option value="hot">인기</option>
			      <option value="recommand">추천</option>
			    </select>
			 </div>

			 <div class="field">
		      	<label>사진</label>
		        <input type="file" name="image">
		    </div>
		</div>


		<div class="ui form">
		  <div class="field">
		    <label>Text</label>
		    <textarea style="margin-top: 0px; margin-bottom: 0px; height: 189px;" name="info"></textarea>
		  </div>
		</div>

  		<div class="ui submit button" style="margin-top: 10px;" id="submit">Submit</div>

	</form>
</div>


<form action="login.jsp" method="post" id="popup">
	<div class="ui basic modal">
	  <div class="ui icon header">
	    <i class="user icon"></i>
	    관리자 로그인
	  </div>
	  <div class="content">
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