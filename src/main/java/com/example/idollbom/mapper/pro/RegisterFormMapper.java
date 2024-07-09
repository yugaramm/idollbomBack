package com.example.idollbom.mapper.pro;

import com.example.idollbom.domain.vo.classVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegisterFormMapper {

    void saveClass(classVO classVO);

}
