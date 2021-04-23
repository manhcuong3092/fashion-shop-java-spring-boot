package com.cuong.shop.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.entities.SaleOrderProduct;



@Service
public class EmailService {
	
	@Autowired
    private JavaMailSender javaMailSender;
    
    public void sendEmail(SaleOrder saleOrder, String... toEmail) {

        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(toEmail);
        msg.setSubject("Bạn đã mua đơn hàng");
        String content = "";
        content += "Xin chào " + saleOrder.getCustomerName() + "!\n";
        content += "Đơn hàng của bạn đã mua bao gồm:\n";
        for (SaleOrderProduct item: saleOrder.getSaleOrderProducts()) {
        	content += item.getProduct().getTitle() + " - " + item.getSize() + " - " + 
        			item.getColor() + " x " + item.getQuantity() + "\n";
        }
        content += "Tổng cộng: " + saleOrder.getTotal() + "\n";
        content += "Cảm ơn bạn đã mua hàng.";
        msg.setText(content);

        javaMailSender.send(msg);

    }
}
