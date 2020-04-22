<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#"></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    	<p class="navbar-text">
        	<span>Signed in as </span>
        	<span>
        		<strong>
			        <security:authorize access="isAuthenticated()">
			        	<security:authentication property="principal.username" />
			        </security:authorize>
        		</strong>
        	</span>
    	</p>
      <ul class="nav navbar-nav">
        <li id="web-app-nav-option" class="active">
            <a href="${pageContext.request.contextPath}/customer">Customer Manager</a>
        </li>
        <!-- This link opens a REST client UI used to test this application's alternate REST implementation.  Now using external client app.
        <li id="web-svc-client-nav-option">
        	<a href="<c:url value='/resources/rest-client/customer/index.html' />" target="_blank">Web Service Client</a>
        </li>
         -->
        <li id="web-app-nav-option">
	       	<a id="logout-link" href="">Logout</a>
			<form:form id="logout-form" action="${pageContext.request.contextPath}/logout"
				method="POST">
			</form:form>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

<script>
$(document).ready(function() {
	$('#web-app-nav-option').click(function() {
		$(this).parent().children().removeClass('active');
		$(this).addClass('active');
	});
	
	$('#web-svc-client-nav-option').click(function() {
		$(this).parent().children().removeClass('active');
		$(this).addClass('active');
	});
	
	$('#logout-link').click(function(event) {
		event.preventDefault();
		$('#logout-form').submit();
	})
});
</script>
