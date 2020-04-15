package com.tcoveney.orderswebappboot.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.tcoveney.orderswebappboot.dao.CustomerDao;
import com.tcoveney.orderswebappboot.dao.OrderDao;
import com.tcoveney.orderswebappboot.exception.ResourceNotFoundException;
import com.tcoveney.orderswebappboot.model.Customer;
import com.tcoveney.orderswebappboot.model.CustomerWithOrders;
import com.tcoveney.orderswebappboot.model.Order;
import com.tcoveney.orderswebappboot.validator.ValidationUtils;

@Controller
@RequestMapping("/customers")
public class CustomerController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

	@Autowired
	private ValidationUtils validationUtils;
	
	@Autowired
	private CustomerDao customerDao;
	
	@Autowired
	private OrderDao orderDao;

	@GetMapping("/")
	public ModelAndView findAll() {
		//logger.debug("Called 'findAll()'");
		List<Customer> customers = customerDao.findAll();
		
		return new ModelAndView("customer/index", "customers", customers);
	}

	@GetMapping("/orderby/lastname")
	public List<Customer> findAllOrderByLastName() {
		
		List<Customer> customers = customerDao.findAllOrderByLastName();
		
		return customers;	
	}
	
	@GetMapping("/{id}")
	public Customer find(@PathVariable int id) {
		Customer customer = customerDao.find(id);
		if (null == customer) {
			throw new ResourceNotFoundException();
		}
		return customer;
	}
	
	@GetMapping("/lastname/{lastName}")
	public List<Customer> findByLastName(@PathVariable String lastName) {
		return customerDao.findByLastName(lastName);
	}
	
	@GetMapping("/{customerId}/orders")
	public CustomerWithOrders findWithOrders(@PathVariable int customerId, HttpServletResponse response){
		CustomerWithOrders cwo = new CustomerWithOrders();
		Customer customer = customerDao.find(customerId);
		if (null == customer) {
			throw new ResourceNotFoundException();
		}
		else {
			List<Order> orders = orderDao.findByCustomer(customerId);
			cwo.setCustomer(customer);
			cwo.setOrders(orders);
		}
		return cwo;
	}
	
	@PostMapping(value = "/", headers = "content-type=application/json")
	public void insert(@RequestBody @Valid Customer customer, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		if (bindingResult.hasErrors()) {
			validationUtils.createValidationErrorsResponse(bindingResult, response);
		}
		else {
			int newCustomerId = customerDao.insert(customer);
			response.setStatus(201);
			response.addHeader( "Location", request.getRequestURL().append( Integer.toString(newCustomerId) ).toString() );
		}
	}
	
	@PutMapping(value = "/", headers = "content-type=application/json")
	public void update(@RequestBody @Valid Customer customer, BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response) {
		if (bindingResult.hasErrors()) {
			validationUtils.createValidationErrorsResponse(bindingResult, response);
		}
		else {
			customerDao.update(customer);
		}
	}
	
	@DeleteMapping("/{id}")
	public void delete(@PathVariable int id) {
		customerDao.delete(id);
	}

}
