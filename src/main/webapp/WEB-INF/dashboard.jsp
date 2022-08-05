<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Show an event</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<body>
	<div class="container w-75 d-flex justify-content-between">
		
		<div class="w-75 mr-4">
		<c:if test="${not empty error}">
			<div class="alert alert-danger mt-4"><c:out value="${error}"/></div>
		</c:if>
			<h3 style="color:#603F8B" >Welcome <c:out value="${user.firstname}"/>!</h3> 
			
			
			<br>
			<br>
			
			<p>First name: <c:out value="${user.firstname}"/></p>
			<p>Last name: <c:out value="${user.lastname}"/></p>
			<p>Email: <c:out value="${user.email}"/></p>
			<p>Sign up date: <fmt:formatDate timeStyle="long" dateStyle = "long" pattern="E MMM d',' hh:mm:ss  y" value="${ user.createdAt }"/></p>
			<p>Last Sign in: <%
         Date date = new Date();
         out.print( "" +date.toString()+"");%></p>
		</div>
			<div class="d-flex flex-column align-items-end">
				<a style="color:#603F8B" href = "/logout">Logout</a>
			<br>
				
			</div>
    </div>
	
</body>
</html>