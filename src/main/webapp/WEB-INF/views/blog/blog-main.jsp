<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script>
//cateNo를 숨겨주기 위한 함수정의
//카테고리 클릭 시 안에 내용 불러오기 
	$(document).ready(function(){
		
		var authUser = sessionStorage.getItem("authUser");
		$('.cateNo').hide();
		//카테고리 리스트에 카테고리 클릭 시 관련된 정보를 리스트로 뿌려준다.
		$('.cateName').click(
			function(e){
				e.preventDefault(); // 주소를 다른 창으로 넘어가지않게 해주는 역할 (부모값 삭제할때 사용했다~)
				var index=$('.cateName').index(this); //몇 번쨰 요소인지 index를 받아온다. 몇 번째 카터고리인지 받아온다
				var cateNo=$(".cateNo:eq(" + index + ")")[0].innerHTML; //eq = 순서를 받아올 수 있다. index번째와 같은 cateNo를 찾아서 cateNo에 담아준다.
				$.ajax({
					type : "GET",
					data : {
						cateNum : cateNo
					},
					async : false,
					url : "${pageContext.request.contextPath }/${authUser.id}/categoryNo",
					success : function(obj){
						$('.blog-list').empty(); //값이 비운다! why? 클릭 시 원래 내용을 비워주기 위해서 다른 거 추가 해주기 위해서
						var bloglist ="";
						if(obj.length >0){
						for(var i=0; i<obj.length;i++){
		                     bloglist+="<li class='postlist'>"
		                     bloglist+="<a href='' class='postTitle'>" + obj[i]['postTitle'] + "</a>"
		                     bloglist+="<span class='postNo'>" + obj[i]['postNo'] + "</span>"
		                     bloglist+="<span>" + obj[i]['regDate'] + "</span>"
		                     bloglist+="</li>"
		                  }
						}else{
							$(".blog-content").empty();
							bloglist+= "<h4> 등록된 글이 없습니다.</h4>"
						}
						$(".blog-list").append(bloglist);
					},
					error : function(xhr,status, error){ // 에러났을 경우 알림을 띄워준다. 
						alert(error + "에러"); //
					}
				});

		//카테고리 리스트에 값을 클릭 시 그 값에 대한 내용 불러오기
		$('.postNo').hide(); //postNo를 숨긴다 클릭 시 
		$('.postTitle').click( //postTitle(제목)을 클릭 시 
			function(e){
				e.preventDefault(); //보호해준다. 다른 창으로 넘어가지않게 
				var index=$('.postTitle').index(this); //몇 번쨰 요소인지 index를 받아온다. 몇 번째 카테고리인지 받아온다
				var postNo=$(".postNo:eq(" + index + ")")[0].innerHTML; //eq = 순서를 받아올 수 있다. index번째와 같은 cateNo를 찾아서 cateNo에 담아준다.
				$.ajax({
					type : "GET",
					data : {
						postNum : postNo
					},
					async : false,
					url : "${pageContext.request.contextPath }/${authUser.id}/postNum",
					success : function(obj){
						$('.blog-content').empty(); //값이 비운다! why? 클릭 시 원래 내용을 비워주기 위해서 다른 거 추가 해주기 위해서
						var bloglist="";
						if(obj.length > 0){
						for(var i=0; i<obj.length;i++){
								bloglist+="<h4>"+ obj[i]['postTitle'] + "</h4>"
								bloglist+="<p>"+ obj[i]['postContent'] + "</p>"
		                  	}
						}else{
							bloglist+= "<h4> 등록된 글이 없습니다.</h4>"
						}
						$(".blog-content").append(bloglist);
					},
					error : function(xhr,status, error){ // 에러났을 경우 알림을 띄워준다. 
						alert(error + "에러"); //
					}
				});
			} //postTitle function(e)닫힘
			) //postTitle click 닫힘
	} //cateName function(e) 닫힘		
	) //cateName click() 닫힘
	$('.postNo').hide(); //postNo를 숨긴다 클릭 시 
	$('.postTitle').click( //postTitle(제목)을 클릭 시 
		function(e){
			e.preventDefault(); //보호해준다. 다른 창으로 넘어가지않게 
			var index=$('.postTitle').index(this); //몇 번쨰 요소인지 index를 받아온다. 몇 번째 카테고리인지 받아온다
			var postNo=$(".postNo:eq(" + index + ")")[0].innerHTML; //eq = 순서를 받아올 수 있다. index번째와 같은 cateNo를 찾아서 cateNo에 담아준다.
			$.ajax({
				type : "GET",
				data : {
					postNum : postNo
				},
				async : false,
				url : "${pageContext.request.contextPath }/${authUser.id}/postNum",
				success : function(obj){
					$('.blog-content').empty(); //값이 비운다! why? 클릭 시 원래 내용을 비워주기 위해서 다른 거 추가 해주기 위해서
					var bloglist="";
					if(obj.length > 0){
					for(var i=0; i<obj.length;i++){
							bloglist+="<h4>"+ obj[i]['postTitle'] + "</h4>"
							bloglist+="<p>"+ obj[i]['postContent'] + "</p>"
	                  	}
					}else{
						bloglist+= "<h4> 등록된 글이 없습니다.</h4>"
					}
					$(".blog-content").append(bloglist);
				},
				error : function(xhr,status, error){ // 에러났을 경우 알림을 띄워준다. 
					alert(error + "에러"); //
				}
			});
		} //postTitle function(e)닫힘
		) //postTitle click 닫힘
		
		//답변 리스트 / form 
		
});

</script>
</head>
<body>

	<div id="container">

		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="${pageContext.servletContext.contextPath }/${userId}"> ${userId} </a></h1> 
			<ul>
			
				<%-- 로그인 전 메뉴 --%>
				<c:choose>
					<c:when test='${empty authUser}'>
						<li><a href="${pageContext.servletContext.contextPath }/user/loginForm">로그인</a></li>
						<!-- 로그인 후 메뉴 -->
					</c:when>
					<c:otherwise>	
						<li><a href="${pageContext.servletContext.contextPath }/user/logout">로그아웃</a></li>
						<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/basic">내블로그 관리</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					<c:choose>
						<c:when test="${empty postcontent }">
							<h4>등록된 글이 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<h4>${postcontent.postTitle }</h4>
							<p>${postcontent.postContent }</p>
						</c:otherwise>
					</c:choose>
				</div>
				

				<ul class="blog-list">
					<c:forEach var="postvo" items="#{postvo }" step="1">
						<li class="postlist"><a href="" class='postTitle'>${postvo.postTitle }</a>
							<span class='postNo'>${postvo.postNo}</span>
							<span>${postvo.regDate}</span>
						</li>
				</c:forEach>
				</ul>
				
			</div>
			
		</div>



		<div id="extra">
			<div class="blog-logo">
				<img src="${pageContext.request.contextPath}/assets/images/${blogvo.logoFile}">				
			</div>
		</div>

		<!-- 카테고리 리스트 -->
		<div id="navigation">
			<h2>카테고리</h2>
			<ul>
				<c:forEach var="cateNo" items="#{cateNo }" step="1">
					<li><a href="" class="cateName">${cateNo.cateName }</a></li>
					<li class="cateNo">${cateNo.cateNo }</li>
				</c:forEach>
			</ul>
		</div>
				
		
		<!-- 푸터-->
		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2018
			</p>
		</div>
		
	</div>
</body>
</html>