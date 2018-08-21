select rownum,ename,sal
from EMP order by sal desc;

select rownum,ename,sal
from(select * from emp order by sal desc);
/*rownum:numbering*/

/*급여 순서에서 상위 3개 뽑기*/
select rownum,ename,sal
from(select * from emp order by sal desc)
where rownum<4;
/*두번째는 sal을 기준으로 정렬을 한 후 rownum을 부여한다.*/
/*두번째는 sal을 기준으로 정렬을 한 후 rownum을 부여한다.*/
