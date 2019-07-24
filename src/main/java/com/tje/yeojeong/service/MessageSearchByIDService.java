package com.tje.yeojeong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.yeojeong.model.*;
import com.tje.yeojeong.repository.*;

@Service
public class MessageSearchByIDService {
	
	@Autowired
	private MessageDAO messageDAO;
	
	public Object service(Object args) {
		return messageDAO.selectById((Message)args);
	}
}
