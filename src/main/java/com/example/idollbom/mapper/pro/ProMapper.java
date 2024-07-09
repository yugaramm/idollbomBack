package com.example.idollbom.mapper.pro;

import com.example.idollbom.domain.vo.ProVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProMapper {
    ProVO selectOne(String Id);
}
