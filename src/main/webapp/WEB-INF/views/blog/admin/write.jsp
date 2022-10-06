<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>

</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<div id="header">
				<h1><a href="${pageContext.servletContext.contextPath }/${authUser.id}">${blogvo.blogTitle}</a></h1>
			<ul>
				<c:choose>
					<c:when test='${empty authUser}'>
						<li><a href="${pageContext.servletContext.contextPath }/user/loginForm">로그인</a></li>
						<!-- 로그인 후 메뉴 -->
					</c:when>
					<c:otherwise>	
					<!-- 로그인 후 메뉴 -->
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
					<li><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/cate">카테고리</a></li>
					<li class="selected"><a href="${pageContext.servletContext.contextPath }/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
				
				<form:form modelAttribute="postVo"
				 action="${pageContext.servletContext.contextPath }/${authUser.id}/admin/pwrite" method="GET">
			      	<table class="admin-cat-write">
			      		<tr>
			      			<td class="t">제목</td>
			      			<td>
			      				<input type="text" size="60" name="postTitle" id="postTitle">
					      			<select name="cateNo" id="cateNo">
					      				<option selected>카테고리이름</option>	
						      				<c:forEach var="catelist" items="${catelist }" step="1">
						      					<option value="${catelist.cateNo }">${catelist.cateName}</option>
						      				</c:forEach>
					      			</select>
				      		</td>
			      		</tr>
			      		<tr>
			      			<td class="t">내용</td>
			      			<td><textarea name="postContent" id="postContent"></textarea></td>
			      		</tr>
			      		<tr>
			      			<td>&nbsp;</td>
			      			<td class="s"><input type="submit" value="포스트하기"></td>
			      		</tr>
			      	</table>
				</form:form>
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