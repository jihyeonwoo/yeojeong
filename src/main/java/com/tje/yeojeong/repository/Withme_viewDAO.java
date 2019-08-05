package com.tje.yeojeong.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.tje.yeojeong.model.*;
import com.tje.yeojeong.setting.*;

@Repository
public class Withme_viewDAO {
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private PagingInfo pagingInfo;
	
	@Autowired
	public Withme_viewDAO(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	// 맵퍼 클래스
	class Withme_viewRowMapper implements RowMapper<Withme_view>{
		@Override
		public Withme_view mapRow(ResultSet rs, int arg1) throws SQLException {
			Withme_view withme_view = new Withme_view(
					rs.getInt(1),rs.getString(2),rs.getInt(3),rs.getInt(4),rs.getDate(5),rs.getInt(6),rs.getString(7));
			return withme_view;
		}
	}
	
	// 조회수
	public int AticleCount(Withme_view obj) {
		String sql = "update withme_article set read_count = read_count + 1 where article_id = ?";
		return this.jdbcTemplate.update(sql, obj.getArticle_id());
	}

	// Count
	public int withme_viewCount() {
		String sql = "select count(*) from withme_view";
		return this.jdbcTemplate.queryForObject(sql, Integer.class);
	}
	
	// 리뷰 뷰 전체 리스트 검색
	public List<Withme_view> selectAll(int page) {
		String sql = "select * from withme_view order by write_time desc limit ?, ?";
		List<Withme_view> result = this.jdbcTemplate.query(sql, new Withme_viewRowMapper(),
				(page-1)*this.pagingInfo.getPagingSize(),this.pagingInfo.getPagingSize());
		return result.isEmpty() ? null : result;
	}
}