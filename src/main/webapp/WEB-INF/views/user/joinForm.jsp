<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script>
//아이디 중복체크
$(function(){
	$('#id').change(function(){
		$('#btn-checkid').show();
		$('#check-image').hide();
	});
	//아이디 중복체크 버튼을 클릭하면!
$('#btn-checkid').click(function(){
	var id = $('#id').val();
	if(id == ''){
		return;
	}
	// ajax 통신
	$.ajax({
		url : "${pageContext.servletContext.contextPath }/user/api/checkid?id="+id, //문자열로 인식이 되는게 아니라 서버에서 el값으로 먼저 치환후 js통신을 한다.
		type : "GET",
		dataType : "json",
		data : "", //post방식일때 값을 여기에 넣어줌
		success:function(response){
			if(response.result != "success"){
				console.error(response.message);
				return;
			}
			if(response.data == true){
				$('#checkid-msg').text("다른 아이디로 가입해주세요.");
				$('#id').focus();
				$('#id').val("");
				return;
			}else{
				$('#checkid-msg').text("사용할 수 있는 아이디 입니다.");
			}
			$('#btn-checkid').hide(); //버튼이 사라지고
			$('#check-image').show(); //이미지가 뜬다 체크이미지
		},
		error : function(xhr, error){ //xmlHttpRequest?
				console.error("error : "+error);
		}
	});
})
});

//회원가입 유효성 검사
	function Validation(){
		var objName = document.getElementById("userName"); //이름
		var objPwd = document.getElementById("pass"); //비밀번호
		var objagree = document.getElementById("agree-prov");//약관동의
		var objId = document.getElementById("id");//약관동의
		
		if(objName.value==''){
			alert("이름을 입력해주세요 !!");
			return false;
		}
		
		if(objId.value==''){
			alert("아이디를 입력해주세요 !!");
			return false;
		}
		
		
		if(objPwd.value==''){
			alert("비밀 번호를 입력해주세요!!");
			return false;
		}
		
		if(objPwd.value==objName.value){
			alert("이름이 들어간 비밀번호는 안됩니다.");
			return false;
		}
		
		if(objagree.checked==false){
			alert("약관 동의를 체크해주세요!!");
			return false;
		}
	
	}

</script>
</head>
<body>
	<div class="center-content">
		
		<!-- 메인해더 -->
	 	<a href="/jblog/">
			<img class="logo" src="${pageContext.request.contextPath}/assets/images/logo.jpg">
		</a>
		<ul class="menu">
				<!-- 로그인 전 메뉴 -->
				<li><a href="${pageContext.servletContext.contextPath }/user/loginForm">로그인</a></li>
				<li><a href="${pageContext.servletContext.contextPath }/user/joinForm">회원가입</a></li>

				<!-- 로그인 후 메뉴 -->
				<!-- 
				<li><a href="">로그아웃</a></li>
				<li><a href="">내블로그</a></li> 
				-->
 		</ul>
	<div class="user">
		<form:form
			  modelAttribute="usersVo"
			  class="join-form" id="join-form" name="join-form" method="post" onsubmit="return Validation();" 
			  action="${pageContext.servletContext.contextPath }/user/join">
			  
			<label class="block-label" for="name">이름</label>
			<input type="text" name="userName" id="userName" value="" />
			
			<spring:hasBindErrors name="usersVo">
    					<c:if test="${errors.hasFieldErrors('userName') }">
    						<p style="font-weight:bold;color:red;text-align:left;padding:0;margin:0">
            					<spring:message code="${errors.getFieldError( 'userName' ).codes[0] }"
            						text="${errors.getFieldError( 'userName' ).defaultMessage }" /><!-- 코드에 해당안되는 에러메세지인 경우 defaultmessage출력 -->
         					</p>
   						</c:if>
			</spring:hasBindErrors>	
			
			<label class="block-label" for="id">아이디</label>			
			<form:input path="id" id="id"/>
						
			<input id="btn-checkid" type="button" value="id 중복체크">
			<img style="display: none" id="check-image" src="${pageContext.servletContext.contextPath }/assets/images/check.png"/>			
			<p id="checkid-msg" class="form-error"><form:errors path="id"/>
			&nbsp;
			</p>
			
			<label class="block-label" for="password">패스워드</label>			
			<input type="password" name="password" id="pass" value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agree-prov"  value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기">

		</form:form>
	</div>
</div>
</body>
</html>