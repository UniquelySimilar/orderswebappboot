<%@ include file="../header.jsp" %>
	<script src="<c:url value="/js/vue.js" />"></script>
	<script src="<c:url value="/js/axios.js" />"></script>

	<div id="vuetest">
		<table>
			<thead>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
				</tr>
				<tr>
					<td>{{ customer.firstName }}</td>
					<td>{{ customer.lastName }}</td>
				</tr>
			</thead>
		</table>
	</div>
	<div>
		<a class="btn btn-default" href="${pageContext.request.contextPath}/customers/" role="button">Back to Customers</a>
	</div>
	
	<script>
	var app = new Vue({
		  el: '#vuetest',
		  data: {
			  customer: {
				  firstName: '',
				  lastName: ''
			  }
		  },
		  created: function() {
			  var that = this;
			  axios.get('${pageContext.request.contextPath}/api/customers/1006')
			  .then(function (response) {
			    // handle success
			    console.log(response.data);
			    that.customer = response.data;
			  })
			  .catch(function (error) {
			    // handle error
			    console.log(error);
			  })
		  }
		})
	</script>
	
<%@ include file="../footer.jsp" %>