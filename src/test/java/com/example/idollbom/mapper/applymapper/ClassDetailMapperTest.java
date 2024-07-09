package com.example.idollbom.mapper.applymapper;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Slf4j
class ClassDetailMapperTest {

    @Autowired
    private ClassDetailMapper classDetailMapper;

    @Test
    void test(){
        log.info(classDetailMapper.selectClassByProNumber(4L).toString());
    }
}