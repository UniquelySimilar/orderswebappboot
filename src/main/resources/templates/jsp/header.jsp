<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/bootstrap.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/dataTables.bootstrap.css" />">
<link rel="stylesheet" type="text/css"
	href="<c:url value="/css/app.css" />">
<title>Customer List</title>
</head>
<body>
	<script src="<c:url value="/js/jquery.js" />"></script>
	<script src="<c:url value="/js/bootstrap.js" />"></script>
	<script src="<c:url value="/js/jquery.dataTables.js" />"></script>
	<script src="<c:url value="/js/dataTables.bootstrap.js" />"></script>

	<%@ include file="navbar.jsp" %>
	
	<div class="container-fluid">
