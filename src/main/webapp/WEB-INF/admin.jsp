<%@ page isErrorPage="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>projects</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        
</head>
<body>
	<div class="container w-75">
		<c:if test="${not empty success}">
			<div class="alert alert-success mt-4"><c:out value="${success}"/></div>
		</c:if>
		
		<div class="d-flex align-items-center justify-content-between">
			<div class="mt-4">
				<h1 style="color:#603F8B">Welcome <c:out value="${user.firstname}"/></h1>
				<br>
				
			</div>
			<div class="d-flex flex-column align-items-end">
				<a style="color:#603F8B" href = "/logout">Logout</a>
				<br>
				
			</div>
			
		</div>

		<table class="table">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Email</th>
					<th scope="col" >Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${users}" var="user">
					<tr>	
						<td ><c:out value="${user.firstname}"/> <c:out value="${user.lastname}"/></td>
						<td ><c:out value="${user.email}"/></td>
						<td class="col-2">
							<div class="d-flex align-items-center">
							<c:choose>
								<c:when test="${user.role == 'non-admin'}">
									<form action="/users/${user.id}/make_admin" method="post">
										<input type="hidden" name="_method" value="put">
										<input type="submit" class="btn-link border-0" value="make_admin">
									</form>	
									<form action='/users/<c:out value="${user.id}"/>/delete' method="post">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" class="btn-link border-0" value="Delete">
									</form>	
								</c:when> 
								<c:when test="${role == 'super_admin'}">
									Admin
									<form action='/users/<c:out value="${user.id}"/>/delete' method="post">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" class="btn-link border-0" value="Delete">
									</form>	
								</c:when> 
								<c:otherwise>Admin</c:otherwise>
							</c:choose>			
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		
		
		
		
		
	</div>
    
	
</body>
</html>
