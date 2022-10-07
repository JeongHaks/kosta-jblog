<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript">
	$(function(){ //이것도 해야해 
		initData();
	});


	//카테고리 리스트 값 가져오기!
	function initData(){
		$.ajax({
			type : "GET",  //이건 나도 모르겠는데? 값을 가져오려면 GET으로 해야하는거 같던데 이건 소미가 설명해줘 GET= 정보를 안 숨시고 POST = 정보를 숨기고
			dataType : "json",
			url : "${pageContext.servletContext.contextPath }/catelist", //이건 컨트롤러로 접속해서 서비스 dao xml가서 db에서 값 가져오려고 하는거 url접속 
			async : false, //비동기식 처리(true) / 동기식 처리(순서대로 하는거 false) true = 순서가 뒤죽박죽 될거다!
			
			
			success : function(obj){			//obj는 컨트롤러/서비스에서 리턴값 받을 변수야 랜덤으로 하고싶은거 하면되	 (근데 obj 아니면 data로 하는게 좋아) 
				var resultCate=""; //이거는 db에서 값을 받아와서 리스트에 뿌려주려고 변수 설정을 한거야 아래에 보면 하나씩 담아줄거거든 
				for(var i = 0; i < obj.length; i++){
					console.log(obj[i]); //콘솔에 찍어줄 거  resultCate = resultCate + obj[i]['cateNo'] 이런 느낌 꼭 아니고 넘어오나 안넘어오나 확인용 하려고 내가 넣은거야
					var cateNo = obj[i]['cateNo'];
					resultCate += "<tr class='tr'>"
					resultCate += "<td class='no'>" +(obj.length-i) +"</td>" //테이블 형식으로 디비에서 가져온 값을 obj[i]로 0~4 값을 찾아서 넣을거야 
					resultCate += "<td>" + obj[i]['cateName'] + "</td>" // 맞아 데이터베이스에 컬럼명들이야 .은 시도안해봤어  
					resultCate += "<td class='count'>" + obj[i]['countPost'] + "</td>" // 지금 이게 변수인데 지금 쿼리를 복잡하게 짜야해 이건 내가 변수를 따로 만들어준거야 포스트 수 올리기위해서 그게 쿼리 컬럼 이라서 	
					resultCate += "<td>" + obj[i]['description'] + "</td>"//이건 카테고리 설명
					resultCate += "<td>" + "<a href='${pageContext.servletContext.contextPath }/${authUser.id}/delete/"+cateNo+"' class='delete'> " + "<img src='${pageContext.request.contextPath}/assets/images/delete.jpg'></a>"  +"</td>"
							//이건 삭제 부분인데 ajax는 아래에 삭제를 넣으면 삭제칸이 이상해져서 여기다가 넣어야해  cateNo가 같으면 삭제 
					resultCate += "</tr>" 
				}
				$("#result_data tbody").html(resultCate); //여긴 아래에 상단바 작성 테이블 아이디를 가져와서 테이블 안에 tbody부분에 결과값을 뿌려주는 용도
			},
			error : function(xhr,status, error){ // 에러났을 경우 알림을 띄워준다. 
				alert(error + "에러"); //
			}//
		})	
	}
	
	//카테고리 등록 하기!!
	//jsp페이지가 시작되면서 function안에 문장 실행
	$(document).ready(function(){
		
		
		$("#btnAddCate").click(
			function(){
				var catename = $("#catename").val(); //아래 버튼 클릭시 각 값들이 변수에 담긴다
				var description = $("#description").val();
				
				$.ajax({
					type : "POST",
					data : "catename="+catename + "&description="+description,
					url : "${pageContext.servletContext.contextPath }/${authUser.id}/admin/cateinsert",
					//성공했을 때 
					success : function(obj){
                  var resultCate="";
                  for(var i=0; i<obj.length;i++){
                     console.log(obj[i]);
                     var cateNo = obj[i]['cateNo'];
                     resultCate += "<tr class='tr'>"
                     if($('.no:eq(0)')[0]==undefinded){
                    	 resuleCate += "<td class='no'>1</td>"
                     }else{
                    	 //https://hianna.tistory.com/480 innerHTML / innerText 참고사이트
                    	 resultCate += "<td class = 'no'>" + (Number($('no:eq(0)')[0].innerHTML)+1) +"</td>"
                     }
                     resultCate += "<td>" + obj[i]['cateName'] + "</td>"
                     resultCate += "<td class='count'>" + obj[i]['countPost'] + "</td>" //포스트 수 올리기 위해 만든 컬럼
                     resultCate += "<td>" + obj[i]['description'] + "</td>"
                     resultCate += "<td>" + "<a href='${pageContext.servletContext.contextPath }/${authUser.id}/delete/"+cateNo+"' class='delete'> " + "<img src='${pageContext.request.contextPath}/assets/images/delete.jpg'></a>"  +"</td>"
                     resultCate += "</tr>"
                  }
                  //.prepend()는 선택한 요소의 내용의 앞에 콘텐트를 추가합니다.
                  //$( 'p' ).prepend( '123 ' ) => <p>123 Lorem Ipsum Dolor</p>
                  $("#result_data tbody").prepend(resultCate);
               },
               error : function(xhr,status, error){ // 에러났을 경우 알림을 띄워준다. 
					alert(error + "에러"); //
					}//
				});
			}
		)
		//부모값 들어있는 값을 삭제 시 안 되는 문구 띄우기
		preventdelete();
	});
	//부모값이 들어있는 값을 삭제시 알림문구 띄우기
	function preventdelete(){
		
		//tr의 길이를 가져와서 for문을 돌려서 가져온다. class줬다 위에 리스트부분!
		//getElementsByClassName(class 이름)
		for(var i=0; i<document.getElementsByClassName('tr').length; i++ ){
			//0보다 크면 지워지면 안된다 countPost수가 countPost class = 'count'
			//엘리먼트 및 노드에 텍스트를 추가하거나 값을 가져올 수 있는 방법 = textContent
			if((document.getElementsByClassName('count')[i].textContent) > 0){
				//addEventListener은 이벤트를 등록하는 가장 권장되는 방식이다. 이 방식을 이용하면 여러개의 이벤트 핸들러를 등록할 수 있다
				document.getElementsByClassName('delete')[i].addEventListener('click',function(e){//delete 버튼에 클릭 이벤트를 준다. 함수가 실행한다.
					e.preventDefault(); //delete를 누르면 다른 창으로 가지 못 하게 해서 알람을 띄워준다.
					alert('삭제할 수 없습니다.');
				})
			}
		}
	}
	
</script>
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<div id="header">
			<h1><a href="${pageContext.servletContext.contextPath }/${authUser.id}">${blogvo.blogTitle} </a></h1> 
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
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/basic">기본설정</a></li>
					<li class="selected"><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/cate">카테고리</a></li>
					<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
		      	<table class="admin-cat" id="result_data">  
		      		<thead>
			      		<tr>
			      			<th>번호</th>
			      			<th>카테고리명</th>
			      			<th>포스트 수</th>
			      			<th>설명</th>
			      			<th>삭제</th>      			
			      		</tr>
		      		</thead>
		      		
		      		<tbody>
						<!-- ajax의 결과값 리스트 출력 --> 
		      			
					</tbody>
				</table>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
      			<form action="" method="" id="CateForm" name="CateForm">
		      	<table id="admin-cat-add" >
		      		<tr>
		      			<td class="t">카테고리명</td>
		      			<td><input type="text" name="catename" id="catename" value=""></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td> 
		      			<td><input type="text" name="description" id="description" value=""></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input id="btnAddCate" type="submit" value="카테고리 추가"></td>
		      		</tr>      		      		
		      	</table> 
		      	</form>
			</div>
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