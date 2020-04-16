package com.tcoveney.orderswebappboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
	// If user tries to access the application from the context root
	// TODO: Determine if I can set the redirect URI as part of the authentication process
	@GetMapping("/")
	public String customersRedirect() {
		return "redirect:customers/";
	}

	@GetMapping("/login")
	public String loginForm() {
		return "login";
	}
	
	@PostMapping
	public String login() {
		return "login";
	}

}
