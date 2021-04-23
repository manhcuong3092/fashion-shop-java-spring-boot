package com.cuong.shop.conf;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.cuong.shop.Constants;


//-> là 1 bean mà spring hiểu được
// bean này dùng để cấu hình.
@Configuration
public class MVCConf implements WebMvcConfigurer, Constants {

	// cấu hình cho MVC biết chỗ folder để lấy view trả về cho Browser.
	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/views/"); // thư mục gốc chứa các file jsp.
		bean.setSuffix(".jsp");
		return bean;
	}
	
	/**
	 * Mapping JS và CSS.
	 * Notes:
	 * 1. classpath <-> src/main/resources
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("classpath:/META-INF/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("classpath:/META-INF/js/");
		registry.addResourceHandler("/img/**").addResourceLocations("classpath:/META-INF/img/");
		registry.addResourceHandler("/fonts/**").addResourceLocations("classpath:/META-INF/fonts/");
		registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/META-INF/assets/");
		registry.addResourceHandler("/summernote/**").addResourceLocations("classpath:/META-INF/summernote/");
		registry.addResourceHandler("/upload/**").addResourceLocations("file:" + ROOT_UPLOAD_PATH);
	}

}
