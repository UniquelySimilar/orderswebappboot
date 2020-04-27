new Vue({
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
			this.searchTerm = '';
			let that = this;
			axios.get('/orderswebappboot/api/customers/')
			.then(function (response) {
				that.customers = response.data;
				// Initialize sort to lastName ascending
				that.customers.sort(that.compareLastNamesAsc);
				that.unfilteredCustomers = that.customers.slice();
				that.currentPage = 1;
				that.ascSort = true;
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
		toggleSort() {
			this.ascSort = !this.ascSort;
			if (this.ascSort) {
				this.customers.sort(this.compareLastNamesAsc);
			}
			else {
				this.customers.sort(this.compareLastNamesDesc);
			}
		},
		compareLastNamesAsc(a, b) {
			if (a.lastName < b.lastName) {
				return -1;
			}
			if (a.lastName > b.lastName) {
				return 1;
			}
			return 0;
		},
		compareLastNamesDesc(a, b) {
			if (a.lastName > b.lastName) {
				return -1;
			}
			if (a.lastName < b.lastName) {
				return 1;
			}
			return 0;
		},
		searchLastName() {
			console.log("called 'searchLastName()'");
			if (this.searchTerm.length < 1) {
				// Reset in case hitting backspace
				this.customers = this.unfilteredCustomers.slice();
				this.currentPage = 1;
				return;
			}

			// Filter customers by last name
			this.customers = this.unfilteredCustomers.filter(customer => {
				return customer.lastName.toLowerCase().substring(0, this.searchTerm.length) === this.searchTerm.toLowerCase();
			});
			this.currentPage = 1;
		},
		clearSearch() {
			this.searchTerm = '';
			this.customers = this.unfilteredCustomers.slice();
		},
		confirmDelete(message, event) {
			if (!window.confirm(message)) {
				event.preventDefault();
			}
		}
	},
	created: function() {
		this.getCustomers();
	}
});
