package com.tcoveney.orderswebappboot.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.tcoveney.orderswebappboot.Utils;
import com.tcoveney.orderswebappboot.dao.CustomerDao;
import com.tcoveney.orderswebappboot.model.Customer;

@Controller
@RequestMapping("/customers")
public class CustomerController {
	private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);
	
	private CustomerDao customerDao;
	
	public CustomerController(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}
	
	@ModelAttribute
	public void addAttributes(Model model) {
		Map<String,String> stateList = Utils.getStateList();
		model.addAttribute("stateList", stateList);
	}
		
	// View that uses Vue.js to retrieve customers via AJAX for better performance
	// and additional client side search/sort functionality
	@GetMapping("/")
	public String findAll() {
		//logger.debug("Called 'findAll()'");
		return "customer/indexVue";
	}
	
	@GetMapping("/{id}")
	public ModelAndView find(@PathVariable int id) {
		Customer customer = customerDao.find(id);
		return new ModelAndView("customer/detail", "customer", customer);
	}
	
	@GetMapping("/create")
	public ModelAndView displayCreateForm() {
		return new ModelAndView("customer/create", "customer", new Customer());
	}
	
	@PostMapping(value = "/save")
	public String save(@ModelAttribute @Valid Customer customer, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "customer/create";
		}
		else {
			customerDao.save(customer);
		}
		
		return "redirect:/customers/";
	}
	
	@GetMapping("/{id}/edit")
	public ModelAndView displayEditForm(@PathVariable int id) {
		Customer customer = customerDao.find(id);
		return new ModelAndView("customer/edit", "customer", customer);
	}
	
	@PostMapping(value = "/update")
	public String update(@Valid @ModelAttribute Customer customer, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "customer/edit";
		}
		customerDao.update(customer);
		
		return "redirect:/customers/";
	}
	
	@DeleteMapping("/")
	public String delete(HttpServletRequest request) {
		String customerId = request.getParameter("customerId");
		customerDao.delete(Integer.parseInt(customerId));
		return "redirect:/customers/";
	}
	
//	@DeleteMapping("/{id}")
//	public String delete(@PathVariable int id) {
//		customerDao.delete(id);
//		return "redirect:/customers/";
//	}

}
