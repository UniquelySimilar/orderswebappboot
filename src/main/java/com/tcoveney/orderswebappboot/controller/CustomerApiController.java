package com.tcoveney.orderswebappboot.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tcoveney.orderswebappboot.dao.CustomerDao;
import com.tcoveney.orderswebappboot.model.Customer;

@RestController
@RequestMapping("/api/customers")
public class CustomerApiController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerApiController.class);
	
	@Autowired
	private CustomerDao customerDao;
	
	@GetMapping("/")
	public List<Customer> findAll() {
		return customerDao.findAllOrderByLastName();
	}
	
	@GetMapping("/{id}")
	public Customer find(@PathVariable int id) {
		return customerDao.find(id);
	}

}
