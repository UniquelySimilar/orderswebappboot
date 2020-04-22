<%@ include file="../header.jsp" %>
	
		<div class="row">
			<div class="col-md-12">
				<a class="btn btn-default" href="${pageContext.request.contextPath}/customers/create" role="button">Add Customer</a>
				<h3>Customer List</h3>
				
				<!-- Used to seed customers table
				<a class="btn btn-default" href="${pageContext.request.contextPath}/customer/createcustomers" role="button">Create Customers</a>
				 -->				
				
				<c:choose>
					<c:when test="${customers.size() > 0}">
						<table id="customer-table" class="table table-striped">
							<thead>
								<tr>
									<th>Last Name</th>
									<th>First Name</th>
									<th>Street</th>
									<th>City</th>
									<th>State</th>
									<th>Zip Code</th>
									<th>Home Phone</th>
									<th>Work Phone</th>
									<th>Email</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${customers}" var="customer">
									<tr>
										<td><c:out value="${ customer.lastName }"/></td>
										<td><c:out value="${ customer.firstName }"/></td>
										<td><c:out value="${ customer.street }"/></td>
										<td><c:out value="${ customer.city }"/></td>
										<td><c:out value="${ customer.state }"/></td>
										<td><c:out value="${ customer.zipcode }"/></td>
										<td><c:out value="${ customer.homePhone }"/></td>
										<td><c:out value="${ customer.workPhone }"/></td>
										<td><c:out value="${ customer.email }"/></td>
										<td>
											<a class="btn btn-default" href="${pageContext.request.contextPath}/customers/${customer.id}/edit" role="button">Edit</a>
										</td>
										<td>
											<security:authorize access="hasRole('ROLE_ADMIN')">
												<form:form id="form-delete-${customer.id}" cssClass="form-delete" method="DELETE"
													action="${pageContext.request.contextPath}/customers/${customer.id}">
													<input type="hidden" name="customerId" value="${customer.id}"/>
													<input type="hidden" name="customerName" value="${customer.firstName}${' '}${customer.lastName}"/>
													<button type="submit" class="btn btn-default submit-btn">Delete</button>
												</form:form>
											</security:authorize>
											&nbsp;
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<p>
						<h4>No Customers Found</h4>
						</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

	<div id="delete-modal" class="modal fade" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary delete-btn" data-customer-id="">Delete</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
				</div>

			</div>
		</div>
	</div>
	<script>
	$(document).ready(function() {
		$('#customer-table').DataTable({
			columns: [
				null,
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false
				},
				{
					orderable: false,
					searchable: false
				},
				{
					orderable: false,
					searchable: false
				}
			]
		});

		$('#customer-table').on('click', '.form-delete .submit-btn', function(event) {
			// Prevent form submission and display modal
			event.preventDefault();
			var customerId = $(this).siblings("input[name='customerId']").val();
			var customerName = $(this).siblings("input[name='customerName']").val();
			$('#delete-modal .modal-title').text('Delete ' + customerName + '?');
			$('#delete-modal .delete-btn').attr('data-customer-id', customerId);
			$('#delete-modal').modal('show');
		});
		
		$('#delete-modal .delete-btn').click(function() {
			var customerId = $(this).attr('data-customer-id');
			var formId = "#form-delete-" + customerId;
			deleteConfirmed = true;
			$(formId).submit();
			$('#delete-modal').modal('hide');
		});
	});
	</script>

<%@ include file="../footer.jsp" %>