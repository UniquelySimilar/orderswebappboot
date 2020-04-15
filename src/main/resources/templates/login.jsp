<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/bootstrap.css" />">
<title>Login</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 col-md-offset-4">
				<form method="POST" action="${pageContext.request.contextPath}/login" class="form-horizontal">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="form-group">
						<h3 style="margin-bottom: 1em;">Login</h3>
						<c:if test="${param.error != null}">
							<h4 style="color: red;">Invalid Username and/or Password</h4>
						</c:if>
						<div class="row">
							<div class="col-md-2">
								<label>User:</label>
							</div>
							<div class="col-md-5">
								<input type="text" name="username" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Password:</label>
							</div>
							<div class="col-md-5">
								<input type="password" name="password" class="form-control"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-default">Login</button>
					</div>
				</form>
			</div>

		</div>
	</div>

	<script src="<c:url value="/resources/js/jquery.js" />"></script>
	<script src="<c:url value="/resources/js/bootstrap.js" />"></script>
</body>
</html>
