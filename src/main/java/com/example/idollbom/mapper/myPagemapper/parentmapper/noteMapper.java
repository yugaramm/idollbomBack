package com.example.idollbom.mapper.myPagemapper.parentmapper;

import com.example.idollbom.domain.dto.myPagedto.parentdto.mailDTO;
import com.example.idollbom.domain.vo.noteVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface noteMapper {
    List<mailDTO> selectNoteById(Long parentNumber);

    mailDTO selectNoteByNoteId(Long mailId);
}
