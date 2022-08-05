<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    


<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Register/Login</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<div class="container w-75">
		<c:if test="${not empty error}">
			<div class="alert alert-danger mt-4"><c:out value="${error}"/></div>
		</c:if>
		<h1 class="mb-2" style="color:#603F8B">Welcome</h1>
		<br>
		<div class="d-flex justify-content-between">
			
			<div class="w-100">
				<h3>Register</h3>
			
				<form:form class="border border-3 p-4 border-dark" method="post" modelAttribute="newUser" action="/register">
					<div class="mb-3"> 
						<form:label path="firstname" class="form-label">First name:</form:label>
						<form:input  path="firstname" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors path="firstname" cssClass="invalid-feedback"/>
					</div>
					<div class="mb-3"> 
						<form:label path="lastname" class="form-label">Last name:</form:label>
						<form:input  path="lastname" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors path="lastname" cssClass="invalid-feedback"/>
					</div>
					<div class="mb-3">
						<form:label path="email" class="form-label">email:</form:label>
						<form:input path="email" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors path="email" cssClass="invalid-feedback"/>
					</div>
					
					
					<div class="mb-3">
						<form:label path="password" class="form-label">Password: </form:label>
						<form:input  path="password" type="password" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors  path="password" cssClass="invalid-feedback"/>
					</div>
					<div class="mb-3">
						<form:label path="confirmPassword" class="form-label">Confirm Password: </form:label>
						<form:input  path="confirmPassword" type="password" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors  path="confirmPassword" cssClass="invalid-feedback"/>
					</div>
					<input style="background-color:#603F8B" type="submit" value="Submit" class="btn btn-dark ">
				</form:form>
			</div>
			<div class="w-100 ml-3">
				
					<h3>Login</h3>
				
				<form:form class="border border-3 p-4 border-dark" method="post" modelAttribute="loginUser" action="/login">
					<div class="mb-3"> 
						<form:label path="email" class="form-label">email:</form:label>
						<form:input  path="email" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors path="email" cssClass="invalid-feedback"/>
					</div>
					<div class="mb-3">
						<form:label path="password" class="form-label">Password: </form:label>
						<form:input  path="password" type="password" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
						<form:errors  path="password" cssClass="invalid-feedback"/>
					</div>
					<input style="background-color:#603F8B" type="submit" value="Submit" class="btn btn-dark">
				</form:form>
			</div>
		
		</div>
		
	</div>
    
	
</body>
</html>
