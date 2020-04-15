<%@ include file="../header.jsp" %>

		<div class="row">
			<div class="col-md-8 col-md-offset-4">
				<form:form modelAttribute="customer" method="PUT"
					action="${pageContext.request.contextPath}/customer/update" cssClass="form-horizontal">
					
					<form:hidden path="id"/>

					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>First Name:</label>
							</div>
							<div class="col-md-5">
								<form:input path="firstName" cssClass="form-control" htmlEscape="true"/>
							</div>
							<div class="col-md-5">
								<form:errors path="firstName" cssStyle="color: red;"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Last Name:</label>
							</div>
							<div class="col-md-5">
								<form:input path="lastName" cssClass="form-control" htmlEscape="true"/>
							</div>
							<div class="col-md-5">
								<form:errors path="lastName" cssStyle="color: red;"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Street:</label>
							</div>
							<div class="col-md-5">
								<form:input path="street" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>City:</label>
							</div>
							<div class="col-md-5">
								<form:input path="city" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>State:</label>
							</div>
							<div class="col-md-5">
								<form:select path="state" items="${stateList}" cssClass="form-control"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Zip Code:</label>
							</div>
							<div class="col-md-5">
								<form:input path="zipcode" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Home Phone:</label>
							</div>
							<div class="col-md-5">
								<form:input path="homePhone" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Work Phone:</label>
							</div>
							<div class="col-md-5">
								<form:input path="workPhone" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-md-2">
								<label>Email:</label>
							</div>
							<div class="col-md-5">
								<form:input path="email" cssClass="form-control" htmlEscape="true"/>
							</div>
						</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-default">Update</button>
						<a class="btn btn-default" href="${pageContext.request.contextPath}/customer" role="button">Cancel</a>
					</div>
				</form:form>
			</div>

		</div>
	</div>

</body>
</html>
