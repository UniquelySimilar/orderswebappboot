<%@ include file="../header.jsp"%>

<script src="<c:url value="/js/vue.js" />"></script>
<script src="<c:url value="/js/axios.js" />"></script>

<div id="customer-list" class="row">
	<div class="col-md-12">
		<div id="list-title">
			<span class="list-title">Customer List</span>
			<a class="btn btn-default"
				href="${pageContext.request.contextPath}/customers/create"
				role="button">Create Customer</a>
			<div style="float: right;">
				<span>Search by last name: </span><input type="text" v-model="searchTerm" v-on:keyup="searchLastName()">
				<button type="button" class="btn btn-default btn-sm" style="margin-left: 1em;" v-on:click="clearSearch()">Clear</button>
			</div>
		</div>
		<table id="customer-table" class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Last Name<span v-html="sortArrow" v-on:click="toggleSort()" style="float: right; cursor: pointer;"></span></th>
					<th>First Name</th>
					<th>City</th>
					<th>State</th>
					<th>Zip Code</th>
					<th>Email</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="customer in currentPageCustomers" v-bind:key="customer.id">
					<td>{{ customer.lastName }}</td>
					<td>{{ customer.firstName }}</td>
					<td>{{ customer.city }}</td>
					<td>{{ customer.state }}</td>
					<td>{{ customer.zipcode }}</td>
					<td>{{ customer.email }}</td>
					<td><a v-bind:href="'${pageContext.request.contextPath}/customers/' + customer.id + '/edit'" role="button">Edit</a></td>
					<td>
						<!-- TODO: Implement confirm box or modal -->
						<security:authorize access="hasRole('ROLE_ADMIN')">
							<form v-bind:id="'form-delete-' + customer.id" class="form-delete" method="POST"
								v-bind:action="'${pageContext.request.contextPath}/customers/'">
								<input type="hidden" name="_method" value="DELETE"/>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<input type="hidden" name="customerId" v-bind:value="customer.id"/>
								<!-- 
								<input type="hidden" name="customerName" v-bind:value="customer.firstName + ' ' + customer.lastName"/>
								 -->
								<button type="submit" class="btn btn-xs submit-btn">Delete</button>
							</form>
						</security:authorize>
					</td>
				</tr>
			</tbody>
		</table>
		<nav id="page-nav" aria-label="Page navigation">
			<ul class="pagination">
				<li>
					<a href="#" v-on:click="goToFirstPage()">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				<li><a href="#" aria-label="Previous" v-on:click="decrementPage()">prev</a></li>
				<li><a href="#" aria-label="Next" v-on:click="incrementPage()">next</a></li>
				<li>
					<a href="#" v-on:click="goToLastPage()">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</nav>
		<div id="current-page">
			<label style="margin: 0 0.4em; font-weight: normal;">Page</label>
			<select v-model="currentPage">
				<option v-for="page in pageList" v-bind:key="page">{{page}}</option>
			</select>
			<span> of {{pageCount}}</span>
		</div>
	</div>
</div>

<div id="delete-modal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">

			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary delete-btn"
					data-customer-id="">Delete</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			</div>

		</div>
	</div>
</div>

<script src="<c:url value="/js/indexVue.js" />"></script>

<script>
	/*
	$(document).ready(function() {
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
	*/
	</script>

<%@ include file="../footer.jsp"%>