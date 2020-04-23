<%@ include file="../header.jsp"%>

<script src="<c:url value="/js/vue.js" />"></script>
<script src="<c:url value="/js/axios.js" />"></script>

<div id="customer-list" class="row">
	<div class="col-md-12">
		<span class="list-title">Customer List</span>
		<a class="btn btn-default"
			href="${pageContext.request.contextPath}/customers/create"
			role="button">Create Customer</a>
		<table id="customer-table" class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Last Name</th>
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
						<!-- 
								<security:authorize access="hasRole('ROLE_ADMIN')">
									<form:form id="form-delete-${customer.id}" cssClass="form-delete" method="DELETE"
										action="${pageContext.request.contextPath}/customers/${customer.id}">
										<input type="hidden" name="customerId" value="${customer.id}"/>
										<input type="hidden" name="customerName" value="${customer.firstName}${' '}${customer.lastName}"/>
										<button type="submit" class="btn btn-default submit-btn">Delete</button>
									</form:form>
								</security:authorize>
							 --> &nbsp;
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
<script>
	var app = new Vue({
		el: '#customer-list',
		data: {
			customers: [],
			unfilteredCustomers: [],
			currentPage: 1,
			pageSize: 10,
			ascSort: true,
			searchTerm: ""
		},
		computed: {
			pageCount: function() {
				return Math.ceil(this.customers.length / this.pageSize);
			},
			currentPageCustomers: function() {
				let startIndex = (this.currentPage - 1) * this.pageSize;
				let endIndex = this.currentPage * this.pageSize;
				return this.customers.slice(startIndex, endIndex);
			},
			pageList: function() {
				let tempAry = [];
				for (let i = 0; i < this.pageCount; i++) {
					tempAry.push(i + 1);
				}
				return tempAry;
			},
			sortArrow: function() {
				if (this.ascSort) {
					return "&#9652;"; // up arrow
				}
				else {
					return "&#9662;"; // down arrow
				}
			}
		},
		methods: {
			getCustomers: function() {
				var that = this;
				axios.get('${pageContext.request.contextPath}/api/customers/')
				.then(function (response) {
					// handle success
					that.customers = response.data;
				})
				.catch(function (error) {
					// handle error
					console.log(error);
				})
			},
			incrementPage() {
				if (this.currentPage < this.pageCount) {
					this.currentPage++;
				}
			},
			decrementPage() {
			if (this.currentPage > 1) {
				this.currentPage--;
				}
			},
			goToFirstPage() {
				this.currentPage = 1;
			},
			goToLastPage() {
				this.currentPage = this.pageCount;
			},
		},
		created: function() {
			this.getCustomers();
		}
	});
	</script>
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