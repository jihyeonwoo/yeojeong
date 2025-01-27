package com.tje.yeojeong.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.yeojeong.model.*;
import com.tje.yeojeong.repository.*;

@Service
public class MessageDeleteService {
	
	@Autowired
	private MessageDAO messageDAO;
	
	public Object service(HashMap<String, Object> values) {
		HashMap<String, Object> result = new HashMap<>();
		Message message = (Message)values.get("message");
		result.put("result", messageDAO.delete(message));
		return result;
	}
}
