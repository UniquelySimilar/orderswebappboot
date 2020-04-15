package com.tcoveney.orderswebappboot.config;

import java.util.Properties;

import javax.naming.NamingException;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.tcoveney.orderswebappboot.model.Customer;
import com.tcoveney.orderswebappboot.model.Order;
import com.zaxxer.hikari.HikariDataSource;

//@Configuration
//@EnableTransactionManagement
//@EnableWebMvc	//TODO: Determine if this annotation necessary.  See SB ref doc 4.7.1.
//@ComponentScan(basePackages = "com.tcoveney")
public class AppConfig implements WebMvcConfigurer {	
	// NOTE: DataSource properties are set in 'application.properties'
	@Bean
	@ConfigurationProperties("app.datasource")
	public HikariDataSource dataSource() {
	    return DataSourceBuilder.create().type(HikariDataSource.class).build();
	}
	
	@Bean
	LocalSessionFactoryBean hibernateSessionFactory() throws NamingException {
		LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		sessionFactory.setDataSource(dataSource());
		sessionFactory.setAnnotatedClasses(Customer.class, Order.class);
		sessionFactory.setHibernateProperties(hibernateProperties());
		return sessionFactory;
	}
	
	@SuppressWarnings("serial")
	Properties hibernateProperties() {
		return new Properties() {
			{
				setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
			}
		};
	}
	
	@Bean
	HibernateTransactionManager transactionManager() throws NamingException {
		HibernateTransactionManager transactionManager = new HibernateTransactionManager();
		transactionManager.setSessionFactory(hibernateSessionFactory().getObject());
		return transactionManager;
	}
	
	@Bean
	public MessageSource messageSource() {
	    ReloadableResourceBundleMessageSource messageSource
	      = new ReloadableResourceBundleMessageSource();
	    messageSource.setBasename("classpath:validation-messages");
	    messageSource.setDefaultEncoding("UTF-8");
	    return messageSource;
	}

}