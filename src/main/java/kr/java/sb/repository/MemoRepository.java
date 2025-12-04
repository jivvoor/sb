package kr.java.sb.repository;

import kr.java.sb.entity.Memo;
import org.springframework.data.jpa.repository.JpaRepository;


public interface MemoRepository extends JpaRepository<Memo, Long> {
}
