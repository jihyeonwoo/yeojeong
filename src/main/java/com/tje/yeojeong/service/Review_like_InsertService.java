package com.tje.yeojeong.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tje.yeojeong.model.*;
import com.tje.yeojeong.repository.*;

@Service
public class Review_like_InsertService {
	
	@Autowired
	private Like_ThumbDAO like_ThumbDAO;
	
	public Object service(Object args) {
		
		return like_ThumbDAO.insertLike((Like_Thumb)args);
		}
	}

