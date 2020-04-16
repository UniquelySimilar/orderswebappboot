package com.tcoveney.orderswebappboot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http.authorizeRequests()
    	.antMatchers("/css/**").permitAll()
    	.antMatchers("/js/**").permitAll()
    	.anyRequest().authenticated()
        .and()
        //.formLogin();
        .formLogin().loginPage("/login").permitAll().defaultSuccessUrl("/customers/");
    }
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
            auth
            // enable in memory based authentication with a user named "user" and "admin"
            .inMemoryAuthentication().withUser("user").password("{noop}password").roles("USER")
                            .and().withUser("admin").password("{noop}password").roles("USER", "ADMIN");
    }


//	@Bean
//	@Override
//	public UserDetailsService userDetailsService() {
//		UserDetails user =
//			 User.withDefaultPasswordEncoder()
//				.username("user")
//				.password("password")
//				.roles("USER")
//				.build();
//
//		return new InMemoryUserDetailsManager(user);
//	}

}
