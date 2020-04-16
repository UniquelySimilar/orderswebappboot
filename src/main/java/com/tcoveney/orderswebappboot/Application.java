package com.tcoveney.orderswebappboot;

import java.util.Properties;

import javax.naming.NamingException;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.tcoveney.orderswebappboot.model.Customer;
import com.tcoveney.orderswebappboot.model.Order;
import com.zaxxer.hikari.HikariDataSource;

@SpringBootApplication(exclude=HibernateJpaAutoConfiguration.class)
@EnableTransactionManagement
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}
	
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
