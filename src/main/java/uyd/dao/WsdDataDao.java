package uyd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import uyd.entity.WsdData;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月20日,上午11:12:14
 * @version 1.0
 * @description
 */
@Repository("wsdDataDao")
public interface WsdDataDao {
	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月21日,上午11:28:11
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 查询温湿度折线图表数据
	 */
	public List<WsdData> loadWsdData(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午3:48:27
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 查询分页数据总数量
	 */
	Integer getCount(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午5:06:56
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 查询创建折线图
	 */
	List<WsdData> createWsdLineCharts(Map<String, Object> map);
}
