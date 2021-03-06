package com.tcoveney.orderswebappboot.controller;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.tcoveney.orderswebappboot.dao.OrderDao;
import com.tcoveney.orderswebappboot.model.Order;

@RestController
@RequestMapping("/api/orders")
// "http://localhost:9000" - vue cli dev server
// "http://vue-client-for-spring-rest.localhost" - Apache2 virtualhost for vue client
@CrossOrigin(origins = {"http://localhost:9000", "http://vue-client-for-spring-rest.localhost"})
public class OrderController {
	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
	
	@Autowired
	private OrderDao orderDao;
	
	@GetMapping("/{id}")
	public Order find(@PathVariable int id) {
		//logger.debug("Called 'find()'");
		Order order = orderDao.find(id);
		if (null == order) {
			// TODO
		}
		return order;
	}
	
	@PostMapping(value = "/", headers = "content-type=application/json")
	public void insert(@RequestBody @Valid Order order, BindingResult bindingResult, HttpServletResponse response) {
		//logger.debug(order.toString());
		// NOTE: Since Order.customerID is NOT nullable and NOT updatable, it is ignored by this update
		if (bindingResult.hasErrors()) {
			// TODO
		}
		else {
			orderDao.insert(order);
			response.setStatus(201);
			//response.addHeader( "Location", request.getRequestURL().append( Integer.toString(newOrderId) ).toString() );
		}
	}
	
	@PutMapping(value = "/", headers = "content-type=application/json")
	public void update(@RequestBody @Valid Order order, BindingResult bindingResult, HttpServletResponse response) {
		//logger.debug(order.toString());
		if (bindingResult.hasErrors()) {
			// TODO
		}
		else {
			orderDao.update(order);
		}
	}
	
	@DeleteMapping("/{id}")
	public void delete(@PathVariable int id) {
		orderDao.delete(id);
	}

}
