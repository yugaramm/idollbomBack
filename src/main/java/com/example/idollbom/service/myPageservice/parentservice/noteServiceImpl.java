package com.example.idollbom.service.myPageservice.parentservice;

import com.example.idollbom.domain.dto.myPagedto.parentdto.mailDTO;
import com.example.idollbom.domain.vo.ParentVO;
import com.example.idollbom.domain.vo.noteVO;
import com.example.idollbom.mapper.loginmapper.ParentMapper;
import com.example.idollbom.mapper.myPagemapper.parentmapper.noteMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
@Slf4j
public class noteServiceImpl implements noteService {
    private final noteMapper noteMapper;
    private final  ParentMapper parentMapper;
    @Override
    public  List<mailDTO> selectAllMyNote() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String currentUserName = userDetails.getUsername();

//      parent VO 찾아서 아이디 찾기
        ParentVO parent = parentMapper.selectOne(currentUserName);
        List<mailDTO> maildto = noteMapper.selectNoteById(parent.getParentNumber());
        return maildto;
    }

    @Override
    public mailDTO selectOneMail(Long mailId) {
        return noteMapper.selectNoteByNoteId(mailId);
    }
}
