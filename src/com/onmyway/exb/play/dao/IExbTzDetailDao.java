package com.onmyway.exb.play.dao;

import com.onmyway.common.dao.EntityDAO;
import com.onmyway.common.exception.DAOException;
import com.onmyway.exb.play.model.ExbTzDetail;

/**
 * @Title:快乐十分-投注信息管理
 * @Description: -保存-验证
 * @Create on: Aug 20, 2010 5:42:25 PM
 * @Author:LJY
 * @Version:1.0
 */
public interface IExbTzDetailDao extends  EntityDAO<ExbTzDetail,String> {
	
	/**
	 * 查询某种玩法已经投注的情况
	 * @param playType
	 * @param playMode
	 * @param issueNum
	 * @return
	 */
	public int getCountOfNum(String playType,String typeName,String playMode,String issueNum,String playNum) throws DAOException;
}
